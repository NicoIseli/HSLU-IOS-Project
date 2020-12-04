//
//  ProductListViewController.swift
//  FoodPrint
//
//  Created by nico on 17.11.20.
//

import UIKit


class ProductListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate, NotifyReloadCoreData {
    
    @IBOutlet weak var aboutButton: UIButton!
    @IBOutlet weak var userSettingsButton: UIButton!
    
    // MARK: - ATTRIBUTES
    var fetchedProductDTOsFromAPI : [ProductDTO] = []
    
    // Products in Core Data
    var allProducts: [ProductCD] = []
    var productsFilteredByUserSettings: [ProductCD] = []
    var productsFilteredBySearchBar: [ProductCD] = []
    
    // User in Core Data, contains User-Settings which can be changed in UserSettingsViewController
    var user: User?
    
    // CONSTANT THAT KEEPS URL FOR API-CALLS
    let urlProducts = URL(string: "http://ffischer-ios-h20.el.eee.intern:8080/api/v1/products/Schweiz")!

    
    // MARK: - IBOUTLETS
    // Searchbar which Filters Products by Name
    @IBOutlet weak var searchBar: UISearchBar!
    // Tableview of Filtered Products
    @IBOutlet weak var tableView: UITableView!
    
    
    
    // MARK: - LIFE-CYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        let paths = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)
        print(paths[0])
        print("Printed Filepath bevore")
        tableView.delegate = self
        tableView.dataSource = self
        searchBar.delegate = self
        
        self.user = CoreData.getUser()
        self.fetchedProductDTOsFromAPI = fetchProductsFromApi()
        
        // Because of Rating calculation I Couldn't put this process to CoreData Class!!! Else I have to made logic functions static...
        convertDTOsToProducts()
        
        self.allProducts = CoreData.getAllProducts()
        
        filterProductsByUserSettings()
        reloadProducts()
    }
   
    
    
    
    
    // MARK: - API
    
    // FUNCTION TO GET THE PRODUCT-DATA FROM API
    func fetchProductsFromApi() -> [ProductDTO] {
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
    
    // ARRAY TO STORE RATING-ICONS
    let ratingIcons = [UIImage(named: "Red"), UIImage(named: "Orange"), UIImage(named: "Yellow"), UIImage(named: "Green")]
    
    // FUNCTION TO DEFINE THE NUMBER OF ROWS
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return productsFilteredBySearchBar.count
    }
    
    // FUNCTION TO SET THE CONTENT OF EACH CELL
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProductCell", for: indexPath)
        cell.textLabel?.text = "\(productsFilteredBySearchBar[indexPath.row].name ?? "")"
        switch productsFilteredBySearchBar[indexPath.row].rating {
        case 0:
            cell.imageView?.image = ratingIcons[0]
        case 1:
            cell.imageView?.image = ratingIcons[1]
        case 2:
            cell.imageView?.image = ratingIcons[2]
        case 3:
            cell.imageView?.image = ratingIcons[3]
        default:
            print("No image was found!")
        }
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
         
        if segue.identifier == "product", let productViewController = segue.destination as? ProductViewController{
            let indexPath = self.tableView.indexPathForSelectedRow!
            productViewController.product = self.productsFilteredBySearchBar[indexPath.row]
         }
        
        if segue.identifier == "user-settings", let userSettingsViewController = segue.destination as? UserSettingsViewController{
            userSettingsViewController.user = self.user
            userSettingsViewController.notifyProductList = self
            userSettingsViewController.modalPresentationStyle = .fullScreen
         }
        
        if segue.identifier == "about", let aboutViewController = segue.destination as? AboutViewController{
            aboutViewController.modalPresentationStyle = .fullScreen
         }
     }
    

    
    
    
    // MARK: - SEARCHBAR
    
    // FUNCTION TO FILTER FILTERED PRODUCTS BY USER INPUT IN SEARCH BAR
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText == "" {
            productsFilteredBySearchBar = productsFilteredByUserSettings
        } else {
            self.productsFilteredBySearchBar = []
            for product in productsFilteredByUserSettings {
                if product.name!.lowercased().contains(searchText.lowercased()) {
                    productsFilteredBySearchBar.append(product)
                }
            }
        }
        reloadProducts()
    }
    
    
    // MARK: - LOGIC
    
    // FUNCTION TO CONVERT DTO TO TYPE OF CLASS PRODUCT
    func convertDTOsToProducts() {
        CoreData.loadProducts()
        for productDTO in self.fetchedProductDTOsFromAPI{
            let rating: Int16 = Int16(rateProduct(months: productDTO.seasonalMonths))
            if (!CoreData.checkIfProductExist(productDto: productDTO, rating: rating)) {
                print("Saving now an Entity")
                CoreData.createAndSaveProduct(productDto: productDTO, rating: rating)
            }
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
        for (index, _) in months.enumerated() {
            if ((months[index + 1] - months[index]) != 1){
                endMonth = months[index]
                break
            }
        }
        
        for(index, _) in months.enumerated() {
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
    
    
    func filterProductsByUserSettings() {
        var tempFilteredProducts: [ProductCD] = []
        for product in self.allProducts {
            if product.rating >= self.user!.rating {
                for userPreference in self.user!.preferences! {
                    if product.category == userPreference {
                        tempFilteredProducts.append(product)
                    }
                }
            }
        }
        let sortedProducts = tempFilteredProducts.sorted(by: { $0.name! < $1.name! })
        self.productsFilteredByUserSettings = sortedProducts
        self.productsFilteredBySearchBar = sortedProducts
    }
    
    // Reload ProductData by new User-Settings made in UserSettingsViewController
    func notifyDelegate() {
        print("Using Delegate function")
        self.user = CoreData.getUser()
        filterProductsByUserSettings()
        reloadProducts()
    }
}
