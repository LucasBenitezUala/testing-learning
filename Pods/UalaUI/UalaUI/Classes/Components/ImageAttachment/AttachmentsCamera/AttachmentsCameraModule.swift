import UIKit
import UalaCore

public class AttachmentsCameraModule {

    public static func build(
        configuration: AttachmentCameraConfigurationProtocol,
        photoReviewViewData: PhotoReviewViewData? = nil,
        delegate: AttachmentCameraDelegate,
        enableProcessing: Bool = false,
        allowsEditing: Bool = true) -> UIViewController {
            let view: AttachmentsCameraView = makeViewController(config: configuration)
            let interactor: AttachmentsCameraInteractor = makeInteractor()
            let presenter: AttachmentsCameraPresenter = makePresenter(attachmentType: configuration.attachmentType)
            let router: AttachmentsCameraRouter = makeRouter()

            interactor.presenter = presenter

            let reviewViewData: PhotoReviewViewData = makeReviewData(from: photoReviewViewData, attachmentType: configuration.attachmentType)
            let picturePickerHelper: PicturePickerHelper = makePicturePicker(delegate: router)
            router.allowsEditing = allowsEditing
            router.viewController = view
            router.viewData = reviewViewData
            router.cameraDelegate = delegate
            router.pictureDelegate = picturePickerHelper

            let permissionsHelper: CameraPermissionsHelper = makePermissionsHelper(delegate: presenter)
            let photoCaptureDelegate: PhotoCaptureDelegate = makePhotoDelegate(
                attachmentType: configuration.attachmentType,
                enableProcessing: enableProcessing)

            let cameraController: CameraController = makeCameraController(cameraView: view.cameraDisplay)
            presenter.view = view
            presenter.interactor = interactor
            presenter.photoCaptureDelegate = photoCaptureDelegate
            presenter.cameraPermissionsHelper = permissionsHelper
            presenter.cameraController = cameraController
            cameraController.photoCaptureCompletionBlock = presenter.photoCaptureDelegate?.managePhotoCapture()

            view.onViewWillAppear = presenter.checkCameraPermissions
            view.onViewDidDisappear = presenter.closeCaptureSession
            view.onPhotoLibraryButtonTap = router.openImagePicker
            view.onCapturePhotoTap = presenter.capture
            view.onSwitchCameraTap = presenter.switchCamera
            view.onCloseButtonTap = router.closeView

            photoCaptureDelegate.onFinishCapture = view.enablePhotoButton
            photoCaptureDelegate.onAcceptedPhoto = router.goToConfirm(picture:)
            photoCaptureDelegate.onInvalidPicture = delegate.onInvalidPicture(_:)

            return view
        }

    public static func buildRoot(configuration: AttachmentCameraConfigurationProtocol, delegate: AttachmentCameraDelegate, allowsEditing: Bool = true) -> UINavigationController {
        let view = self.build(configuration: configuration, delegate: delegate, allowsEditing: allowsEditing)
        let navigation = UalaNavigationController(rootViewController: view)
        navigation.navigationBar.topItem?.title = configuration.titleLabel
        return navigation
    }

    // MARK: - View

    private static func makeViewController(config: AttachmentCameraConfigurationProtocol) -> AttachmentsCameraView {
        let view: AttachmentsCameraView = AttachmentsCameraView(
            nibName: AttachmentsCameraView.nibName,
            bundle: .init(for: AttachmentsCameraView.self))
        view.loadViewIfNeeded()

        view.applyCameraConfiguration(config)

        return view
    }

    // MARK: - Interactor

    private static func makeInteractor() -> AttachmentsCameraInteractor {
        .init()
    }

    // MARK: - Presenter

    private static func makePresenter(attachmentType: AttachmentType) -> AttachmentsCameraPresenter {
        .init(attachmentType: attachmentType)
    }

    // MARK: - Router

    private static func makeRouter() -> AttachmentsCameraRouter {
        .init()
    }

    // MARK: - Review Data

    private static func makeReviewData(from data: PhotoReviewViewData?, attachmentType: AttachmentType) -> PhotoReviewViewData {
        data ?? .init(attachmentType: attachmentType)
    }

    // MARK: - Photo Delegate

    private static func makePhotoDelegate(attachmentType: AttachmentType, enableProcessing: Bool) -> PhotoCaptureDelegate {
        .init(attachmentType: attachmentType,
              enableProcessing: enableProcessing)
    }

    // MARK: - Camera

    private static func makeCameraController(cameraView: UIView) -> CameraController {
        let cameraController: CameraController = .init()

        cameraController.previewContainer = cameraView

        return cameraController
    }

    // MARK: - Permissions Helper

    private static func makePermissionsHelper(delegate: CameraPermissionsProtocol) -> CameraPermissionsHelper {
        let permissonsHelper: CameraPermissionsHelper = .init()
        
        permissonsHelper.delegate = delegate

        return permissonsHelper
    }

    // MARK: - Picture Helper Manager

    private static func makePicturePicker(delegate: PicturePickerDelegate) -> PicturePickerHelper {
        let picturePickerHelper: PicturePickerHelper = .init()

        picturePickerHelper.delegate = delegate

        return picturePickerHelper
    }
}
