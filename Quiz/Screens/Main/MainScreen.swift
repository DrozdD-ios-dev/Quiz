import SwiftUI

struct MainScreen: View {
    @EnvironmentObject var vm: ViewModel
    
    var body: some View {
        ZStack {
            LinearGradient(colors: [.purpleGradientUp, .purpleGradientDown], startPoint: .top, endPoint: .bottom)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .ignoresSafeArea()
            
            VStack {
                
                HStack(spacing: 40) {
                    CustomProgressView(progress: vm.currentProgress, level: vm.user.level)
                        .frame(width: 240, height: 30)
                    
                    VStack {
                        Text("Points")
                            .customFont(.poppins400, 14)
                            .foregroundStyle(.white)
                        
                        Text("\(vm.user.points)")
                            .customFont(.poppins700, 20)
                            .foregroundStyle(.white)
                    }
                }
                Spacer()
                
                Image(.Images.swords)
                    .frame(width: 100, height: 100)
                    .padding(.top, 150)
                
                Spacer()
                
                Button {
                    vm.showPlayScreen()
                } label: {
                    HStack {
                        Text("PLAY")
                            .customFont(.poppins800, 32)
                            .foregroundStyle(.white)
                        Image(.Images.play)
                    }
                }
                Spacer()
                
                HStack(spacing: 16) {
                    Button {
                        vm.showCalendarScreen()
                    } label: {
                        BaseMenuButton(color: .redLight, icon: Image(.Icons.calendar))
                    }
                    
                    Button {
                        vm.showMapScreen()
                    } label: {
                        BaseMenuButton(color: .greenLight, icon: Image(.Icons.map))
                    }
                }
                Spacer()
            }
        }
        .toolbar(.hidden, for: .navigationBar)
        .onAppear {
            vm.setupSettings()
        }
    }
}

struct CustomProgressView: View {
    let progress: CGFloat
    let level: Int
    
    var body: some View {
        GeometryReader { geometry in
            HStack(spacing: -5) {
                ZStack(alignment: .leading) {
                    Rectangle()
                        .frame(width: geometry.size.width, height: 10)
                        .foregroundColor(.white)
                        .cornerRadius(5)
                        .padding(.leading, -1)
                    Rectangle()
                        .frame(
                            width: min(progress * geometry.size.width,
                                       geometry.size.width),
                            height: 8
                        )
                        .cornerRadius(8)
                        .foregroundColor(.greenLight)
                }
                
                ZStack {
                    Color(.greenLight)
                        .frame(width: 28, height: 28)
                        .border(.white)
                        .cornerRadius(13)
                        .overlay(
                            RoundedRectangle(cornerRadius: 13)
                                .stroke(.white, lineWidth: 1)
                        )
                    Text("\(level)")
                        .customFont(.poppins700, 12)
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        MainScreen()
    }
    .environmentObject(ViewModel())
}
