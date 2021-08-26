//
//  TicTacToeModel.swift
//  TicTacToe
//
//  Created by Lennart Post on 25.08.21.
//

import Foundation

struct TicTacToeGame { //Muss ein Struct sein, damit Observable Kram funktioniert.
    var activePlayer: Player
    var field = [TicTacToeField]()
    var winner: Player? = nil
    var gameOver = false
    init() {
        for _ in 0...8 {
            field.append(TicTacToeField(chosen: .empty))
        }
        activePlayer = .Player1
    }
    
    mutating func reset() {
        for i in 0...8 {
            field[i].chosen = .empty
        }
    }
    
    mutating func chooseField(fieldIndex: Int){
        print("Choose Field: \(fieldIndex)")
        if !gameOver {
        switch(field[fieldIndex].chosen){
        case SquareStatus.empty:
            field[fieldIndex].chosen = TicTacToeGame.playerToStatus(player: activePlayer)
            if activePlayer == .Player2 {
                activePlayer = .Player1
            } else {
                activePlayer = .Player2
            }
            print(field[fieldIndex].chosen)
            break
        case SquareStatus.player1:
            break
        case SquareStatus.player2:
            break
        }
        _ = checkGameState()
        if activePlayer == .Player2 {
            chooseField(fieldIndex: minimax(board: field))
        }
        }
        
    }
    
    mutating func checkGameState(){ //Mutating Funktion. Darf nicht durch Views aufgerufen werden. Sonst Crasht das Programm, da nach jedem Aufruf neu berechnet wird.
        var gameOver = false
        var fieldsFilled = true;
        for i in 0...8 { // Testen ob noch freie Felder verfügbar  sind
            if field[i].chosen == .empty {
                fieldsFilled = false
            }
        }
        if fieldsFilled {
            gameOver = true
        }
        for col in 0...2 {
            let player = field[col].chosen
            if player != SquareStatus.empty {
                if (field[col+3].chosen == field[col].chosen && field[col].chosen == field[col+6].chosen) {
                    gameOver = true
                    winner = TicTacToeGame.statusToPlayer(status: player)
                }
            }
        }
        
        for ln in 0...2 {
            let player = field[3*ln].chosen
            if player != SquareStatus.empty {
                if (field[3*ln+1].chosen == field[3*ln].chosen && field[3*ln+2].chosen == field[3*ln].chosen) {
                    gameOver = true
                    winner = TicTacToeGame.statusToPlayer(status: player)!
                }
            }
        }
        
        if field[0].chosen == field[4].chosen && field[4].chosen == field[8].chosen && field[0].chosen != SquareStatus.empty{
            winner = TicTacToeGame.statusToPlayer(status: field[0].chosen)!
            gameOver = true
        }

        if field[2].chosen == field[4].chosen && field[4].chosen == field[6].chosen && field[2].chosen != SquareStatus.empty{
            winner = TicTacToeGame.statusToPlayer(status: field[2].chosen)!
            gameOver = true
        }
        
        self.gameOver = gameOver
        if gameOver {
            print(utility(board: field, player: Player.Player1))
        }
    }
    
    
    static func playerToStatus(player: Player) -> SquareStatus {
        switch(player){
        case Player.Player1:
            return SquareStatus.player1
        case Player.Player2:
            return SquareStatus.player2
        }
    }
    
    static func statusToPlayer(status: SquareStatus) -> Player? {
        if status == SquareStatus.player1 {
            return Player.Player1
        }
        if status == SquareStatus.player2 {
            return Player.Player2
        }
        return nil
    }
    
}

struct TicTacToeField {
    var chosen: SquareStatus
}

enum Player {
    case Player1
    case Player2
}
