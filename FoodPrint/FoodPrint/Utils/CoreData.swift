//
//  CoreData.swift
//  FoodPrint
//
//  Created by Frederico on 29.11.20.
//

import Foundation
import UIKit


class CoreData {
    
    // CONSTANT TO KEEP MANAGED-OBJECT-CONTEXT OF PERSISTENCE-CONTAINER
    static let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    static var products: [ProductCD] = []
    
    // MARK: - User
    // Creates and persists a new User
    static func createUser() -> User {
        let user = User(context: context)
        user.country = "Schweiz"
        user.language = "Deutsch"
        user.preferences = ["Gemüse"]
        user.rating = 1
        
        do {
            try context.save()
        } catch {
            print("User couldnt be created");
        }
        print("User was created")
        return user
    }
    
    // Returns the last element of the persisted Users
    static func getUser() -> User {
        var users: [User] = []
        do{
            users = try self.context.fetch(User.fetchRequest())
            if (users.count > 0){
                print("Reading User in Product List")
                print(users.last!)
                return users.last!
            }
        } catch {
           print("User could not be read")
        }
        return createUser()
    }
    
    // MARK: - Product
    // Parses productDTOs to Products and persists them in Core Data
    static func createAndSaveProduct(productDto: ProductDTO, rating: Int16) {
        let product = ProductCD(context: context)
        product.category = productDto.category
        product.country = productDto.country
        product.name = productDto.name
        product.rating = rating
        product.months = productDto.seasonalMonths.sorted()
        do {
            try context.save()
        } catch {
            print("Product couldn't be saved!!!");
        }
        print("Product was created")
    }
    
    // Returns all Products
    static func getAllProducts() -> [ProductCD] {
        if (!CoreData.products.isEmpty) {
            return CoreData.products
        }
        var products: [ProductCD] = []
        do{
            products = try context.fetch(ProductCD.fetchRequest())
            if (products.count > 0){
                print("Reading Products from CoreData")
                print(products.description)
            }
        } catch {
           print("Products from CoreData could not be read")
        }
        CoreData.products = products
        return products
    }
    
    static func checkIfProductExist(productDto: ProductDTO, rating: Int16) -> Bool {
        for product in CoreData.products {
            if (productDto.name == product.name) {
                return true
            }
        }
        return false
    }
    
    static func loadProducts() {
        var products: [ProductCD] = []
        do{
            products = try context.fetch(ProductCD.fetchRequest())
            if (products.count > 0){
                print("Reading Products from CoreData")
                print(products.description)
                CoreData.products = products
            }
        } catch {
           print("Products from CoreData could not be read")
        }
        
    }
    
    
}
