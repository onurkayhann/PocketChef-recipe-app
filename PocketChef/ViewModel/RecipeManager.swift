import Foundation
import FirebaseFirestore
import FirebaseAuth

class RecipeManager: ObservableObject {
    let api = Api()
    
    @Published var recipes: [ApiRecipe] = []
    
    let BASE_URL = ""
    let API_KEY = "546b720dd1364370aac95e4048ae91a5"
    
    func saveRecipesToFirestore(_ recipes: [ApiRecipe]) {
        let db = Firestore.firestore()
        for recipe in recipes {
            guard let id = recipe.id else { continue }
            do {
                try db.collection("recipes").document(id).setData(from: recipe)
            } catch {
                print("Error saving recipe \(id): \(error)")
            }
        }
    }
    
    func fetchTopRecipes() async {
        let url = "https://api.spoonacular.com/recipes/complexSearch?number=10&apiKey=\(API_KEY)"
        
        do {
            let response: RecipeResponseWrapper = try await api.get(url: url)
            DispatchQueue.main.async {
                self.recipes = response.results
                self.saveRecipesToFirestore(response.results)
            }
        } catch {
            print("Failed to fetch recipes: \(error)")
        }
    }
    
    func searchRecipesByCuisine(cuisine: String) async {
        let url = "https://api.spoonacular.com/recipes/complexSearch?cuisine=\(cuisine)&number=10&apiKey=\(API_KEY)"
        
        do {
            let response: RecipeResponseWrapper = try await api.get(url: url)
            DispatchQueue.main.async {
                self.recipes = response.results
            }
        } catch {
            print("Failed to search recipes by cuisine: \(error)")
        }
    }
    
    func fetchInstructions(for recipeId: Int) async -> [Instructions] {
        let url = "https://api.spoonacular.com/recipes/\(recipeId)/analyzedInstructions?apiKey=546b720dd1364370aac95e4048ae91a5"
        
        do {
            let result: [AnalyzedInstruction] = try await api.get(url: url)
            return result.first?.steps ?? []
        } catch {
            print("Error fetching instructions: \(error)")
            return []
        }
    }
}
