//
//  ChessBoardSquare.swift
//  HexagonMap
//
//  Created by Christoph Freier on 28.10.24.
//



import SwiftUI
import DragAndDrop

struct ChessBoardSquare: Identifiable, DropReceiver {
    let id: Int
    var dropArea: CGRect? = nil
    
    var piece: Piece? = nil
    var legalDropTarget: DragState = .none
}
