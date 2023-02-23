//
//  SurveyProtocols.swift
//  Pods
//
//  Created by Miguel Jasso on 06/10/21.
//  
//

import Foundation
import UalaUI

protocol SurveyRouterProtocol: class {
    func present(view: UIViewController)
}

protocol SurveyPresenterProtocol: class {
    var questionTitle: String { get }
    var totalAnswers: Int { get }
    var selectedAnswer: AnswerChoice? { get set }
    
    var question: SurveyQuestion? { get set }
    var view: SurveyViewProtocol? { get set }
    var router: SurveyRouterProtocol? { get set }
    var surveyManager: SurveyManager? { get set }
 
    func setProgressViewPercent()
    func nextQuestion()
    func setButtonStatus()
    func back()
    func answer(index: Int) -> AnswerChoice?
    func updateSelected(answer: AnswerChoice)
    func showLoading()
    func hideLoading()
    func onGet(error: Error)
}

protocol SurveyInteractorProtocol: class {
    var presenter: SurveyPresenterProtocol? { get set }
    
    func save(survery: Survey)
}

protocol SurveyViewProtocol: BaseView {
    var surveyPresenter: SurveyPresenterProtocol? { get set }
    
    func setTitle(surveyTitle: String?)
    func updateProgressView(percent: Float)
    func setSubButton(title: String)
    func reloadTable()
    func enabledNextButton()
}
