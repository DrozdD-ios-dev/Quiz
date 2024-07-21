//
//  MainScreen.swift
//  Quiz
//
//  Created by Дрозд Денис on 21.07.2024.
//

import SwiftUI

struct MainScreen: View {
    
    @State private var progress: Double = 0.5 // Прогресс от 0 до 1
    
    var body: some View {
        ZStack {
            LinearGradient(colors: [.purpleGradientUp, .purpleGradientDown], startPoint: .top, endPoint: .bottom)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .ignoresSafeArea()
            
            VStack {
                
                VStack {
                         ProgressView(value: progress)
                        .progressViewStyle(CustomProgressViewStyle(height: 8))
//                        .frame(height: 10)
                             .background(.white)
//                             .cornerRadius(4)
                             .padding(.vertical, 30)
                             .padding(.horizontal, 50)
                         
                         Button("Increase Progress") {
                             if progress < 1.0 {
                                 progress += 0.1
                             }
                         }
                         .padding()
                     }
                //--------------
              
                Spacer()
                
                Image(.Images.swords)
                    .frame(width: 100, height: 100)
                    .padding(.vertical, 50)
                Spacer()
        
                
                Button {
                    print("play")
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
                    DefaultButton(color: .redLight, icon: Image(.Icons.calendar))
                    DefaultButton(color: .greenLight, icon: Image(.Icons.map))
                }
                Spacer()
            }
            
        
            
        }
    }
}

struct CustomProgressViewStyle: ProgressViewStyle {
    var height: CGFloat
    
    func makeBody(configuration: Configuration) -> some View {
        ZStack(alignment: .leading) {
            RoundedRectangle(cornerRadius: height)
                .frame(height: height + 4)
                .foregroundColor(.white)
            RoundedRectangle(cornerRadius: height / 2)
                .frame(width: CGFloat(configuration.fractionCompleted ?? 0) * UIScreen.main.bounds.width * 0.9, height: height)
                .foregroundColor(.greenLight)
        }
    }
}

struct DefaultButton: View {
    var color: Color
    var icon: Image
    var body: some View {
        ZStack {
            Button {
                print("any")
            } label: {
                color
                    .frame(width: 72, height: 72)
                    .border(.black)
                    .cornerRadius(25)
                    .overlay(
                        RoundedRectangle(cornerRadius: 25)
                            .stroke(.black, lineWidth: 2)
                    )
            }
            icon
        }
    }
}

#Preview {
    MainScreen()
}
