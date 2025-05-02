import SwiftUI

struct LoginView: View {
    @State private var email: String = ""
    @State private var password: String = ""
    
    var body: some View {
        VStack {
            Image("PocketChef-logo")
                .resizable()
                .scaledToFit()
                .frame(width: 150, height: 150)
                        
            VStack(spacing: 20) {
                Text("Login")
                    .font(.largeTitle)
                    .bold()
                    .foregroundStyle(.white)

                TextField("Email", text: $email)
                    .padding()
                    .background(Color(.systemGray6))
                    .frame(width: 250)
                    .cornerRadius(8)
                    .keyboardType(.emailAddress)
                    .autocapitalization(.none)
                
                SecureField("Password", text: $password)
                    .padding()
                    .background(Color(.systemGray6))
                    .frame(width: 250)
                    .cornerRadius(8)
                
                Button("Login") {
                    // login
                }
                .frame(width: 200)
                .padding()
                .background(Color("DarkerBlue"))
                .foregroundColor(.white)
                .clipShape(Capsule())
            }
            .frame(width: 300, height: 500)
            .background(Color("Blue"))
            .cornerRadius(16)
        }
    }
}

#Preview {
    LoginView()
}
