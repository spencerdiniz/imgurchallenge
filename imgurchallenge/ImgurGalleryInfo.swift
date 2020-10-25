//
//  ImgurGalleryInfo.swift
//  imgurchallenge
//
//  Created by Spencer Müller Diniz on 25/10/20.
//

import Foundation

public struct ImgurGalleryInfo: Decodable {
    let id: String
    let title: String?
    let cover: String?
    let ups: Int
    let downs: Int
    let views: Int
    let images: [ImgurImageInfo]?
}
