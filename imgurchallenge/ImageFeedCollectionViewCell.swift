//
//  ImageFeedCollectionViewCell.swift
//  imgurchallenge
//
//  Created by Spencer Müller Diniz on 25/10/20.
//

import UIKit

class ImageFeedCardCollectionViewCell: UICollectionViewCell {
    @IBOutlet private weak var viewContent: UIView!
    @IBOutlet private weak var imageViewMain: UIImageView!
    @IBOutlet private weak var labelUpDownBalance: UILabel!
    @IBOutlet private weak var labelCommentCount: UILabel!
    @IBOutlet private weak var labelViewCount: UILabel!
    @IBOutlet private weak var viewInfoBar: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()

        self.viewContent.clipsToBounds = true
        self.viewContent.layer.cornerRadius = 6.0

        self.viewInfoBar.clipsToBounds = true
        self.viewInfoBar.layer.cornerRadius = 5.0
    }

}
