//
//  BorderedButton.swift
//  Calculator
//
//  Created by Dang Thanh Dat on 8/2/19.
//  Copyright © 2019 Dang Thanh Dat. All rights reserved.
//

import UIKit

@IBDesignable final class BorderedButton: UIButton {

    @IBInspectable var borderColor: UIColor? {
        didSet {
            layer.borderColor = borderColor?.cgColor
        }
    }

    @IBInspectable var borderWidth: CGFloat = 0 {
        didSet {
            layer.borderWidth = borderWidth
        }
    }

    override var isHighlighted: Bool {
        didSet {
            guard let fadedColor = borderColor?.withAlphaComponent(0.2).cgColor else {
                return
            }

            if isHighlighted {
                layer.borderColor = fadedColor
            } else {
                layer.borderColor = borderColor?.cgColor

                let animation = CABasicAnimation(keyPath: "borderColor")
                animation.fromValue = fadedColor
                animation.toValue = borderColor?.cgColor
                animation.duration = 0.4
                layer.add(animation, forKey: "")
            }
        }
    }
}
