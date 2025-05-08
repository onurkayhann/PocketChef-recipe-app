import Foundation

class RecipeManager: ObservableObject {
    let api = Api()
    
    @Published var recipes: [ApiRecipe] = []
    
    let BASE_URL = ""
    let API_KEY = "22e0c12bc5ea49d09d1f3e73c1a78258"
    
    func fetchTopRecipes() async {
            let url = "https://api.spoonacular.com/recipes/complexSearch?number=10&apiKey=\(API_KEY)"

            do {
                let response: RecipeResponseWrapper = try await api.get(url: url)
                DispatchQueue.main.async {
                    self.recipes = response.results
                }
            } catch {
                print("❌ Failed to fetch recipes: \(error)")
            }
        }
}
