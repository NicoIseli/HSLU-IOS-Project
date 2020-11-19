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
    
    
    
    
    
    // MARK: - IBOUTLETS

    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var ratingSlider: UISlider!
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

      let startText: String = "Mindestqualität: "
      let castedNumber: Int = Int(sender.value)

      switch(castedNumber) {
          case 0  :
              self.ratingLabel.text = startText + "Nicht saisonal"
              break
          case 1  :
              self.ratingLabel.text = startText + "Knapp nicht saisonal"
              break
          case 2  :
              self.ratingLabel.text = startText + "Knapp Saisonal"
              break
          case 3  :
              self.ratingLabel.text = startText + "Saisonal"
              break
         default :
              break
      }
        
        self.user?.rating = Int16(castedNumber)
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
        self.dismiss(animated: true, completion: nil)
    }

    
     

    
    // MARK: - LIFE-CYCLE

    override func viewDidLoad() {
        super.viewDidLoad()

        //TODO READ THE USER AN INITIALIZE IT
        
        //TODO INITIALIZE BUTTON DESIGN
    }
     

     

    
    // MARK: - LOGIC

    // FUNCTION TO INITIALIZE DESIGN OF PREFERENCE-BUTTONS
    func initializeButtonDesign(){

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

        if self.user!.preferences!.contains("Kräuter & Blüten"){
          doDesignChangeOfPreference(sender: herbButton)
        }

        if self.user!.preferences!.contains("Pilze"){
          doDesignChangeOfPreference(sender: mushroomButton)
        }

        if self.user!.preferences!.contains("Äpfel"){
          doDesignChangeOfPreference(sender: appleButton)
        }
    }

    // FUNCTION TO DO DESIGN-CHANGES ON BUTTON
    func doDesignChangeOfPreference(sender: UIButton){
        sender.backgroundColor = UIColor(named: "#6CBD84")
        sender.layer.cornerRadius = 5
        sender.layer.borderWidth = 1
    }

    // FUNCTION TO UNDO DESIGN-CHANGES ON BUTTON
    func undoDesignChangeOfPreference(sender: UIButton){
        sender.backgroundColor = .clear
    }
}
