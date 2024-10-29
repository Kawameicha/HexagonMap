//
//  DropReceivableObservableObject.swift
//  HexagonMap
//
//  Created by Christoph Freier on 28.10.24.
//

import SwiftUI

public protocol DropReceivableObservableObject: ObservableObject {
    associatedtype DropReceivable: DropReceiver

    func setDropArea(_ dropArea: CGRect, on dropReceiver: DropReceivable)
}
