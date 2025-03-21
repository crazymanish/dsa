class Solution {
    func findAllRecipes(_ recipes: [String], _ ingredients: [[String]], _ supplies: [String]) -> [String] {
        var recipeRequirements = [String: [String]]() // Map recipe to its required ingredients
        var recipeIngredientCount = [String: Int]() // Map recipe to the count of its required ingredients
        var availableIngredients = Set(supplies) // Set of initially available ingredients
        var creatableRecipes = [String]() // List of recipes that can be created

        // Populate recipeRequirements and recipeIngredientCount
        for (recipeIndex, recipe) in recipes.enumerated() {
            recipeRequirements[recipe] = ingredients[recipeIndex] // Store ingredients needed for the recipe
            recipeIngredientCount[recipe] = ingredients[recipeIndex].count // Store the number of ingredients needed
        }

        var ingredientQueue = supplies // Queue of ingredients to process

        // Process ingredients using topological sort
        while !ingredientQueue.isEmpty {
            let currentIngredient = ingredientQueue.removeFirst() // Get the next available ingredient

            // Check which recipes use this ingredient
            for (recipe, requiredIngredients) in recipeRequirements {
                if requiredIngredients.contains(currentIngredient) {
                    recipeIngredientCount[recipe]! -= 1 // Decrement the count of ingredients needed for the recipe

                    // If all ingredients for the recipe are available
                    if recipeIngredientCount[recipe]! == 0 {
                        availableIngredients.insert(recipe) // Add the recipe to available ingredients
                        ingredientQueue.append(recipe) // Add the recipe to the queue for further processing
                        creatableRecipes.append(recipe) // Add the recipe to the result list
                    }
                }
            }
        }

        return creatableRecipes // Return the list of creatable recipes
    }
}