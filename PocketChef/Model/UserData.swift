import Foundation

struct UserData: Codable {
    var name: String
    var recipes: [String]
    
    var favoriteRecipes: [String] {
        recipes
    }
}
