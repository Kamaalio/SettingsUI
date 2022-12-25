//
//  Stack.swift
//
//
//  Created by Kamaal M Farah on 25/12/2022.
//

import Foundation

struct Stack<Value> {
    private var top: Node<Value>?

    func peek() -> Value? {
        top?.value
    }

    mutating func push(_ item: Value) {
        let currentTop = top
        top = Node(value: item, next: currentTop)
    }

    @discardableResult
    mutating func pop() -> Value? {
        let currentTop = top
        top = top?.next
        return currentTop?.value
    }
}
