//
//  RestartPopupView.swift
//  BinaryBoardPuzzle
//
//  Created by Harry Pantaleon on 3/25/23.
//

import SwiftUI

struct RestartPopupView: View {
    @EnvironmentObject var myAppState: MyAppState
    
    @Binding var askAgain: Bool
    
    var body: some View {
        ZStack {
            //Rectangle()
              //  .fill(.black.opacity(0.3))
            VStack{
                Text("Are You Sure?")
                    .font(.title)
                    .padding()
                Text("Are you sure you want to restart this level?")
                    .font(.subheadline)
                    .padding(.bottom)
                
                let colorBlueButton = Color.blue.opacity(0.7)
                
                Button {
                    print("btn")
                    askAgain = false
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
                    myAppState.currentScreen = .playing
                    print("btnYes")
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
            }
            .padding(.all)
            .background{
                RoundedRectangle(cornerRadius: 16)
                    .fill(.white)
            }
        }
    }
}

struct RestartPopupView_Previews: PreviewProvider {
    static var previews: some View {
        RestartPopupView(askAgain: .constant(false))
    }
}
