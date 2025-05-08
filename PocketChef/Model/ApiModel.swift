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

struct ApiRecipe: Codable, Identifiable {
    var id: String? { UUID().uuidString }
    var title: String
    var imageUrl: String
    var instructions: String
    var intolerances: [String]
    var cuisine: String
}

extension ApiRecipe {
    func toSavedRecipe() -> SavedRecipe {
        return SavedRecipe(id: id, title: title, imageUrl: imageUrl, instructions: instructions, intolerances: intolerances, cuisine: cuisine)
    }
}

struct SavedRecipe: Codable {
    var id: String?
    var title: String
    var imageUrl: String
    var instructions: String
    var intolerances: [String]
    var cuisine: String
}
 
