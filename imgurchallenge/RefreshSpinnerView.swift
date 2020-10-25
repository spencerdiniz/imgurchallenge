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
        self.imageViewSpinner.startRotating()
    }
}
