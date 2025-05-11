import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var db: DbConnection
    
    let settings: Array<SettingsModel> = [
       SettingsModel(title: "Edit Profile", color: .cardBlue, imageName: "person.crop.circle"),
       SettingsModel(title: "Language", color: .cardBlue, imageName: "globe"),
       SettingsModel(title: "Change Password", color: .cardBlue, imageName: "lock.fill"),
       SettingsModel(title: "About PocketChef", color: .cardBlue, imageName: "info.circle.fill"),
       SettingsModel(title: "Rate This App", color: .cardBlue, imageName: "star.fill"),
       SettingsModel(title: "Saved Recipes", color: .cardBlue, imageName: "fork.knife.circle.fill")
    ]
    
    var body: some View {
           VStack(spacing: 0) {
               Text("Hello \(db.currentUserData?.name ?? "")! Here you can edit your settings")
                   .font(.headline)
                   .padding()

               List {
                   ForEach(settings, id: \.self) { setting in
                       HStack {
                           ZStack {
                               RoundedRectangle(cornerRadius: 8)
                                   .fill(setting.color)
                                   .frame(width: 36, height: 36)
                               Image(systemName: setting.imageName)
                                   .foregroundColor(.white)
                                   .frame(width: 20, height: 20)
                           }
                           
                           Text(setting.title)
                               .foregroundColor(.primary)
                               .padding(.leading, 5)

                           Spacer()

                           Image(systemName: "chevron.right")
                               .foregroundColor(.gray)
                       }
                       .padding(.vertical, 2)
                   }
               }
               .scrollContentBackground(.hidden)
               .background(Color("background"))
               
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
