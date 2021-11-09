//
//  Constants.swift
//  ARJoystick
//
//  Created by 황지은 on 2021/11/10.
//

import UIKit

var joystickNotificationName = NSNotification.Name("joystickNotificationName")
let joystickVelocityMultiplier: CGFloat = 0.0005

struct Constants {
    static let tubeScenePath = "art.scnassets/Models/tube.scn"
    static let galleryScenePath = "art.scnassets/Models/FocusScene.scn"
    static let tubeNodeName = "tubes"
    static let frameNodeName = "frame1"
    static let tubeCameraNodeName = "camera"
}
