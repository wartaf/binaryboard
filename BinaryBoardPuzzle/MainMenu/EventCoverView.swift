//
//  EventBoxView.swift
//  BinaryBoardPuzzle
//
//  Created by Harry Pantaleon on 3/29/23.
//

import SwiftUI

struct EventCoverView: View {
    let eventData: [EventInfo]
    
    var body: some View {
        ScrollView (.horizontal, showsIndicators: false) {
            HStack {
                ForEach(eventData) { data in
                    EventBoxView(boxInfo: data)
                }
            }
            .padding()
        }
    }
}

struct EventInfo: Identifiable {
    let id: UUID = UUID()
    let title: String
    let image: Image
    let color: Color
    
    static let test = EventInfo.init(title: "Event Sample", image: Image(systemName: "car.2"), color: Color.green)
}

struct EventBoxView: View {
    let boxInfo: EventInfo
    var body: some View {
        let boxColorGreen: [Color] = [boxInfo.color.opacity(0.5), boxInfo.color]
        VStack {
            boxInfo.image
                .resizable()
                .frame(width: 32, height: 32)
                .padding(12)
            Text(boxInfo.title)
            
            Text("Play")
                .frame(width: 80, height: 28)
                .background {
                    Capsule(style: .continuous)
                        .fill(.white.opacity(0.3))
                }
        }
        .frame(width: 110)
        .foregroundColor(.white)
        .padding(.vertical, 32)
        .padding(.horizontal, 16)
        .background {
            RoundedRectangle(cornerRadius: 16)
                .fill (
                    LinearGradient(colors: boxColorGreen, startPoint: .top, endPoint: .bottom)
                )
        }
    }
}

struct EventListView_Previews: PreviewProvider {
    static var previews: some View {
        EventCoverView(eventData: [.init(title: "Sample", image: .init(systemName: "circle"), color: .indigo)])
    }
}
