import SwiftUI

struct HomeView: View {
    @EnvironmentObject var db: DbConnection
    @EnvironmentObject var recipeManager: RecipeManager
    
    var body: some View {
        Text(db.currentUserData?.name ?? "John Doe")
        
        Button(action: {
            db.signOut()
        }) {
            Text("Logout")
                .frame(width: 220)
                .padding()
                .background(Color("DarkerBlue"))
                .foregroundColor(.white)
                .clipShape(Capsule())
        }.padding()
        
        ScrollView {
            ForEach(recipeManager.recipes) { recipe in
                RecipeCard(recipe: recipe)
            }
        }.task {
            await recipeManager.fetchTopRecipes()
        }
    }
}

#Preview {
    HomeView()
        .environmentObject(DbConnection())
        .environmentObject(RecipeManager())
}
