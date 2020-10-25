//
//  ImageFeedCollectionViewCell.swift
//  imgurchallenge
//
//  Created by Spencer Müller Diniz on 25/10/20.
//

import UIKit
import Kingfisher

class ImageFeedCardCollectionViewCell: UICollectionViewCell {
    public static let reuseIdentifier: String = "ImageFeedCardCollectionViewCell"
    
    @IBOutlet private weak var viewContent: UIView!
    @IBOutlet private weak var imageViewMain: UIImageView!
    @IBOutlet private weak var labelUpDownBalance: UILabel!
    @IBOutlet private weak var labelCommentCount: UILabel!
    @IBOutlet private weak var labelViewCount: UILabel!
    @IBOutlet private weak var viewInfoBar: UIView!
    @IBOutlet private weak var imageViewSpinner: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()

        self.viewContent.clipsToBounds = true
        self.viewContent.layer.cornerRadius = 6.0

        self.viewInfoBar.clipsToBounds = true
        self.viewInfoBar.layer.cornerRadius = 5.0

        self.imageViewSpinner.layer.borderColor = ColorPalette.mainText?.cgColor
        self.imageViewSpinner.layer.borderWidth = 2.0
        self.imageViewSpinner.layer.cornerRadius = self.imageViewSpinner.bounds.width / 2.0
        self.imageViewSpinner.clipsToBounds = true

        self.prepareForReuse()
    }

    override func prepareForReuse() {
        self.imageViewMain.kf.cancelDownloadTask()
        self.imageViewMain.image = nil
        self.labelViewCount.text = "0"
        self.labelCommentCount.text = "0"
        self.labelUpDownBalance.text = "0"
    }

    public func setup(_ imageFeedCard: ImageFeedCard) {
        if let imageUrl = imageFeedCard.imageUrl {
            self.startSpinner()
            self.imageViewMain.kf.setImage(with: imageUrl, completionHandler: { [weak self] result in
                DispatchQueue.main.async {
                    self?.stopSpinner()

                    switch result {
                    case .failure(_):
                        self?.imageViewMain.image = UIImage(named: "imagePlaceholder")
                    default:
                        break
                    }
                }
            })
        }
        else {
            self.imageViewSpinner.isHidden = true
            self.imageViewMain.image = UIImage(named: "imagePlaceholder")
        }

        self.labelViewCount.text = "\(imageFeedCard.views)"
        self.labelCommentCount.text = "\(imageFeedCard.comments)"
        self.labelUpDownBalance.text = "\(imageFeedCard.upDownBalance)"
    }

    private func startSpinner() {
        self.imageViewSpinner.isHidden = false
        self.imageViewSpinner.startRotating()
    }

    private func stopSpinner() {
        self.imageViewSpinner.isHidden = true
        self.imageViewSpinner.stopRotating()
    }
}
