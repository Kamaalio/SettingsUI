//
//  AppColorScreen.swift
//  
//
//  Created by Kamaal M Farah on 22/12/2022.
//

import SwiftUI
import SalmonUI

struct AppColorScreen: View {
    var body: some View {
        KScrollableForm {
            KSection(header: "Colors".localized(comment: "")) {
                Text("Hello, World!")
            }
            .padding(.all, .medium)
        }
        .ktakeSizeEagerly(alignment: .topLeading)
        .navigationTitle(localizedTitle: "App colors", comment: "", displayMode: .inline)
    }
}

struct AppColorScreen_Previews: PreviewProvider {
    static var previews: some View {
        AppColorScreen()
    }
}
