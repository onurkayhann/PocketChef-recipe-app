import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var db: DbConnection
    
    var body: some View {
        VStack {
            Text("Hello \(db.currentUserData?.name ?? "")! Here you can edit your settings")
            Spacer()
            LogoutButton(text: "Logout", action: {
                db.signOut()
            })
            .frame(width: 250)
            .padding(.bottom, 40)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color("background"))
        .ignoresSafeArea()
    }
}

#Preview {
    SettingsView()
        .environmentObject(DbConnection())
}
