//
//  ProvinceModel.swift
//  Networking&MVVM
//
//  Created by Samet Korkmaz on 14.09.2024.
//

import Foundation
// TableView ı doldurmak için kullanacağımız veriler
struct ProvinceModel {
    var cityName: String
    var isExpanded: Bool
    var universiteDetayData: [UniversiteDetayData]
}

struct UniversiteDetayData {
    var uniAdi: String
    var phone: String
    var fax: String
    var website: String
    var email: String
    var adress: String
    var rector: String
}
