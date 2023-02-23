import UalaCore

public class  AttachmentsCameraPresenter: AttachmentsCameraPresenterProtocol {

    public var cameraPermissionsHelper: CameraPermissionsHelperProtocol?
    weak var view: AttachmentsCameraViewProtocol?
    var interactor: AttachmentsCameraInteractorProtocol?
    var cameraController: CameraController?
    var attachmentType: AttachmentType
    var reviewViewData: PhotoReviewViewData?
    var photoCaptureDelegate: PhotoCaptureDelegate?

    // MARK: - Life cycle

    init(attachmentType: AttachmentType) {
        self.attachmentType = attachmentType
    }

    func checkCameraPermissions() {
        cameraPermissionsHelper?.checkCameraVideoPermission()
    }

    func closeCaptureSession() {
        cameraController?.captureSession?.commitConfiguration()
        cameraController?.captureSession?.stopRunning()
    }

    // MARK: - UI Handling

    func capture() {
        cameraController?.captureImage()
    }

    func switchCamera() {
        try? cameraController?.switchCameras()
    }

    // MARK: - Camera configuration set up

    func configureCameraController() {
        var defaultCamera: CameraController.CameraPosition = .front

        if [.document, .identification].contains(attachmentType) {
            defaultCamera = .rear
        }

        cameraController?.prepare(defaultCamera: defaultCamera,
                                 completion: { [weak self] (error) in
            guard error != nil else {
                return
            }

             self?.view?.showAlert(
                title: translate(CameraErrorLocalizableKeys.title.rawValue,
                                 from: .Common),
                message: translate(CameraErrorLocalizableKeys.description.rawValue,
                                   from: .Common))
        })
    }
}
