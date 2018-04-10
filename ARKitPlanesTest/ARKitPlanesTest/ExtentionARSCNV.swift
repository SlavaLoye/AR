//
//  ExtentionARSCNV.swift
//  ARKitPlanesTest
//
//  Created by Вячеслав Лойе on 10.04.2018.
//  Copyright © 2018 Вячеслав Лойе. All rights reserved.
//

import ARKit
import SceneKit
import UIKit

// MARK: - ARSCNViewDelegate

extension ViewController : ARSCNViewDelegate {
    
    // обрабатываем делегат didAdd который точками (рендерит,считывает) определяет поверхность на земле
    
    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
        
        // проверка, если мы опредедили лицо то мы не хотим больше добыавлять никакой поверхности
        
        guard anchor is ARPlaneAnchor else { return } // можно добавить fatal error
        
        // но если это поверхность то мы будем ее использовать
        let plane = Plane(anchor: anchor as! ARPlaneAnchor)
        // после того как мы создали поверхность нужно положить ее в массив planes
        self.planes.append(plane)
        // добавляем только что созданную поверхность в node(представление)
        node.addChildNode(plane)
    }
    
    // plane - Это поверхность мы ее определяем
    
    // этот метод обновляет node (представление) потому что оно постоянно расширяется и мы узнаем о ней больше нового и он определяет поверхность какую мы должны обновить
    func renderer(_ renderer: SCNSceneRenderer, didUpdate node: SCNNode, for anchor: ARAnchor) {
        
        // мы замыканием перебираем весь наш массив planes  и фильтруем (filter) его,  например мы направили в пол наш телефон и фильтруем поверхность и если мы находим поверхность с тем индефикатором который мы определили то мы ее расширяем
        let plane = self.planes.filter { plane  in
            return plane.anchor.identifier == anchor.identifier
        }.first
        
        // и если мы такую поверхность нашли не nil то идем дальше
        
        guard plane != nil  else { return }
        plane?.update(anchor: anchor as! ARPlaneAnchor)
        
    }
}
