//
//  UniversityModel.swift
//  Networking&MVVM
//
//  Created by Samet Korkmaz on 13.09.2024.
//

import Foundation

// Main response model including paging data
struct UniversityResponse: Codable {
    let currentPage: Int
    let totalPage: Int
    let total: Int
    let itemPerPage: Int
    let pageSize: Int
    let data: [Province]
    
    enum CodingKeys: String, CodingKey {
        case currentPage
        case totalPage
        case total
        case itemPerPage
        case pageSize
        case data
    }
}

// Province and University data models
struct Province: Codable {
    let id: Int
    let province: String
    let universities: [University]
}

struct University: Codable {
    let name: String
    let phone: String
    let fax: String
    let website: String
    let email: String
    let address: String
    let rector: String
    
    // Custom coding key to match 'adress' from JSON to 'address' in the model
    enum CodingKeys: String, CodingKey {
        case name
        case phone
        case fax
        case website
        case email
        case address = "adress"  // Handling the mismatched key
        case rector
    }
}
