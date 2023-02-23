import Foundation
import UIKit

protocol AttachmentsReviewRouterProtocol: AnyObject { }

protocol AttachmentsReviewPresenterProtocol: AnyObject {
    var delegate: AttachmentsReviewDelegate? { get set }
    func reviewConfirm()
    func didTapRetakePicture()
}

protocol AttachmentsReviewInteractorProtocol: AnyObject {
    var presenter: AttachmentsReviewPresenterProtocol? { get set }
}

protocol AttachmentsReviewViewProtocol: AnyObject {
    var presenter: AttachmentsReviewPresenterProtocol? { get set }
    var titleText: String? { get set }
    var descriptionText: String? { get set }
    var pic: UIImage? { get set }
}
