//
//  PhotoReviewViewData+AttachmentType.swift
//  UalaUI
//
//  Created by Ualá on 20/10/21.
//

import UalaCore

extension PhotoReviewViewData {
    init(attachmentType: AttachmentType, table: StringTables = .Common) {
        switch attachmentType {
        case .selfie:
            self.init(title: translate(CameraReviewTitleLocalizableKeys.selfie.rawValue,
                                       from: table),
                      description: translate(CameraReviewDescriptionLocalizableKeys.selfie.rawValue,
                                             from: table))
        case .document:
            self.init(title: translate(CameraReviewTitleLocalizableKeys.document.rawValue,
                                       from: table),
                      description: translate(CameraReviewDescriptionLocalizableKeys.document.rawValue,
                                             from: table))
        case .identification:
            self.init(title: translate(CameraReviewTitleLocalizableKeys.identification.rawValue,
                                       from: table),
                      description: translate(CameraReviewDescriptionLocalizableKeys.identification.rawValue,
                                             from: table))
        }
    }
}
