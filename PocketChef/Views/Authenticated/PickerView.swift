import SwiftUI

struct PickerView: View {
    enum Tab: String, CaseIterable, Identifiable {
        case home = "Home"
        case settings = "Settings"
        case favoriteRecipes = "My Recipes"
        
        var id: String { self.rawValue }
    }
    
    @State private var selectedTab: Tab = .home
    
    var body: some View {
            VStack {
                Picker("View Picker", selection: $selectedTab) {
                    ForEach(Tab.allCases) { tab in
                        Text(tab.rawValue).tag(tab)
                    }
                }
                .pickerStyle(.segmented)
                .padding()

                Spacer()

                switch selectedTab {
                case .home:
                    HomeView()
                case .settings:
                    SettingsView()
                case .favoriteRecipes:
                    FavoriteRecipesView()
                }
            }
        }
}

#Preview {
    PickerView()
}
