import SwiftUI

struct ContentView: View {
    @EnvironmentObject var db: DbConnection
    
    var body: some View {
        if db.currentUser != nil {
            // Inloggad vy
            NavigationStack {
                PickerView()
            }
        } else {
            // Utloggad vy
            NavigationStack {
                LoginView()
            }
        }
    }
}

#Preview {
    ContentView().environmentObject(DbConnection())
}
