//
//  HomeViewController.swift
//  imgurchallenge
//
//  Created by Spencer Müller Diniz on 25/10/20.
//

import UIKit

class HomeViewController: UIViewController {
    @IBOutlet private var collectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.collectionView.register(UINib(nibName: "ImageFeedCardCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: ImageFeedCardCollectionViewCell.reuseIdentifier)
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    private func setupUI() {
    }
}

extension HomeViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cardCell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageFeedCardCollectionViewCell.reuseIdentifier, for: indexPath)
        return cardCell
    }
}

extension HomeViewController: UICollectionViewDelegate {
}

extension HomeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = CGSize(width: collectionView.frame.width, height: 240.0)
        return size
    }
}
