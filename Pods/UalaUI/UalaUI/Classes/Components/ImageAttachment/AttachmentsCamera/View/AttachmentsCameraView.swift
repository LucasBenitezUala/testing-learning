import UIKit
import UalaCore

public final class AttachmentsCameraView: UIViewController, AttachmentsCameraViewProtocol {

    @IBOutlet weak var cameraTakePhotoButton: UIButton!
    @IBOutlet weak var placeHolderText: UILabel!
    @IBOutlet weak var cameraDisplay: UIView!
    @IBOutlet weak var documentPlaceHolderShape: PlaceHolderShapeCameraView!
    @IBOutlet weak var identificationPlaceholderShape: PlaceHolderShapeCameraView!
    @IBOutlet weak var galleryButton: UIButton!
    @IBOutlet weak var placeHolderBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var swiftchCameraButton: UIButton!
    var onPhotoLibraryButtonTap: (() -> Void)?
    var onCloseButtonTap: (() -> Void)?
    var onSwitchCameraTap: (() -> Void)?
    var onCapturePhotoTap: (() -> Void)?
    var onViewWillAppear: (() -> Void)?
    var onViewDidDisappear: (() -> Void)?
    private lazy var imageFactory: AttachmentsCameraImageFactory = .init()

    // MARK: - Life cycle

    public override func viewDidLoad() {
        super.viewDidLoad()

        setUpUI()
    }

    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        onViewWillAppear?()
    }

    public override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)

        onViewDidDisappear?()
    }

    // MARK: - Callable interfaces

    func applyCameraConfiguration(_ cameraConfiguration: AttachmentCameraConfigurationProtocol) {
        placeHolderText.isHidden = cameraConfiguration.labelText == nil
        placeHolderText.text = cameraConfiguration.labelText
        galleryButton.isHidden = cameraConfiguration.hideGalleryButton ?? true

        setUpFor(attachmentType: cameraConfiguration.attachmentType)
    }

    func enablePhotoButton() {
        cameraTakePhotoButton.isEnabled = true
    }

    // MARK: - User Interactions

    @IBAction func capturePhoto(_ sender: Any) {
        cameraTakePhotoButton.isEnabled = false
        onCapturePhotoTap?()
    }

    @IBAction func switchCamera(_ sender: Any) {
        onSwitchCameraTap?()
    }

    @IBAction func openPhotoLibraryAction(_ sender: Any) {
        onPhotoLibraryButtonTap?()
    }

    @objc func closePage() {
        onCloseButtonTap?()
    }

    // MARK: - UI Construction

    private func setUpUI() {
        addCloseButton()
        addIcons()
        setUpPlaceHolderLabel()
    }

    public func getPlaceHolderText() -> String? {
        return placeHolderText.text
    }
    
    private func addCloseButton() {
        let button: UIButton = .init(type: .custom)
        button.setImage(imageFactory.closeButtonImage, for: .normal)
        button.addTarget(self, action: #selector(closePage), for: .touchUpInside)
        button.tintColor = #colorLiteral(red: 0.3621281683, green: 0.3621373773, blue: 0.3621324301, alpha: 1)

        navigationItem.leftBarButtonItem = .init(customView: button)
        navigationItem.leftBarButtonItem?.accessibilityIdentifier = "close"
    }

    private func addIcons() {
        galleryButton.setImage(imageFactory.galleryIcon, for: .normal)
        swiftchCameraButton.setImage(imageFactory.switchCameraIcon, for: .normal)
        cameraTakePhotoButton.setImage(imageFactory.capturePhotoIcon, for: .normal)
    }

    private func setUpFor(attachmentType: AttachmentType) {
        switch attachmentType {
        case .selfie:
            documentPlaceHolderShape.placeHolderType = .selfie
        case .document:
            setUpPlaceholder(for: .document)
        case .identification:
            setUpPlaceholder(for: .identification)
        }
    }

    private func setUpPlaceholder(for attachmentType: AttachmentType) {
        placeHolderBottomConstraint.constant -= placeHolderText.frame.height
        identificationPlaceholderShape.setNeedsLayout()
        identificationPlaceholderShape.placeHolderType = attachmentType
        identificationPlaceholderShape.accessibilityIdentifier = attachmentType.getAccessibilityIdentifier()
    }

    private func setUpPlaceHolderLabel() {
        let shadowOpacity: Float = 1.0
        let shadowRadius: CGFloat = 2.0
        let shadowColor: CGColor = UIColor.black.cgColor

        placeHolderText.setShadow(
            opacity: shadowOpacity,
            radius: shadowRadius,
            color: shadowColor)
    }
}
