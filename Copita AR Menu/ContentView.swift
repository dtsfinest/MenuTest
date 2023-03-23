//
//  ContentView.swift
//  Copita AR Menu
//
//  Created by Felix Barker on 3/12/23.
//

import SwiftUI
import RealityKit
import ARKit



struct ContentView : View {

    @StateObject private var vm = FoodViewModel()
    let copitafood = ["Chips&TwoSalsas", "Guacamole","PapasBravas", "HabaneroWings","TortillaSoupCup", "TortillaSoupBowl","EnsaladaMixta", "GoldenBeetSalad", "QuesoFundido", "Bruselas", "MexicanTruffleEmpanadas" ]

    
    var body: some View {
        VStack {
            ARViewContainer(vm: vm).edgesIgnoringSafeArea(.all)
            ScrollView(.horizontal){
                HStack{
                    ForEach(copitafood, id:\.self) {name in
                        Image(name)
                            .resizable()
                            .frame(width:350, height: 150)
                            .border(.red, width: vm.selectedcopitafood == name ? 1.0: 0.0)
                            .onTapGesture{
                                vm.selectedcopitafood = name
                            }
                        
                    }
                }
            }
        }
    }
}

struct ARViewContainer: UIViewRepresentable {
    
    let vm:FoodViewModel
    
    func makeUIView(context: Context) -> ARView {
        
        let arView = ARView(frame: .zero, cameraMode: .ar, automaticallyConfigureSession: true)
        
        
        let session = arView.session
        let config = ARWorldTrackingConfiguration()
        config.planeDetection = .horizontal
        config.environmentTexturing = .automatic
        session.run(config)
        
        
        arView.addGestureRecognizer(UITapGestureRecognizer(target: context.coordinator, action: #selector(Coordinator.tapped)))
        
        context.coordinator.arView = arView
        arView.addCoachingOverlay()
        return arView
        
    }
    
    func updateUIView(_ uiView: ARView, context: Context) {}
    
    func makeCoordinator() -> Coordinator{
        Coordinator(vm: vm)
        
    }
}
    
#if DEBUG
    struct ContentView_Previews : PreviewProvider {
        static var previews: some View {
            ContentView()
        }
    }
#endif

