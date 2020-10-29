//
//  testCoreData.swift
//  FoodPrint
//
//  Created by nico on 29.10.20.
//

import Foundation
import UIKit


class testCoreData {
    
    var user: User?

    
    
    
    
    // MARK: - Core Data Setup
    
    // Get de Managed-Object-Context of the Persistent Container
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    
    
    
    
    // MARK: - Functions to handle Core Data
    
    // Function to get User-Object
    func readUser() {
        var users: [User] = []
        do{
            
            // FILTERING - WATCH DOC FOR MORE
            // let request = User.fetchRequest() as NSFetchRequest<User>
            // let predicate = NSPredicate(format: "language CONTAINS %@", "English")
            // request.predicate = pred
            // self.user = try context.fetch(request)
            
            // SORTING - WATCH DOC FOR MORE
            // let request = User.fetchRequest() as NSFetchRequest<User>
            // let sort = NSSortDescriptor(key: "language", ascending: true)
            // request.sortDescriptor = [sort]
            // self.user = try context.fetch(request)
            
            users = try self.context.fetch(User.fetchRequest())
            if (users.count > 0){
                self.user = users[0]
            }
        } catch {
            
        }
    }
    
    // Function to update User-Object
    func updateUser(language: String, rating: Int16, preferences: [String]) {
        self.user?.language = language
        self.user?.rating = rating
        self.user?.preferences = preferences
        
        do{
            try self.context.save()
        } catch {
            
        }
    }

}
