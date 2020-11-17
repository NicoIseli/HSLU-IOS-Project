//
//  Product.swift
//  FoodPrint
//
//  Created by nico on 17.11.20.
//

class Product {
    let rating: Int
    let name: String
    let category : String
    let country: String
    let months: [Int]
    
    
    init(rating: Int, name: String, category: String, country: String, months: [Int]) {
        self.rating = rating
        self.name = name
        self.category = category
        self.country = country
        self.months = months
    }
}
