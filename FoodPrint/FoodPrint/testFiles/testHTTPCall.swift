//
//  testHTTPCall.swift
//  FoodPrint
//
//  Created by nicock on 29.10.20.
//

import Foundation





// MARK: - URL's
let urlProductList = URL(string: "https://")!
let urlLabels = URL(string: "https://")!





// MARK: - Data Structures for fetching data

// Structs containing information about the products
struct ProductList: Codable {
    let products: [Product]
}

struct Product: Codable {
    let name: String
    let description : String
    let season: String
    let lables: [String]
}

// Struct containing information for the label
struct Label: Codable{
    let labels: [String]
}




// MARK: - Functions to get data over HTTP

// Function to get products
func fetchProducts() -> [Product] {
    
    var products: [Product] = []
    
    do{
        let encodedData = try Data(contentsOf: urlProductList)
        
        let decodedData = try JSONDecoder().decode(ProductList.self, from: encodedData)
        
        products = decodedData.products
        
    } catch {
        print("error")
    }
    
    return products
}

// Function to get Labels
func fetchLabels() -> [String] {
    
    var products: [String] = []
    
    do{
        let encodedData = try Data(contentsOf: urlLabels)
        
        let decodedData = try JSONDecoder().decode(Label.self, from: encodedData)
        
        products = decodedData.labels
        
    } catch {
        print("error")
    }
    
    return products
}

