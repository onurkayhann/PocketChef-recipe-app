import SwiftUI

struct RecipeCard: View {
    var recipe: ApiRecipe
    @EnvironmentObject var db: DbConnection
    @State private var isAdded = false
    
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
                    .foregroundColor(.white)
            }
            .padding()

            Spacer()

            Button(action: {
                guard let recipeId = recipe.id else { return }

                if isAdded {
                    db.deleteRecipe(id: recipeId)
                } else {
                    db.addRecipe(recipeId: recipeId)
                }

                isAdded.toggle()
            }) {
                Text(!isAdded ? "Add Recipe" : "Added")
                    .frame(width: 220)
                    .padding()
                    .background(Color("DarkerBlue"))
                    .foregroundColor(.white)
                    .clipShape(Capsule())
            }
            .padding()
        }
        .frame(width: 375, height: 250, alignment: .center)
        .background(.blue)
        .clipShape(.buttonBorder)
    }
}

#Preview {
    RecipeCard(recipe: ApiRecipe(
        recipeId: 1222,
        title: "Chicken Tikka Masala",
        image: "https://www.seriouseats.com/thmb/DbQHUK2yNCALBnZE-H1M2AKLkok=/1500x0/filters:no_upscale():max_bytes(150000):strip_icc()/chicken-tikka-masala-for-the-grill-recipe-hero-2_1-cb493f49e30140efbffec162d5f2d1d7.JPG"))
    .environmentObject(DbConnection())
}
