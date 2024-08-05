//
//  ServiceFile.swift
//  codingTask
//
//  Created by Allnet Systems on 7/30/24.
//

import Alamofire
import Foundation
import UIKit

class ServiceFile {
    static let shared = ServiceFile()
    
    func fetchMenu(completion: @escaping (Result<MenuModel, Error>) -> Void) {
        let url = "http://points.thecodelab.me/api/v2/vendor-details?id=127&lang=en&user_id="
        
        AF.request(url).responseDecodable(of: MenuModel.self) { response in
            switch response.result {
            case .success(let menuModel):
                completion(.success(menuModel))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func downloadImage(from url: URL, completion: @escaping (UIImage?) -> Void) {
        AF.request(url).responseData { response in
            switch response.result {
            case .success(let data):
                if let image = UIImage(data: data) {
                    completion(image)
                } else {
                    completion(nil)
                }
            case .failure(let error):
                completion(nil)
            }
        }
    }
}
