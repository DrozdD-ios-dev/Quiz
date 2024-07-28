import SwiftUI

struct CalendarScreen: View {
    @EnvironmentObject var vm: ViewModel
    var deviceWidth = UIScreen.main.bounds.width
    var deviceHeight = UIScreen.main.bounds.height
    
    var body: some View {
        ZStack {
            LinearGradient(colors: [.purpleGradientUp, .purpleGradientDown], startPoint: .top, endPoint: .bottom)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .ignoresSafeArea()
            
            GeometryReader { geometry in
                Circle()
                    .frame(width: deviceWidth * 2,
                           height: deviceHeight * 0.93)
                    .foregroundColor(.backgroundPurpleCircle)
                    .position(x: geometry.size.width / 2 + deviceWidth * 0.38, y: geometry.size.height - deviceHeight * 0.70)
            }
            
            VStack(spacing: 12) {
                Image(.Images.holiday)
                    .resizable()
                    .frame(width: deviceWidth < 380 ? 200 : 302, height: deviceWidth < 380 ? 200 : 302)
                
                VStack(spacing: 10) {
                    Text("You’ve earned a")
                        .customFont(.poppins500, 16)
                    
                    Text("\(vm.user.presentDay)-day streak")
                        .customFont(.poppins400, 44)
                        .frame(height: 20)
                        .padding(.bottom, 10)
                    
                    Text("Keep up this good work!")
                        .customFont(.poppins500, 14)
                        .foregroundStyle(.white.opacity(0.7))
                }
                
                HStack {
                    Text(" STREAK BONUS")
                        .customFont(.poppins700, 16)
                        .padding(.leading, 16)
                    Spacer()
                }
                .padding(.top, deviceWidth < 380 ? 20 : 45)
                
                ZStack {
                    ScrollViewReader { content in
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 8) {
                                ForEach((1..<31), id: \.self) { index in
                                    DayCell(currentDay: fillingFor(index), number: index, presentDay: vm.user.presentDay)
                                }
                            }
                            .padding(.leading, 16)
                        }
                        .disabled(true)
                        .onAppear {
                            content.scrollTo(vm.user.presentDay, anchor: .center)
                        }
                    }
                }
                .padding(.bottom, 30)
                
                DefaultButton(text: "Claim") {
                    vm.updatePresentDay()
                    vm.goBack()
                }
                
                CustomButton(text: "Back to Home", state: .normal) {
                    vm.goBack()
                }
            }
            .foregroundColor(.white)
            
        }
        .toolbar(.hidden, for: .navigationBar)
    }
    
    private func fillingFor(_ index: Int) -> Bool {
        return index == vm.user.presentDay ? true : false
    }
}

struct DayCell: View {
    var currentDay: Bool
    var number: Int
    var presentDay: Int
    
    var body: some View {
        ZStack {
            Color(.clear)
                .background(currentDay ? .greenLight : .purpleLight.opacity(0.5))
                .frame(width: 68, height: 77)
                .border(currentDay ? .black : .purpleDim)
                .cornerRadius(16)
                .overlay(
                    RoundedRectangle(cornerRadius: 16)
                        .strokeBorder(currentDay ? .black : .purpleDim,
                                      lineWidth: currentDay ? 2 : 1)
                )
            
            VStack(spacing: 18) {
                Text("Day \(number)")
                    .customFont(.poppins500, 12)
                
                HStack(spacing: 2) {
                    Text("+\(number)0")
                        .customFont(.poppins500, 16)
                    
                    Image(.Icons.coin)
                }
            }
            .foregroundStyle(currentDay ? .black : .white)
            
            Color(.clear)
                .background(number >= presentDay ? .clear : .purpleLight.opacity(0.5))
                .frame(width: 68, height: 77)
                .cornerRadius(16)
        }
    }
}

#Preview {
    CalendarScreen()
        .environmentObject(ViewModel())
}
