//
//  MainMenu.swift
//  BinaryBoardPuzzle
//
//  Created by Harry Pantaleon on 3/13/23.
//

import SwiftUI

struct MainMenuView: View {
    @EnvironmentObject var myAppState: MyAppState
    //@State private var text = ""
    
    @State private var bgRotate: Double = 0
    
    let eventData: [EventInfo] = [
        .init(title: "EVENT_________", image: Image(systemName: "person"), color: .teal),
        .init(title: "EVENTDATA1", image: Image("imgbg"), color: .indigo),
        .init(title: "EVENTDATA2", image: .init(systemName: "circle"), color: .green),
        .init(title: "EVENTDATA3", image: .init(systemName: "car"), color: .red)
    ]
    
    private let colors: [Color] = [.blue.opacity(0.8), .white, .green.opacity(0.4)]
    var body: some View {
        ZStack {
            LinearGradient(colors: colors, startPoint: .top, endPoint: .bottom)
                .rotationEffect(.degrees(bgRotate))
                .scaleEffect(3)
                .onAppear{
                    withAnimation (.easeInOut(duration: 4).repeatForever()) {
                        bgRotate = 360
                    }
                }
            VStack {
                EventCoverView(eventData: eventData)
                
                VStack{
                    //TextField("", text: $text)
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
                .background(.gray.opacity(0.2), in: RoundedRectangle(cornerRadius: 16))
                .padding(52)
                
                Button{
                    myAppState.currentScreen = .playing
                } label: {
                    VStack {
                        Text("New Game")
                            .font(.title3)
                            .foregroundColor(.white)
                        Text("Hard")
                            .font(.subheadline)
                            .foregroundColor(.white)
                    }
                }
                .frame(width: 256, height: 48, alignment: .center)
                .background(.blue.opacity(0.8), in: RoundedRectangle(cornerRadius: 32))
                .shadow(radius: 4)
                .padding(6)
                
                if myAppState.resumeGameData != nil {
                    Button {
                        myAppState.currentScreen = .playing
                    } label: {
                        Text("Resume Level")
                            .font(.title3)
                            .foregroundColor(.blue.opacity(0.8))
                    }
                    .frame(width: 256, height: 48, alignment: .center)
                    .background(.white, in: RoundedRectangle(cornerRadius: 32))
                    .shadow(radius: 4)
                    .padding(6)
                }
            }
            
            
        }
    }
    
    enum MainMenuSelection {
        case newGame, restartGame
    }
}

struct ButtonContent <Content: View>: View {
    let content: () -> Content
    
    var body: some View {
        VStack {
            content()
        }
        .frame(width: 72, height: 60 )
        .background{
            RoundedRectangle(cornerRadius: 12)
                .fill(.white)
                .shadow(radius: 6)
                .opacity(0.7)
        }
    }
}

struct MainMenuView_Previews: PreviewProvider {
    static var previews: some View {
        MainMenuView()
    }
}
