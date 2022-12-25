//
//  Node.swift
//
//
//  Created by Kamaal M Farah on 25/12/2022.
//

import Foundation

class Node<Value> {
    let value: Value
    var next: Node<Value>?

    init(value: Value, next: Node<Value>? = .none) {
        self.value = value
        self.next = next
    }
}
