//
//  Coordinator.swift
//  Copita AR Menu
//
//  Created by Felix Barker on 3/12/23.
//

import Foundation
import RealityKit
import ARKit

class Coordinator {
    var arView: ARView?
    var mainScene: Experience.MainScene
    var vm: FoodViewModel
    
    
    init(vm: FoodViewModel) {
        self.vm = vm

        self.mainScene = try! Experience.loadMainScene()
    }
    
    @objc func tapped(_ recognizer: UITapGestureRecognizer){
        
        guard let arView = arView else {
            return
        }
        
        let location = recognizer.location(in: arView)
        let results = arView.raycast(from: location, allowing: .estimatedPlane, alignment: .horizontal)
    
        if let result = results.first {
            
            let anchor = AnchorEntity (raycastResult: result)
            guard let entity = mainScene.findEntity(named: vm.selectedcopitafood) else {
                return
            }
            
            entity.position = SIMD3(0,0,0)
            anchor.addChild(entity)
            arView.scene.addAnchor(anchor)
            
        }
    }
}
