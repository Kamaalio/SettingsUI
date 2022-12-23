//
//  ContributorsSection.swift
//  
//
//  Created by Kamaal M Farah on 23/12/2022.
//

import SwiftUI
import SalmonUI

struct ContributorsSection: View {
    let contributors: [Acknowledgements.Contributor]

    var body: some View {
        KSection(header: "Contributors".localized(comment: "")) {
            ForEach(contributors, id: \.self) { contributor in
                AppText(string: contributor.name)
                    .bold()
                    .ktakeWidthEagerly(alignment: .leading)
                #if os(macOS)
                if contributor != contributors.last {
                    Divider()
                }
                #endif
            }
        }
        .padding(.horizontal, .medium)
        .padding(.top, .medium)
    }
}

struct ContributorsSection_Previews: PreviewProvider {
    static var previews: some View {
        ContributorsSection(contributors: [])
    }
}
