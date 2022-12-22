//
//  PersonalizationSection.swift
//  
//
//  Created by Kamaal M Farah on 22/12/2022.
//

import SwiftUI
import SalmonUI

struct PersonalizationSection: View {
    var body: some View {
        KSection(header: "Personalization".localized(comment: "")) {
            NavigationLinkColorRow(
                localizedLabel: "App colors",
                comment: "",
                color: .accentColor,
                destination: { AppColorScreen() })
        }
    }
}

struct PersonalizationSection_Previews: PreviewProvider {
    static var previews: some View {
        PersonalizationSection()
    }
}
