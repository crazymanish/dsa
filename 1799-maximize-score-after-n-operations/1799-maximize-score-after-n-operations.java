
/*
class Solution {
    func maxScore(_ nums: [Int]) -> Int {
        let n = nums.count
        var bits = Array(repeating: 1, count: n)
        var hashMap: [Int: Int] = [:]
        
        var bitsNumber: Int {
            var result = 0
            for index in 0..<bits.count {
                result = (result*2) + bits[index]
            }
            return result
        }
        
        func gcd(_ a: Int, _ b: Int) -> Int {
            if a == 0 { return b }
            
            return gcd(b%a, a)
        }
        
        func findMaxScore(_ index: Int) -> Int {
            let num = bitsNumber
            
            if num == 0 { return 0 }
            if hashMap[num] != nil { return hashMap[num]! }
            
            var result = 0
            for i in 0..<bits.count {
                for j in (i+1)..<bits.count {
                    if bits[i] == 1 && bits[j] == 1 {
                        bits[i] = 0
                        bits[j] = 0
                        
                        let currentResult = index * gcd(nums[i], nums[j])
                        let maxResult = max(result, currentResult)
                        result = maxResult + findMaxScore(index+1)
                        
                        bits[i] = 1
                        bits[j] = 1
                    }
                }
            }
            
            hashMap[num] = result
            return hashMap[num]!
        }
        
        return findMaxScore(1)
    }
}
*/


class Solution {
    public int maxScore(int[] nums) {
        int n = nums.length;
        int[] bits = new int[n];
        Arrays.fill(bits, 1);
        
        return maxScore(nums, bits, 1, new HashMap<Integer, Integer>());
    }
    
    private int maxScore(int[] nums, int[] bits, int index, Map<Integer,Integer> memo) {
        int num = getNum(bits);
        if(num == 0) return 0;
        if(memo.containsKey(num)) return memo.get(num);
        int result = 0;
        for(int i = 0; i < bits.length; i++) {
            for(int j = i + 1; j < bits.length; j++) {
                if(bits[i] == 1 && bits[j] == 1) {
                    bits[i] = 0;
                    bits[j] = 0;
                    result = Math.max(result, index * gcd(nums[i], nums[j]) + maxScore(nums, bits, index + 1, memo));
                    bits[i] = 1;
                    bits[j] = 1;
                }
            }
        }
        
        memo.put(num, result);
        return memo.get(num);
    } 
    
    private int gcd(int a, int b) {
        return a == 0 ? b : gcd(b % a, a);
    }
    
    private int getNum(int[] bits) {
        int result = 0;
        for(int i = 0; i < bits.length; i++)
            result = (result * 2) + bits[i];
        return result;
    }
}