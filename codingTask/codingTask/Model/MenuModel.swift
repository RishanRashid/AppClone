//
//  MenuModel.swift
//  codingTask
//
//  Created by Allnet Systems on 7/30/24.
//

import Foundation

// MARK: - MenuModel
struct MenuModel: Codable {
    let success: Bool?
    let status: Int?
    let message: String?
    let data: DataClass?
}

// MARK: - DataClass
struct DataClass: Codable {
    let vendorsDetail: VendorsDetail?
    let vendorsItems: [VendorsItem]?
    
    private enum CodingKeys: String, CodingKey {
        case vendorsDetail = "Vendors_detail"
        case vendorsItems = "Vendors_items"
    }
}

// MARK: - VendorsDetail
struct VendorsDetail: Codable {
    let id: String?
    let phoneCode: String?
    let phone: String?
    let vendorPolicy: String?
    let location: String?
    let deliveryTime: String?
    let serviceCharges: String?
    let area: String?
    let logo: String?
    let minOrderAmount: String?
    let destinationId: String?
    let avgRating: String?
    let totalRatings: String?
    let isBusy: String?
    let startTime: String?
    let endTime: String?
    let isHomeService: String?
    let name: String?
    let description: String?
    let banner: String?
    let address: String?
    let vendorCategories: [String]?
    let workingDay: String?
    let is24: String?
    let isOpen: String?
    let areas: [Area]?
    
    private enum CodingKeys: String, CodingKey {
        case id
        case phoneCode = "phone_code"
        case phone
        case vendorPolicy = "vendor_policy"
        case location
        case deliveryTime = "delivery_time"
        case serviceCharges = "service_charges"
        case area
        case logo
        case minOrderAmount = "min_order_amount"
        case destinationId = "destination_id"
        case avgRating = "avg_rating"
        case totalRatings = "total_ratings"
        case isBusy = "is_busy"
        case startTime = "start_time"
        case endTime = "end_time"
        case isHomeService = "is_home_service"
        case name
        case description
        case banner
        case address
        case vendorCategories = "vendor_categories"
        case workingDay = "working_day"
        case is24 = "is_24"
        case isOpen = "is_open"
        case areas
    }
}

// MARK: - Area
struct Area: Codable {
    let vendorAreaID: String?
    let areaID: String?
    let nameEn: String?
    let latitude: String?
    let longitude: String?
    
    private enum CodingKeys: String, CodingKey {
        case vendorAreaID = "vendor_area_id"
        case areaID = "area_id"
        case nameEn = "name_en"
        case latitude
        case longitude
    }
}

// MARK: - VendorsItem
struct VendorsItem: Codable {
    let vendorCategoryID: Int?
    let vendorCategoryName: String?
    let items: [Item]?
    
    private enum CodingKeys: String, CodingKey {
        case vendorCategoryID = "vendor_category_id"
        case vendorCategoryName = "vendor_category_name"
        case items
    }
}

// MARK: - Item
struct Item: Codable {
    let id: Int?
    let name: String?
    let description: String?
    let icon: String?
    let vendorID: String?
    let regularPrice: Int?
    let servicePrice: Double?
    let serviceDiscountPrice: Double?
    let duration: String?
    let isProduct: Int?
    let isBusy: Int?
    let subItems: [SubItem]?
    let quantity: Int?
    
    private enum CodingKeys: String, CodingKey {
        case id
        case name
        case description
        case icon
        case vendorID = "vendor_id"
        case regularPrice = "regular_price"
        case servicePrice = "service_price"
        case serviceDiscountPrice = "service_discount_price"
        case duration
        case isProduct = "is_product"
        case isBusy = "is_busy"
        case subItems = "sub_item"
        case quantity
    }
}

// MARK: - SubItem
struct SubItem: Codable {
    let id: Int?
    let name: String?
    let minimum: Int?
    let maximum: Int?
    let addonValues: [AddonValue]?
    
    private enum CodingKeys: String, CodingKey {
        case id
        case name
        case minimum
        case maximum
        case addonValues = "addon_values"
    }
}

// MARK: - AddonValue
struct AddonValue: Codable {
    let id: Int?
    let name: String?
    let price: Double?
    let discountPrice: Int?
    
    private enum CodingKeys: String, CodingKey {
        case id
        case name
        case price
        case discountPrice = "discount_price"
    }
}
