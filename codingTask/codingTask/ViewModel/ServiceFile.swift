//
//  ServiceFile.swift
//  codingTask
//
//  Created by Allnet Systems on 7/30/24.
//

//import Alamofire
//import Foundation
//import UIKit
//
//class ServiceFile {
//    static let shared = serviceFile()
//    
//    func fetchProfiles(completion: @escaping (Result<EmployeesModel, Error>) -> Void) {
//            let url = "http://ec2-3-7-253-252.ap-south-1.compute.amazonaws.com:3052/user/profiles/cb3d7d28-0cd6-4505-8f33-35f5543dfbbd"
//            
//            AF.request(url, method: .get).validate().responseDecodable(of: EmployeesModel.self) { response in
//                switch response.result {
//                case .success(let employeesModel):
//                    completion(.success(employeesModel))
//                case .failure(let error):
//                    completion(.failure(error))
//                }
//            }
//        }
//
//    
//func downloadImage(from url: URL, completion: @escaping (UIImage?) -> Void) {
//        AF.request(url).responseData { response in
//            if let data = response.data, let image = UIImage(data: data) {
//                completion(image)
//            } else {
//                completion(nil)
//            }
//        }
//    }
//}
