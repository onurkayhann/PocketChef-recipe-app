import SwiftUI

struct ShadowButton: View {
    let text: String
    let action: () -> Void
    
    var body: some View {
        Button(action: {
            action()
        }, label: {
            Text(text)
                .shadowButtonTextStyle()
                .foregroundColor(Color.white.opacity(0.92))
        })
        .buttonStyle(.shadow)
    }
}

extension ButtonStyle where Self == ShadowButtonStyle {
    static var shadow: ShadowButtonStyle {
        .init()
    }
}

struct ShadowButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(maxWidth: .infinity)
            .padding([.top, .bottom], 12)
            .background(
                Capsule()
                    .fill(Color("buttonBlue"))
                    .shadow(color: Color("buttonShadow"), radius: 4, x: 4, y: 4)
                    .shadow(color: Color("buttonHighlight"), radius: 4, x: -4, y: -4)
            )
            .opacity(configuration.isPressed ? 0.85 : 1)
    }
}

extension Text {
    func shadowButtonTextStyle() -> some View {
        self
            .font(.body)
            .fontWeight(.bold)
    }
}

struct RaisedButton_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            ShadowButton(text: "Get Started") {
                print("Hello World")
            }
            .buttonStyle(.shadow)
            .padding(20)
        }
        .background(Color("background"))
        .previewLayout(.sizeThatFits)
    }
}
