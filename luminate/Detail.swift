//
//  Detail.swift
//  luminate
//
//  Created by Prayash Thapa on 10/7/17.
//  Copyright © 2017 com.reality.af. All rights reserved.
//

import UIKit
import LBTAComponents

class DetailView: UIView {
    var textView = UITextView()
    var button = UIButton()
    var content = String()
    
    override init (frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor(red: 0.08, green: 0.5, blue: 0.78, alpha: 0.3)
        self.translatesAutoresizingMaskIntoConstraints = false
        
        setupGradient()
        setupTextView()
        setupRecognizers()
    }
    
    convenience init() {
        self.init(frame: CGRect.zero)
    }
    
    func setupGradient() {
        let imageView: UIImageView = {
            let view = UIImageView()
            view.image = UIImage(named: "gradient")
            return view
        }()
        
        addSubview(imageView)
        
        imageView.anchor(self.topAnchor, left: self.leftAnchor, bottom: self.bottomAnchor, right: self.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
    }
    
    func setupTextView() {
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.text = self.content
        textView.font = UIFont.boldSystemFont(ofSize: 24)
        textView.textColor = UIColor.white
        textView.backgroundColor = UIColor.clear
        textView.isEditable = false
        textView.textAlignment = .center
        self.addSubview(textView)
        
        let sizeThatfitsTextView = textView.sizeThatFits(CGSize(width: textView.frame.size.width, height: CGFloat(MAXFLOAT)))
        
        textView.anchor(nil, left: self.leftAnchor, bottom: self.bottomAnchor, right: self.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 250)
    }
    
    func setupRecognizers() {
        // Single taps insert a new geometry into scene
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(hideSelf))
        tapGestureRecognizer.numberOfTapsRequired = 1
        self.addGestureRecognizer(tapGestureRecognizer)
    }
    
    @objc func hideSelf() {
        self.isHidden = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
