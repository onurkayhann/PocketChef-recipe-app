import Foundation
import FirebaseFirestore
import FirebaseAuth

class DbConnection: ObservableObject {
    var db = Firestore.firestore()
    
    let COLLECTION_RECIPES = "recipes"
    @Published var recipes: [ApiRecipe] = []
    var recipesListener: ListenerRegistration?

    var auth = Auth.auth()
    let COLLECTION_USER_DATA = "user_data"
    @Published var currentUser: User?
    @Published var currentUserData: UserData?
    var userDataListener: ListenerRegistration?
    
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
    
    func signOut() {
        do {
            try auth.signOut()
            currentUser = nil
            currentUserData = nil
        } catch _ {
            
        }
    }
    
    init() {
        auth.addStateDidChangeListener { auth, user in
            
            if let user = user {
                // Användaren har loggat in
                self.currentUser = user
                self.startRecipeListener()
                self.startUserDataListener()
            } else {
                // Användaren har loggat ut
                self.currentUser = nil
                self.recipesListener?.remove()
                self.recipesListener = nil
                
                self.userDataListener?.remove()
                self.userDataListener = nil
                self.currentUserData = nil
            }
        }
    }
    
    func addRecipe(recipeId: String) {
        guard let currentUser = currentUser else { return }
        
        do {
            try db.collection(COLLECTION_USER_DATA)
                .document(currentUser.uid)
                .updateData(["recipes": FieldValue.arrayUnion([recipeId])])
        } catch _ {
            print("Something went wrong adding recipe to userData")
        }
    }
    
    func deleteRecipe(id: String) {
        guard let currentUser = currentUser else { return }

        db.collection(COLLECTION_USER_DATA)
            .document(currentUser.uid)
            .updateData([
                "recipes": FieldValue.arrayRemove([id])
            ]) { error in
                if let error = error {
                    print("Failed to remove recipe: \(error.localizedDescription)")
                } else {
                    print("Recipe removed from user favorites.")
                }
            }
    }
    
    func startRecipeListener() {
        recipesListener = db.collection(COLLECTION_RECIPES).addSnapshotListener { snapshot, error in
            
            if let error = error {
                print("Error on snapshot: \(error.localizedDescription)")
                return
            }
            
            guard let snapshot = snapshot else { return }
            
            self.recipes = []
            
            for document in snapshot.documents {
                
                do {
                    print("🧾 Firestore raw data:", document.data())
                    let recipe = try document.data(as: ApiRecipe.self)
                    self.recipes.append(recipe)
                } catch let error {
                    print("Omvandlingsfel! \(error.localizedDescription)")
                }
                
            }
        }
    }
    
    func startUserDataListener() {
        guard let currentUser = currentUser else { return }
        userDataListener = db.collection(COLLECTION_USER_DATA).document(currentUser.uid).addSnapshotListener { snapshot, error in
            
            if let error = error {
                print("Error listening to user data! \(error.localizedDescription)")
                return
            }
            
            guard let snapshot = snapshot else { return }
            
            do {
                self.currentUserData = try snapshot.data(as: UserData.self)
            } catch _ {
                print("Could not convert userData!")
            }
        }
    }
}
