//
//  ResaultsViewController.swift
//  BrainHack
//
//  Created by Uladzimir on 22.05.2022.
//

import Foundation
import UIKit

class ResaultsViewController: UIViewController, ResultsDelegate{
    
    @IBOutlet weak var nameOfGame: UILabel!
    @IBOutlet weak var rightAnswers: UILabel!
    @IBOutlet weak var wrongAnswers: UILabel!
    
    @IBOutlet weak var firstLabel: UILabel!
    @IBOutlet weak var secondLabel: UILabel!
    override func viewDidLoad() {
        navigationItem.hidesBackButton = true
        loadResults()
        SummaryGameLogic.shared.clearAll()
    }
    
    func loadResults(){
        if ((SummaryGameLogic.shared.nameOfTheGame == "Простая арифметика") || (SummaryGameLogic.shared.nameOfTheGame == "Сложная арифметика") || (SummaryGameLogic.shared.nameOfTheGame == "Проценты")){
            firstLabel.text = "Правильных ответов:"
            secondLabel.text = "Неправильных ответов:"
            rightAnswers.text = SummaryGameLogic.shared.resultRight
            wrongAnswers.text = SummaryGameLogic.shared.resultWrong
            nameOfGame.text = SummaryGameLogic.shared.nameOfTheGame
        }
        if (SummaryGameLogic.shared.nameOfTheGame == "Найди одинаковое"){
            firstLabel.text = "Время:"
            secondLabel.text = "Количество нажатий:"
            rightAnswers.text = SummaryGameLogic.shared.time
            wrongAnswers.text = SummaryGameLogic.shared.amountOfTaps
            nameOfGame.text = SummaryGameLogic.shared.nameOfTheGame
        }
        if (SummaryGameLogic.shared.nameOfTheGame == "Чтение текста"){
            firstLabel.text = "Правильных ответов:"
            secondLabel.text = "Неправильных ответов:"
            rightAnswers.text = SummaryGameLogic.shared.resultRight
            wrongAnswers.text = SummaryGameLogic.shared.resultWrong
            nameOfGame.text = SummaryGameLogic.shared.nameOfTheGame
        }
        if (SummaryGameLogic.shared.nameOfTheGame == "Судоку"){
            firstLabel.text = "Cложность:"
            secondLabel.text = "Длительность игры:"
            rightAnswers.text = "Средняя"
            wrongAnswers.text = SummaryGameLogic.shared.time
            nameOfGame.text = SummaryGameLogic.shared.nameOfTheGame
        }
    }

    
    @IBAction func mainMenuButtonAction(_ sender: Any) {
        SummaryGameLogic.shared.clearAll()
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "ViewController") as! ViewController
        //self.window?.rootViewController?.present(newvc, animated: true, completion: nil)
        //navigationController?.pushViewController(newvc, animated: true)
        self.show(viewController, sender: self)
    }
    func update(wrong: String, right: String) {
        rightAnswers.text = right
        wrongAnswers.text = wrong
        print("\(right),\(wrong)")
    }
}
