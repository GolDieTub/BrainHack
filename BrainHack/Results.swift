//
//  Results.swift
//  BrainHack
//
//  Created by Uladzimir on 29.05.2022.
//

import Foundation

class Results{
    
    private var wrong: String
    private var right: String
    
    static let shared = Results()
    
    private init(){
        self.wrong = ""
        self.right = ""
    }
    
//    static func shared() -> Results{
//        return Results()
//    }
}
