import SwiftUI

struct BaseMenuButton: View {
    var color: Color
    var icon: Image
    let action: () -> Void
    
    var body: some View {
        Button {
            action()
        } label: {
            ZStack {
                color
                    .frame(width: 72, height: 72)
                    .border(.black)
                    .cornerRadius(28)
                    .overlay(
                        RoundedRectangle(cornerRadius: 28)
                            .stroke(.black, lineWidth: 2)
                    )
                icon
            }
        }
    }
}

#Preview {
    BaseMenuButton(color: .greenLight, icon: Image(.Icons.arrowRight)) {
        
    }
}
