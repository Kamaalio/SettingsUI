//
//  Array+extensions.swift
//
//
//  Created by Kamaal M Farah on 20/12/2022.
//

import Foundation

extension Array where Element: Identifiable {
    var mappedByID: [Element.ID: Element] {
        reduce([:]) {
            var result = $0
            result[$1.id] = $1
            return result
        }
    }
}
