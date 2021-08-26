//
//  TicTacToeAI.swift
//  TicTacToe
//
//  Created by Lennart Post on 25.08.21.
//

import Foundation


//Sollte das Feld beinhalten, welches gefüllt werden soll. SuchAlgorithmus!
func minimax(board: [TicTacToeField]) -> Int {
    var v = -2
    var bestMove: Int = 0
    for s in actions(board: board){ //Auslagerung in maxValue funktion ist nicht so einfach, weil diese nur den Wert aber nicht den zugehörigen Zug zurückgibt.
        let newValue = max(v, minValue(board: result(board: board, action: s)))
        if newValue > v {
            bestMove = s
            v = newValue
        }
    }
    return bestMove
}

func maxValue(board: [TicTacToeField]) -> Int {
    if terminal(board: board) {
        return utility(board: board, player: Player.Player2) // KI ist immer Spieler 2
    }
    var v = -2
    for s in actions(board: board) {
        v = max(v, minValue(board: result(board: board, action: s)))
    }
    return v
}

func minValue(board: [TicTacToeField]) -> Int {
    if terminal(board: board) {
        return utility(board: board, player: Player.Player2) // KI ist immer Spieler 2
    }
    var v = 2
    for s in actions(board: board) {
        v = min(v, maxValue(board: result(board: board, action: s)))
    }
    return v
}

//Gibt das resultierende Bord zurück.
func result(board: [TicTacToeField], action: Int) -> [TicTacToeField] {
    // Create new TicTacToeField
    var copyField = board
    let activePlayer = player(board: board)
    copyField[action].chosen = TicTacToeGame.playerToStatus(player: activePlayer)
    return copyField
}


//Gibt an ob das spiel aus ist.
func terminal(board: [TicTacToeField]) -> Bool {
    var allFilled = true
    for i in 0...8 {
        if board[i].chosen == SquareStatus.empty {
            allFilled = false
        }
    }
    if allFilled {
        return true
    }
    if utility(board: board, player: Player.Player1) != 0 {
        return true
    }
    return false
}

func actions(board: [TicTacToeField]) -> [Int] {
    var empty: [Int] = []
    for i in 0...8 {
        if board[i].chosen == SquareStatus.empty {
            empty.append(i)
        }
    }
    return empty
}

//Gibt aus wer dran ist
func player(board: [TicTacToeField]) -> Player{
    var balance = 0
    for i in 0...8 {
        if board[i].chosen == SquareStatus.player1 {
            balance = balance+1
        }
        if board[i].chosen == SquareStatus.player2 {
            balance = balance-1
        }
    }
    return balance == 0 ? .Player1 : .Player2
}

//Gibt den Gewinner eines Boards zurück.
func winner(board: [TicTacToeField]) -> Player?{
    let util = utility(board: board, player: Player.Player1)
    return util == 1 ? Player.Player1 : util == -1 ? Player.Player2 : nil
}

//Gibt 1 zurück, falls player gewinnt. 0 bei unentschieden -1 bei Verlust.
func utility(board: [TicTacToeField], player: Player) -> Int {
    
    for col in 0...2 {
        let fieldplayer = board[col].chosen
        if fieldplayer != SquareStatus.empty {
            if (board[col+3].chosen == board[col].chosen && board[col].chosen == board[col+6].chosen) {
                if TicTacToeGame.statusToPlayer(status: fieldplayer)! == player {
                    return 1
                }
                else {
                    return -1
                }
            }
        }
    }
    
    for ln in 0...2 {
        let fieldplayer = board[3*ln].chosen
        if fieldplayer != SquareStatus.empty {
            if (board[3*ln+1].chosen == board[3*ln].chosen && board[3*ln+2].chosen == board[3*ln].chosen) {
                if TicTacToeGame.statusToPlayer(status: fieldplayer)! == player {
                    return 1
                }
                else {
                    return -1
                }
            }
        }
    }
    
    if board[0].chosen == board[4].chosen && board[4].chosen == board[8].chosen && board[0].chosen != SquareStatus.empty{
        return TicTacToeGame.statusToPlayer(status: board[0].chosen)! == player ? 1 : -1
    }

    if board[2].chosen == board[4].chosen && board[4].chosen == board[6].chosen && board[2].chosen != SquareStatus.empty{
        return TicTacToeGame.statusToPlayer(status: board[2].chosen)! == player ? 1 : -1
    }
    
    return 0
}


