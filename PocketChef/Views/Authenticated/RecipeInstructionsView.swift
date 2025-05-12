import SwiftUI

struct RecipeInstructionsView: View {
    var recipe: ApiRecipe
    
    @EnvironmentObject var recipeManager: RecipeManager
    @State private var instructions: [Instructions] = []
    
    var body: some View {
        ScrollView {
            if instructions.isEmpty {
                ProgressView("Loading instructions...")
            } else {
                VStack(alignment: .leading, spacing: 16) {
                    ForEach(instructions) { instruction in
                        Text("Step \(instruction.number):")
                            .font(.headline)
                        Text(instruction.step)
                            .padding(.bottom, 8)
                    }
                }
                .padding()
            }
        }
        .navigationTitle(recipe.title)
        .task {
            if let id = recipe.recipeId as Int? {
                instructions = await recipeManager.fetchInstructions(for: id)
            }
        }
    }
}

#Preview {
    let recipe = ApiRecipe(recipeId: 1234, title: "Sample Dish", image: "")
    return RecipeInstructionsView(recipe: recipe)
        .environmentObject(RecipeManager())
}
