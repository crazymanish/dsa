class Solution {
    func primeSubOperation(_ nums: [Int]) -> Bool {
        if nums.last! < nums.count { return false } // impossible to build an increasing array
        
        let primes = [2,3,5,7,11,13,17,19,23,29,31,37,41,43,47,53,59,61,67,71,73,79,83,89,97,101,103,107,109,113,
                        127,131,137,139,149,151,157,163,167,173,179,181,191,193,197,199,211,223,227,229,233,239,241,                                                    251,257,263,269,271,277,281,283,293,307,311,313,317,331,337,347,349,353,359,367,373,379,383,
                        389,397,401,409,419,421,431,433,439,443,449,457,461,463,467,479,487,491,499,503,509,521,523,
                        541,547,557,563,569,571,577,587,593,599,601,607,613,617,619,631,641,643,647,653,659,661,673,
                        677,683,691,701,709,719,727,733,739,743,751,757,761,769,773,787,797,809,811,821,823,827,829,
                        839,853,857,859,863,877,881,883,887,907,911,919,929,937,941,947,953,967,971,977,983,991,997]

        var changedNum = 0 // previous number in array after subtracting prime from it
        var diff, left, right, mid: Int
        for num in nums {
            if num <= changedNum { return false } // we can't increase current num
            
            diff = num - changedNum

            if diff <= 2 {
                changedNum = num // current num is 1 or 2 bigger than previous, no subtracting
            } else { // we need to find the biggest possible prime number to subtract from current num
                // binary search to find the last index such that primes[index] < diff
                left = 0; right = primes.count - 1
                
                while left < right {
                    mid = (left + right + 1) / 2
                    if primes[mid] < diff { 
                        left = mid 
                    } else { 
                        right = mid - 1 
                    }
                }
                
                changedNum = num - primes[left] // subtract max possible prime from current num
            }
        }
        
        return true
    }
}