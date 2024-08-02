//
//  MainViewModel.swift
//  codingTask
//
//  Created by Allnet Systems on 7/30/24.
//

class MainViewModel {
    private let menuService = ServiceFile.shared
    private(set) var items: [Item] = []
    
    var onItemsUpdated: (() -> Void)?
    var onError: ((String) -> Void)?
    
    func fetchItems(completion: (() -> Void)? = nil) {
        menuService.fetchItems { [weak self] items in
            self?.items = items ?? []
            self?.onItemsUpdated?()
            completion?()
        }
    }
    
    var numberOfItems: Int {
        return items.count
    }
}

