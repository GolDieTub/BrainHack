//
//  ViewController.swift
//  BrainHack
//
//  Created by Uladzimir on 04.04.2022.
//

import UIKit
import Firebase

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true
    }
    

    @IBAction func logoutAction(_ sender: Any) {
        do{
            try Auth.auth().signOut()
        }catch{
            print(error)
        }
    }
 
    @IBAction func SummaryGameAction(_ sender: Any) {
        let storyboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let summaryViewController = storyboard.instantiateViewController(withIdentifier: "SummaryViewController") as! SummaryViewController
        //self.present(summaryViewController, animated: false, completion: nil)
        show(summaryViewController, sender: self)
    }
    
    
    @IBAction func hardArithmButtonAction(_ sender: Any) {
        let storyboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let hardArithmViewController = storyboard.instantiateViewController(withIdentifier: "HardArithmViewController") as! HardArithmViewController
        show(hardArithmViewController, sender: self)
    }
    
    @IBAction func procentsButtonAction(_ sender: Any) {
        let storyboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let procentsViewController = storyboard.instantiateViewController(withIdentifier: "ProcentsViewController") as! ProcentsViewController
        show(procentsViewController, sender: self)
    }
    
    @IBAction func readingButtonAction(_ sender: Any) {
        let storyboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let readingViewController = storyboard.instantiateViewController(withIdentifier: "ReadingViewController") as! ReadingViewController
        show(readingViewController, sender: self)
    }
    
    @IBAction func flipperButtonAction(_ sender: Any) {
        let storyboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let flipperViewController = storyboard.instantiateViewController(withIdentifier: "FlipperViewController") as! FlipperViewController
        show(flipperViewController, sender: self)
    }
    
    @IBAction func sudokyButtonAction(_ sender: Any) {
        let storyboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let sudokyViewController = storyboard.instantiateViewController(withIdentifier: "SudokyViewController") as! SudokyViewController
        show(sudokyViewController, sender: self)
    }

}

