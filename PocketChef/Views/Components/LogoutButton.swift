import SwiftUI

struct LogoutButton: View {
  let text: String
  let action: () -> Void

  var body: some View {
    Button(action: {
      action()
    }, label: {
      Text(text)
        .logoutButtonTextStyle()
    })
    .buttonStyle(.shadowLogout)
  }
}

extension ButtonStyle where Self == LogoutButtonStyle {
  static var shadowLogout: LogoutButtonStyle {
    .init()
  }
}

struct LogoutButtonStyle: ButtonStyle {
  func makeBody(configuration: Configuration) -> some View {
    configuration.label
      .frame(maxWidth: .infinity)
      .padding([.top, .bottom], 12)
      .background(
        Capsule()
          .foregroundColor(Color("background"))
          .shadow(color: Color("drop-shadow"), radius: 4, x: 6, y: 6)
          .shadow(color: Color("drop-highlight"), radius: 4, x: -6, y: -6))
  }
}

extension Text {
  func logoutButtonTextStyle() -> some View {
    self
    .font(.body)
    .fontWeight(.bold)
  }
}

struct LogoutButton_Previews: PreviewProvider {
  static var previews: some View {
    ZStack {
        LogoutButton(text: "Get Started") {
        print("Hello World")
      }
      .buttonStyle(.shadowLogout)
      .padding(20)
    }
    .background(Color("background"))
    .previewLayout(.sizeThatFits)
  }
}
