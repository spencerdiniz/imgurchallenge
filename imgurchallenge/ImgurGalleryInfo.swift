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
    let comments: Int
    let images: [ImgurImageInfo]?

    enum CodingKeys: String, CodingKey {
        case id
        case title
        case cover
        case ups
        case downs
        case views
        case comments = "comment_count"
        case images
    }
}
