//
//  FeaturesSection.swift
//  
//
//  Created by Kamaal M Farah on 23/12/2022.
//

import Logster
import SwiftUI
import SalmonUI

private let logger = Logster(from: FeaturesSection.self)

struct FeaturesSection: View {
    @Environment(\.settingsConfiguration) private var settingsConfiguration: SettingsConfiguration

    var body: some View {
        KSection(header: "Features".localized(comment: "")) {
            ForEach(settingsConfiguration.features) { feature in
                FeatureRow(feature: feature, onChange: onFeatureChange)
            }
        }
    }

    private func onFeatureChange(_ newFeature: Feature) {
        NotificationCenter.default.post(name: .featureChanged, object: newFeature)
        logger.info("feature changed to \(newFeature)")
    }
}

struct FeaturesSection_Previews: PreviewProvider {
    static var previews: some View {
        FeaturesSection()
    }
}
