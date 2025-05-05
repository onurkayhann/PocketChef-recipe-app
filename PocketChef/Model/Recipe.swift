import Foundation

struct Recipe: Codable {
    var title: String
    var imageUrl: String
    var instructions: String
    var intolerances: [String]
    var cuisine: String
}
 
