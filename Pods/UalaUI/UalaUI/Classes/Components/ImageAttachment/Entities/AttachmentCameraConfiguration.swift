//
//  AttachmentCameraConfiguration.swift
//  UalaUI
//
//  Created by Rodrigo German Ferretty on 05/04/2020.
//

import Foundation

public enum InvalidAttachmentPicture {
    case unableToIdentifySingleFace
    case unableToIdentifyRectangle
}

// MARK: - Module API
public protocol AttachmentCameraDelegate: AnyObject {
    func cameraPictureResult(picture: UIImage)
    func didTapRetakePicture()
    func onInvalidPicture(_ reason: InvalidAttachmentPicture)
}

// MARK: Default methods in AttachmentCameraDelegate in order to make them optionals
public extension AttachmentCameraDelegate {
    func didTapRetakePicture() { }
    func onInvalidPicture(_ reason: InvalidAttachmentPicture) { }
}

public protocol AttachmentCameraConfigurationProtocol {
    var titleLabel: String? { get set }
    var labelText: String? { get }
    var hideGalleryButton: Bool { get }
    var attachmentType: AttachmentType { get }
}

public protocol CameraConfiguration {
    var config: AttachmentCameraConfigurationProtocol { get }
}

// Implementation

public struct AttachmentCameraConfiguration: AttachmentCameraConfigurationProtocol {
    public var titleLabel: String?
    public var labelText: String?
    public var hideGalleryButton: Bool
    public var attachmentType: AttachmentType

    public init(titleText: String? = nil,
         labelText: String? = nil,
         hideGalleryButton: Bool,
         attachmentType: AttachmentType) {
        self.titleLabel = titleText
        self.labelText = labelText
        self.hideGalleryButton = hideGalleryButton
        self.attachmentType = attachmentType
    }
}

public enum AttachmentType: Int {
    case selfie   = 0
    case document
    case identification
    
    func getAccessibilityIdentifier() -> String {
        switch self {
        case .selfie:
            return "selfie"
        case .document:
            return "document"
        case .identification:
            return "identification"
        }
    }
}
