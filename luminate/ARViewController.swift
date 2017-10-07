//
//  ViewController.swift
//  luminate
//
//  Created by Jesse Litton on 10/6/17.
//  Copyright © 2017 com.reality.af. All rights reserved.
//

import UIKit
import ARKit
import SceneKit

class ARViewController: UIViewController, ARSCNViewDelegate, SCNSceneRendererDelegate, UIGestureRecognizerDelegate {

    @IBOutlet var sceneView: ARSCNView!
    
    var geometries = [SCNSphere(radius: 0.05),
                      SCNPlane(width: 0.05, height: 0.05),
                      SCNBox(width: 0.05, height: 0.05, length: 0.05, chamferRadius: 0.0025),
                      SCNPyramid(width: 0.01, height: 0.01, length: 0.01),
                      SCNBox(width: 0.25, height: 0.1, length: 0.1, chamferRadius: 0.0),
                      SCNPyramid(width: 0.05, height: 0.05, length: 0.05)]
    
    // MARK: - View Controller Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupScene()
        setupRecognizers()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupSession()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }
    
    // MARK: - Setup Methods
    
    func setupScene() {
        // Setup the ARSCNViewDelegate - this gives us callbacks to handle new
        // geometry creation
        self.sceneView.delegate = self
        
        // Adds default lighting to scene
        self.sceneView.autoenablesDefaultLighting = true
        
        // Show statistics such as fps and timing information
        self.sceneView.showsStatistics = true
        
        // Show debug information for feature tracking
        self.sceneView.debugOptions = [ARSCNDebugOptions.showFeaturePoints] // ARSCNDebugOptions.showWorldOrigin
        
        // Create a new scene by loading it from scene assets
        let scene = SCNScene()

        // Set the scene to the view
        self.sceneView.scene = scene
        sceneView.isPlaying = true
    }
    
    func setupSession() {
        // Create a session configuration
        let configuration = ARWorldTrackingConfiguration()
        
        // Specify that we want to track horizontal planes. Setting this will cause
        // the ARSCNViewDelegate methods to be called when planes are detected!
        configuration.planeDetection = .horizontal
        
        // Run the view's session
        sceneView.session.run(configuration)
    }
    
    func setupRecognizers() {
        // Single taps insert a new geometry into scene
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTapFrom))
        tapGestureRecognizer.numberOfTapsRequired = 1
        self.sceneView.addGestureRecognizer(tapGestureRecognizer)
    }
    
    // MARK: - Tap Handling Callbacks
    @objc func handleTapFrom(recognizer: UITapGestureRecognizer) {
        generateParticles()
    }
    
    func generateParticles() {
        print("Generating particles...")

        self.sceneView.scene.physicsWorld.gravity = SCNVector3Make(0.0, 0.0, 0.0)
        
        var angle: Float = 0.0
        let angleInc: Float = Float.pi / Float(geometries.count)
        
        for i in 0 ..< geometries.count {
            let radius: Float = Float.random(min: 0.5, max: 2.5)
            let phi: Float = Float.random(min: 0.5, max: 5)
            let theta: Float = Float.random(min: 0.5, max: 5)
 
            let parentOrb = SCNSphere(radius: CGFloat(Float.random(min: 0.05, max: 0.08)))
            parentOrb.firstMaterial?.diffuse.contents = UIColor(white: 1.0, alpha: CGFloat(Float.random(min: 0.4, max: 0.6)))
            
            let childOrb = SCNSphere(radius: CGFloat(Float.random(min: 0.03, max: 0.04)))
            childOrb.firstMaterial?.diffuse.contents = UIColor(white: 1.0, alpha: 1.0)
            childOrb.firstMaterial?.emission.contents = UIColor(white: 1.0, alpha: 1.0)
            
            
            let node = SCNNode(geometry: parentOrb)
            let child = SCNNode(geometry: childOrb)
            node.addChildNode(child)
            
            
            let displacement: Float = 0.025
            let up = SCNAction.moveBy(x: 0.0, y: CGFloat(displacement), z: 0.0, duration: 5.0)
            let down = SCNAction.moveBy(x: 0.0, y: CGFloat(-displacement), z: 0.0, duration: 5.0)
            
            let oscillation = SCNAction.repeatForever(SCNAction.sequence([up, down]))
            let rotation = SCNAction.repeatForever(SCNAction.rotateBy(x: 1, y: 1, z: 1, duration: 10))
            let actions = SCNAction.group([oscillation, rotation])
            
            node.runAction(actions)
            node.scale = SCNVector3Make(0.5, 0.5, 0.5)
            node.position = SCNVector3Make(
                radius * sin(theta) * cos(phi),
                radius * sin(theta) * sin(phi),
                radius * cos(theta)
            )
            
            self.sceneView.scene.rootNode.addChildNode(node)
            angle += angleInc
        }
    }
    
    // MARK: - Renderer Delegate Methods
    func renderer(_ renderer: SCNSceneRenderer, updateAtTime time: TimeInterval) {
        
    }
    
    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
        
    }
    
    func renderer(_ renderer: SCNSceneRenderer, didUpdate node: SCNNode, for anchor: ARAnchor) {
        
    }
    
    func renderer(_ renderer: SCNSceneRenderer, didRemove node: SCNNode, for anchor: ARAnchor) {
        
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
