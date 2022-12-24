//
//  SwiftUIView.swift
//  
//
//  Created by Kamaal M Farah on 18/12/2022.
//

import SwiftUI

func AppText(localizedString: String, comment: String, with variables: [CVarArg]) -> Text {
    AppText(string: localizedString.localized(comment: comment, with: variables))
}

func AppText(localizedString: String, comment: String) -> Text {
    AppText(localizedString: localizedString, comment: comment, with: [])
}

func AppText(string: String) -> Text {
    Text(string)
}

struct AppText_Previews: PreviewProvider {
    static var previews: some View {
        AppText(string: "Buy me coffee")
    }
}
