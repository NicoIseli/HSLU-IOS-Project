//
//  DTOs.swift
//  FoodPrint
//
//  Created by Frederico on 29.11.20.
//

import Foundation

struct ProductDTO: Codable{
    let category : String
    let name: String
    let country: String
    let seasonalMonths: [Int]
}


