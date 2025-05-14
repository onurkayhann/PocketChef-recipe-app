import SwiftUI

struct RecipeInstructionsView: View {
    var recipe: ApiRecipe
    
    @EnvironmentObject var recipeManager: RecipeManager
    @State private var instructions: [Instructions] = []
    
    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                ZStack {
                    Color.blue.opacity(0.7)
                        .frame(height: 320)
                        .ignoresSafeArea()
                    
                    VStack(spacing: 12) {
                        Text(recipe.title)
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .multilineTextAlignment(.center)
                            .padding(.top, 50)
                        
                        AsyncImage(url: URL(string: recipe.image)) { image in
                            image
                                .resizable()
                                .scaledToFill()
                                .frame(width: 180, height: 180)
                                .clipShape(Circle())
                                .overlay(Circle().stroke(Color.blue, lineWidth: 4))
                                .shadow(radius: 10)
                        } placeholder: {
                            ProgressView()
                        }
                    }
                }
                
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
