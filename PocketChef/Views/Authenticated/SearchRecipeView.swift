import SwiftUI

struct SearchRecipeView: View {
    @EnvironmentObject var db: DbConnection
    @EnvironmentObject var recipeManager: RecipeManager
    @State private var userInput: String = ""

    var body: some View {
        VStack {
            Text("Search Recipe")
                .font(.headline)
                .padding(.top)

            ScrollView {
                ForEach(recipeManager.recipes) { recipe in
                    NavigationLink(destination: RecipeInstructionsView(recipe: recipe)) {
                        RecipeCard(recipe: recipe)
                    }
                }
            }
            .searchable(text: $userInput, prompt: "Search by cuisine")
            .onChange(of: userInput) {
                Task {
                    if userInput.isEmpty {
                        await recipeManager.fetchTopRecipes()
                    } else {
                        await recipeManager.searchRecipesByCuisine(cuisine: userInput)
                    }
                }
            }
            .task {
                if recipeManager.recipes.isEmpty {
                    await recipeManager.fetchTopRecipes()
                }
            }
        }
    }
}

#Preview {
    SearchRecipeView()
        .environmentObject(DbConnection())
        .environmentObject(RecipeManager())
}
