//
//  Extensions.swift
//  ARPotal_SceneKit
//
//  Created by 황지은 on 2021/10/14.
//

import Foundation
import SceneKit
import ARKit

var width: CGFloat = 0.02
var height: CGFloat = 1
var length: CGFloat = 1

var doorLength: CGFloat = 0.3

func createBox(isDoor: Bool) -> SCNNode {
    let node = SCNNode()
    
    //ADD First Box
    let firstBox = SCNBox(width: width, height: height, length: isDoor ? doorLength : length, chamferRadius: 0)
    firstBox.firstMaterial?.diffuse.contents = UIColor.white
    let firstBoxNode = SCNNode(geometry: firstBox)
    firstBoxNode.renderingOrder = 200
    
    node.addChildNode(firstBoxNode)
    
    //ADD Masked Box
    let maskedBox = SCNBox(width: width, height: height, length: isDoor ? doorLength : length, chamferRadius: 0)
    maskedBox.firstMaterial?.diffuse.contents = UIColor.white
    maskedBox.firstMaterial?.transparency = 0.000000001
    
    let maskedBoxNode = SCNNode(geometry: maskedBox)
    maskedBoxNode.renderingOrder = 100
    maskedBoxNode.position = SCNVector3.init(width, 0, 0)
    
    node.addChildNode(maskedBoxNode)
    
    return node
}

extension FloatingPoint {
    var degreesToRadians: Self {
        return self * .pi / 180
    }
    
    var radiansToDegrees: Self {
        return self * 180 / .pi
    }
}
