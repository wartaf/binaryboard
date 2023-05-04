//
//  PopupView.swift
//  BinaryBoardPuzzle
//
//  Created by Harry Pantaleon on 3/1/23.
//

import SwiftUI

struct EmptyHeartPopupView: View {
    @EnvironmentObject var myAppState: MyAppState
    
    @State private var askAgain: Bool = false
    
    private let colors: [Color]
    @State private var sAngle = 0.0
    
    init() {
        let gray = Color(red: 0.5, green: 0.5, blue: 0.5)
        self.colors =  [.white, gray, .white, gray, .white, gray, .white, gray, .white]
    }
    
    var body: some View {
        ZStack {
            AngularGradient(colors: colors, center: .center, startAngle: .degrees(sAngle), endAngle: .degrees(sAngle + 360))
                .ignoresSafeArea()
                .opacity(0.6)
                .onAppear{
                    withAnimation(.linear(duration: 32).repeatForever(autoreverses: false)){
                        sAngle += 360
                    }
                }
            
            if askAgain == false {
                VStack {
                    Text("Out of Hearts!")
                        .font(.title)
                    
                    Circle()
                        .fill(.gray.opacity(0.2))
                        .frame(width: 100, height: 100)
                        .overlay {
                            Image(systemName: "heart.fill")
                                .resizable()
                                .foregroundColor(.red)
                                .padding(.all, 24)
                        }
                    let colorBlueButton = Color.blue.opacity(0.7)
                    Button {
                        
                    } label: {
                        Text("No")
                            .foregroundColor(.white)
                            .frame(width: 200)
                            .padding(.all)
                            .background{
                                Capsule()
                                    .fill(colorBlueButton)
                            }
                            .shadow(color: .gray.opacity(0.4), radius: 4)
                    }
                    
                    Button {
                        askAgain = true
                        //print("btnYes")
                    } label: {
                        Text("Yes")
                            .foregroundColor(colorBlueButton)
                            .frame(width: 200)
                            .padding(.all)
                            .background{
                                Capsule()
                                    .fill(.white)
                            }
                            .shadow(color: .gray.opacity(0.4), radius: 4)
                    }
                    /*
                    Button{
                        
                    } label: {
                        Text("Get More Hearts")
                            .font(.title3)
                            .foregroundColor(.white)
                    }
                    .frame(width: 256, height: 48, alignment: .center)
                    .background(content: {
                        RoundedRectangle(cornerRadius: 32)
                            .fill(.blue.opacity(0.8))
                    })
                    .shadow(color: .gray.opacity(0.4), radius: 4)
                    .padding(6)
                    
                    Button {
                        askAgain = true
                        //myAppState.currentScreen = .playing
                    } label: {
                        Text("Restart")
                            .font(.title3)
                            .foregroundColor(.blue.opacity(0.8))
                    }
                    .frame(width: 256, height: 48, alignment: .center)
                    .background(content: {
                        RoundedRectangle(cornerRadius: 32)
                            .fill(.white)
                    })
                    .shadow(color: .gray.opacity(0.4), radius: 4)
                    .padding(6)
                     
                     */
                }
                
                //.frame(width: 300)
                .padding(48)
                
                .background(content: {
                    RoundedRectangle(cornerRadius: 16)
                        .fill(.white)
                })
                .shadow(color: .gray.opacity(0.4), radius: 4)
            } else {
                RestartPopupView(askAgain: $askAgain)
            }// If askAgain
        }
    }
}

struct PopupView_Previews: PreviewProvider {
    static var previews: some View {
        EmptyHeartPopupView()
    }
}
