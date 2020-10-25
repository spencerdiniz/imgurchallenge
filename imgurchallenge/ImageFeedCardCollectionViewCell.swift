//
//  ImageFeedCollectionViewCell.swift
//  imgurchallenge
//
//  Created by Spencer Müller Diniz on 25/10/20.
//

import UIKit

class ImageFeedCardCollectionViewCell: UICollectionViewCell {
    public static let reuseIdentifier: String = "ImageFeedCardCollectionViewCell"
    
    @IBOutlet private weak var viewContent: UIView!
    @IBOutlet private weak var imageViewMain: UIImageView!
    @IBOutlet private weak var labelUpDownBalance: UILabel!
    @IBOutlet private weak var labelCommentCount: UILabel!
    @IBOutlet private weak var labelViewCount: UILabel!
    @IBOutlet private weak var viewInfoBar: UIView!

    override func awakeFromNib() {
        super.awakeFromNib()

        self.viewContent.clipsToBounds = true
        self.viewContent.layer.cornerRadius = 6.0

        self.viewInfoBar.clipsToBounds = true
        self.viewInfoBar.layer.cornerRadius = 5.0

        self.prepareForReuse()
    }

    override func prepareForReuse() {
        self.imageViewMain.image = nil
        self.labelViewCount.text = "0"
        self.labelCommentCount.text = "0"
        self.labelUpDownBalance.text = "0"
    }

    public func setup(_ imageFeedCard: ImageFeedCard) {
//        self.imageViewMain.image = nil
        self.labelViewCount.text = "\(imageFeedCard.views)"
        self.labelCommentCount.text = "\(imageFeedCard.comments)"
        self.labelUpDownBalance.text = "\(imageFeedCard.upDownBalance)"
    }
}
