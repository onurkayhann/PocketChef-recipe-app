import SwiftUI

struct HomeView: View {
    @EnvironmentObject var db: DbConnection
    var body: some View {
        Text(db.currentUserData?.name ?? "John Doe")
        
        Button(action: {
            db.signOut()
        }) {
            Text("Logout")
                .frame(width: 220)
                .padding()
                .background(Color("DarkerBlue"))
                .foregroundColor(.white)
                .clipShape(Capsule())
        }.padding()
    }
}

#Preview {
    HomeView().environmentObject(DbConnection())
}
