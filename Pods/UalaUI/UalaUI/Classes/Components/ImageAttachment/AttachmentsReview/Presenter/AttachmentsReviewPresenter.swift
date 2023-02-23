import UIKit

protocol AttachmentsReviewDelegate: AnyObject {
    func reviewConfirm(pictureTaken: UIImage?)
    func didTapRetakePicture()
}

class AttachmentsReviewPresenter: AttachmentsReviewPresenterProtocol {

    weak var view: AttachmentsReviewViewProtocol?
    var interactor: AttachmentsReviewInteractorProtocol?
    var router: AttachmentsReviewRouterProtocol?
    var delegate: AttachmentsReviewDelegate?

    func reviewConfirm() {
        delegate?.reviewConfirm(pictureTaken: view?.pic)
    }

    func didTapRetakePicture() {
        delegate?.didTapRetakePicture()
    }
}
