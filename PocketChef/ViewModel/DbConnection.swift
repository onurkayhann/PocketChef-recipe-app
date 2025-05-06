import Foundation
import FirebaseFirestore
import FirebaseAuth

class DbConnection {
    var db = Firestore.firestore()
    var auth = Auth.auth()
    let COLLECTION_RECIPES = "recipes"
    var recipes: [Recipe] = []
    
    func deleteRecipe(id: String) {
        let recipeToDelete = recipes.first { $0.id == id }
        
        guard let recipeToDelete = recipeToDelete else { return }
        guard let recipeId = recipeToDelete.id else { return }
        
        db.collection(COLLECTION_RECIPES).document(recipeId).delete()
    }
    
    func startListeningToDb() {
        db.collection(COLLECTION_RECIPES).addSnapshotListener { snapshot, error in
            
            if let error = error {
                print("Error on snapshot: \(error.localizedDescription)")
                return
            }
            
            guard let snapshot = snapshot else { return }
            
            self.recipes = []
            
            for document in snapshot.documents {
                
                do {
                    let recipe = try document.data(as: Recipe.self)
                    self.recipes.append(recipe)
                } catch let error {
                    print("Omvandlingsfel! \(error.localizedDescription)")
                }
                
            }
        }
    }
}
