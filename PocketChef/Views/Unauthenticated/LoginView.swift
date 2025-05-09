import SwiftUI

struct LoginView: View {
    @State private var email: String = ""
    @State private var password: String = ""
    @EnvironmentObject var db: DbConnection
    
    var body: some View {
        VStack {
            Image("PocketChef-logo")
                .resizable()
                .scaledToFit()
                .frame(width: 150, height: 150)
                .offset(y: -50)

                        
            VStack(spacing: 20) {
                Text("Login")
                    .font(.largeTitle)
                    .bold()
                    .foregroundStyle(.white)
                
                TextField("Email", text: $email)
                    .textFieldStyle(.roundedBorder)
                    .frame(width: 250)
                    .cornerRadius(8)
                    .keyboardType(.emailAddress)
                    .autocapitalization(.none)
                
                SecureField("Password", text: $password)
                    .textFieldStyle(.roundedBorder)
                    .frame(width: 250)
                    .cornerRadius(8)
                
                ShadowButton(text: "Login") {
                    db.loginUser(email: email, password: password)
                }
                .frame(width: 250)
                
                NavigationLink(destination: RegisterView(), label: {
                    Text("Don't have an account? Register")
                        .foregroundColor(Color.white.opacity(0.87))
                        .bold()
                        .padding()
                        .underline()
                })
            }
            .frame(width: 300, height: 500)
            .background(.cardBlue)
            .cornerRadius(16)
        }
    }
}

#Preview {
    LoginView().environmentObject(DbConnection())
}
