//
//  RadioButton.swift
//  UalaFareUI
//
//  Created by Luis Perez on 19/07/22.
//

import UIKit

@IBDesignable
public final class UIFareRadioButton: UIControl {
    // MARK: Observable Properties
    @IBInspectable public var isRadioSelected: Bool = false {
        didSet {
            configureModel()
        }
    }
    
    public override var isEnabled: Bool {
        didSet {
            configureModel()
        }
    }
    
    // MARK: Content views
    private lazy var backgroundCircleView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isUserInteractionEnabled = false
        return view
    }()
    
    private lazy var selectionCircleView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isUserInteractionEnabled = false
        return view
    }()
    
    // MARK: Status properties
    private var model: UIFareRadioButtonModel = MainThemeManager.shared.radioButtonTheme()
    private var weakButtons: [WeakObjectContainer<UIFareRadioButton>] = []
    private let hapticGenerator = UINotificationFeedbackGenerator()
    // MARK: Helper Connector
    public static let connector = RadioButtonConnector.self
    
    public override var intrinsicContentSize: CGSize {
        return CGSize(width: smallerRectangleSide(rectangle: bounds),
                      height: smallerRectangleSide(rectangle: bounds))
    }
    
    public init(frame: CGRect = .zero,
                model: UIFareRadioButtonModel) {
        self.model = model
        super.init(frame: frame)
        contentMode = .redraw
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        contentMode = .redraw
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        contentMode = .redraw
    }
    
    public override func draw(_ rect: CGRect) {
        configureLayout(in: rect)
        configureLayer(rect: rect)
        configureModel()
    }
    
    private func configureLayer(rect: CGRect) {
        backgroundCircleView.layer.borderWidth = 1
        backgroundCircleView.layer.cornerRadius = smallerRectangleSide(rectangle: rect) / 2
        selectionCircleView.layer.cornerRadius = smallerRectangleSide(rectangle: rect) / 4
    }
    
    private func configureLayout(in rect: CGRect) {
        self.addSubview(backgroundCircleView)
        backgroundCircleView.addSubview(selectionCircleView)
        
        NSLayoutConstraint.activate([
            backgroundCircleView.widthAnchor.constraint(equalTo: sizeAnchor(in: rect)),
            backgroundCircleView.heightAnchor.constraint(equalTo: sizeAnchor(in: rect)),
            backgroundCircleView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            backgroundCircleView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            selectionCircleView.centerXAnchor.constraint(equalTo: backgroundCircleView.centerXAnchor),
            selectionCircleView.centerYAnchor.constraint(equalTo: backgroundCircleView.centerYAnchor),
            selectionCircleView.widthAnchor.constraint(equalTo: backgroundCircleView.widthAnchor,
                                                       multiplier: 0.5),
            selectionCircleView.heightAnchor.constraint(equalTo: backgroundCircleView.heightAnchor,
                                        multiplier: 0.5)
        ])
    }
    
    private func configureBackgroundView() {
        if isRadioSelected {
            if isEnabled {
                backgroundCircleView.layer.borderColor = model.selectedStateBorderColor.cgColor
                backgroundCircleView.backgroundColor = model.selectedStateBackgroundColor
            } else {
                backgroundCircleView.backgroundColor = model.disabledSelectedStateBackgroundColor
                backgroundCircleView.layer.borderColor = model.disabledSelectedStateBorderColor.cgColor
            }
        } else {
            if isEnabled {
                backgroundCircleView.layer.borderColor = model.deselectedStateBorderColor.cgColor
                backgroundCircleView.backgroundColor = model.deselectedStateBackgroundColor
            } else {
                backgroundCircleView.backgroundColor = model.disabledDeselectedStateBackgroundColor
                backgroundCircleView.layer.borderColor = model.disabledDeselectedStateBorderColor.cgColor
            }
        }
    }
    
    private func configureDotView() {
        if isRadioSelected {
            if isEnabled {
                selectionCircleView.backgroundColor = model.selectedStateDotColor
            } else {
                selectionCircleView.backgroundColor = model.disabledSelectedStateDotColor
            }
        } else {
            if isEnabled {
                selectionCircleView.backgroundColor = model.deselectedStateDotColor
            } else {
                selectionCircleView.backgroundColor = model.disabledDeselectedStateDotColor
            }
        }
    }
    
    private func configureModel() {
        configureBackgroundView()
        configureDotView()
    }
    
    public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        hapticGenerator.prepare()
        pressBeganAnimation()
        isRadioSelected = true
        updateOtherButtonsIfNeeded()
        sendActions(for: .valueChanged)
    }
    
    public override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        pressEndAnimation()
        hapticGenerator.notificationOccurred(.success)
    }
    
    public func configure(with model: UIFareRadioButtonModel) {
        self.model = model
        configureModel()
    }
    
    private func sizeAnchor(in rect: CGRect) -> NSLayoutDimension {
        if rect.width > rect.height {
            return self.heightAnchor
        }
        return self.widthAnchor
    }
    
    private func smallerRectangleSide(rectangle: CGRect) -> CGFloat {
        return rectangle.width > rectangle.height ? rectangle.height : rectangle.width
    }
    
    private func updateOtherButtonsIfNeeded() {
        weakButtons.forEach({ $0.object?.isRadioSelected = false })
    }
    
    private func pressBeganAnimation() {
        UIView.animate(withDuration: 0.1,
                       delay: 0,
                       usingSpringWithDamping: 1,
                       initialSpringVelocity: 1,
                       options: [.curveEaseIn]) { [weak self] in
            self?.transform = CGAffineTransform.init(scaleX: 1.2, y: 1.2)
        } completion: { _ in }
    }
    
    private func pressEndAnimation() {
        UIView.animate(withDuration: 0.2,
                       delay: 0,
                       usingSpringWithDamping: 1,
                       initialSpringVelocity: 1,
                       options: [.curveEaseIn]) { [weak self] in
            self?.transform = CGAffineTransform.identity
        } completion: { _ in }
    }
    
    internal func addRadioButtonReference(button: UIFareRadioButton) {
        weakButtons.append(WeakObjectContainer(object: button))
    }
}
