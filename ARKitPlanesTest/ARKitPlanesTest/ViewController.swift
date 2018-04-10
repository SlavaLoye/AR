//
//  ViewController.swift
//  ARKitPlanesTest
//
//  Created by Вячеслав Лойе on 10.04.2018.
//  Copyright © 2018 Вячеслав Лойе. All rights reserved.
//

import UIKit
import SceneKit
import ARKit
import MetalKit

class ViewController: UIViewController {
    
    static var yTochca : CGFloat = 0.05

    @IBOutlet var sceneView: ARSCNView!
    
    //  добавляем массив с различными поверхностями
    
    var planes = [Plane]()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the view's delegate
        sceneView.delegate = self
        
        // Show statistics such as fps and timing information
        sceneView.showsStatistics = true
        
        // добавляем желтые точки
        sceneView.debugOptions = [ARSCNDebugOptions.showFeaturePoints, ARSCNDebugOptions.showWorldOrigin]
        // освещение
        sceneView.autoenablesDefaultLighting = true
        
        // Create a new scene
        let scene = SCNScene()
        
        // Set the scene to the view
        sceneView.scene = scene
        setupGesture()
        
    }
    
    //  MARK: Developer
    
    func setupGesture()  {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(placeBox))
        tapGestureRecognizer.numberOfTapsRequired = 1
        self.sceneView.addGestureRecognizer(tapGestureRecognizer)
        print("setupGesture")
    }
    
    @objc func placeBox(tapGesture: UITapGestureRecognizer) {
        // при нажатии на экран мы должны получить sceneView
        let sceneView = tapGesture.view as! ARSCNView
        let location = tapGesture.location(in: sceneView)
        let hitTestResult = sceneView.hitTest(location, types: .existingPlaneUsingExtent)
        //        !hitTestResult.isEmpty
        guard let hitResult = hitTestResult.first else { return }
        cteateBox(hitResult: hitResult)
            
        }
        
        func cteateBox(hitResult: ARHitTestResult) {
             //var yTochca : Float = 0.05
            let position = SCNVector3(hitResult.worldTransform.columns.3.x,
                                      hitResult.worldTransform.columns.3.y + 0.05 + 0.5,
                                      hitResult.worldTransform.columns.3.z)
            let box = Box(atPosition: position)
            sceneView.scene.rootNode.addChildNode(box)
            print(box)
            
        }
        
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARWorldTrackingConfiguration()
        // и добавляем метод определение горизонтальных поверхностей (пока айркит может только так)
        
        configuration.planeDetection = .horizontal

        // Run the view's session
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }
    
}


















