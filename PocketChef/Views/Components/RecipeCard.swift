import SwiftUI

struct RecipeCard: View {
    var recipe: ApiRecipe
    @EnvironmentObject var db: DbConnection
    
    var isAdded: Bool {
        guard let recipeId = recipe.id else { return false }
        return db.currentUserData?.recipes.contains(recipeId) ?? false
    }
    
    var body: some View {
        VStack {
            HStack(alignment: .center, spacing: 20) {
                AsyncImage(url: URL(string: recipe.image)) { image in
                    image
                        .resizable()
                        .scaledToFill()
                } placeholder: {
                    Text("Loading...")
                }
                .frame(width: 100, height: 100)
                .clipShape(Circle())
                
                Text(recipe.title)
                    .font(.headline)
                    .foregroundColor(Color.white.opacity(0.87))
            }
            .padding()
            Spacer()
            recipeButton
                .padding()
        }
        .frame(width: 375, height: 250, alignment: .center)
        .background(.cardBlue)
        .clipShape(.buttonBorder)
    }
    
    var recipeButton: some View {
        ShadowButton(text: isAdded ? "Delete Recipe" : "Add Recipe") {
            guard let recipeId = recipe.id else { return }
            
            if isAdded {
                db.deleteRecipe(id: recipeId)
            } else {
                db.addRecipe(recipeId: recipeId)
            }
        }
        .padding()
    }
}


#Preview {
    RecipeCard(recipe: ApiRecipe(
        recipeId: 1222,
        title: "Chicken Tikka Masala",
        image: "https://www.seriouseats.com/thmb/DbQHUK2yNCALBnZE-H1M2AKLkok=/1500x0/filters:no_upscale():max_bytes(150000):strip_icc()/chicken-tikka-masala-for-the-grill-recipe-hero-2_1-cb493f49e30140efbffec162d5f2d1d7.JPG"))
    .environmentObject(DbConnection())
}
