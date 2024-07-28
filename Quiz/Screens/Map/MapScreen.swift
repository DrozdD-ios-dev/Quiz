import SwiftUI

struct MapScreen: View {
    @EnvironmentObject var vm: ViewModel

    var body: some View {
        ZStack {
            LinearGradient(colors: [.purpleGradientUp, .purpleGradientDown], startPoint: .top, endPoint: .bottom)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .ignoresSafeArea()
            
            VStack(spacing: 0) {
                
                ZStack {
                    HStack {
                        Button {
                            vm.goBack()
                        } label: {
                            Image(.Icons.chevronLeft)
                        }
                        .padding()
                        Spacer()
                        
                        Button {
                            // something
                        } label: {
                            Image(.Icons.dots)
                        }
                        .padding()
                    }
                    Text("Map")
                        .customFont(.poppins500, 20)
                        .foregroundStyle(.white)
                }
                
                ZStack {
                    ScrollViewReader { content in
                        ScrollView {
                            VStack(spacing: 0) {
                                MapFirstItem()
                                ForEach((2..<11), id: \.self) { index in
                                    if index % 2 == 0 {
                                        if index % 4 == 0 {
                                            ZStack {
                                                HStack {
                                                    Spacer()
                                                    LeftPresentItem()
                                                }
                                                MapItem(flag: fillingFor(index), number: index)
                                                    .rotationEffect(.degrees(180))
                                            }
                                        } else {
                                            ZStack {
                                                HStack {
                                                    RightPresentItem()
                                                    Spacer()
                                                }
                                                MapItem(flag: fillingFor(index), number: index)
                                                    .rotationEffect(.degrees(180))
                                            }
                                        }
                                    } else {
                                        MapItem(flag: fillingFor(index), number: index)
                                            .rotationEffect(.degrees(180))
                                    }
                                    
                                }
                            }
                        }
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .padding(.vertical, 30)
                        .rotationEffect(.degrees(180))
                        .scrollIndicators(.hidden)
                        .onAppear {
                            content.scrollTo(vm.user.level, anchor: .top)
                        }
                    }
                    
                    VStack {
                        LinearGradient(colors: [.purpleGradientMiddle, .purpleGradientMiddle, .purpleGradientMiddle.opacity(0.5), .clear], startPoint: .top, endPoint: .bottom)
                            .frame(maxWidth: .infinity)
                            .frame(height: 100)
                        
                        Spacer()
                        
                        LinearGradient(colors: [.purpleGradientDown, .purpleGradientDown, .purpleGradientDown, .clear], startPoint: .top, endPoint: .bottom)
                            .frame(maxWidth: .infinity)
                            .rotationEffect(.degrees(180))
                            .ignoresSafeArea()
                            .frame(height: 60)
                    }
                }
                
            }
        }
        .toolbar(.hidden, for: .navigationBar)
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                vm.updatePresent()
            }
        }
    }
    
    private func fillingFor(_ index: Int) -> Bool {
        return index <= vm.user.level ? true : false
    }
}

struct MapItem: View {
    var flag: Bool
    var number: Int
    
    var body: some View {
        HStack {
            ZStack {
                VStack(spacing: 70) {
                    Color(.white)
                        .frame(width: 1, height: 40)
                    
                    Color(.white)
                        .frame(width: 1, height: 40)
                }
                
                if flag {
                    Image(.Images.frameGreenLight)
                        .frame(width: 80, height: 80)
                    Text("\(number)")
                        .customFont(.poppins800, 32)
                        .foregroundStyle(.black)
                } else {
                    Image(.Images.framePurpleLight)
                        .frame(width: 80, height: 80)
                    Image(.Icons.lock)
                        .frame(width: 36, height: 36)
                }
            }
        }
        .frame(width: UIScreen.main.bounds.width)
    }
}

struct RightPresentItem: View {
    var body: some View {
        HStack(spacing: 0) {
            Color(.white)
                .frame(width: 90, height: 1)
                .padding(.trailing, -5)
            ZStack {
                Image(.Images.frameRedLight)
                    .frame(width: 80, height: 80)
                Image(.Icons.present)
                    .frame(width: 36, height: 36)
                    .padding(.bottom, 6)
                    .padding(.leading, 1)
            }
        }
        .padding(.horizontal, 16)
        .rotationEffect(.degrees(180))
    }
}

struct LeftPresentItem: View {
    var body: some View {
        HStack(spacing: 0) {
            Color(.white)
                .frame(width: 90, height: 1)
                .padding(.trailing, -5)
            ZStack {
                Image(.Images.frameRedLight)
                    .frame(width: 80, height: 80)
                Image(.Icons.present)
                    .frame(width: 36, height: 36)
                    .padding(.bottom, 6)
                    .padding(.leading, 1)
            }
            .rotationEffect(.degrees(180))
        }
        .padding(.horizontal, 16)
    }
}

struct MapFirstItem: View {
    var body: some View {
        HStack {
            ZStack {
                VStack(spacing: 70) {
                    Color(.white)
                        .frame(width: 1, height: 40)
                    Spacer()
                }
                
                Image(.Images.frameGreenLight)
                    .frame(width: 80, height: 80)
                Text("1")
                    .customFont(.poppins800, 32)
                    .foregroundStyle(.black)
            }
        }
        .rotationEffect(.degrees(180))
        .frame(width: UIScreen.main.bounds.width)
    }
}

#Preview {
    MapScreen()
        .environmentObject(ViewModel())
}
