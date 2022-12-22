//
//  ColorTextRow.swift
//  
//
//  Created by Kamaal M Farah on 22/12/2022.
//

import SwiftUI
import ShrimpExtensions

struct ColorTextRow: View {
    let label: String
    let color: Color

    private let size: CGSize = .squared(28)

    init(label: String, color: Color) {
        self.label = label
        self.color = color
    }

    var body: some View {
        ValueRow(label: label) {
            color
                .frame(width: size.width, height: size.height)
                .cornerRadius(.small)
        }
    }
}

struct ColorTextRow_Previews: PreviewProvider {
    static var previews: some View {
        ColorTextRow(label: "Label", color: .accentColor)
    }
}
