//
//  LoadErrorView.swift
//  imgurchallenge
//
//  Created by Spencer Müller Diniz on 25/10/20.
//

import UIKit

class LoadErrorView: UIView {
    @IBOutlet private weak var imageViewErrorIcon: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()

        self.imageViewErrorIcon.layer.borderColor = ColorPalette.highlightText?.cgColor
        self.imageViewErrorIcon.layer.borderWidth = 2.0
        self.imageViewErrorIcon.layer.cornerRadius = self.imageViewErrorIcon.bounds.width / 2.0
        self.imageViewErrorIcon.clipsToBounds = true
    }
}
