//
//  SurveyModels.swift
//  UalaUI
//
//  Created by Miguel Jasso on 19/04/22.
//

import Foundation
import  UalaCore

public class Survey: Codable {
    public var surveryId: String?
    public var questions: [SurveyQuestion]?
    
    enum CodingKeys: String, CodingKey {
        case questions
        case surveryId = "id"
    }
}

public class SurveyQuestion: Codable {
    public var title: String?
    public var questionId: String?
    public var choices: [AnswerChoice]?
    
    enum CodingKeys: String, CodingKey {
        case title
        case questionId = "id"
        case choices
    }
}

public class AnswerChoice: Codable {
    public var answerId: String?
    public var text: String?
    public var isSelected: Bool? = false
    
    enum CodingKeys: String, CodingKey {
        case answerId = "id"
        case text
        case isSelected
    }
}
