//
//  TTTViewModel.swift
//  TicTacToe
//
//  Created by Lennart Post on 25.08.21.
//

import Foundation

class TTTViewModel: ObservableObject { // Ist für den kompletten Zugriff zuständig, sollte eine Klasse sein, um von Views referenziert zu werden.
    @Published var GameModel = TicTacToeGame() //Die Published Variable darf keine Klasse sein, da diese sich nicht ändert, wenn dort etwas zugewiesen wird. https://stackoverflow.com/questions/59464845/swiftui-view-doesnt-update
    
    static func createTTTGame() -> TicTacToeGame { //Init returned implizit das Objekt welches es initialisiert.
        return TicTacToeGame.init()
    }
    
    func newGame() { // Self scheint nicht sonderlich gut zu funktionierten in Swift
        GameModel = TTTViewModel.createTTTGame()
        //Self vs self... sollten am besten beide nicht benutzt werden.
    }
    
    func getFieldState(field: Int) -> SquareStatus{
        return GameModel.field[field].chosen
    }
    
    func chooseField(field: Int){
        GameModel.chooseField(fieldIndex: field)
    }
    
    func getstatus() -> String {
//        return "Test"
        if GameModel.winner != nil {
            return "Spieler hat gewonnen!"
        }
        if GameModel.gameOver {
            return "Unentschieden"
        }
        return ""
    }
    
    var status: String {
        get {
            if GameModel.winner != nil {
                return "Spieler \(GameModel.winner!) hat gewonnen!"
            }
            if GameModel.gameOver {
                return "Unentschieden!"
            }
//            if GameModel.isGameOver() { // Problematischer Code. Funktioniert nicht.
//                return "Unentschieden"
//            }
            return ""
        }
    }
}
