//
//  ImgurImageInfo.swift
//  imgurchallenge
//
//  Created by Spencer Müller Diniz on 25/10/20.
//

import Foundation

public struct ImgurImageInfo: Decodable {
    let id: String
    let link: String
    let type: String
}
