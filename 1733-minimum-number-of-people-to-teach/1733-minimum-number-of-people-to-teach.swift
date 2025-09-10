// Time Complexity: O(U*K + F*K + L*U)
//   - U: The number of users (`languages.count`).
//   - L: The number of languages (`n`).
//   - F: The number of friendships.
//   - K: The maximum number of languages a single user knows.
//   - The complexity breaks down as follows:
//     1. Building the lookup matrix: O(U * K).
//     2. Finding users who can't communicate: O(F * K) because for each friendship, we
//        may iterate through up to K languages.
//     3. Finding the minimum teachings: O(L * U) because we iterate through every
//        language and (in the worst case) every user in the `candidatesForTeaching` set.
//
// Space Complexity: O(L * U)
//   - The primary space usage is the `userSpeaksLanguage` boolean matrix, which has
//     dimensions L x U. The `candidatesForTeaching` set can store up to U users.
class Solution {
    /**
     * Calculates the minimum number of users to teach a single language so all friends can communicate.
     *
     * The strategy is a three-step process:
     * 1.  **Pre-computation:** Create a fast lookup structure (a 2D boolean array) to quickly
     * check if a given user speaks a given language.
     * 2.  **Identify Candidates:** Find all friendships where the two users cannot communicate
     * (they share no common languages). Collect all unique users from these problematic
     * friendships into a set. These are the only users we potentially need to teach.
     * 3.  **Find Minimum Cost:** For each language from 1 to `n`, assume we will teach that
     * language. Count how many users from our candidate set do *not* already know it. The
     * minimum of these counts over all languages is our answer.
     *
     * - Parameters:
     * - n: The total number of languages.
     * - languages: A 2D array where `languages[i]` lists the languages spoken by user `i+1`.
     * - friendships: A 2D array of `[user1, user2]` pairs.
     * - Returns: The minimum number of users that need to be taught.
     */
    func minimumTeachings(_ n: Int, _ languages: [[Int]], _ friendships: [[Int]]) -> Int {
        let languageCount = n
        let userCount = languages.count
        
        // --- Step 1: Pre-computation for fast language lookups ---
        // `userSpeaksLanguage[lang][user]` is true if the user speaks that language.
        var userSpeaksLanguage = [[Bool]](repeating: [Bool](repeating: false, count: userCount), count: languageCount)
        for userIndex in 0..<userCount {
            for lang in languages[userIndex] {
                // Languages are 1-indexed in input, so we use `lang - 1`.
                userSpeaksLanguage[lang - 1][userIndex] = true
            }
        }

        // --- Step 2: Identify users in non-communicating friendships ---
        var candidatesForTeaching = Set<Int>()
        for friendship in friendships {
            // Users are 1-indexed in input, so we use `- 1` for 0-based array access.
            let user1 = friendship[0] - 1
            let user2 = friendship[1] - 1
            
            var canCommunicate = false
            for lang in languages[user1] {
                // Check if user2 also speaks one of user1's languages.
                if userSpeaksLanguage[lang - 1][user2] {
                    canCommunicate = true
                    break
                }
            }
            
            if !canCommunicate {
                candidatesForTeaching.insert(user1)
                candidatesForTeaching.insert(user2)
            }
        }
        
        // Edge Case: If all friends can already communicate, no teaching is needed.
        if candidatesForTeaching.isEmpty {
            return 0
        }

        // --- Step 3: Find the language that requires the minimum number of new teachings ---
        var minTeachings = Int.max
        // Iterate through each possible language we could teach.
        for langIndex in 0..<languageCount {
            var teachingsForThisLang = 0
            // Count how many candidates don't already know this language.
            for userIndex in candidatesForTeaching {
                if !userSpeaksLanguage[langIndex][userIndex] {
                    teachingsForThisLang += 1
                }
            }
            minTeachings = min(minTeachings, teachingsForThisLang)
        }
        
        return minTeachings
    }
}