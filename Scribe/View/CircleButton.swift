//
//  CircleButton.swift
//  Scribe
//
//  Created by Molnár Csaba on 2019. 09. 10..
//  Copyright © 2019. Molnár Csaba. All rights reserved.
//

import UIKit

@IBDesignable
class CircleButton: UIButton {
    
    @IBInspectable var cornerRadius: CGFloat = 30 {
        didSet {
            ()
        }
    }

    override func prepareForInterfaceBuilder() {
        setupView()
    }
    
    func setupView() {
        layer.cornerRadius = cornerRadius
    }
}
