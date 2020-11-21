//
//  UserSettingsViewController.swift
//  FoodPrint
//
//  Created by nicock on 19.11.20.
//

import UIKit

class UserSettingsViewController: UIViewController {
    
    // MARK: - ATTRIBUTES
    var user: User?
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var notifyProductList: NotifyReloadCoreData?
    
    
    // MARK: - IBOUTLETS

    @IBOutlet weak var ratingSliderLabel: UILabel!
    @IBOutlet weak var ratingSlider: UISlider!
    @IBOutlet weak var ratingTitleLabel: UILabel!
    @IBOutlet weak var ratingDescriptionLabel: UILabel!
    @IBOutlet weak var doneButton: UIButton!
    @IBOutlet weak var vegetableButton: UIButton!
    @IBOutlet weak var fruitButton: UIButton!
    @IBOutlet weak var saladButton: UIButton!
    @IBOutlet weak var berryButton: UIButton!
    @IBOutlet weak var potatoeButton: UIButton!
    @IBOutlet weak var herbButton: UIButton!
    @IBOutlet weak var mushroomButton: UIButton!
    @IBOutlet weak var appleButton: UIButton!

    
    // MARK: - IBACTIONS

    // FUNCTION TO HANDLE SLIDER CHANGES
    @IBAction func onRatingSliderChanged(sender: UISlider){
        let castedRating = Int(sender.value)
        self.ratingSliderLabel.text = getRatingLabel(castedRating)
        self.user?.rating = Int16(castedRating)
    }

    // FUNCTION TO HANDLE PRESS ON VEGETABLE BUTTON
    @IBAction func onVegetableButtonPressed(sender: UIButton){
        let category: String = "Gemüse"
        if self.user!.preferences!.contains(category){

            if let index = self.user?.preferences?.firstIndex(of: category) {
                self.user?.preferences?.remove(at: index)
            }
            
            undoDesignChangeOfPreference(sender: sender)
          
        } else {
            self.user?.preferences?.append(category)
            doDesignChangeOfPreference(sender: sender)
        }
    }
    
    // FUNCTION TO HANDLE PRESS ON FRUIT BUTTON
    @IBAction func onFruitButtonPressed(sender: UIButton){
        let category: String = "Früchte"
        if self.user!.preferences!.contains(category){

            if let index = self.user?.preferences?.firstIndex(of: category) {
                self.user?.preferences?.remove(at: index)
            }
            
            undoDesignChangeOfPreference(sender: sender)
          
        } else {
            self.user?.preferences?.append(category)
            doDesignChangeOfPreference(sender: sender)
        }
    }
    
    // FUNCTION TO HANDLE PRESS ON SALAD BUTTON
    @IBAction func onSaladButtonPressed(sender: UIButton){
        let category: String = "Salate"
        if self.user!.preferences!.contains(category){

            if let index = self.user?.preferences?.firstIndex(of: category) {
                self.user?.preferences?.remove(at: index)
            }
            
            undoDesignChangeOfPreference(sender: sender)
          
        } else {
            self.user?.preferences?.append(category)
            doDesignChangeOfPreference(sender: sender)
        }
    }
    
    // FUNCTION TO HANDLE PRESS ON BERRY BUTTON
    @IBAction func onBerryButtonPressed(sender: UIButton){
        let category: String = "Beeren"
        if self.user!.preferences!.contains(category){

            if let index = self.user?.preferences?.firstIndex(of: category) {
                self.user?.preferences?.remove(at: index)
            }
            
            undoDesignChangeOfPreference(sender: sender)
          
        } else {
            self.user?.preferences?.append(category)
            doDesignChangeOfPreference(sender: sender)
        }
    }
    
    // FUNCTION TO HANDLE PRESS ON POTATOE BUTTON
    @IBAction func onPotatoeButtonPressed(sender: UIButton){
        let category: String = "Kartoffeln"
        if self.user!.preferences!.contains(category){

            if let index = self.user?.preferences?.firstIndex(of: category) {
                self.user?.preferences?.remove(at: index)
            }
            
            undoDesignChangeOfPreference(sender: sender)
          
        } else {
            self.user?.preferences?.append(category)
            doDesignChangeOfPreference(sender: sender)
        }
    }
    
    // FUNCTION TO HANDLE PRESS ON HERB BUTTON
    @IBAction func onHerbButtonPressed(sender: UIButton){
        let category: String = "Kräuter und Blüten"
        if self.user!.preferences!.contains(category){

            if let index = self.user?.preferences?.firstIndex(of: category) {
                self.user?.preferences?.remove(at: index)
            }
            
            undoDesignChangeOfPreference(sender: sender)
          
        } else {
            self.user?.preferences?.append(category)
            doDesignChangeOfPreference(sender: sender)
        }
    }

    // FUNCTION TO HANDLE PRESS ON MUSHROOM BUTTON
    @IBAction func onMushroomButtonPressed(sender: UIButton){
        let category: String = "Pilze"
        if self.user!.preferences!.contains(category){

            if let index = self.user?.preferences?.firstIndex(of: category) {
                self.user?.preferences?.remove(at: index)
            }
            
            undoDesignChangeOfPreference(sender: sender)
          
        } else {
            self.user?.preferences?.append(category)
            doDesignChangeOfPreference(sender: sender)
        }
    }
    
    // FUNCTION TO HANDLE PRESS ON APPLE BUTTON
    @IBAction func onAppleButtonPressed(sender: UIButton){
        let category: String = "Äpfel"
        if self.user!.preferences!.contains(category){

            if let index = self.user?.preferences?.firstIndex(of: category) {
                self.user?.preferences?.remove(at: index)
            }
            
            undoDesignChangeOfPreference(sender: sender)
          
        } else {
            self.user?.preferences?.append(category)
            doDesignChangeOfPreference(sender: sender)
        }
    }
    
    // FUNCTION TO HANDLE PRESS ON DONE BUTTON
    @IBAction func onDoneButtonPressed(_ sender: Any){
        do {
            try self.context.save()
        } catch {
            print("Couldn't save the new Preferences of the User!!!")
        }
        notifyProductList?.notifyDelegate()
        self.dismiss(animated: true, completion: nil)
    }

    
     

    
    // MARK: - LIFE-CYCLE

    override func viewDidLoad() {
        super.viewDidLoad()
        initializeButtonsAndLabels()

        //TODO READ THE USER AN INITIALIZE IT
        
        //TODO INITIALIZE BUTTON DESIGN
    }
     

     

    
    // MARK: - LOGIC

    // FUNCTION TO INITIALIZE DESIGN OF PREFERENCE-BUTTONS
    func initializeButtonsAndLabels(){

        if self.user!.preferences!.contains("Gemüse"){
          doDesignChangeOfPreference(sender: vegetableButton)
        }

        if self.user!.preferences!.contains("Früchte"){
          doDesignChangeOfPreference(sender: fruitButton)
        }

        if self.user!.preferences!.contains("Salate"){
          doDesignChangeOfPreference(sender: saladButton)
        }

        if self.user!.preferences!.contains("Beeren"){
          doDesignChangeOfPreference(sender: berryButton)
        }

        if self.user!.preferences!.contains("Kartoffeln"){
          doDesignChangeOfPreference(sender: potatoeButton)
        }

        if self.user!.preferences!.contains("Kräuter und Blüten"){
          doDesignChangeOfPreference(sender: herbButton)
        }

        if self.user!.preferences!.contains("Pilze"){
          doDesignChangeOfPreference(sender: mushroomButton)
        }

        if self.user!.preferences!.contains("Äpfel"){
          doDesignChangeOfPreference(sender: appleButton)
        }
        
        self.ratingSlider.setValue(Float(self.user!.rating), animated: true)
        self.ratingSliderLabel.text = getRatingLabel(Int(self.user!.rating))

    }

    // FUNCTION TO DO DESIGN-CHANGES ON BUTTON
    func doDesignChangeOfPreference(sender: UIButton){
        
        sender.backgroundColor = UIColor(red: 0.42, green: 0.74, blue: 0.52, alpha: 1.00)
        sender.layer.cornerRadius = 10
    }

    // FUNCTION TO UNDO DESIGN-CHANGES ON BUTTON
    func undoDesignChangeOfPreference(sender: UIButton){
        sender.backgroundColor = .clear
        sender.layer.cornerRadius = 0
    }
    
    func getRatingLabel(_ ratingNumber: Int) -> String {
        let startText: String = "Mindestqualität: "
        switch(ratingNumber) {
            case 0  :
                return startText + "Nicht saisonal"
            case 1  :
                return startText + "Knapp nicht saisonal"
            case 2  :
                return startText + "Knapp Saisonal"
            case 3  :
                return startText + "Saisonal"
           default :
                return "Ratingnumber unknown :: " + String(ratingNumber)
        }
    }
    
}
