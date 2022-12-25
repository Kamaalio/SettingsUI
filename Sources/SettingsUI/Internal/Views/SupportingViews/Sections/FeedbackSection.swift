//
//  FeedbackSection.swift
//
//
//  Created by Kamaal M Farah on 20/12/2022.
//

import SwiftUI
import SalmonUI

struct FeedbackSection: View {
    var body: some View {
        KSection(header: "Feedback".localized(comment: "")) {
            ForEach(FeedbackStyles.allCases, id: \.title) { style in
                VStack {
                    NavigationLinkImageRow(
                        label: style.title,
                        imageSystemName: style.imageSystemName,
                        destination: .feedback(style: style, description: "")
                    )
                    #if os(macOS)
                    if style != FeedbackStyles.allCases.last! {
                        Divider()
                    }
                    #endif
                }
            }
        }
    }
}

struct FeedbackSection_Previews: PreviewProvider {
    static var previews: some View {
        FeedbackSection()
    }
}
