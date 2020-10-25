//
//  ImgurService.swift
//  imgurchallenge
//
//  Created by Spencer Müller Diniz on 25/10/20.
//

import Foundation
import Alamofire

public class ImgurService {
    private static let clienteId = "e12eff138a85e3f"
    private static let clientSecret = "faed87cb80dd559cb5b855015f12210049f4e69c"
    private static let apiBase = "https://api.imgur.com/3"

    public static func getTopOfWeek(page: Int = 10, completion: @escaping (_ galleries: [ImgurGalleryInfo]?) -> Void) {
        let urlString = self.apiBase + "/gallery/top/top/week/\(page)?showViral=false&mature=false"

        let headers: HTTPHeaders = [
            "Authorization": "Client-ID \(self.clienteId)"
        ]

        let request = AF.request(urlString, method: .get, headers: headers)

        request.responseJSON { (response) in
            switch response.result {
            case .success:
                guard
                    let json = (response.value as? [String: Any]),
                    let dataDictionary = json["data"],
                    let jsonData = try? JSONSerialization.data(withJSONObject: dataDictionary) else {
                    completion([])
                    return
                }

                let galleries = (try? JSONDecoder().decode([ImgurGalleryInfo].self, from: jsonData)) ?? []
                completion(galleries)
            case .failure(_):
                completion(nil)
            }
        }
    }
}
