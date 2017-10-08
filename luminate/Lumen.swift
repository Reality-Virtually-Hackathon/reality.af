//
//  Lumen.swift
//  luminate
//
//  Created by Prayash Thapa on 10/7/17.
//  Copyright © 2017 com.reality.af. All rights reserved.
//

import SceneKit

class Lumen: SCNNode {
    
    let size = Float.random(min: 0.125, max: 0.15)
    let sprites = [UIImage(named: "sprite1"),
                   UIImage(named: "sprite2"),
                   UIImage(named: "sprite3")]
    
    init(id: String, position: SCNVector3) {
        super.init()
        
        let orb = SCNPlane(width: CGFloat(size), height: CGFloat(size))
        let billboard = SCNBillboardConstraint()
        billboard.freeAxes = SCNBillboardAxis.all
        
        let node = SCNNode(geometry: orb)
        node.constraints = [billboard]
        node.name = id
        node.opacity = 0.0
        node.scale = SCNVector3Make(0.5, 0.5, 0.5)
        node.position = position
        
        let img = sprites[0]
        orb.firstMaterial?.diffuse.contents = img
        
        let displacement: Float = 0.5
        let down = SCNAction.moveBy(x: 0.0, y: CGFloat(-displacement), z: 0.0, duration: 5.0)
        let fade = SCNAction.fadeIn(duration: 3.0)
        let actions = SCNAction.group([down, fade])
        
        node.runAction(actions)
        addChildNode(node)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
