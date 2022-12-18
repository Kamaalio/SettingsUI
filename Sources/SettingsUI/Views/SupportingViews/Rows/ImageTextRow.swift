//
//  ImageTextRow.swift
//  
//
//  Created by Kamaal M Farah on 18/12/2022.
//

import SwiftUI

struct ImageTextRow: View {
    let label: String
    let imageSystemName: String

    init(label: String, imageSystemName: String) {
        self.label = label
        self.imageSystemName = imageSystemName
    }

    init(localizedLabel: String, comment: String, imageSystemName: String) {
        self.init(label: localizedLabel.localized(comment: comment), imageSystemName: imageSystemName)
    }

    var body: some View {
        ValueRow(label: label) {
            Image(systemName: imageSystemName)
        }
    }
}

struct ImageTextRow_Previews: PreviewProvider {
    static var previews: some View {
        ImageTextRow(label: "Label", imageSystemName: "person")
    }
}
