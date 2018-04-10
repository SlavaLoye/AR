//
//  Box.swift
//  ARKitPlanesTest
//
//  Created by Вячеслав Лойе on 10.04.2018.
//  Copyright © 2018 Вячеслав Лойе. All rights reserved.
//

import SceneKit
import ARKit


class Box: SCNNode {
    
    init(atPosition position: SCNVector3) {
        super.init()
        
        let  boxGeometry = SCNBox(width: 0.1, height: 0.1, length: 0.1, chamferRadius: 0)
        let material = SCNMaterial()
        material.diffuse.contents = UIColor.green
        boxGeometry.materials = [material]
        
        self.geometry = boxGeometry
        
        // добавляем SCNPhysicsBody что бы управлять физическими телами (масса , заряд, трение и тд)
        // если даже поставить nil SceneKit автоматом определит что за фигуру мы делаем
        // SCNPhysicsShape - определяет какая форма или сами создаем фигру и форму
        
        let physicsShape = SCNPhysicsShape(geometry: self.geometry!, options: nil)
        self.physicsBody = SCNPhysicsBody(type: .dynamic, shape: nil)
        self.position = position
        
        print(physicsShape)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
