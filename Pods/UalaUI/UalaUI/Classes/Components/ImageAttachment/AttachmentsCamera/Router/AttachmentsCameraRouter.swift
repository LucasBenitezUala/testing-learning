import UIKit

final class AttachmentsCameraRouter: AttachmentsCameraRouterProtocol {

    weak var viewController: UIViewController?
    weak var cameraDelegate: AttachmentCameraDelegate?
    var overlayView: UIView?
    var allowsEditing: Bool = true
    var viewData: PhotoReviewViewData?
    var pictureDelegate: (UIImagePickerControllerDelegate & UINavigationControllerDelegate)?

    func goToConfirm(picture: UIImage) {
        let view = AttachmentsReviewModule
            .build(image: picture,
                   title: viewData?.title ?? .init(),
                   description: viewData?.description ?? .init(),
                   delegate: self)

        viewController?.navigationController?.pushViewController(view, animated: true)
    }

    func openImagePicker() {
        let imagePickerController = UIImagePickerController()
        imagePickerController.view.backgroundColor = .white
        imagePickerController.view.contentMode = .center
        imagePickerController.sourceType = .photoLibrary
        imagePickerController.delegate = pictureDelegate
        imagePickerController.allowsEditing = self.allowsEditing

        viewController?.present(imagePickerController, animated: true, completion: nil)
    }

    func closeView() {
        viewController?.dismiss(animated: true, completion: {})
    }
}

// MARK: - Attachments Review Delegate

extension AttachmentsCameraRouter: AttachmentsReviewDelegate {

    func reviewConfirm(pictureTaken: UIImage?) {
        if let picture = pictureTaken {
            cameraDelegate?.cameraPictureResult(picture: picture)
            closeView()
        }
    }

    func didTapRetakePicture() {
        cameraDelegate?.didTapRetakePicture()
    }
}

// MARK: - Picture Picker Delegate

extension AttachmentsCameraRouter: PicturePickerDelegate {

    public func picturePicker(didFinishPickcing image: UIImage,
                              type: UIImagePickerController.SourceType) {
        if allowsEditing {
            goToConfirm(picture: image)
        } else {
            reviewConfirm(pictureTaken: image)
            closeView()
        }
    }
}
