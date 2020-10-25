//
//  RefreshSpinnerView.swift
//  imgurchallenge
//
//  Created by Spencer Müller Diniz on 25/10/20.
//

import UIKit

class RefreshSpinnerView: UIView {
    @IBOutlet private weak var imageViewSpinner: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()

        UIView.animate(withDuration: Constants.kDefaultAnimationDuration, delay: 0.0, options: [.repeat], animations: { [weak self] in
            let degrees = CGFloat(180.0 * Double.pi / 180.0)
            self?.imageViewSpinner.transform = CGAffineTransform(rotationAngle: degrees)
        }, completion: nil)
    }
}
