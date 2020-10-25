//
//  Extensions.swift
//  imgurchallenge
//
//  Created by Spencer Müller Diniz on 25/10/20.
//

import Foundation

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
