import SwiftUI

struct FinishGameScreen: View {
    @EnvironmentObject var vm: ViewModel
    
    var body: some View {
        ZStack {
            LinearGradient(colors: [.purpleGradientUp, .purpleGradientDown], startPoint: .top, endPoint: .bottom)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .ignoresSafeArea()
            
            VStack(spacing: 24) {
                
                HStack {
                    Button {
                        vm.resetProgress()
                        vm.goBackToRoot()
                    } label: {
                        Image(.Icons.cross)
                    }
                    .padding(16)
                    Spacer()
                }
                Spacer()
                
                Text("Nice Work")
                    .customFont(.poppins600, 28)
                    .foregroundStyle(.white)
                
                ZStack {
                    Circle()
                        .foregroundColor(.redLight)
                        .overlay(
                            RoundedRectangle(cornerRadius: 60)
                                .stroke(.white, lineWidth: 1.5)
                        )
                        .frame(maxWidth: 120, maxHeight: 120)
                    
                    Circle()
                        .foregroundColor(.redLight)
                        .overlay(
                            RoundedRectangle(cornerRadius: 37)
                                .stroke(.white, lineWidth: 1.5)
                        )
                        .frame(maxWidth: 78, maxHeight: 78)
                    
                    Image(.Icons.done)
                }
                
                StarsView(state: vm.starsState)
                    .padding(10)
                
                HStack {
                    Text(vm.makeAttributedString(points: vm.addingPoints))
                        .foregroundStyle(.white)
                }
                Spacer()
                
                DefaultButton(text: "Claim") {
                    vm.resetProgress()
                    vm.goBackToRoot()
                }
            }
        }
        .toolbar(.hidden, for: .navigationBar)
    }
}

struct StarsView: View {
    var state: StarsState
    
    var stars: [Image] {
        switch state {
        case .noStar:
            return [Image(.Icons.starPurple), Image(.Icons.starPurple), Image(.Icons.starPurple)]
        case .oneStar:
            return [Image(.Icons.starYellow), Image(.Icons.starPurple), Image(.Icons.starPurple)]
        case .twoStar:
            return [Image(.Icons.starYellow), Image(.Icons.starYellow), Image(.Icons.starPurple)]
        case .threeStar:
            return [Image(.Icons.starYellow), Image(.Icons.starYellow), Image(.Icons.starYellow)]
        }
    }
    
    var body: some View {
        HStack(spacing: 10) {
            ForEach(0..<3) { index in
                let size: CGFloat = index == 1 ? 52 : 32
                HStack(spacing: 10) {
                    stars[index]
                        .resizable()
                        .frame(width: size, height: size)
                }
            }
        }
    }
}

#Preview {
    FinishGameScreen()
        .environmentObject(ViewModel())
}
