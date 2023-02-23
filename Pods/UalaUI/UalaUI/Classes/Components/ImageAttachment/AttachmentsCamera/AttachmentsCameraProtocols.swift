import Foundation
import UIKit

protocol AttachmentsCameraRouterProtocol: AnyObject {
    var cameraDelegate: AttachmentCameraDelegate? { get set }
    func goToConfirm(picture: UIImage)
    func openImagePicker()
    func closeView()
}

protocol AttachmentsCameraPresenterProtocol: AnyObject {
    var cameraController: CameraController? { get set }
    var attachmentType: AttachmentType { get set }
    func configureCameraController()
    func switchCamera()
    func capture()
    func closeCaptureSession()
    func checkCameraPermissions()
}

protocol AttachmentsCameraInteractorProtocol: AnyObject {
    var presenter: AttachmentsCameraPresenterProtocol? { get set }
}

protocol AttachmentsCameraViewProtocol: AnyObject {
    func showAlert(title: String, message: String)
}
