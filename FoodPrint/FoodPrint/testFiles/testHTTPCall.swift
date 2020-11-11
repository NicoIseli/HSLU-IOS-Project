//
//  testHTTPCall.swift
//  FoodPrint
//
//  Created by nico on 29.10.20.
//

import Foundation


    // MARK: - URL's
    let urlProductList = URL(string: "https://")!


    // MARK: - Data Structures for fetching data

    // Structs containing information about the products
    struct ProductList: Codable {
        let products: [Product]
    }

    struct Product: Codable {
        let name: String
        let category : String
        let country: String
        let months: [Int]
    }




    // MARK: - Functions to get data over HTTP

    // Function to get products
    func fetchProducts() -> [Product] {
        
        //What about using a class instead of a struct? Calculate Rating etc. use it throughout several files etc.
        
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


    
    // MARK: - Functions to fill Tables
    
    
    /*
        let products : [Product] = fetchProducts()
        
        func reloadProducts() {
            self.tableView.reloadData()
        }
 
        override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            // #warning Incomplete implementation, return the number of rows
            return products.count
        }
 
        override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ProductCell", for: indexPath)
            cell.textLabel?.text = "\(products[indexPath.row].name) \(products[indexPath.row].rating)"
            return cell
         }
 
        override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
            return "Don't even know if this is necessary"
         }
 
 
        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            // Get the new view controller using segue.destination.
            // Pass the selected object to the new view controller.
             
            let indexPath = self.tableView.indexPathForSelectedRow!
             
            if segue.identifier == "product", let productViewController = segue.destination as? ProductViewController{
                productViewController.product = products[indexPath.row]
             }
         }
    */


    //MARK: - Class-Code for ProductViewController
    /*
         import UIKit

         class ProductViewController: UIViewController {

            @IBOutlet weak var nameLabel: UILabel!
             
            @IBOutlet weak var informationLabel: UILabel!
 
            @IBOutlet weak var informationLabel: UILabel!
             
            var product: Product
             
            override func viewDidLoad() {
                     super.viewDidLoad()
                 }
             
            override func viewWillAppear(_ animated: Bool) {
                 super.viewWillAppear(animated)
                 
                 self.firstNameLabel.text = self.product!.firstName
                 self.lastNameLabel.text = self.product!.lastName
                 self.postalCodeLabel.text = String(self.product!.rating)
             }
         }
 
 
    */

    
