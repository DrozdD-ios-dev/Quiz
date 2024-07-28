import SwiftUI

struct PlayScreen: View {
    @EnvironmentObject var vm: ViewModel
    
    var body: some View {
        ZStack {
            LinearGradient(colors: [.purpleGradientUp, .purpleGradientDown], startPoint: .top, endPoint: .bottom)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .ignoresSafeArea()
            
            VStack(spacing: 24) {
                
                ZStack {
                    HStack {
                        Button {
                            vm.goBack()
                        } label: {
                            Image(.Icons.chevronLeft)
                        }
                        .padding()
                        Spacer()
                    }
                    Text("Question \(vm.currentQuestionID + 1)")
                        .customFont(.poppins500, 20)
                        .foregroundStyle(.white)
                }
                
                PlayProgressView(progress: vm.questionProgress)
                    .frame(height: 40)
                    .padding(.horizontal, 24)
                ZStack {
                    Color(.white)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .cornerRadius(40)
                        .padding(.horizontal, 16)
                        .padding(.bottom, 16)
                    
                    Text(vm.currentQuestion.title)
                        .customFont(.poppins700, 24)
                        .foregroundStyle(.blueDark)
                        .lineLimit(3)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 30)
                    
                }
                
                ForEach(0..<3) { number in
                    CustomButton(
                        text: "\(vm.currentQuestion.answers[number].letter)",
                        state: vm.buttonStates[number]) {
                            guard !vm.isButtonDisabled else { return }
                            Task { await vm.answerButtonTapped(index: number) }
                        }
                }
                Spacer()
            }
        }
        .toolbar(.hidden, for: .navigationBar)
    }
}

struct PlayProgressView: View {
    let progress: CGFloat
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                Rectangle()
                    .frame(width: geometry.size.width, height: 10)
                    .foregroundColor(.purpleLight)
                    .cornerRadius(5)
                Rectangle()
                    .frame(
                        width: min(progress * geometry.size.width,
                                   geometry.size.width),
                        height: 10
                    )
                    .cornerRadius(8)
                    .foregroundColor(.greenLight)
            }
        }
    }
}

#Preview {
    PlayScreen()
        .environmentObject(ViewModel())
}
