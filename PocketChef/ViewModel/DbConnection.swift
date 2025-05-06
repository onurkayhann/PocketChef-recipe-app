import Foundation
import FirebaseFirestore
import FirebaseAuth

class DbConnection {
    var db = Firestore.firestore()
    var auth = Auth.auth()
    let COLLECTION_RECIPES = "recipes"
    var recipes: [Recipe] = []
    
    let COLLECTION_USER_DATA = "user_data"
    @Published var currentUser: User?
    @Published var currentUserData: UserData?
    
    func registerUser(name: String, email: String, password: String, confirmPassword: String) {
        guard password == confirmPassword else {
            print("Error: Passwords do not match!")
            return
        }
        
        auth.createUser(withEmail: email, password: password) { authResult, error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
                return
            }
            
            guard let authResult = authResult else { return }
            
            let newUserData = UserData(name: name, favoriteRecipes: [])
            
            do {
                try self.db.collection(self.COLLECTION_USER_DATA).document(authResult.user.uid).setData(from: newUserData)
            } catch let error {
                print("Failed to create userData: \(error.localizedDescription)")
            }
        }
    }
    
    func loginUser(email: String, password: String) {
        auth.signIn(withEmail: email, password: password)
    }
    
    init() {
        auth.addStateDidChangeListener { auth, user in
            
            if let user = user {
                // Användaren har loggat in
                self.currentUser = user
                self.startListeningToDb()
            } else {
                // Användaren har loggat ut
                self.currentUser = nil
            }
        }
    }
    
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
