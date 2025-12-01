/// ---------------------------------------------------------------------------
/// Time Complexity:
///   • Sorting batteries: O(m log m), where m = batteries.count
///   • Single pass to remove oversized batteries: O(m)
///   • Total: O(m log m)
///
/// Space Complexity:
///   • O(1) extra (sorting can be considered O(1) if done in-place)
///
/// Explanation:
///   We want the maximum uniform runtime T such that n computers can run for T
///   minutes using all battery energy.
///
///   Greedy Insight:
///     - If a battery capacity is greater than the target T, that excess energy
///       cannot be used by one computer (batteries are not shareable simultaneously),
///       so we remove that battery from the pool of "candidate" batteries and
///       subtract its energy from the total.
///     - After removing all oversized batteries, the remaining batteries’
///       total energy determines the feasible runtime:
///
///           T = totalRemainingEnergy / remainingComputers
///
///   We keep removing outliers until all remaining batteries can contribute
///   to an equal runtime.
/// ---------------------------------------------------------------------------

class Solution {
    func maxRunTime(_ n: Int, _ batteries: [Int]) -> Int {
        // Total sum of all battery energies.
        var totalEnergy = batteries.reduce(0, +)
        
        // Sort batteries descending so we can remove oversized ones first.
        let sortedBatteries = batteries.sorted(by: >)
        
        // Index of the next battery to examine.
        var batteryIndex = 0
        
        // Computed uniform runtime based on current totalEnergy + remaining computers.
        var targetRuntime: Int {
            return totalEnergy / (n - batteryIndex)
        }

        // Remove batteries that exceed the feasible target runtime.
        while sortedBatteries[batteryIndex] > targetRuntime {
            totalEnergy -= sortedBatteries[batteryIndex]
            batteryIndex += 1
        }
        
        // After all oversized batteries are removed, this is the maximum feasible runtime.
        return targetRuntime
    }
}
