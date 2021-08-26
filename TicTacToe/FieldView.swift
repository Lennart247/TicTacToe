//
//  FieldView.swift
//  TicTacToe
//
//  Created by Lennart Post on 25.08.21.
//

import SwiftUI
import Foundation


enum SquareStatus {
    case empty
    case player1
    case player2
}

struct FieldView: View {
    
    var chosenBy : SquareStatus
    var size: CGFloat
    
    var fieldtext : String {
        chosenBy == .empty ? " " : chosenBy == .player1 ? "X" : "O"
    }
    
    var body : some View {
        Text(fieldtext)
            .font(.largeTitle)
            .foregroundColor(.blue)
            .frame(width: size, height: size, alignment: .center)
            
            //.padding(0)
            .background(Color.gray)
            .cornerRadius(25)
            
            
    }
    
}

func doNothing(){
    
}
