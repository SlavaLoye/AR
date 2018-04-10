//
//  Plane.swift
//  ARKitPlanesTest
//
//  Created by Вячеслав Лойе on 10.04.2018.
//  Copyright © 2018 Вячеслав Лойе. All rights reserved.
//

import SceneKit
import ARKit

class Plane: SCNNode {
    var anchor: ARPlaneAnchor! // класс считывает повехности
    var planeGeometry: SCNPlane! // класс для того что бы передовать размер поверхности
      init(anchor: ARPlaneAnchor) {
        self.anchor = anchor
        super.init()
        configure()
    }

    // определяемся с поверхностью и материалами
    private func configure() {
        self.planeGeometry = SCNPlane(width: CGFloat(anchor.extent.x), height: CGFloat(anchor.extent.z))
        let material = SCNMaterial()
        material.diffuse.contents  = UIImage(named: "pinkWeb.png")
        
        //  позиция и материал
        self.planeGeometry.materials = [material]
        self.geometry = planeGeometry
    
        // добавляем SCNPhysicsBody что бы управлять динамическими телами
        // если даже поставить nil SceneKit автоматом определит что за фигуру мы делаем
        // SCNPhysicsShape - определяет какая форма или сами создаем фигру и форму
        
        let physicsShape = SCNPhysicsShape(geometry: self.geometry!, options: nil)
        self.physicsBody = SCNPhysicsBody(type: .static, shape: physicsShape)
        
        
        self.position = SCNVector3(anchor.center.x, 0, anchor.center.z)
    // отражение в горизонтале
        self.transform = SCNMatrix4MakeRotation(Float( -Double.pi / 2), 1.0, 0.0, 0.0)
    }
    
    // делаем апдейт - обновление при вращении что бы было видно что там больше места
    func update(anchor: ARPlaneAnchor)  {
        
        // расширяем нашу поверхность и указываем ей новую поверхность из делегата ARSCNViewDelegate
        //определяем что наша ширина не то что прежде
        self.planeGeometry.width = CGFloat(anchor.extent.x)
        self.planeGeometry.width = CGFloat(anchor.extent.z)
        
        // обнаружили например что наша позиция не квадратная а ввиде прямоугольника и нужно сместиться
        
        self.position = SCNVector3(anchor.center.x, 0, anchor.center.z)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
