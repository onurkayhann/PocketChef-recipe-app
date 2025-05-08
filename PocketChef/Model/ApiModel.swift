import Foundation
import FirebaseFirestore

struct LoginRequest: Encodable {
    var email: String
    var password: String
}

struct RegisterRequest: Encodable {
    var name: String
    var email: String
    var pasword: String
}

struct AuthResponse: Decodable {
    var success: Bool
    var message: String
}

typealias RecipeResponse = [ApiRecipe]

struct RecipeResponseWrapper: Codable {
    let results: RecipeResponse
}

struct ApiRecipe: Codable, Identifiable {
    var id: String? { String(recipeId) }

        let recipeId: Int
        let title: String
        let image: String
        var instructions: String = ""
        var intolerances: [String] = []
        var cuisine: String = "Unknown"

        enum CodingKeys: String, CodingKey {
            case recipeId = "id"
            case title
            case image
        }
    }

extension ApiRecipe {
    func toSavedRecipe() -> SavedRecipe {
        return SavedRecipe(id: id, title: title, image: image, instructions: instructions, intolerances: intolerances, cuisine: cuisine)
    }
}

struct SavedRecipe: Codable {
    var id: String?
    var title: String
    var image: String
    var instructions: String
    var intolerances: [String]
    var cuisine: String
}
 
