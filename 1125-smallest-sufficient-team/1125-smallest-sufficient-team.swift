class Solution {
    func smallestSufficientTeam(_ req_skills: [String], _ people: [[String]]) -> [Int] {
	    //mapping skills to value for creating a bitmask
	    var map = [String: Int]()
	    for (i, skill) in req_skills.enumerated() {
		    map[skill] = i
	    }
	
        //potential mappings, key is index, value is person array
	    var result = [Int: [Int]]()
	    result[0] = []
        
	    //go through each person and find our best fit
	    for (i, person) in people.enumerated() {
		    var skillValue = 0
		    
            //create bitmask for that person
		    for skill in person {
			    skillValue |= 1 << map[skill]!
		    }
		
            //now compare adding people as we move along
		    for (j, need) in result {
			    var mayAdd = j | skillValue
			    
                //if the person adds no value, continue
			    if mayAdd == j { continue }
			    
                //otherwise, add them
			    if result[mayAdd] == nil || result[mayAdd]!.count > need.count + 1 {
				    result[mayAdd] = need+[i]
			    }
		    }
	    }
	
        //return the result at 2^req_skill.count - 1
	    return result[(1 << req_skills.count) - 1]!
    }
}