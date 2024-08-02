//
//  MenuModel.swift
//  codingTask
//
//  Created by Allnet Systems on 7/30/24.
//

import Foundation

// MARK: - MenuModel
struct MenuModel: Decodable {
    let success: Bool?
    let status: Int?
    let message: String?
    let data: DataClass?
}

struct DataClass: Decodable {
//    let vendorsDetail: VendorsDetail?
//    let reviews: [Review]?
    let vendorsItems: [VendorsItem]?
//    let userLoyaltyPoints: Int?
}

//struct Review: Decodable {
//    let title, comment: String?
//    let rating: Int?
//}
//
//struct VendorsDetail: Decodable {
//    let id, phoneCode, phone, vendorPolicy: String?
//    let location, deliveryTime, serviceCharges, area: String?
//    let logo: String?
//    let minOrderAmount, destinationID, avgRating, totalRatings: String?
//    let isBusy, startTime, endTime, isHomeService: String?
//    let name, description: String?
//    let banner: String?
//    let address: String?
//    let vendorCategories: [String]?
//    let workingDay: WorkingDayEnum?
//    let is24, isOpen: String?
//    let areas: [Area]?
//}

// MARK: - Area
//struct Area: Decodable {
//    let vendorAreaID, areaID, nameEn, latitude: String?
//    let longitude: String?
//}

//enum WorkingDayEnum: String, Decodable {
//    case friday
//    case monday
//    case saturday
//    case sunday
//    case thursday
//    case tuesday
//    case wednesday
//}

// MARK: - VendorsItem
struct VendorsItem: Decodable {
    let vendorCategoryID: Int?
    let vendorCategoryName: String?
    let items: [Item]?  
}


// MARK: - Item
struct Item: Decodable {
    let id: Int?
    let name, description: String?
    let icon: String?
    let vendorID: String?
    let regularPrice: Int?
    let servicePrice: Double?
    let serviceDiscountPrice: Double? // Changed to Double
    let duration: String?
    let isProduct, isBusy: Int?
//    let subItem: [SubItem]?
    let quantity: Int?
//    let workingDays: [WorkingDayElement]?
}

// MARK: - SubItem
//struct SubItem: Decodable {
//    let id: Int?
//    let name: Name?
//    let minimum, maximum: Int?
//    let addonValues: [AddonValue]?
//}
//
//// MARK: - AddonValue
//struct AddonValue: Decodable {
//    let id: Int?
//    let name: String?
//    let price: Double?
//    let discountPrice: Int?
//}
//
//enum Name: String, Decodable {
//    case addONS
//    case carType
//    case ceilingSize
//    case extras
//    case nameCarType
//    case service
//    case size
//}
//
//// MARK: - WorkingDayElement
//struct WorkingDayElement: Decodable {
//    let workingDay: WorkingDayEnum?
//    let startTime, endTime: String?
//    let is24: Int?
//}
