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
                print("❌ Error saving recipe \(id): \(error)")
            }
        }
    }
    
    func fetchTopRecipes() async {
        let url = "https://api.spoonacular.com/recipes/complexSearch?number=10&apiKey=\(API_KEY)"
        
        do {
            let response: RecipeResponseWrapper = try await api.get(url: url)
            DispatchQueue.main.async {
                self.recipes = response.results
                self.saveRecipesToFirestore(response.results) // ✅ Save to Firestore
            }
        } catch {
            print("❌ Failed to fetch recipes: \(error)")
        }
    }
}
