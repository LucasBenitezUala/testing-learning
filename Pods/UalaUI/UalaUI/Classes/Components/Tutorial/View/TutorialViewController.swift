//
//  TutorialViewController.swift
//
//  Created by Monserrath Castro on 07/10/21.
//  Copyright © 2021 Ualá. All rights reserved.
//

import UIKit

public enum TutorialType {
    case tutorial
    case steps

    var nibName: String {
        if self == .tutorial {
            return String(describing: TutorialViewController.self)
        } else {
            return String(describing: "StepsViewController")
        }
    }

    var titleLabelStyle: LabelStyle {
        guard self == .steps else { return .blackTitle }
        return .mediumBlackishLeft(size: 24)
    }

    var primaryButtonStyle: ButtonStyle {
        guard self == .steps else { return UalaStyle.buttons.standardFilledLight }
        return UalaStyle.buttons.standardOutlineLight
    }
}

public class TutorialViewController: BaseViewController {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var primaryActionButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var gradientView: GradientView!
    @IBOutlet weak var footerLabel: UILabel!
    
    public var tutorialPresenter: TutorialPresenterProtocol?
    private let tutorialType: TutorialType

    public override var presenter: Presenter? {
        return tutorialPresenter
    }

    public init(tutorialPresenter: TutorialPresenterProtocol,
                type: TutorialType = .tutorial) {
        self.tutorialPresenter = tutorialPresenter
        self.tutorialType = type
        super.init(nibName: tutorialType.nibName,
                   bundle: Bundle(for: TutorialViewController.self))
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
	
	public override func viewDidLoad() {
        super.viewDidLoad()
        tutorialType == .tutorial ? customizeUI() : customizeStepsUI()
        tutorialPresenter?.getViewModel()
    }
	
	// MARK: - View - Private Methods
    private func customizeUI() {
        titleLabel.customize(style: .mediumBlackishLeft(size: 22))
        titleLabel.text = nil
        subtitleLabel.customize(style: .regularFarePrimaryLeft(size: 14))
        primaryActionButton.customize(style: UalaStyle.buttons.standardFilledLight)
        primaryActionButton.addTarget(self, action: #selector(primaryActionButtonPressed), for: .touchUpInside)
        configureButtonGradient()
        customizedTable()
        configureBackground()
    }

    private func customizeStepsUI() {
        titleLabel.customize(style: tutorialType.titleLabelStyle)
        subtitleLabel.isHidden = true

        primaryActionButton.customize(style: tutorialType.primaryButtonStyle)
        primaryActionButton.addTarget(self,
                                      action: #selector(primaryActionButtonPressed),
                                      for: .touchUpInside)
        customizedTable()
        configureBackground()
    }

    private func customizedTable() {
        tableView.register(InstructionTableViewCell.self)
        tableView.register(InstructionAttributedTableViewCell.self)
        tableView.register(InstructionCardTableViewCell.self)
        tableView.register(StepsTableViewCell.self)
        tableView.estimatedRowHeight = 98
        tableView.isScrollEnabled = false
    }
    
    private func configureBackground() {
        guard let backgroundColor = tutorialPresenter?.getBackgroundColor() else {
            return
        }
        
        view.backgroundColor = backgroundColor
        tableView.backgroundColor = backgroundColor
    }
    
    private func configureButtonGradient() {
        gradientView.backgroundColor = .clear
        gradientView.orientation = GradientOrientation.vertical.rawValue
        
        let gradientType = tutorialPresenter?.getGradientType() ?? .defaultValue
        
        switch gradientType {
        case .regular(let startColor, let endColor):
            gradientView.startColor = startColor
            gradientView.endColor = endColor
        case .none:
            gradientView.startColor = .clear
            gradientView.endColor = .clear
        }
    }
    
    private func getCell(for indexPath: IndexPath) -> InstructionBaseTableViewCell {
        let cell: InstructionBaseTableViewCell
        let style = tutorialPresenter?.getCellStyle() ?? .plain
        
        switch style {
        case .plain:
            cell = tableView.dequeueReusableCell(forIndexPath: indexPath) as InstructionTableViewCell
        case .plainHtmlAttributed:
            cell = tableView.dequeueReusableCell(forIndexPath: indexPath) as InstructionAttributedTableViewCell
        case .card:
            cell = tableView.dequeueReusableCell(forIndexPath: indexPath) as InstructionCardTableViewCell
        case .step:
            cell = tableView.dequeueReusableCell(forIndexPath: indexPath) as StepsTableViewCell
        }
        
        return cell
    }

    public override func customizeNavigation() {
        super.customizeNavigation()
        navigationController?.configureNavigationCleanBar()
    }

    @objc private func primaryActionButtonPressed() {
        tutorialPresenter?.primaryActionButtonPressed()
    }
}

extension TutorialViewController: TutorialViewProtocol {
    public func addBackAction() {
        let backImage = BundleImage(bundle: .Common, named: "back")
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: backImage, style: .plain, target: self, action: #selector(backButtonPressed))
    }

    @objc private func backButtonPressed() {
        tutorialPresenter?.backButtonPressed()
    }

    public func setTitle(with text: String?) {
        titleLabel.text = text
    }

    public func setSubtitle(with text: String?) {
        subtitleLabel.text = text
    }

    public func setPrimaryActionTitle(with text: String?) {
        primaryActionButton.setTitle(text, for: .normal)
    }

    public func reloadInstructions() {
        tableView.reloadData()
    }

    public func removePrimaryActionButton() {
        guard let button = primaryActionButton else { return }
        button.removeFromSuperview()
    }
}

extension TutorialViewController: UITableViewDataSource, UITableViewDelegate {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tutorialPresenter?.getNumberOfInstructions() ?? 0
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let style = tutorialPresenter?.getCellStyle() ?? .plain

        guard let instruction = tutorialPresenter?.getInstruction(at: indexPath.row) else {
            return UITableViewCell()
        }
        
        let cell = getCell(for: indexPath)
        
        let configurable = cell as InstructionConfigurator
        configurable.configure(data: instruction)
        configurable.update(configuration: tutorialPresenter?.getConfiguration())
        
        return cell
    }
}
