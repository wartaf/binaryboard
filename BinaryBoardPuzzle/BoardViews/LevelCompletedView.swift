//
//  LevelCompletedView.swift
//  BinaryBoardPuzzle
//
//  Created by Harry Pantaleon on 3/27/23.
//

import SwiftUI



struct LevelCompletedView: View {
    let uiImg: UIImage
    
    @EnvironmentObject var myAppState: MyAppState
    
    @State private var sAngle = 0.0
    
    @State private var opacityBG = 0.0
    @State private var opacityTodayGoal = 0.0
    @State private var opacityRanking = 0.0
    
    @State private var scaleImgCover = 1.6
    
    var body: some View {
        ZStack {
            Color.white
                .opacity(opacityBG)
            Color(hue: 0.761, saturation: 1.0, brightness: 0.357)
                .myLinearGradient
                .opacity(opacityBG)
            
            let colors: [Color] =  [.white.opacity(0.4), .clear, .white.opacity(0.4), .clear, .white.opacity(0.4), .clear, .white.opacity(0.4), .clear, .white.opacity(0.4)]
            AngularGradient(colors: colors, center: .center, startAngle: .degrees(sAngle), endAngle: .degrees(sAngle + 360))
                .scaleEffect(2)
                .opacity(0.6)
                .offset(.init(width: 0, height: -180))
                .onAppear{
                    withAnimation(.linear(duration: 32).repeatForever(autoreverses: false)){
                        sAngle += 360
                    }
                }
            
            VStack{
                Text("Mission Completed!")
                    .font(.title)
                
                //Image("template")
                Image(uiImage: uiImg)
                    .interpolation(.none)
                    .resizable()
                    .frame(width: 180, height: 180)
                    .padding(8)
                    .background{
                        RoundedRectangle(cornerRadius: 8)
                            .fill(.white)
                    }
                    .scaleEffect(scaleImgCover, anchor: .top)
                
                VStack{
                    HStack{
                        Text("Today's Goals")
                        Spacer()
                        Text("Time")
                    }
                    HStack {
                        ButtonContent {
                            Text("Hellow")
                                .font(.caption2)
                                .foregroundColor(.secondary)
                        }
                        ButtonContent {
                            Text("Hellow")
                        }
                        ButtonContent {
                            Text("Hellow")
                        }
                        ButtonContent {
                            Text("Hellow")
                        }
                    }
                }
                .padding(.horizontal, 8)
                .padding(.vertical, 12)
                .background(content: {
                    RoundedRectangle(cornerRadius: 16)
                        .fill(.white.opacity(0.1))
                })
                .padding(52)
                .opacity(opacityTodayGoal)
                
                VStack{
                    HStack{
                        Text("Position")
                        Spacer()
                        Text("20th")
                    }
                    Divider()
                        .background(.white)
                    HStack{
                        Text("Total Score")
                        Spacer()
                        Text("100")
                    }
                }
                .padding(16)
                .background(content: {
                    RoundedRectangle(cornerRadius: 16)
                        .fill(.white.opacity(0.1))
                })
                .padding(52)
                .opacity(opacityRanking)
                
                
                Button {
                    myAppState.setNextLevel()
                } label: {
                    Text("Continue")
                        .font(.title3)
                        .foregroundColor(.blue.opacity(0.8))
                }
                .frame(width: 256, height: 48, alignment: .center)
                .background(content: {
                    RoundedRectangle(cornerRadius: 32)
                        .fill(.white)
                        .shadow(radius: 4)
                })
                .padding(6)
            }
            .foregroundColor(.white)
        }
        .ignoresSafeArea()
        .onAppear{
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.0, execute: {
                withAnimation (.easeOut(duration: 1)){
                    opacityBG = 1
                    scaleImgCover = 1
                }
                
            })
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.8, execute: {
                withAnimation (.easeOut(duration: 1)){
                    opacityTodayGoal = 1
                }
                
            })
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.2, execute: {
                withAnimation (.easeOut(duration: 1)){
                    opacityRanking = 1
                }
            })
            
        }
    }
}

struct LevelCompletedView_Previews: PreviewProvider {
    static var previews: some View {
        LevelCompletedView(uiImg: UIImage(named: "template")!)
    }
}
