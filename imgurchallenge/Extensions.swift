//
//  Extensions.swift
//  imgurchallenge
//
//  Created by Spencer Müller Diniz on 25/10/20.
//

import Foundation
import UIKit

extension Int {
    public func friendlyString() -> String {
        if self > 999999 {
            return "\(self / 1000000)M"
        }
        else if self > 999 {
            return "\(self / 1000)K"
        }
        else {
            return "\(self)"
        }
    }
}


extension UIView {
    private static let kRotationAnimationKey = "rotationanimationkey"

    func startRotating(duration: Double = 1.0) {
        if layer.animation(forKey: UIView.kRotationAnimationKey) == nil {
            let rotationAnimation = CABasicAnimation(keyPath: "transform.rotation")

            rotationAnimation.fromValue = 0.0
            rotationAnimation.toValue = Float.pi * 2.0
            rotationAnimation.duration = duration
            rotationAnimation.repeatCount = Float.infinity

            layer.add(rotationAnimation, forKey: UIView.kRotationAnimationKey)
        }
    }

    func stopRotating() {
        if layer.animation(forKey: UIView.kRotationAnimationKey) != nil {
            layer.removeAnimation(forKey: UIView.kRotationAnimationKey)
        }
    }
}
