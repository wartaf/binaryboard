//
//  PlayingView.swift
//  BinaryBoardPuzzle
//
//  Created by Harry Pantaleon on 2/12/23.
//
import Combine
import SwiftUI


struct PlayingView: View {
    @ObservedObject var playingVM: PlayingViewModel
    @EnvironmentObject var myAppState: MyAppState
    
    @State private var uiImg: UIImage // Image Label at missionCompleted
    
    init() {
        let size = 10
        let uiImg = resizeImage(image: convertToGrayScale(image: UIImage(named: "weights")! )! , targetSize: .init(width: size, height: size))!
        self.playingVM = PlayingViewModel(board: uiImageToBoard(image: uiImg))
        self.uiImg = uiImg
    }
    
    var body: some View {
        ZStack {
            VStack{
                ZStack{
                    Text("\(playingVM.title)") 
                        .font(.title)
                    
                    HStack {
                        Button(role: .destructive){
                            myAppState.currentScreen = .main
                        } label: {
                            Image(systemName: "arrowtriangle.left.fill")
                                .resizable()
                                .foregroundColor(.black.opacity(0.5))
                                .frame(width: 24, height:24)
                                .padding(16)
                        }
                        Spacer()
                    }
                }
                
            VStack {
                Spacer()
                HStack{
                    ForEach(1...3, id: \.self) { n in
                        Image(systemName: "heart.fill")
                            .resizable()
                            .frame(width: 32, height: 32)
                            .foregroundColor(playingVM.heartRemaining >= n ? .red : .gray)
                    }
                }
                Spacer()
                }
                
            GeometryReader { geo in
                let w5 = geo.size.width / 5
                
                VStack{
                    
                    
                    VStack (spacing: 1) {
                        HStack (spacing: 1) {
                            Spacer()
                                .frame(width: w5, height: w5)
                            
                            HStack (spacing: 1) {
                                HTallyBoxesView(playingVM.board)
                            }
                        }
                        .frame(height: w5)
                        HStack (spacing: 1) {
                            
                            VStack (spacing: 1){
                                VTallyBoxesView(playingVM.board)
                            }
                            .frame(width: w5)
                            ZStack{
                                NonoGraph(size: Double(playingVM.boardSize))
                                    .fill(.gray)
                                    .border(.gray)
                                VStack(spacing: 0){
                                    ForEach(0..<playingVM.boardSize, id: \.self) { cols in
                                        HStack (spacing: 0){
                                            ForEach(0..<playingVM.boardSize, id: \.self) { rows in
                                                let boxValue: NonoGridType = playingVM.graph[cols][rows]
                                                Image(systemName: boxValue.rawValue < 3 ? "square.fill" : "xmark")
                                                    .resizable()
                                                    .padding(1)
                                                    .foregroundColor(
                                                        boxValue == .none ? .secondary.opacity(0.1) :
                                                            boxValue == .black ? .primary :
                                                            boxValue == .boxRed ? .red :
                                                            boxValue == .crossRed ? .red : .primary
                                                        
                                                    )
                                                    .gesture(playingVM.gestureCompute(rows: rows, cols: cols, boxPixelWidth: (w5 * 4)))
                                            }
                                        }
                                    }
                                }
                                .coordinateSpace(name: "coor")
                                .frame(maxWidth: .infinity, maxHeight: .infinity)
                            }
                        }
                        .frame(height: w5 * 4)
                    }
                    Spacer()
                }
                .frame(width: geo.size.width, height: geo.size.height)

                }
            //.border(.red)
                VStack {
                    Spacer()
                    HStack (spacing: 32){
                        Group {
                            Button{
                                playingVM.markerType = .cross
                            } label: {
                                Image(systemName: "xmark")
                                    .resizable()
                                    .frame(width: 24, height: 24)
                                    .foregroundColor(playingVM.markerType == .cross ? .black : .gray)
                            }
                            //Toggle(isOn: $playingVM.blackMarker) { EmptyView() }
                              //  .border(.red)
                            Button {
                                playingVM.markerType = .black
                            } label: {
                                Image(systemName: "square.fill")
                                    .resizable()
                                    .frame(width: 32, height: 32)
                                    .foregroundColor(playingVM.markerType == .black ? .black : .gray)
                            }
                            
                            Button {
                                playingVM.markerType = .clue
                            } label: {
                                Image(systemName: "circle.dashed")
                                    .resizable()
                                    .foregroundColor(playingVM.markerType == .clue ? .blue : .gray)
                                    .frame(width: 32, height: 32)
                                    .overlay(
                                        Text("\(playingVM.remainingClue)")
                                            .foregroundColor(.red)
                                    )
                            }
                        }
                        
                        
                        
                    }
                    .frame(width: 100)
                    
                    
                    
                    
                    Spacer()
                } //VSTACK
            }
            
            if playingVM.heartRemaining < 1 {
                EmptyHeartPopupView()
            }
            if playingVM.remainingBlock < 1 {
                LevelCompletedView(uiImg: uiImg)
            }
        }
    }

}

struct PlayingView_Previews: PreviewProvider {
    static var previews: some View {
        PlayingView()
    }
}





