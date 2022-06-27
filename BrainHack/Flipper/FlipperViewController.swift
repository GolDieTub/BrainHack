//
//  FlipperViewController.swift
//  BrainHack
//
//  Created by Uladzimir on 22.05.2022.
//

import UIKit

class FlipperViewController: UIViewController {

    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var touchLabel: UILabel!
    @IBOutlet var buttonCollection: [UIButton]!
    
    lazy var logic = SummaryGameLogic.shared
    var timer = Timer()
    var time = 0{
        didSet{
            timerLabel.text = "\(time)"
        }
    }
    
    var endGame: Int = 0
    
    lazy var game = ConsentrationGame(numberOfPairsOfCards: 8)
    
    var touches = 0 {
        didSet{
            touchLabel.text = "Touches: \(touches)"
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(tick), userInfo: nil, repeats: true)
    }
    
    func updateViewFromModel(){
        for index in buttonCollection.indices{
            let button = buttonCollection[index]
            let card = game.cards[index]
            if card.isFaceUp{
                button.setTitle(emojiIdentifier(for : card ), for: .normal)
                button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
                button.isEnabled = false
            } else{
                button.setTitle("", for: .normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 0.2877701223, blue: 0.2510596812, alpha: 0) : #colorLiteral(red: 0.5791940689, green: 0.1280144453, blue: 0.5726861358, alpha: 1)
                button.isEnabled = true
            }
        }
    }
    
    var emojiDictionary = [Int:String]()
    
    
    var emodjiCollection = ["🤠","🧛‍♂️","🥷","🧜","🎩","🦁","🐨","🦆"]
    
    func emojiIdentifier(for card: Card) -> String{
        if emojiDictionary[card.identifier] == nil{
            let randomIndex = Int(arc4random_uniform(UInt32(emodjiCollection.count)))
            emojiDictionary[card.identifier] = emodjiCollection.remove(at: randomIndex)
        }
        return emojiDictionary[card.identifier] ?? "?"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()


    }
    
    @objc func tick(){
        time += 1
    }
    
    @IBAction func buttonAction(_ sender: UIButton) {
        touches += 1
        if let buttonIndex = buttonCollection.firstIndex(of: sender){
            endGame = game.chooseCard(at: buttonIndex)
            updateViewFromModel()
            if endGame == 8 {
                timer.invalidate()
                SummaryGameLogic.shared.nameOfTheGame = "Найди одинаковое"
                SummaryGameLogic.shared.time = "\(time)"
                SummaryGameLogic.shared.amountOfTaps = "\(touches)"
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                guard let resaultsViewController = storyboard.instantiateViewController(withIdentifier: "ResaultsViewController") as? ResaultsViewController else { return}
                self.show(resaultsViewController, sender: self)
            }
            
        }
    }

 
}

