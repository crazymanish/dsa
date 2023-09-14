class Solution {
    func findItinerary(_ tickets: [[String]]) -> [String] {
        var answer: [String] = []
        var hashMap = [String: [String]]()

        for ticket in tickets {
            hashMap[ticket[0], default: []].append(ticket[1])
        }

        // sort the value
        for (key, value) in hashMap {
            hashMap[key] = value.sorted(by: { $0 > $1 }) // put the smallest lexical order at the last of the list.
        }

        func dfs(_ departureAirport: String) {
            guard let _ = hashMap[departureAirport] else {
                answer.append(departureAirport)
                return
            }

            while hashMap[departureAirport]?.isEmpty == false {
                guard let arrivalAirport = hashMap[departureAirport]?.removeLast() else { return }

                dfs(arrivalAirport)
            }

            answer.append(departureAirport)
        }

        dfs("JFK")
        answer.reverse()
        return answer
    }
}
