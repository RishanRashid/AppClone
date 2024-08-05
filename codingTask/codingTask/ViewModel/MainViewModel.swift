//
//  MainViewModel.swift
//  codingTask
//
//  Created by Allnet Systems on 7/30/24.
//

import Foundation

class MainViewModel {
    private let menuService = ServiceFile.shared
        private(set) var vendorsItems: [VendorsItem] = []
        private(set) var items: [Item] = []
        
        var onItemsUpdated: (() -> Void)?
        var onError: ((String) -> Void)?
        
        func fetchItems(completion: (() -> Void)? = nil) {
            menuService.fetchMenu { [weak self] result in
                switch result {
                case .success(let menuModel):
                    self?.vendorsItems = menuModel.data?.vendorsItems ?? []
                    self?.items = self?.vendorsItems.flatMap { $0.items ?? [] } ?? []
                    self?.onItemsUpdated?()
                case .failure(let error):
                    self?.onError?(error.localizedDescription)
                }
                completion?()
            }
        }
        
        var numberOfItems: Int {
            return items.count
        }
        
        func item(at index: Int) -> Item? {
            return index < items.count ? items[index] : nil
        }
        
        func vendorsItems(forCategory category: String) -> [Item] {
            return vendorsItems.first(where: { $0.vendorCategoryName == category })?.items ?? []
        }
    }
