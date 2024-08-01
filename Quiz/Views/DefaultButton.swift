import SwiftUI

struct DefaultButton: View {
    let text: String
    let color: Color
    let action: () -> Void
    
    var body: some View {
        Button {
            action()
        } label: {
            Text("\(text)")
                .foregroundStyle(.black)
                .padding(.vertical, 16)
                .frame(maxWidth: .infinity)
                .background(color)
                .cornerRadius(25)
                .padding(.horizontal, 16)
                .font(.customFont(.poppins700, 16))
        }
        .buttonStyle(.plain)
    }
}

#Preview(body: {
    DefaultButton(text: "Claim", color: .greenLight) {
        
    }
})
