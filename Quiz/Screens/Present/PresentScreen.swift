import SwiftUI

struct PresentScreen: View {
    @EnvironmentObject var vm: ViewModel
    
    var body: some View {
            ZStack {
                LinearGradient(colors: [.purpleGradientUp, .purpleGradientDown], startPoint: .top, endPoint: .bottom)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .ignoresSafeArea()
                
                VStack(spacing: 24) {
                    
                    HStack {
                        Button {
                            vm.goBack()
                        } label: {
                            Image(.Icons.cross)
                        }
                        .padding(16)
                        Spacer()
                    }
                    Spacer()
                    
                    Text("Claim")
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
                        
                        Image(.Icons.present)
                    }
            
                    HStack {
                        Text(vm.makeAttributedString(points: 20))
                            .foregroundStyle(.white)
                    }
                    Spacer()
                    
                    DefaultButton(text: "Claim", color: .greenLight) {
                        vm.goBack()
                    }
                }
            }
            .toolbar(.hidden, for: .navigationBar)
        }
    }

#Preview {
    PresentScreen()
        .environmentObject(ViewModel())
}
