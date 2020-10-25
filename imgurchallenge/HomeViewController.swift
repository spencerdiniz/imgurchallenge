//
//  HomeViewController.swift
//  imgurchallenge
//
//  Created by Spencer Müller Diniz on 25/10/20.
//

import UIKit

class HomeViewController: UIViewController {
    @IBOutlet private var collectionView: UICollectionView!

    private var galleries: [ImgurGalleryInfo] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        self.collectionView.register(UINib(nibName: "ImageFeedCardCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: ImageFeedCardCollectionViewCell.reuseIdentifier)

        self.loadGalleries()
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    private func loadGalleries() {
        ImgurService.getTopOfWeek { [weak self] galleries in
            guard let galleries = galleries else {
                return
            }

            self?.galleries = galleries
            self?.collectionView.reloadData()
        }
    }
}

extension HomeViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.galleries.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cardCell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageFeedCardCollectionViewCell.reuseIdentifier, for: indexPath) as! ImageFeedCardCollectionViewCell

        let galleryInfo = self.galleries[indexPath.item]

        let imageUrl: URL? = {
            guard let coverImage = galleryInfo.images?.first(where: { $0.id == galleryInfo.cover }) else {
                return nil
            }

            return URL(string: coverImage.link)
        }()

        let upDownBalance = (galleryInfo.ups - galleryInfo.downs).friendlyString()
        let comments = galleryInfo.comments.friendlyString()
        let views = galleryInfo.views.friendlyString()
        let imageFeedCard = ImageFeedCard(imageUrl: imageUrl, upDownBalance: upDownBalance, comments: comments, views: views)
        cardCell.setup(imageFeedCard)

        return cardCell
    }
}

extension HomeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = CGSize(width: collectionView.frame.width, height: 240.0)
        return size
    }
}
