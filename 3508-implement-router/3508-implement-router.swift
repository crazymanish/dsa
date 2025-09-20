// Note: This solution assumes the existence of a `Deque` (Double-Ended Queue)
// data structure providing O(1) time complexity for append, popFirst, and count.
// A simple Deque can be built using a doubly-linked list or a circular buffer.

// MARK: - Complexity Analysis
// Let N be the number of packets currently in the router (N <= memoryLimit).
// Let N_d be the number of packets for a specific destination.
//
// Time Complexity:
// - `init`: O(1).
// - `addPacket`: O(1) on average. Set/Dictionary lookups and insertions, and Deque
//   operations are all O(1) on average.
// - `forwardPacket`: O(1) on average. Operations on all three data structures are O(1).
// - `getCount`: O(log N_d). The dominant operation is the binary search, which runs on
//   the queue of packets for the specific destination.
//
// Space Complexity: O(M)
// - M: The `memoryLimit`.
// - All three data structures (`packetSet`, `packetQueue`, `destinations`) store the packets.
//   The total number of packets is capped by the memory limit.


/**
 * A class that simulates a network router with a fixed memory capacity.
 *
 * ## Core Design
 * This implementation uses a combination of three data structures to handle the requirements efficiently:
 * 1.  **`packetQueue` (Deque):** A master double-ended queue that stores all packets in their
 * order of arrival. This provides a First-In, First-Out (FIFO) mechanism, allowing us to
 * identify and forward the "oldest" packet in O(1) time.
 * 2.  **`packetSet` (Set):** A set containing all packets currently in the router. This is used to
 * efficiently check for and prevent duplicate packets from being added in O(1) average time.
 * 3.  **`destinations` (Dictionary of Deques):** A dictionary that maps a destination ID to a
 * dedicated Deque of packets for that destination. This grouping allows the `getCount` method
 * to operate only on the relevant subset of packets.
 *
 * All three data structures are kept in sync during `addPacket` and `forwardPacket` operations.
 */
class Router {

    /// A simple struct to represent a network packet. It's `Hashable` for use in a `Set`.
    struct Packet: Hashable {
        let source: Int
        let destination: Int
        let timestamp: Int

        func output() -> [Int] {
            return [source, destination, timestamp]
        }
    }

    private let memoryLimit: Int
    private var packetSet: Set<Packet>
    private var packetQueue: Deque<Packet>
    private var destinations: [Int: Deque<Packet>]

    init(_ memoryLimit: Int) {
        self.memoryLimit = memoryLimit
        self.packetSet = []
        self.packetQueue = []
        self.destinations = [:]
    }
    
    /// Adds a new packet to the router's memory.
    /// If the memory limit is exceeded, the oldest packet is forwarded.
    /// - Returns: `false` if the exact same packet already exists, `true` otherwise.
    func addPacket(_ source: Int, _ destination: Int, _ timestamp: Int) -> Bool {
        let newPacket = Packet(source: source, destination: destination, timestamp: timestamp)
        
        // Use the set for an efficient O(1) duplicate check.
        guard !packetSet.contains(newPacket) else { return false }
        
        // Add the new packet to all three data structures to maintain consistency.
        packetQueue.append(newPacket)
        packetSet.insert(newPacket)
        destinations[destination, default: Deque()].append(newPacket)
        
        // Enforce the memory limit by forwarding the oldest packet if necessary.
        if packetQueue.count > memoryLimit {
            _ = forwardPacket()
        }
        return true
    }
    
    /// Forwards the oldest packet from the router.
    /// - Returns: The [source, destination, timestamp] of the forwarded packet, or an empty array if none.
    func forwardPacket() -> [Int] {
        // Retrieve the oldest packet from the main queue.
        guard let packetToForward = packetQueue.popFirst() else { return [] }
        
        // Remove the forwarded packet from the other two data structures to maintain consistency.
        packetSet.remove(packetToForward)
        destinations[packetToForward.destination]?.popFirst()
        
        return packetToForward.output()
    }
    
    /**
     * Counts packets for a specific destination within a given time range.
     *
     * **Important Assumption:** This function assumes that packets are added with
     * monotonically increasing timestamps. This ensures the destination deques are
     * sorted by timestamp, allowing for an efficient binary search.
     */
    func getCount(_ destination: Int, _ startTime: Int, _ endTime: Int) -> Int {
        guard let destinationQueue = destinations[destination], !destinationQueue.isEmpty else { return 0 }
        
        /**
         * A binary search helper that counts packets with a timestamp less than or equal to `time`.
         * It finds the insertion point for a value just greater than `time`, which corresponds
         * to the count of elements `<= time`.
         */
        func countUpTo(_ time: Int) -> Int {
            if time < 0 { return 0 }
            
            var low = 0
            var high = destinationQueue.count - 1
            var rightmostIndex = -1
            
            while low <= high {
                let mid = low + (high - low) / 2
                if destinationQueue[mid].timestamp <= time {
                    rightmostIndex = mid
                    low = mid + 1 // Search in the right half
                } else {
                    high = mid - 1 // Search in the left half
                }
            }
            return rightmostIndex + 1
        }

        // The number of packets in [startTime, endTime] is calculated as:
        // (count <= endTime) - (count <= startTime - 1)
        return countUpTo(endTime) - countUpTo(startTime - 1)
    }
}

/**
 * Your Router object will be instantiated and called as such:
 * let obj = Router(memoryLimit)
 * let ret_1: Bool = obj.addPacket(source, destination, timestamp)
 * let ret_2: [Int] = obj.forwardPacket()
 * let ret_3: Int = obj.getCount(destination, startTime, endTime)
 */