import SwiftUI
import DragAndDrop

struct HexagonView: View {
    @EnvironmentObject var model: BoardViewModel

    let square: HexagonBoard

    var body: some View {
        ZStack {
            HexagonShape()
                .checkered(id: square.id, color: .gray)
                .overlay(
                    HexagonShape()
                        .fill(Color.green.opacity(square.legalDropTarget == .accepted ? 0.3 : 0))
                )
                .dropReceiver(for: model.hexagonBoard[square.id], model: model)
            HexagonShape()
                .overlay(
                    HexagonShape()
                        .stroke(Color.green, lineWidth: 4) // Green border with stroke
                )
                .opacity(square.legalDropTarget == .accepted ? 1 : 0)
            switch square.piece {
            case .none:
                EmptyView()
            case .some(let unit):
                UnitView(unit: unit)
                    .dragable(object: unit,
                              onDragObject: onDragPiece,
                              onDropped: onDropPiece)
            }
        }
        .scaledToFit()
    }

    func onDragPiece(piece: Dragable, position: CGPoint) -> DragState {
        if model.pieceDidMoveFrom == nil {
            model.setPieceOrigin((piece as! Unit).square)
            model.setLegalDropTargets()
        }
        return .none
    }

    func onDropPiece(position: CGPoint) -> Bool {
        if model.movePiece(location: position) {
            return true
        } else {
            model.clearPieceOrigin()
            model.setLegalDropTargets()
            return false
        }
    }
}

struct HexagonView_Previews: PreviewProvider {
    struct Preview: View {
        @StateObject var model = BoardViewModel()

        let square = HexagonBoard(id: 0, dropArea: nil, piece: Unit(type: .king, color: .home, square: 0))

        var body: some View {
            HexagonView(square: square)
                .environmentObject(model)
        }
    }

    static var previews: some View {
        Preview()
    }
}