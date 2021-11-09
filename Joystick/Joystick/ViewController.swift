//
//  ViewController.swift
//  Joystick
//
//  Created by 황지은 on 2021/11/09.
//

import UIKit
import SceneKit
import ARKit

class ViewController: UIViewController {
    
    @IBOutlet var sceneView: ARSCNView!
    let augmentedRealitySession = ARSession()
    let configuration = ARWorldTrackingConfiguration()
    var nodeWeCanChange: SCNNode?
    let imageGallery = [
        UIImage(named: "texture"), UIImage(named: "pink")]

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the view's delegate
        sceneView.delegate = self
        
        // Show statistics such as fps and timing information
        sceneView.showsStatistics = true
        
//        // Create a new scene
//        let scene = SCNScene(named: "art.scnassets/ship.scn")!
//
//        // Set the scene to the view
//        sceneView.scene = scene
        
        //1. Set Up Our ARSession
        sceneView.session = augmentedRealitySession
        
        //3. Set Up Plane Detection
        configuration.planeDetection = .vertical
        
        //4. Run Our Configuration
        augmentedRealitySession.run(configuration, options: [.resetTracking, .removeExistingAnchors])
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
    
    @IBAction func imageTap(_ sender: UIButton) {
        guard let imageToApply = imageGallery[sender.tag], let node = nodeWeCanChange  else { return}
            node.geometry?.firstMaterial?.diffuse.contents = imageToApply
    }
    // MARK: - ARSCNViewDelegate
    
    /*
     // Override to create and configure nodes for anchors added to the view's session.
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
extension ViewController: ARSCNViewDelegate {

    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {

            //1. If We Havent Create Our Interactive Node Then Proceed
            if nodeWeCanChange == nil{

                //a. Check We Have Detected An ARPlaneAnchor
                guard let planeAnchor = anchor as? ARPlaneAnchor else { return }

                //b. Get The Size Of The ARPlaneAnchor
                let width = CGFloat(planeAnchor.extent.x)
                let height = CGFloat(planeAnchor.extent.z)

                //c. Create An SCNPlane Which Matches The Size Of The ARPlaneAnchor
                nodeWeCanChange = SCNNode(geometry: SCNPlane(width: width, height: height))

                //d. Rotate It
                nodeWeCanChange?.eulerAngles.x = -.pi/2

                //e. Set It's Colour To Red
                nodeWeCanChange?.geometry?.firstMaterial?.diffuse.contents = UIColor.red

                //f. Add It To Our Node & Thus The Hiearchy
                node.addChildNode(nodeWeCanChange!)
            }


        }
}
