//
//  InformationScreenController.swift
//  UalaUI
//
//  Created by Rodrigo Torres on 17/05/2022.
//

import UIKit

final internal class InformationScreenController: UIViewController, InformationScreenViewType {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var primaryActionButton: UIButton!
    @IBOutlet weak var secondaryActionButton: UIButton!
    
    private let presenter: InformationScreenPresenterType
    private let dependencies: InformationScreenDependenciesType
    
    init(with dependencies: InformationScreenDependenciesType,
         presenter: InformationScreenPresenterType) {
        self.dependencies = dependencies
        self.presenter = presenter
        super.init(nibName: String(describing: InformationScreenController.self),
                   bundle: Bundle(for: type(of: self)))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter.viewDidLoad()
        configureUI()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if isMovingFromParent {
            presenter.didTapBackButton()
        }
    }
    
    private func configureUI() {
        setupLabels()
        
        addActionDescriptionLabel(hasInteraction: dependencies.uiConstants.descriptionHasInteraction)
        
        primaryActionButton.customize(style: dependencies.uiConstants.primaryActionStyle)
        primaryActionButton.setTitle(dependencies.parameters.primaryButtonTitle, for: .normal)
        
        imageView.image = dependencies.parameters.image
        imageView.contentMode = dependencies.uiConstants.imageViewContentMode
        
        secondaryActionButton.customize(style: dependencies.uiConstants.secondaryActionStyle)
        secondaryActionButton.setTitle(dependencies.parameters.secondaryButtonTitle, for: .normal)
    }
    
    @IBAction func didTapPrimaryButtonAction(_ sender: Any) {
        presenter.didTapPrimaryAction()
    }
    
    @IBAction func didTapSecondaryButtonAction(_ sender: Any) {
        presenter.didTapSecondaryAction()
    }
    
    private func setupLabels() {
        setupLabel(label: titleLabel,
                   title: dependencies.parameters.title,
                   labelStyle: dependencies.uiConstants.titleStyle)
        
        setupLabel(label: descriptionLabel,
                   title: dependencies.parameters.description,
                   labelStyle: dependencies.uiConstants.descriptionStyle)
    }
    
    private func setupLabel(label: UILabel, title: NSAttributedString, labelStyle: LabelStyle?) {
        guard let style = labelStyle else {
            label.attributedText = title
            return
        }
        label.text = title.string
        label.customize(style: style)
    }
    
    private func addActionDescriptionLabel(hasInteraction: Bool) {
        if hasInteraction {
            let tap = UITapGestureRecognizer(target: self, action: #selector(didTapDescriptionAction))
            descriptionLabel.addGestureRecognizer(tap)
            descriptionLabel.isUserInteractionEnabled = true
        }
    }
    
    @objc private func didTapDescriptionAction() {
        presenter.didTapDescription()
    }
}
