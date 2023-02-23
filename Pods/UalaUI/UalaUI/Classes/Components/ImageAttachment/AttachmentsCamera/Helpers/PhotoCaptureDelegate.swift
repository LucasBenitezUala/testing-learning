//
//  PhotoCaptureDelegate.swift
//  UalaUI
//
//  Created by Ualá on 20/10/21.
//

import UIKit

final class PhotoCaptureDelegate {
    var onFinishCapture: (() -> Void)?
    var onInvalidPicture: ((InvalidAttachmentPicture) -> Void)?
    var onAcceptedPhoto: ((UIImage) -> Void)?
    private let attachmentType: AttachmentType
    private let enableProcessing: Bool

    init(attachmentType: AttachmentType, enableProcessing: Bool) {
        self.attachmentType = attachmentType
        self.enableProcessing = enableProcessing
    }

    func managePhotoCapture() -> ((UIImage?, Error?) -> Void) {
        { [weak self] image, _ in
            guard let self = self,
                  let onInvalidPicture = self.onInvalidPicture,
                  let onAcceptedPicture = self.onAcceptedPhoto else { return }
            self.onFinishCapture?()

            guard let image = image else {
                return
            }

            if self.enableProcessing {
                PhotoProcessor(attachment: self.attachmentType)
                    .validate(image: image,
                              onInvalidPicture: onInvalidPicture,
                              onAcceptedPicture: onAcceptedPicture)
                return
            }

            onAcceptedPicture(image)
        }
    }
}
