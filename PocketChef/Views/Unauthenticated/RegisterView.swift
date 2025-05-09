import SwiftUI

struct RegisterView: View {
    @State private var name: String = ""
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var confirmPassword: String = ""
    
    @EnvironmentObject var db: DbConnection
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack {
            Image("PocketChef-logo")
                .resizable()
                .scaledToFit()
                .frame(width: 150, height: 150)
                .offset(y: -50)
            
            VStack(spacing: 20) {
                Text("Register")
                    .font(.largeTitle)
                    .bold()
                    .foregroundStyle(.white)
                
                TextField("Name", text: $name)
                    .textFieldStyle(.roundedBorder)
                    .frame(width: 250)
                    .cornerRadius(8)
                    .keyboardType(.emailAddress)
                    .autocapitalization(.none)
                
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
                
                SecureField("Confirm Password", text: $confirmPassword)
                    .textFieldStyle(.roundedBorder)
                    .frame(width: 250)
                    .cornerRadius(8)
                
                ShadowButton(text: "Register") {
                    db.registerUser(name: name, email: email, password: password, confirmPassword: confirmPassword)
                }
                .frame(width: 250)
                
                Button(action: {
                    dismiss()
                }) {
                    Text("Already have an account? Login")
                        .foregroundColor(Color.white.opacity(0.87))
                        .bold()
                        .padding()
                        .underline()
                }
            }
            .frame(width: 300, height: 500)
            .background(.cardBlue)
            .cornerRadius(16)
        }
    }
}


#Preview {
    RegisterView().environmentObject(DbConnection())
}
