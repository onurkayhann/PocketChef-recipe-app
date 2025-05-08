import SwiftUI

struct RecipeCard: View {
    var recipe: ApiRecipe
    
    var body: some View {
        VStack {
            
            HStack(alignment: .center, spacing: 40) {
                AsyncImage(url: URL(string: recipe.imageUrl)) { image in
                                    image
                                        .resizable()
                                        .scaledToFill()
                                } placeholder: {
                                    Text("Loading...")
                                }
                                .frame(width: 100, height: 100)
                                .clipShape(Circle())
                Text(recipe.title)
            }
            .padding()
            Spacer()
            
            HStack(alignment: .center, spacing: 60) {
                Text(recipe.cuisine)
                HStack(spacing: 8) { 
                        ForEach(recipe.intolerances, id: \.self) { intolerance in
                            Text(intolerance)
                                .padding(6)
                                .background(Color.white.opacity(0.2))
                                .clipShape(Capsule())
                                .foregroundColor(.white)
                        }
                    }
            }
            Button(action: {
                // Make this embossed button
            }) {
                Text("Add Recipe")
                    .frame(width: 220)
                    .padding()
                    .background(Color("DarkerBlue"))
                    .foregroundColor(.white)
                    .clipShape(Capsule())
            }.padding()
        }
        .frame(width: 375, height: 250, alignment: .center)
        .background(.blue)
        .clipShape(.buttonBorder)
    }
}

#Preview {
    RecipeCard(recipe: ApiRecipe(
        title: "Chicken Tikka Masala",
        imageUrl: "https://www.seriouseats.com/thmb/DbQHUK2yNCALBnZE-H1M2AKLkok=/1500x0/filters:no_upscale():max_bytes(150000):strip_icc()/chicken-tikka-masala-for-the-grill-recipe-hero-2_1-cb493f49e30140efbffec162d5f2d1d7.JPG",
        instructions: "1. Boil Chicken. 2. Cook",
        intolerances: ["Gluten", "Nuts"],
        cuisine: "Indian"))
}
