class Solution {
    /**
     Problem Summary:
     Determine whether a planet can destroy all asteroids. The planet starts with
     the given mass and can destroy an asteroid only if its current mass is greater
     than or equal to the asteroid's mass. After destroying it, the asteroid's mass
     is added to the planet's mass.

     Strategy:
     Sort the asteroids in ascending order so the planet always tries to destroy
     the smallest remaining asteroid first. This greedy order gives the planet the
     best chance to grow before facing larger asteroids.

     Time Complexity: O(n log n), where n is the number of asteroids.
     Space Complexity: O(n), due to sorting.
     */
    func asteroidsDestroyed(_ mass: Int, _ asteroids: [Int]) -> Bool {
        var currentMass = mass

        // Destroy smaller asteroids first to grow the planet as much as possible.
        for asteroidMass in asteroids.sorted() {
            // If the planet is too small for this asteroid, it cannot continue.
            if currentMass < asteroidMass {
                return false
            }

            // The planet absorbs the asteroid's mass after destroying it.
            currentMass += asteroidMass
        }

        return true
    }
}