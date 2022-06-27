//
//  ResultsLogic.swift
//  BrainHack
//
//  Created by Uladzimir on 28.05.2022.
//

import Foundation

protocol ResultsDelegate: AnyObject{
    func update(wrong: String, right: String)
}

