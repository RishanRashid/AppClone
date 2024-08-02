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
        
        AF.request(url, method: .get).validate().responseDecodable(of: MenuModel.self) { response in
            switch response.result {
            case .success(let menuModel):
                completion(.success(menuModel))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func fetchItems(completion: @escaping ([Item]?) -> Void) {
        fetchMenu { result in
            switch result {
            case .success(let menuModel):
                let items = menuModel.data?.vendorsItems?.flatMap { $0.items ?? [] } ?? []
                completion(items)
            case .failure(let error):
                print("Failed to fetch menu: \(error)")
                completion(nil)
            }
        }
    }

    
    func downloadImage(from url: URL, completion: @escaping (UIImage?) -> Void) {
        AF.request(url).responseData { response in
            if let data = response.data, let image = UIImage(data: data) {
                completion(image)
            } else {
                completion(nil)
            }
        }
    }
}
