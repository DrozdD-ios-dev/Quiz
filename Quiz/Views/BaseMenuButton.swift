import SwiftUI

struct BaseMenuButton: View {
    var color: Color
    var icon: Image
    var body: some View {
        ZStack {
            color
                .frame(width: 72, height: 72)
                .border(.black)
                .cornerRadius(25)
                .overlay(
                    RoundedRectangle(cornerRadius: 25)
                        .stroke(.black, lineWidth: 2)
                )
            icon
        }
    }
}

#Preview {
    BaseMenuButton(color: .greenLight, icon: Image(.Icons.arrowRight))
}
