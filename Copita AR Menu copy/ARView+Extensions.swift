//
//  ARView+Extensions.swift
//  Copita AR Menu
//
//  Created by Felix Barker on 3/13/23.
//

import Foundation
import RealityKit
import ARKit




extension ARView {
    func addCoachingOverlay() {
        let coachingOverlay = ARCoachingOverlayView()
        coachingOverlay.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        coachingOverlay.goal = .horizontalPlane
        coachingOverlay.session = self.session
        self.addSubview(coachingOverlay)
    }
}
