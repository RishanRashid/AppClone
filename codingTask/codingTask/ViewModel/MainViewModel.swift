//
//  MainViewModel.swift
//  codingTask
//
//  Created by Allnet Systems on 7/30/24.
//

//import Foundation
//
//class MainViewModel {
//    private let profileService = serviceFile.shared
//    private(set) var profiles: [employeeProfile] = []
//        
//        var onProfilesUpdated: (() -> Void)?
//        var onError: ((String) -> Void)?
//        
//    func fetchProfiles(completion: (() -> Void)? = nil) {
//            profileService.fetchProfiles { [weak self] result in
//                switch result {
//                case .success(let employeesModel):
//                    self?.profiles = employeesModel.profiles
//                    print("Received Profiles: \(self?.profiles ?? [])")
//                    self?.onProfilesUpdated?()
//                case .failure(let error):
//                    self?.onError?(error.localizedDescription)
//                    print("Error fetching profiles: \(error.localizedDescription)")
//                }
//                completion?()
//            }
//        }
//        
//        func getProfile(at index: Int) -> employeeProfile {
//            return profiles[index]
//        }
//        
//        var numberOfProfiles: Int {
//            return profiles.count
//        }
//    }
