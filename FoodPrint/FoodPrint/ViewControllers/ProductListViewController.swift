//
//  ProductListViewController.swift
//  FoodPrint
//
//  Created by nico on 17.11.20.
//

import UIKit


class ProductListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    
    
    
    
    
    // MARK: - ATTRIBUTES
    
    // VARIABLE THAT KEEPS PRODUCT-DATA OF DTO FROM API
    var productsDTO : [ProductDTO] = []
    
    // VARIABLE THAT KEEPS THE PRODUCT-DATA
    var products: [Product] = []
    
    // VARIABLE THAT KEEPS THE FILTERED PRODUCT-DATA ACCORDING TO USER-SETTINGS
    var filteredProducts: [Product] = []
    
    // VARIABLE THAT KEEPS FILTERED DATA OF SEARCHBOX
    var searchBarProducts: [Product] = []
    
    // VARIABLE THAT KEEPS USER-SETTINGS
    var user: User?
    
    // CONSTANT THAT KEEPS URL FOR API-CALLS
    let urlProducts = URL(string: "http://localhost:8080/api/v1/products/Schweiz")!
    
    
    
    
    
    // MARK: - IBOUTLETS
    
    // VARIABLE THAT KEEPS REFERENCE TO TABLE VIEW ON STORYBOARD
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    
    
    
    
    // MARK: - IBACTIONS
    
    
    
    
    
    // MARK: - LIFE-CYCLE
    
    // FUNCTION WHICH IS CALLED AFTER VIEW DID LOAD
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        searchBar.delegate = self
        self.productsDTO = fetchProducts()
        createUser()
        readUser()
    
        
        // ADD USER-DATA TO USER-ATTRIBUTE
        // readUser()
        
        // CONVERT THE DTO FROM API TO THE STRUCTURE OF PRODUCT-CLASS AND ADD THEM TO PRODUCTS-ATTRIBUTE
        convertToProductFromDTO()
        
        // FILTER THE PRODUCTS-ATTRIBUTE BASED ON USER-SETTINGS AND ADD RESULT TO FILTEREDPRODUCTS-ATTRIBUTE
        filterProductData()
    }
   
    
    
    
    
    // MARK: - API
    
    // STRUCT
    struct ProductDTO: Codable{
        let category : String
        let name: String
        let country: String
        let seasonalMonths: [Int]
    }
    
    // STRUCT WITH A LIST OF DTO ON API
    struct ProductListOfDTO: Codable {
        let decodedProductsDTO: [ProductDTO]
    }
    
    // FUNCTION TO GET THE PRODUCT-DATA FROM API
    func fetchProducts() -> [ProductDTO] {
        var fetchedProducts: [ProductDTO]?
        do{
            let encodedData = try Data(contentsOf: self.urlProducts)
            print("Printing fetched data now")
            print(encodedData.description)
            fetchedProducts = try JSONDecoder().decode([ProductDTO].self, from: encodedData)
            // fetchedProductsDTO = decodedData.decodedProductsDTO
        } catch {
            print("Products could not be fetched from API")
        }
        return fetchedProducts!
    }

    
    
    
    
    // MARK: - TABLE VIEW
    
    // FUNCTION TO DEFINE THE NUMBER OF ROWS
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchBarProducts.count
    }
    
    // FUNCTION TO SET THE CONTENT OF EACH CELL
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProductCell", for: indexPath)
        cell.textLabel?.text = "\(searchBarProducts[indexPath.row].name)"
        return cell
    }
    
    // FUNCTION TO DEFINE THE AMOUNT OF SECTIONS IN TABLE VIEW
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    // FUNCTION TO REFRESH THE TABLE VIEW
    func reloadProducts() {
        self.tableView.reloadData()
    }
    
    
    
    
    
    // MARK: - SEGUES
    
    // FUNCTION TO CHANGE VIEW TO PRODUCT VIEW CONTROLLER
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let indexPath = self.tableView.indexPathForSelectedRow!
         
        if segue.identifier == "product", let productViewController = segue.destination as? ProductViewController{
            productViewController.product = filteredProducts[indexPath.row]
         }
        
        //TODO Create View in Storyboard and add identifier
        if segue.identifier == "user-settings", let userSettingsViewController = segue.destination as? UserSettingsViewController{
            userSettingsViewController.user = self.user
            userSettingsViewController.modalPresentationStyle = .fullScreen
         }
        
        //TODO Create View in Storyboard and add identifier
        if segue.identifier == "about", let aboutViewController = segue.destination as? AboutViewController{
            aboutViewController.modalPresentationStyle = .fullScreen
         }
        
     }
    

    
    
    
    // MARK: - SEARCHBAR
    
    // FUNCTION TO FILTER FILTERED PRODUCTS BY USER INPUT IN SEARCH BAR
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText == "" {
            searchBarProducts = filteredProducts
        } else {
            for product in filteredProducts {
                if product.name.lowercased().contains(searchText.lowercased()) {
                    searchBarProducts.append(product)
                }
            }
        }
        reloadProducts()
    }
    
    
    
    
    
    // MARK: - CORE DATA
    
    // CONSTANT TO KEEP MANAGED-OBJECT-CONTEXT OF PERSISTENCE-CONTAINER
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    func createUser() {
        
        var user = User(context: self.context)
        user.country = "Schweiz"
        user.language = "Deutsch"
        user.preferences = ["Gemüse"]
        user.rating = 4
        
        do {
            try self.context.save()
        } catch {
            print("User couldnt be created");
        }
        print("User was created")
    }
    
    // FUNCTION TO READ USER-SETTINGS
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
                print(users.first)
                self.user = users.first
            }
        } catch {
           print("User could not be read")
        }
    }
    
    // FUNCTION TO UPDATE USER-SETTINGS
    func updateUser(language: String, rating: Int16, preferences: [String]) {
        self.user?.language = language
        self.user?.rating = rating
        self.user?.preferences = preferences
        
        do{
            try self.context.save()
        } catch {
            print("User could not be updated")
        }
    }
    
    
    
    
    
    // MARK: - LOGIC
    
    // FUNCTION TO CONVERT DTO TO TYPE OF CLASS PRODUCT
    func convertToProductFromDTO() {
        for productDTO in self.productsDTO{
            let rating: Int = rateProduct(months: productDTO.seasonalMonths)
            let name: String = productDTO.name
            let category: String = productDTO.category
            let country: String = productDTO.country
            let months: [Int] = productDTO.seasonalMonths.sorted()
            
            self.products.append(Product(rating: rating, name: name, category: category, country: country, months: months))
            
        }
    }
    
    // FUNCTION TO RATE A PRODUCT BY ITS SEASON
    func rateProduct(months: [Int]) -> Int {
        var rating: Int?
        var startMonth : Int?
        var endMonth : Int?
        let existingYearTransition: Bool =  checkForYearTransition(months: months)
        
        let currentMonth = Calendar.current.component(.month, from: Date())
        
        switch(months.count) {
            case 1  :
                startMonth = months[0]
                endMonth = months[0]
                break
            case 2  :
                startMonth = months[0]
                endMonth = months[1]
                break
           default :
            if(existingYearTransition == true){
                let fetchedMonths = evaluateDatesWithYearTransition(months: months)
                startMonth = fetchedMonths[0]
                endMonth = fetchedMonths[1]
            } else {
                let fetchedMonths = evaluateDatesWithoutYearTransition(months: months)
                startMonth = fetchedMonths[0]
                endMonth = fetchedMonths[1]
            }
            break
        }
        
        rating = calculateRating(currentMonth: currentMonth, startMonth: startMonth!, endMonth: endMonth!, isTransitionYear: existingYearTransition)
        
        return rating!
    }
    
    // FUNCTION TO CHECK FOR YEAR TRANSITION
    func checkForYearTransition(months: [Int]) -> Bool{
        if months[0] == 1 && months[(months.count - 1)] == 12 {
            return true
        } else {
            return false
        }
    }
    
    // FUNCTION TO RECEIVE START AND ENDDATE WITHOUT YEAR TRANSITION
    func evaluateDatesWithoutYearTransition(months: [Int]) -> [Int] {
        let startMonth: Int = months[0]
        let endMonth: Int = months[months.count - 1]
        return [startMonth, endMonth]
    }
    
    // FUNCTION TO RECEIVE START AND ENDDATE WITH YEAR TRANSITION
    func evaluateDatesWithYearTransition(months: [Int]) -> [Int] {
        var startMonth : Int?
        var endMonth : Int?
        if (months.count == 12) {
            return [1, 12]
        }
        for (index, month) in months.enumerated() {
            if ((months[index + 1] - months[index]) != 1){
                endMonth = months[index]
                break
            }
        }
        
        for(index, month) in months.enumerated() {
            if((months[months.count-(index+1)] - months[months.count-(index + 2)]) != 1) {
                startMonth = months[months.count - (index+1)]
                break
            }
        }
        
        return[startMonth!, endMonth!]
    }
    
    // FUNCTION TO CALCULATE THE RATING BASED ON DATES
    func calculateRating(currentMonth: Int, startMonth: Int, endMonth: Int, isTransitionYear: Bool) -> Int {
        if (!isTransitionYear) {
            if startMonth < currentMonth && endMonth > currentMonth {
                return 3
            } else if startMonth == currentMonth || endMonth == currentMonth {
                return 2
            } else if (startMonth-1) == currentMonth || (endMonth+1)%12 == currentMonth {
                return 1
            } else if (startMonth-1) == 0 && currentMonth == 12 {
                return 1
            } else {
                return 0
            }
        } else {
            if (currentMonth < startMonth && currentMonth > endMonth)  {
                return 0
            } else if (currentMonth == startMonth || currentMonth == endMonth) {
                return 2
            } else if ((currentMonth + 1) == startMonth) || ((currentMonth - 1) == endMonth) {
                return 1
            } else {
                return 3
            }
        }
    }
    
    // FUNCTION TO FILTER THE PRODUCT-DATA ACCORDING TO USER-SETTINGS
    func filterProductData() {
        var tempFilteredProducts: [Product] = []
        for product in self.products{
            if product.rating >= self.user!.rating{
                for userPreference in self.user!.preferences! {
                    if product.category == userPreference{
                        tempFilteredProducts.append(product)
                    }
                }
            }
        }
        self.filteredProducts = tempFilteredProducts
    }
}
