//
//  AttachmentsCameraImageFactory.swift
//  UalaUI
//
//  Created by Ualá on 20/10/21.
//

import Foundation

final class AttachmentsCameraImageFactory {
    private let icClose: String = "ic-close"
    private let icGallery: String = "ic-gallery"
    private let icSwitchCamera: String = "ic-switchcamera"
    private let icCaptureButton: String = "ic-captureButton"

    lazy var closeButtonImage: UIImage? = { CommonImage(named: icClose) }()
    lazy var galleryIcon: UIImage? = { CommonImage(named: icGallery) }()
    lazy var switchCameraIcon: UIImage? = { CommonImage(named: icSwitchCamera) }()
    lazy var capturePhotoIcon: UIImage? = { CommonImage(named: icCaptureButton) }()
}
