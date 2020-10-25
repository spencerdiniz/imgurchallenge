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
    @IBOutlet private weak var activityIndicator: UIActivityIndicatorView!

    override func awakeFromNib() {
        super.awakeFromNib()

        self.viewContent.clipsToBounds = true
        self.viewContent.layer.cornerRadius = 6.0

        self.viewInfoBar.clipsToBounds = true
        self.viewInfoBar.layer.cornerRadius = 5.0

        self.prepareForReuse()
    }

    override func prepareForReuse() {
        self.imageViewMain.kf.cancelDownloadTask()
        self.imageViewMain.image = UIImage(named: "imagePlaceholder")
        self.labelViewCount.text = "0"
        self.labelCommentCount.text = "0"
        self.labelUpDownBalance.text = "0"
        self.activityIndicator.stopAnimating()
    }

    public func setup(_ imageFeedCard: ImageFeedCard) {
        if let imageUrl = imageFeedCard.imageUrl {
            print(imageUrl)
            
            self.activityIndicator.startAnimating()
            self.imageViewMain.kf.setImage(with: imageUrl, completionHandler: { result in
                DispatchQueue.main.async {
                    self.activityIndicator.stopAnimating()

                    switch result {
                    case .failure(_):
                        self.imageViewMain.image = UIImage(named: "noImagePlaceholder")
                    default:
                        break
                    }
                }
            })
        }
        else {
            self.activityIndicator.stopAnimating()
            self.imageViewMain.image = UIImage(named: "noImagePlaceholder")
        }

        self.labelViewCount.text = "\(imageFeedCard.views)"
        self.labelCommentCount.text = "\(imageFeedCard.comments)"
        self.labelUpDownBalance.text = "\(imageFeedCard.upDownBalance)"
    }
}
