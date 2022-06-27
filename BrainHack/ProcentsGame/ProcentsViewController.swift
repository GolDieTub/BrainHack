//
//  ProcentsViewController.swift
//  BrainHack
//
//  Created by Uladzimir on 22.05.2022.
//

import Foundation
import UIKit

class ProcentsViewController: UIViewController{
    
    weak var delegate: ResultsDelegate!
    lazy var logic = SummaryGameLogic.shared
    var timer = Timer()
    var time = 30{
        didSet{
            timerLabel.text = "\(time)"
        }
    }
    var first: Int?
    var second: Int?
    var answer: Int?
    var score: Bool?
    
    override func viewDidLoad() {
        generateNewNumbers()
        navigationItem.backButtonTitle = "Назад"
        logic.clearAll()
    }
    
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var firstOperandLabel: UILabel!
    @IBOutlet weak var secondOperandLabel: UILabel!
    @IBOutlet weak var operationLabel: UILabel!
    @IBOutlet weak var answerTextField: UITextField!
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(tick), userInfo: nil, repeats: true)
    }
    
    func generateNewNumbers(){
        repeat{
            first = Int.random(in: 10...100)
            second = Int.random(in: 10...100) + 100
        } while (((second! * first!) % 100) != 0)
        firstOperandLabel.text = first?.toString()
        secondOperandLabel.text = second?.toString()
        operationLabel.text = "%"

    }
    
    @objc func tick(){
        time -= 1
        if time == 0 {
            timer.invalidate()
            delegate?.update(wrong: logic.resultWrong, right: logic.resultRight)
            SummaryGameLogic.shared.nameOfTheGame = "Проценты"
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            guard let resaultsViewController = storyboard.instantiateViewController(withIdentifier: "ResaultsViewController") as? ResaultsViewController else { return}
            self.show(resaultsViewController, sender: self)
        }
    }
    
    @IBAction func okButtonAction(_ sender: Any) {
        first = (firstOperandLabel?.text?.toInt())!
        second = (secondOperandLabel?.text?.toInt())!
        answer = (second! * first!) / 100
        
        if (answer == answerTextField?.text?.toInt()){
            logic.conclusion(right: 1,wrong: 0)
            
        }else {
            logic.conclusion(right: 0,wrong: 1)
        }
        answerTextField.text = ""
        generateNewNumbers()
    }
}
