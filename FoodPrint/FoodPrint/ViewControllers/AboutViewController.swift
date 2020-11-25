//
//  AboutViewController.swift
//  FoodPrint
//
//  Created by nicock on 19.11.20.
//

import UIKit

class AboutViewController: UIViewController {
    
    
    
    
    
    // MARK: - IBOUTLETS
    @IBAction func onDoneButtonPressed(_ sender: Any){
        self.dismiss(animated: true, completion: nil)
    }
    
    
    
    
    
    // MARK: - LIFE-CYCLE
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // CHANGE BACKGROUND-COLOR OF STATUS-BAR
        let statusBarView = UIView(frame: UIApplication.shared.statusBarFrame)
        statusBarView.backgroundColor = .black
        view.addSubview(statusBarView)
    }
}
