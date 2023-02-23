//
//  SurveyModule.swift
//  Pods
//
//  Created by Miguel Jasso on 06/10/21.
//  
//
import UIKit
import UalaCore

public protocol SurveyDelegate: AnyObject {
    func finish(survey: Survey)
    func faqsPressed()
    func continuePressed(surveyId: Int)
}

public extension SurveyDelegate {
    
    func continuePressed(surveyId: Int) {
        // default implementation
    }
}

public class SurveyManager {
    var survey: Survey
    var currentPage: Int = 0
    var totalPages: Int {
        survey.questions?.count ?? 0
    }
    var surveyTitle: String?
    public weak var delegate: SurveyDelegate?
    
    public init(survey: Survey, surveyTitle: String?) {
        self.survey = survey
        self.surveyTitle = surveyTitle
    }
    
    public var firstQuestionView: UIViewController? {
        return nextQuestion
    }
    
    internal var nextQuestion: UIViewController? {
        delegate?.continuePressed(surveyId: currentPage)
        if currentPage < totalPages {
            guard let question = survey.questions?[currentPage] else {
                return nil
            }
            let view = SurveyModule.build(surveyManager: self, question: question, title: self.surveyTitle ?? "")
            view.setTitle(surveyTitle: self.surveyTitle)
            currentPage += 1
            view.delegate = self
            return view
        }
        delegate?.finish(survey: survey)
        return nil
    }
    
    var titleButton: String {
        return (currentPage < totalPages) ? translate("CONTINUE", from: .Common) : translate("FINISH", from: .Common)
    }
    
    var progressPercent: Float {
        return Float(currentPage)/Float(totalPages)
    }
    
    func goBack() {
        if currentPage > 0 {
            currentPage -= 1
        }
    }
    
    func add(answer: AnswerChoice, to question: SurveyQuestion) {
        let question: SurveyQuestion? = survey.questions?.first(where: {$0.questionId == question.questionId }) ?? nil
        for var choice in question?.choices ?? [] {
            choice.isSelected = choice.answerId  == answer.answerId
        }
    }
    
    func getSurveyResult() -> Survey {
        return survey
    }
}

class SurveyModule {
    static func build(surveyManager: SurveyManager, question: SurveyQuestion, title: String) -> SurveyView {
        let view: SurveyView = SurveyView.loadXib()
        let router = SurveyRouter()
        let presenter = SurveyPresenter()
        
        presenter.view = view
        presenter.router = router
        presenter.surveyManager = surveyManager
        presenter.question = question
        presenter.title = title
        
        view.surveyPresenter = presenter
        router.viewController = view
        
        return view
    }    
}

extension SurveyManager: SurveyViewDelegate {
    public func faqsPressed() {
        delegate?.faqsPressed()
    }
    public func continuePressed(surveyId: Int) {
        delegate?.continuePressed(surveyId: surveyId)
    }
}
