//
//  ViewHelper.swift
//  BinaryBoardPuzzle
//
//  Created by Harry Pantaleon on 3/28/23.
//

import Foundation
import SwiftUI


struct MyWhiteBackground: ViewModifier {
    func body(content: Content) -> some View {
        content
            .background(content: {
                RoundedRectangle(cornerRadius: 16)
                    .fill(.white)
            })
    }
}

extension View {
    func myWhiteBG() -> some View {
        modifier(MyWhiteBackground())
    }
}
