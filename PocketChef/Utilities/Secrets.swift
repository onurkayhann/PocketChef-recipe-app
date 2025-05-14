import Foundation

enum Secrets {
    static var spoonacularAPIKey: String {
        guard let filePath = Bundle.main.path(forResource: "Secrets", ofType: "plist"),
              let plist = NSDictionary(contentsOfFile: filePath),
              let value = plist["SpoonacularAPIKey"] as? String else {
            fatalError("Couldn't find API key in Secrets.plist")
        }
        return value
    }
}
