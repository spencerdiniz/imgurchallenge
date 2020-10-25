//
//  HomeViewController.swift
//  imgurchallenge
//
//  Created by Spencer Müller Diniz on 25/10/20.
//

import UIKit

class HomeViewController: UIViewController {
    @IBOutlet private var collectionView: UICollectionView!

    private let refreshControl = UIRefreshControl()
    private var galleries: [ImgurGalleryInfo] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        self.collectionView.register(UINib(nibName: "ImageFeedCardCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: ImageFeedCardCollectionViewCell.reuseIdentifier)

        self.setupCollectionView()
        self.loadGalleries()
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    private func setupCollectionView() {
        self.refreshControl.tintColor = ColorPalette.highText
        self.refreshControl.attributedTitle = nil
        self.refreshControl.alpha = 0.0
        self.refreshControl.addTarget(self, action: #selector(self.refreshGalleries), for: .valueChanged)
        self.collectionView.refreshControl = refreshControl

        if let refreshSpinnerView = Bundle.main.loadNibNamed("RefreshSpinnerView", owner: nil, options: nil)?.first as? RefreshSpinnerView {
            refreshSpinnerView.translatesAutoresizingMaskIntoConstraints = false

            self.refreshControl.addSubview(refreshSpinnerView)
            refreshSpinnerView.topAnchor.constraint(equalTo: self.refreshControl.topAnchor).isActive = true
            refreshSpinnerView.bottomAnchor.constraint(equalTo: self.refreshControl.bottomAnchor).isActive = true
            refreshSpinnerView.leadingAnchor.constraint(equalTo: self.refreshControl.leadingAnchor).isActive = true
            refreshSpinnerView.trailingAnchor.constraint(equalTo: self.refreshControl.trailingAnchor).isActive = true
        }
    }

    @objc private func refreshGalleries() {
        self.refreshControl.alpha = 0.0
        UIView.animate(withDuration: Constants.kDefaultAnimationDuration) { [weak self] in
            self?.refreshControl.alpha = 1.0
        }

        self.loadGalleries() {
            DispatchQueue.main.async { [weak self] in
                UIView.animate(withDuration: Constants.kDefaultAnimationDuration, delay: 0.0, options: []) {
                    self?.refreshControl.alpha = 0.0
                } completion: { _ in
                    self?.refreshControl.endRefreshing()
                }
            }
        }
    }

    private func loadGalleries(completion: (() -> Void)? = nil) {
        ImgurService.getTopOfWeek { [weak self] galleries in
            guard let galleries = galleries else {
                return
            }

            let filteredGalleries = galleries.filter { (galleryInfo) -> Bool in
                galleryInfo.images?.filter({ !$0.type.hasPrefix("video")}).count ?? 0 > 0
            }

            self?.galleries = filteredGalleries

            DispatchQueue.main.async {
                self?.collectionView.reloadData()
                completion?()
            }
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
            guard let coverImage = galleryInfo.images?.first(where: { $0.id == galleryInfo.cover && !$0.type.hasPrefix("video")}) else {
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
