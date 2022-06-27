//
//  question.swift
//  BrainHack
//
//  Created by Uladzimir on 10.06.2022.
//

import MapKit
import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

struct Question: Codable, Identifiable{
    @DocumentID var id: String? = UUID().uuidString
    var rightAnswer: String
    var text: String
    var wrong1: String
    var wrong2: String
    var wrong3: String
    var question: String

    enum CodingKeys: String, CodingKey{
        case id
        case rightAnswer
        case text
        case wrong1
        case wrong2
        case wrong3
        case question
    }
    init(rightAnswer: String, text: String, wrong1: String, wrong2: String, wrong3: String, question: String) {
        self.rightAnswer = rightAnswer
        self.text = text
        self.wrong1 = wrong1
        self.wrong2 = wrong2
        self.wrong3 = wrong3
        self.question = question
    }
    
}
