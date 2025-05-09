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
                
                Button(action: {
                    db.registerUser(name: name, email: email, password: password, confirmPassword: confirmPassword)
                }) {
                    Text("Register")
                        .frame(width: 220)
                        .padding()
                        .background(Color("DarkerBlue"))
                        .foregroundColor(.white)
                        .clipShape(Capsule())
                }.padding()
                
                Button(action: {
                    dismiss()
                }) {
                    Text("Already have an account? Login")
                        .foregroundStyle(Color.white)
                        .bold()
                        .padding()
                        .underline()
                }
            }
            .frame(width: 300, height: 500)
            .background(Color("Blue"))
            .cornerRadius(16)
        }
    }
}


#Preview {
    RegisterView().environmentObject(DbConnection())
}
