//
//  SurveyPresenter.swift
//  Pods
//
//  Created by Miguel Jasso on 06/10/21.
//  
//

import UIKit
import UalaCore

class SurveyPresenter: SurveyPresenterProtocol {
    var question: SurveyQuestion?
    weak var view: SurveyViewProtocol?
    var router: SurveyRouterProtocol?
    var surveyManager: SurveyManager?
    var selectedAnswer: AnswerChoice?
    var title: String = ""
    
    var questionTitle: String {
        return question?.title ?? ""
    }
    
    var totalAnswers: Int {
        return question?.choices?.count ?? 0
    }
    
    func nextQuestion() {
        if let controller = surveyManager?.nextQuestion {
            controller.title = title
            router?.present(view: controller)
        } else {
            surveyManager?.getSurveyResult()
        }
    }
    
    func setButtonStatus() {
        view?.setSubButton(title: surveyManager?.titleButton ?? "")
    }
    
    func setProgressViewPercent() {
        view?.updateProgressView(percent: surveyManager?.progressPercent ?? 0.0)
    }
    
    func back() {
        surveyManager?.goBack()
    }
    
    func answer(index: Int) -> AnswerChoice? {
        guard let choices = question?.choices, index < choices.count else { return nil }
        return choices[index]
    }
    
    func updateSelected(answer: AnswerChoice) {
        selectedAnswer = answer
        updateQuestion()
        view?.reloadTable()
        view?.enabledNextButton()
    }
    
    func updateQuestion() {
        guard let answer = selectedAnswer, let question = question else {
            return
        }
        surveyManager?.add(answer: answer, to: question)
    }
    
    func showLoading() {
        view?.showLoadingView()
    }
    
    func hideLoading() {
        view?.hideLoadingView()
    }
    
    func onGet(error: Error) {
        view?.showAlert(with: error)
    }
}
