import AVFoundation
import UIKit
import UalaUtils

// TODO - Remove force unwraps in this class
// swiftlint:disable force_unwrapping
class CameraController: NSObject {
    var captureSession: AVCaptureSession?

    var currentCameraPosition: CameraPosition?

    var frontCamera: AVCaptureDevice?
    var frontCameraInput: AVCaptureDeviceInput?

    var photoOutput: AVCapturePhotoOutput?

    var rearCamera: AVCaptureDevice?
    var rearCameraInput: AVCaptureDeviceInput?

    var previewContainer: UIView? {
        didSet {
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTapToFocus(sender:)))
            previewContainer?.addGestureRecognizer(tapGesture)
        }
    }

    var flashMode = AVCaptureDevice.FlashMode.off
    var photoCaptureCompletionBlock: ((UIImage?, Error?) -> Void)?
    // swiftlint:disable:next function_body_length
    func prepare(defaultCamera: CameraPosition, completion: @escaping (Error?) -> Void) {
        func createCaptureSession() {
            self.captureSession = AVCaptureSession()
            self.captureSession?.sessionPreset = .medium
        }

        func configureCaptureDevices() throws {

            let session = AVCaptureDevice.DiscoverySession(deviceTypes: [.builtInWideAngleCamera], mediaType: AVMediaType.video, position: .unspecified)

            let cameras = session.devices.compactMap { $0 }
            guard !cameras.isEmpty else { throw CameraControllerError.noCamerasAvailable }

            for camera in cameras {
                if camera.position == .front {
                    self.frontCamera = camera
                }

                if camera.position == .back {
                    self.rearCamera = camera

                    try camera.lockForConfiguration()
                    camera.focusMode = .autoFocus
                    camera.unlockForConfiguration()
                }
            }
        }

        func configureDeviceInputs() throws {
            guard let captureSession = self.captureSession else { throw CameraControllerError.captureSessionIsMissing }

            if let rearCamera = self.rearCamera, defaultCamera == .rear {
                self.rearCameraInput = try AVCaptureDeviceInput(device: rearCamera)

                if captureSession.canAddInput(self.rearCameraInput!) {
                    captureSession.addInput(self.rearCameraInput!)
                }

                self.currentCameraPosition = .rear
            } else if let frontCamera = self.frontCamera, defaultCamera == .front {
                self.frontCameraInput = try AVCaptureDeviceInput(device: frontCamera)

                if captureSession.canAddInput(self.frontCameraInput!) {
                    captureSession.addInput(self.frontCameraInput!)
                } else {
                    throw CameraControllerError.inputsAreInvalid
                }

                self.currentCameraPosition = .front
            } else { throw CameraControllerError.noCamerasAvailable }
        }

        func configurePhotoOutput() throws {
            guard let captureSession = self.captureSession else { throw CameraControllerError.captureSessionIsMissing }

            self.photoOutput = AVCapturePhotoOutput()
            self.photoOutput!.setPreparedPhotoSettingsArray([AVCapturePhotoSettings(format: [AVVideoCodecKey: AVVideoCodecType.jpeg])], completionHandler: nil)

            if captureSession.canAddOutput(self.photoOutput!) {
                captureSession.addOutput(self.photoOutput!)
            }
            captureSession.startRunning()
        }

        DispatchQueue(label: "prepare").async { [weak self] in
            do {
                createCaptureSession()
                try configureCaptureDevices()
                try configureDeviceInputs()
                try configurePhotoOutput()
            } catch {
                DispatchQueue.main.async {
                    completion(error)
                }

                return
            }

            DispatchQueue.main.async { [weak self] in
                completion(nil)
                do {
                    try self?.displayPreview()
                } catch {
                    completion(error)
                }
            }
        }
    }

    @objc func displayPreview() throws {
        guard let captureSession = self.captureSession,
              captureSession.isRunning,
              let previewContainer = previewContainer else {
            throw CameraControllerError.captureSessionIsMissing
        }

        let videoLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        videoLayer.videoGravity = AVLayerVideoGravity.resizeAspectFill
        videoLayer.connection?.videoOrientation = .portrait
        videoLayer.session?.sessionPreset = .vga640x480
        videoLayer.frame = previewContainer.layer.bounds

        previewContainer.layer.sublayers?.forEach { $0.removeFromSuperlayer() }
        previewContainer.layer.insertSublayer(videoLayer, at: 0)
    }

    @objc func handleTapToFocus(sender: UITapGestureRecognizer) {
        if let device = rearCamera, let previewContainer = self.previewContainer {
            let focusPoint = sender.location(in: previewContainer)
            let focusScaledPointX = focusPoint.x / previewContainer.frame.size.width
            let focusScaledPointY = focusPoint.y / previewContainer.frame.size.height
            if device.isFocusModeSupported(.autoFocus) && device.isFocusPointOfInterestSupported {
                do {
                    try device.lockForConfiguration()
                } catch {
                    LogManager.shared.debugError(error: error, type: "Could not lock camera device for configuration")
                    return
                }

                device.focusMode = .autoFocus
                device.focusPointOfInterest = CGPoint(x: focusScaledPointX, y: focusScaledPointY)
                device.exposurePointOfInterest = CGPoint(x: focusScaledPointX, y: focusScaledPointY)

                device.exposureMode = .continuousAutoExposure

                device.unlockForConfiguration()
            }
        }
    }

    func switchCameras() throws {
        guard let currentCameraPosition = currentCameraPosition, let captureSession = self.captureSession, captureSession.isRunning else { throw CameraControllerError.captureSessionIsMissing }

        captureSession.beginConfiguration()

        func switchToFrontCamera() throws {

            guard let rearCameraInput = self.rearCameraInput, captureSession.inputs.contains(rearCameraInput),
                  let frontCamera = self.frontCamera else { throw CameraControllerError.invalidOperation }

            self.frontCameraInput = try AVCaptureDeviceInput(device: frontCamera)

            captureSession.removeInput(rearCameraInput)

            if captureSession.canAddInput(self.frontCameraInput!) {
                captureSession.addInput(self.frontCameraInput!)

                self.currentCameraPosition = .front
            } else {
                throw CameraControllerError.invalidOperation
            }
        }

        func switchToRearCamera() throws {

            guard let frontCameraInput = self.frontCameraInput, captureSession.inputs.contains(frontCameraInput),
                  let rearCamera = self.rearCamera else { throw CameraControllerError.invalidOperation }

            self.rearCameraInput = try AVCaptureDeviceInput(device: rearCamera)

            captureSession.removeInput(frontCameraInput)

            if captureSession.canAddInput(self.rearCameraInput!) {
                captureSession.addInput(self.rearCameraInput!)

                self.currentCameraPosition = .rear
            } else { throw CameraControllerError.invalidOperation }
        }

        switch currentCameraPosition {
        case .front:
            try switchToRearCamera()

        case .rear:
            try switchToFrontCamera()
        }

        captureSession.commitConfiguration()
    }

    func captureImage() {
        guard let captureSession = captureSession, captureSession.isRunning else { photoCaptureCompletionBlock?(nil, CameraControllerError.captureSessionIsMissing)
            return
        }

        let settings = AVCapturePhotoSettings()
        settings.flashMode = self.flashMode

        self.photoOutput?.capturePhoto(with: settings, delegate: self)
    }
}

extension CameraController: AVCapturePhotoCaptureDelegate {

    public func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        guard let imageData = photo.fileDataRepresentation(), let previewImage = UIImage(data: imageData) else {
            self.photoCaptureCompletionBlock?(nil, CameraControllerError.unknown)
            return
        }

        self.photoCaptureCompletionBlock?(previewImage, nil)
    }
}

extension CameraController {
    enum CameraControllerError: Swift.Error {
        case captureSessionAlreadyRunning
        case captureSessionIsMissing
        case inputsAreInvalid
        case invalidOperation
        case noCamerasAvailable
        case unknown
    }

    public enum CameraPosition {
        case front
        case rear
    }
}
