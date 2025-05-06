import SwiftUI

struct RegisterView: View {
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var confirmPassword: String = ""
    
    var body: some View {
        VStack {
            Image("PocketChef-logo")
                .resizable()
                .scaledToFit()
                .frame(width: 150, height: 150)
                .offset(y: -40)
                        
            VStack(spacing: 20) {
                Text("Register")
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
                
                SecureField("Confirm Password", text: $confirmPassword)
                    .textFieldStyle(.roundedBorder)
                    .frame(width: 250)
                    .cornerRadius(8)
                
                Button("Register") {
                    // register
                }
                .frame(width: 220)
                .padding()
                .background(Color("DarkerBlue"))
                .foregroundColor(.white)
                .clipShape(Capsule())
                
                NavigationLink(destination: LoginView(), label: {
                    Text("Already have an account? Login")
                        .foregroundStyle(Color.white)
                        .bold()
                        .padding()
                        .underline()
                })
            }
            .frame(width: 300, height: 500)
            .background(Color("Blue"))
            .cornerRadius(16)
        }
    }
}


#Preview {
    RegisterView()
}
