import SwiftUI

struct CustomButton: View {
    let text: String
    let state: ButtonState
    let action: () -> Void
    
    var body: some View {
        Button {
            action()
        } label: {
            Text("\(text)")
                .foregroundStyle(state == .normal ? .white : (state == .right ? .black : .white))
                .padding(.vertical, 16)
                .frame(maxWidth: .infinity)
                .background(state == .normal ? .purpleGradientDown : (state == .right ? .greenLight : .redCustom))
                .cornerRadius(25)
                .overlay(
                    RoundedRectangle(cornerRadius: 25)
                        .stroke(state == .normal ? .white : (state == .right ? .greenLight : .white), lineWidth: 2)
                    )
                .padding(.horizontal, 16)
                .font(.customFont(.poppins700, 16))
        }
        .buttonStyle(.plain)
    }
}
