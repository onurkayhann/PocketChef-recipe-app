import Foundation

struct SecretKeys {
    static var spoonacularAPIKey: String {
        guard let url = Bundle.main.url(forResource: "Secrets", withExtension: "plist"),
              let data = try? Data(contentsOf: url),
              let dict = try? PropertyListSerialization.propertyList(from: data, options: [], format: nil) as? [String: Any],
              let key = dict["SpoonacularAPIKey"] as? String else {
            fatalError("SpoonacularAPIKey not found in Secrets.plist")
        }
        return key
    }
}
