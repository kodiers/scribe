//
//  CircleButton.swift
//  scribe
//
//  Created by Viktor Yamchinov on 04.06.2020.
//  Copyright © 2020 Viktor Yamchinov. All rights reserved.
//

import UIKit

@IBDesignable
class CircleButton: UIButton {

    @IBInspectable var cornerRadius: CGFloat = 30 {
        didSet {
            setupView()
        }
    }
    
    override func prepareForInterfaceBuilder() {
        setupView()
    }
    
    func setupView() {
        layer.cornerRadius = cornerRadius
    }

}
