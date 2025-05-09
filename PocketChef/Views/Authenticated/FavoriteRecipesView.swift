import SwiftUI

struct FavoriteRecipesView: View {
    @EnvironmentObject var db: DbConnection
    @EnvironmentObject var recipeManager: RecipeManager
    
    var body: some View {
        VStack {
            Text("Favorite Recipes below") // render user name here maybe?
                .font(.title)
                .bold()
                .foregroundStyle(.black)
                .padding(.top, 30)
            
            if let myFavoriteRecipes = db.currentUserData?.recipes, !myFavoriteRecipes.isEmpty {
                ScrollView {
                    ForEach(recipeManager.recipes.filter { recipe in
                        if let id = recipe.id {
                            return myFavoriteRecipes.contains(id)
                        }
                        return false
                    }) { recipe in
                        RecipeCard(recipe: recipe)
                    }
                }
            } else {
                Text("You have no favorite recipes yet.")
                    .foregroundColor(.gray)
                    .padding()
            }
        }
    }
}

#Preview {
    FavoriteRecipesView()
        .environmentObject(DbConnection())
}
