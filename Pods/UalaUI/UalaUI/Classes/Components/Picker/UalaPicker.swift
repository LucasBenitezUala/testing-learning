//
//  UalaPicker.swift
//  Alamofire
//
//  Created by Matías Schwalb on 17/06/2021.
//

import UIKit
import UalaCore

public protocol UalaPickerConfig {
    var arrowImage: UIImage { get }
    var informationLabelStyle: LabelStyle { get }
    var contentLabelStyle: LabelStyle { get }
    var bottomLineColor: UIColor { get }
}

private struct UalaPickerDefaultConfig: UalaPickerConfig {
    var arrowImage: UIImage { return BundleImage(bundle: .Common, named: "blue_arrow_down") ?? UIImage() }
    var informationLabelStyle: LabelStyle { return .pickerInformationText }
    var contentLabelStyle: LabelStyle { return .pickerTextLeft }
    var bottomLineColor: UIColor { return UalaStyle.colors.blue50 }
}

public class UalaPicker: XibView {
    
    @IBOutlet weak var informationLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var arrowImageView: UIImageView!
    @IBOutlet weak var bottomLineSeparator: UIView!

    var didSelectItem: (() -> Void)?
        
    private var selectionType: UalaPickerSelectionType = .picker
    private var searchableItems: [SearchableString] = []
    private var title: String?
    private var selectedItem: SearchableString? {
        didSet {
            updateUI()
            didSelectItem?()
        }
    }
    private var selectedIndex: Int = 0

    public override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
        configureButtonBehaviour()
    }
    
    public func setAdjustsFontSizeToFitWidth(value: Bool) {
        contentLabel.adjustsFontSizeToFitWidth = value
    }
    
    private func setupUI(config: UalaPickerConfig = UalaPickerDefaultConfig()) {
        self.arrowImageView.image = config.arrowImage
        informationLabel.customize(style: .pickerInformationText)
        informationLabel.adjustsFontSizeToFitWidth = true
        informationLabel.minimumScaleFactor = 0.2
        contentLabel.customize(style: .pickerTextLeft)
        contentLabel.adjustsFontSizeToFitWidth = true
        contentLabel.minimumScaleFactor = 0.2
        bottomLineSeparator.backgroundColor = config.bottomLineColor
    }
    
    private func configureButtonBehaviour() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        view?.addGestureRecognizer(tap)
    }
    
    private func updateUI() {
        if selectedItem != nil {
            contentLabel.text = selectedItem?.name
            informationLabel.text = title
        } else {
            informationLabel.text = nil
            contentLabel.text = title
        }
    }
    
    private func presentUalaSearch() {
        let parentViewController = findParentViewController()

        let searchViewController: UalaSearchViewController = UalaSearchViewController(data: searchableItems) { [weak self] item in
            self?.selectedItem = item
        }
        
        parentViewController?.present(searchViewController, animated: true, completion: nil)
    }
    
    private func presentPickerView() {
        let parentViewController = findParentViewController()

        let pickerViewController = PickerViewController<SearchableString>(with: searchableItems, selected: selectedItem)
        pickerViewController.cancelTitle = nil
        pickerViewController.doneTitle = translate("READY", from: .Common)
        pickerViewController.handler = { [weak self] pickerViewController, result in
            self?.pickerHandler(picker: pickerViewController, result: result)
        }

        parentViewController?.present(pickerViewController, animated: true, completion: nil)
    }
    
    private func presentPickerViewWithSelection() {
        let parentViewController = findParentViewController()

        let searchViewController: UalaSearchViewController = UalaSearchViewController(data: searchableItems, indexSelected: getIndex()) { [weak self] item in
            self?.selectedItem = item
        }
        
        parentViewController?.present(searchViewController, animated: true, completion: nil)
    }
    
    private func pickerHandler(picker: PickerViewController<SearchableString>, result: PickerResult<[SearchableString]>) {
        if case .select(let value) = result {
            guard let item = value.first else { return }
            selectedItem = item
        }
    }
    
    @objc func handleTap(_ sender: UITapGestureRecognizer? = nil) {
        switch selectionType {
        case .picker:
            presentPickerView()
        case .list:
            presentUalaSearch()
        case .listWithSelectionImage:
            presentPickerViewWithSelection()
        }
    }
}

// MARK: - Public methods
public extension UalaPicker {
    /**
     Defines the picker selection type
     
     - Cases:
        - picker: native picker style
        - list: opens a list with a search bar, presented
     */
    enum UalaPickerSelectionType {
        case picker
        case list
        case listWithSelectionImage
    }
    
    /**
     Setups the picker with the provided params and specifications
     
     - Parameters:
        - selectionType: Picker selection type, either native picker or search list
        - items: String array with possible items
        - title: Title displayed, can be nil
        - selectedItem: Item set as selected upon creation, can be nil
     
     - Warning: items must not be empty, or the picker will crash
     */
    func setupPicker(selectionType: UalaPickerSelectionType, items: [String], title: String? = nil, selectedItem: String? = nil) {
        self.selectionType = selectionType
        self.title = title
        
        searchableItems = items.compactMap { (item) -> SearchableString? in
            guard let id = items.firstIndex(of: item) else { return nil }
            return SearchableString(id: id, name: item)
        }
        
        guard let selectedItem = selectedItem else {
            updateUI()
            return
        }
        self.selectedItem = searchableItems.first(where: { item in item.name == selectedItem })
    }
    
    /**
     Returns the picker's selected value
     
     - Returns: picker's selected value
     */
    func getItemName() -> String? {
        return selectedItem?.name
    }
    
    /**
     Returns the picker's selected value
     
     - Returns: picker's selected value
     */
    func getIndex() -> Int? {
        return selectedItem?.id
    }
    
    /**
     Sets the picker's selected value
     
     - Parameters:
        - value: String
     */
    func setSelectedItem(value: String) {
        selectedItem = searchableItems.first(where: { item in item.name == value })
    }
    
    /**
     Sets the picker's action when an item is selected
     
     - Parameters:
        - behaviour: Void -> Void closure
     */
    func setupBehaviourOnItemSelected(_ behaviour: (() -> Void)?) {
        self.didSelectItem = behaviour
    }
    
    /**
     Sets the picker's field value
     
     - Parameters:
        - value: String
     */
    func setFieldText(_ value: String) {
        contentLabel.text = value
        informationLabel.text = title
    }
}

public class SearchableString: Searcheable, CustomStringConvertible, Equatable {
    public static func == (lhs: SearchableString, rhs: SearchableString) -> Bool {
        return "\(lhs.id)\(lhs.name)" == "\(rhs.id)\(rhs.name)"
    }
    
    public var description: String {
        return name
    }
    
    public var id: Int
    public var name: String
    
    init(id: Int, name: String) {
        self.id = id
        self.name = name
    }
}
