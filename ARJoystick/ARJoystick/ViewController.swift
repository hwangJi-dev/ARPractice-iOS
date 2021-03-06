//
//  ViewController.swift
//  ARJoystick
//
//  Created by 황지은 on 2021/11/10.
//

import UIKit
import SceneKit
import ARKit

struct SceneState {
    static let detectSurface = 0
    static let pointToSurface = 1
    static let readyToShow = 2
}

class ViewController: UIViewController, ARSCNViewDelegate {
    
    // MARK: - Properties
    @IBOutlet var sceneView: ARSCNView!
    var tubeNode: SCNNode!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the view's delegate
        sceneView.delegate = self
        
        // Show statistics such as fps and timing information
        sceneView.showsStatistics = true
        
        // Create a new scene
        let scene = SCNScene(named: Constants.tubeScenePath)!
        tubeNode = scene.rootNode.childNode(withName: Constants.tubeNodeName, recursively: false)!
        
        // Set the scene to the view
        sceneView.scene = scene
        notificationAddObserver()
        setupSKViewScene()
        makeGalleryFrames()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARWorldTrackingConfiguration()
        
        // Run the view's session
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }
    
    func notificationAddObserver() {
        NotificationCenter.default.addObserver(forName: joystickNotificationName, object: nil, queue: OperationQueue.main) { (notification) in
            guard let userInfo = notification.userInfo else { return }
            let data = userInfo["data"] as! AnalogJoystickData
            
            //      print(data.description)
            
            self.tubeNode.position = SCNVector3(self.tubeNode.position.x + Float(data.velocity.x * joystickVelocityMultiplier), self.tubeNode.position.y, self.tubeNode.position.z - Float(data.velocity.y * joystickVelocityMultiplier))
            
            self.tubeNode.eulerAngles.y = Float(data.angular) + Float(180.0.degreesToRadians)
        }
    }
    
    
    @IBAction func switchOnOffDidTap(_ sender: UISwitch) {
        
        if !sender.isOn {
            
            sceneView.scene.rootNode.childNodes.filter({ $0.name == "tubes" }).forEach({ $0.isHidden = true })
        }
        else {
            sceneView.scene.rootNode.childNodes.filter({ $0.name == "tubes" }).forEach({ $0.isHidden = false })
        }
    }
    
    func makeGalleryFrames() {
        let image = UIImage(named: "apple")
        let image2 = UIImage(named: "img1")
        let image3 = UIImage(named: "img2")
        let image4 = UIImage(named: "img3")
        let image5 = UIImage(named: "img4")
        let image6 = UIImage(named: "img5")
        
        let firstFrame = SCNNode(geometry: SCNPlane(width: 0.3, height: 0.3))
        let secondFrame = SCNNode(geometry: SCNPlane(width: 0.3, height: 0.3))
        let thirdFrame = SCNNode(geometry: SCNPlane(width: 0.3, height: 0.3))
        let fourthFrame = SCNNode(geometry: SCNPlane(width: 0.3, height: 0.3))
        let fifthFrame = SCNNode(geometry: SCNPlane(width: 0.3, height: 0.3))
        let sixthFrame = SCNNode(geometry: SCNPlane(width: 0.3, height: 0.3))
        
//        secondFrame.position.x = firstFrame.position.x + 0.1
//        thirdFrame.position.x = secondFrame.position.x + 0.1
//        fourthFrame.position.x = thirdFrame.position.x + 0.1
//        fifthFrame.position.x = firstFrame.position.x - 0.1
//        sixthFrame.position.x = fifthFrame.position.x - 0.1
        
        firstFrame.geometry?.firstMaterial?.diffuse.contents = image
        secondFrame.geometry?.firstMaterial?.diffuse.contents = image2
        thirdFrame.geometry?.firstMaterial?.diffuse.contents = image3
        fourthFrame.geometry?.firstMaterial?.diffuse.contents = image4
        fifthFrame.geometry?.firstMaterial?.diffuse.contents = image5
        sixthFrame.geometry?.firstMaterial?.diffuse.contents = image6
        
//          var nodes = [SCNNode]()
        let nodes = [firstFrame, secondFrame, thirdFrame, fourthFrame, fifthFrame, sixthFrame]
//        self.sceneView.scene.rootNode.addChildNode(firstFrame)
//        self.sceneView.scene.rootNode.addChildNode(secondFrame)
//        self.sceneView.scene.rootNode.addChildNode(thirdFrame)
//        self.sceneView.scene.rootNode.addChildNode(fourthFrame)
//        self.sceneView.scene.rootNode.addChildNode(fifthFrame)
//        self.sceneView.scene.rootNode.addChildNode(sixthFrame)
 
        for i in 0...nodes.count - 1 {
//            let node = createSphereNode(withRadius: 0.05, color: .yellow)
//            nodes.append(node)
            nodes[i].position = SCNVector3(0,0,-1 * 1 / (i + 1))
//            nodes[i].rotate(by: SCNQuaternion(-1 * 1 / (i + 1), -2 / (i + 1), 0, 0), aroundTarget: SCNVector3(0,0,0))
            self.sceneView.scene.rootNode.addChildNode(nodes[i])
        }

        DispatchQueue.main.asyncAfter(deadline: .now()) {
            self.arrangeNode(nodes: nodes)
        }
    }
    
    func setupSKViewScene() {
        let scene = ARJoystickSKScene(size: CGSize(width: view.bounds.size.width, height: 180))
        scene.scaleMode = .resizeFill
        sceneView.overlaySKScene = scene
        //        sceneView.ignoresSiblingOrder = true
        //        sceneView.showsFPS = true
        //        sceneView.showsNodeCount = true
        //        sceneView.showsPhysics = true
    }
    
    func createSphereNode(withRadius radius: CGFloat, color: UIColor) -> SCNNode {
        let geometry = SCNSphere(radius: radius)
        geometry.firstMaterial?.diffuse.contents = color
        let sphereNode = SCNNode(geometry: geometry)
        return sphereNode
    }
    
    func arrangeNode(nodes:[SCNNode]) {
        
        let radius:CGFloat = 1;
        
        let angleStep = 2.0 * CGFloat.pi / CGFloat(nodes.count)
        
        var count:Int = 0
        
        for node in nodes {
            let xPos:CGFloat = CGFloat(self.sceneView.pointOfView?.position.x ?? 0) + CGFloat(cosf(Float(angleStep) * Float(count))) * (radius - 0)
            let zPos:CGFloat = CGFloat(self.sceneView.pointOfView?.position.z ?? 0) + CGFloat(sinf(Float(angleStep) * Float(count))) * (radius - 0)
            
            node.position = SCNVector3(xPos, 0, zPos)
            
            count = count + 1
        }
    }
    
    // MARK: - ARSCNViewDelegate
    
    /*
     Override to create and configure nodes for anchors added to the view's session.
     func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
     let node = SCNNode()
     
     return node
     }
     */
    
    func session(_ session: ARSession, didFailWithError error: Error) {
        // Present an error message to the user
        
    }
    
    func sessionWasInterrupted(_ session: ARSession) {
        // Inform the user that the session has been interrupted, for example, by presenting an overlay
        
    }
    
    func sessionInterruptionEnded(_ session: ARSession) {
        // Reset tracking and/or remove existing anchors if consistent tracking is required
        
    }
}
