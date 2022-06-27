//
//  SummaryGameLogic.swift
//  BrainHack
//
//  Created by Uladzimir on 21.05.2022.
//

import Foundation

class SummaryGameLogic{
    
    var rightAnswers: Int = 0
    var wrongAnswers: Int = 0
    var resultRight: String = "0"
    var resultWrong: String = "0"
    var nameOfTheGame: String = ""
    var amountOfTaps: String = ""
    var touches: String = ""
    var time: String = ""
    
    static let shared = SummaryGameLogic()
    
    
    func conclusion(right: Int, wrong: Int){
        rightAnswers += right
        wrongAnswers += wrong
        resultRight = rightAnswers.toString()
        resultWrong = wrongAnswers.toString()
    }
    
    func clearAll(){
        rightAnswers = 0
        wrongAnswers = 0
        resultRight = "0"
        resultWrong = "0"
        amountOfTaps = ""
        touches = ""
        time = ""
    }
    
    func random(min: Int, max: Int) -> Int {
        return Int.random(in: min...max)
    }
    var firstOp = Int.random(in: 10...100)
    //var convertedFirstOP = String(firstOp)
    
}
extension Int{
    func toString()->String{
        let myString = String(self)
        return myString
    }
    
}
extension String{
    func toInt()->Int{
        let myInt = Int(self)!
        return myInt
    }
    
}

