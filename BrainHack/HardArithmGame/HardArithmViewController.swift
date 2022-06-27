//
//  HardArithmViewController.swift
//  BrainHack
//
//  Created by Uladzimir on 22.05.2022.
//

import Foundation
import UIKit

class HardArithmViewController: UIViewController{
    
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
    
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var firstOperandLabel: UILabel!
    @IBOutlet weak var secondOperandLabel: UILabel!
    @IBOutlet weak var answerField: UITextField!
    @IBOutlet weak var operationLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.backButtonTitle = "Назад"
        first = Int.random(in: 2...20)
        second = Int.random(in: 2...30)
        firstOperandLabel.text = first?.toString()
        secondOperandLabel.text = second?.toString()
        operationLabel.text = "*"
        logic.clearAll()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(tick), userInfo: nil, repeats: true)
    }
    
    func generateNewNumbers(){
        let chance = Int.random(in: 0...1)
        if chance == 0{
            first = Int.random(in: 2...20)
            second = Int.random(in: 2...30)
            firstOperandLabel.text = first?.toString()
            secondOperandLabel.text = second?.toString()
            operationLabel.text = "*"
        }else{
            repeat{
                first = Int.random(in: 10...100) + 100
                second = Int.random(in: 10...100)
            } while ((first! % second!) != 0)
            firstOperandLabel.text = first?.toString()
            secondOperandLabel.text = second?.toString()
            operationLabel.text = "/"
        }

    }
    
    @objc func tick(){
        time -= 1
        if time == 0 {
            timer.invalidate()
            delegate?.update(wrong: logic.resultWrong, right: logic.resultRight)
            SummaryGameLogic.shared.nameOfTheGame = "Сложная арифметика"
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            guard let resaultsViewController = storyboard.instantiateViewController(withIdentifier: "ResaultsViewController") as? ResaultsViewController else { return}
            self.show(resaultsViewController, sender: self)
        }
    }
    
    @IBAction func okButtonAction(_ sender: Any) {
        first = (firstOperandLabel?.text?.toInt())!
        second = (secondOperandLabel?.text?.toInt())!
        if operationLabel.text == "*"{
            answer = first! * second!
        }else{
            answer = first! / second!
        }
        if (answer == answerField?.text?.toInt()){
            logic.conclusion(right: 1,wrong: 0)
            
        }else {
            logic.conclusion(right: 0,wrong: 1)
        }
        answerField.text = ""
        generateNewNumbers()
    }
    
}
