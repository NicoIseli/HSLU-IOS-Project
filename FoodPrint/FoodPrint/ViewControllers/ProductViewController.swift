//
//  ProductViewController.swift
//  FoodPrint
//
//  Created by nico on 17.11.20.
//

import UIKit

class ProductViewController: UIViewController {
    
    var product: Product?
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var seasonLabel: UILabel!
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var productNameLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadLabels()
    }
    
    // TODO; set language in usersettings
    func loadLabels() {
        self.categoryLabel.text = product!.category
        self.scoreLabel.text = String(product!.rating)
        self.seasonLabel.text = getMonthsAsString(product!.months)
        self.countryLabel.text = product!.country
        self.productNameLabel.text = product!.name
    }
    
    func getMonthsAsString(_ months: [Int]) -> String {
        var firstMonth: String = ProductViewController.translateMonth(months.first!)
        var lastMonth: String = ProductViewController.translateMonth(months.last!)
        return firstMonth + " - " + lastMonth
    }
    

    // MARK: - Utils
    
    // TODO: If we use more languages, we should use translationfiles AKA include formal language Parameter and read from a imported File!
    static func translateMonth(_ monthAsInt: Int) -> String {
        switch monthAsInt {
        case 1:
            return "Januar"
        case 2:
            return "Februar"
        case 3:
            return "März"
        case 4:
            return "April"
        case 5:
            return "Mai"
        case 6:
            return "Juni"
        case 7:
            return "Juli"
        case 8:
            return "August"
        case 9:
            return "September"
        case 10:
            return "Oktober"
        case 11:
            return "November"
        case 12:
            return "Dezember"
        default:
            return "Monat existiert nicht..."
        }
    }

}
