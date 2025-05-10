import SwiftUI

struct HomeView: View {
    @EnvironmentObject var db: DbConnection
    @EnvironmentObject var recipeManager: RecipeManager
    
    var body: some View {
        Text(db.currentUserData?.name ?? "John Doe")
        
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
