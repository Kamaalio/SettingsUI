//
//  SupportAuthorSection.swift
//
//
//  Created by Kamaal M Farah on 18/12/2022.
//

import SwiftUI
import SalmonUI

struct SupportAuthorSection: View {
    @EnvironmentObject private var store: Store

    var body: some View {
        KSection(header: "Support Author".localized(comment: "")) {
            NavigationLinkImageRow(
                localizedLabel: "Buy me coffee",
                comment: "",
                imageSystemName: "cup.and.saucer.fill",
                destination: { SupportAuthorScreen().environmentObject(store) }
            )
        }
    }
}

struct SupportAuthorSection_Previews: PreviewProvider {
    static var previews: some View {
        SupportAuthorSection()
    }
}
