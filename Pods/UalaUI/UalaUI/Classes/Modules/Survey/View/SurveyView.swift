//
//  SurveyView.swift
//  Pods
//
//  Created by Miguel Jasso on 06/10/21.
//  
//

import UIKit
import UalaUI
import UalaCore

public protocol SurveyViewDelegate: AnyObject {
    func faqsPressed()
}

class SurveyView: BaseViewController, SurveyViewProtocol {

    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet weak var subButton: UIButton!
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    var surveyPresenter: SurveyPresenterProtocol?
    public weak var delegate: SurveyViewDelegate?

    public var surveyTitle: String? {
        get {
            return self.title
        }
        set {
            self.title = surveyTitle
        }
    }

	override func viewDidLoad() {
        super.viewDidLoad()
        customizeView()
        surveyPresenter?.setButtonStatus()
        surveyPresenter?.setProgressViewPercent()
        tableView.register(AnswerTableViewCell.self)
    }
    
    public func setTitle(surveyTitle: String?) {
        self.title = surveyTitle
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(false)
        UIView.setAnimationsEnabled(false)
    }
    
    override func willMove(toParent parent: UIViewController?) {
        super.willMove(toParent: parent)
        if parent == nil {
            surveyPresenter?.back()
        }
    }
    
    private func customizeView() {
        subButton.customize(style: UalaStyle.buttons.standardFilledLight)
        questionLabel.text = surveyPresenter?.questionTitle
        questionLabel.font = UalaStyle.font.h2SemiBold
        let button = UIButton()
        button.setImage(BundleImage(bundle: .Common, named: "faqsGreyIcon"), for: .normal)
        button.addTarget(self, action: #selector(infoButtonPressed), for: .touchUpInside)
        let navBarButton = UIBarButtonItem(customView: button)
        navBarButton.tintColor = .blue
        navigationItem.setRightBarButton(navBarButton, animated: true)
    }
    
    override func customizeNavigation() {
        navigationController?.configNavigationBar(.solid(color: .white))
    }
    
    @IBAction func subButtonAction(_ sender: Any) {
        surveyPresenter?.nextQuestion()
    }
    
    @objc func infoButtonPressed() {
        delegate?.faqsPressed()
    }
    
    func updateProgressView(percent: Float) {
        progressView.progress = percent
    }
    
    func setSubButton(title: String) {
        subButton.setTitle(title, for: .normal)
    }
    
    func reloadTable() {
        tableView.reloadData()
    }
    
    func enabledNextButton() {
        subButton.isEnabled = true
    }
}

extension SurveyView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return surveyPresenter?.totalAnswers ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let answer = surveyPresenter?.answer(index: indexPath.row) else {
            return UITableViewCell()
        }
        let cell: AnswerTableViewCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
        cell.delegate = self
        cell.config(choice: answer)
        if answer.answerId == surveyPresenter?.selectedAnswer?.answerId {
            cell.radioButton.isSelected = true
        } else {
            cell.radioButton.isSelected = false
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

extension SurveyView: answerSelectionProtocol {
    func selected(answer: AnswerChoice?) {
        guard let answer = answer else {
            return
        }
        surveyPresenter?.updateSelected(answer: answer)
    }
}
