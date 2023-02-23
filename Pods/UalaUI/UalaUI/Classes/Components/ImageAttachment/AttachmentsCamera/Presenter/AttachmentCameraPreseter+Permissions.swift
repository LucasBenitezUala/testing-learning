//
//  AttachmentCameraPreseter+Permissions.swift
//  UalaUI
//
//  Created by Ualá on 20/10/21.
//

import UalaCore

extension AttachmentsCameraPresenter: CameraPermissionsProtocol {

    public func cameraPermissionGranted() {
        configureCameraController()
    }

    public func cameraPermissionDenied() {
        view?.showAlert(
            title: translate(CameraDeniedLocalizableKeys.title.rawValue),
            message: translate(CameraDeniedLocalizableKeys.message.rawValue))
    }
}
