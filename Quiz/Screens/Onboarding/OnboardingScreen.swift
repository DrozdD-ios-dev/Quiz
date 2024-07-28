import SwiftUI

struct OnboardingScreen: View {
    @EnvironmentObject var vm: ViewModel
    let deviceHeight = UIScreen.main.bounds.height
    
    var body: some View {
        ZStack {
            LinearGradient(colors: [.purpleGradientUp, .purpleGradientDown], startPoint: .top, endPoint: .bottom)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .ignoresSafeArea()
            
            VStack(spacing: 0) {
                HStack {
                    Image(.Images.character)
                    Spacer()
                }
                
                ZStack {
                    HStack {
                        Color(.white)
                            .frame(width: 50, height: deviceHeight * 0.375)
                        Spacer()
                    }
                    
                    Color(.white)
                        .frame(height: deviceHeight * 0.375)
                        .cornerRadius(40)
                        .padding(.trailing, 48)
                    
                    HStack {
                        VStack(spacing: 30) {
                            Text("Interesting QUIZ \nAwaits You")
                                .customFont(.poppins700, 28)
                                .lineLimit(2)
                                .multilineTextAlignment(.center)
                            
                            Text(" play quizzes \nand get various prizes")
                                .customFont(.poppins400, 16)
                                .foregroundStyle(.gray167)
                                .lineLimit(2)
                                .multilineTextAlignment(.center)
                        }
                    }
                    .padding(.trailing, 48)
                }
                
                Button {
                    vm.goBackToRoot()
                } label: {
                    BaseMenuButton(color: .greenLight, icon: Image(.Icons.arrowRight))
                }
                .offset(y: -36)
            }
            .offset(y: -40)
        }
        .toolbar(.hidden, for: .navigationBar)
    }
}

#Preview {
    OnboardingScreen()
        .environmentObject(ViewModel())
}
