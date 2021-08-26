//
//  ContentView.swift
//  TicTacToe
//
//  Created by Lennart Post on 25.08.21.
//

import SwiftUI
var width: CGFloat = 90.0
var spacing: CGFloat = 15.0
struct ContentView: View {
    @ObservedObject var viewModel = TTTViewModel() //Listens for objectWillChange Messages from viewModel. Invalidates the view, whenever the Object changes.
    
    var body: some View {
        
        GeometryReader { geometry in
            ZStack{
                Rectangle().position(x: 1.5*width, y: 1.5*width-spacing).frame(width: 3*width, height: 3*width, alignment: .center)
                VStack(spacing: spacing){
                    HStack(spacing: spacing){
                        FieldView(chosenBy: viewModel.getFieldState(field: 0), size: width).onTapGesture(perform: {
                            self.viewModel.chooseField(field: 0)
                        })
                        FieldView(chosenBy: viewModel.getFieldState(field: 1), size: width).onTapGesture(perform: {
                            self.viewModel.chooseField(field: 1)
                        })
                        FieldView(chosenBy: viewModel.getFieldState(field: 2), size: width).onTapGesture(perform: {
                            self.viewModel.chooseField(field: 2)
                        })
                    }
                    HStack(spacing: spacing){
                        FieldView(chosenBy: viewModel.getFieldState(field: 3), size: width).onTapGesture(perform: {
                            self.viewModel.chooseField(field: 3)
                        })
                        FieldView(chosenBy: viewModel.getFieldState(field: 4), size: width).onTapGesture(perform: {
                            self.viewModel.chooseField(field: 4)
                        })
                        FieldView(chosenBy: viewModel.getFieldState(field: 5), size: width).onTapGesture(perform: {
                            self.viewModel.chooseField(field: 5)
                        })
                    }
                    HStack(spacing: spacing){
                        FieldView(chosenBy: viewModel.getFieldState(field: 6), size: width).onTapGesture(perform: {
                            self.viewModel.chooseField(field: 6)
                        })
                        FieldView(chosenBy: viewModel.getFieldState(field: 7), size: width).onTapGesture(perform: {
                            self.viewModel.chooseField(field: 7)
                        })
                        FieldView(chosenBy: viewModel.getFieldState(field: 8), size: width).onTapGesture(perform: {
                            self.viewModel.chooseField(field: 8)
                        })
                    }
                    Text(viewModel.status)
                }
            }.position(x: geometry.size.width/2, y: geometry.size.height/2)
        }
    }
}

func chooseField(){
    print("Apfelsine")
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

