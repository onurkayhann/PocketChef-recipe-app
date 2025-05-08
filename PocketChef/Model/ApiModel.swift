import Foundation
import FirebaseFirestore

struct ApiRecipe: Codable, Identifiable {
    @DocumentID var id: String?
    var title: String
    var imageUrl: String
    var instructions: String
    var intolerances: [String]
    var cuisine: String
}
 
