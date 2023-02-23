//
//  PhotoProcessor.swift
//  UalaUI
//
//  Created by Ualá on 20/10/21.
//

import Vision

// TODO: - Refactor similar code and update Vision APIs
final class PhotoProcessor {
    let attachment: AttachmentType

    init(attachment: AttachmentType) {
        self.attachment = attachment
    }

    func validate(image: UIImage,
                  onInvalidPicture: @escaping (InvalidAttachmentPicture) -> Void,
                  onAcceptedPicture: @escaping (UIImage) -> Void) {
        switch attachment {
        case .selfie:
            identifySingleFace(image,
                               onInvalidPicture: onInvalidPicture,
                               onAcceptedPicture: onAcceptedPicture)
        case .identification:
            identifySingleRectangle(image,
                                    onInvalidPicture: onInvalidPicture,
                                    onAcceptedPicture: onAcceptedPicture)
        default:
            onAcceptedPicture(image)
        }
    }

    /// Verifies that the image has a single identifyble face
    private func identifySingleFace(_ image: UIImage,
                                    onInvalidPicture: @escaping (InvalidAttachmentPicture) -> Void,
                                    onAcceptedPicture: @escaping (UIImage) -> Void) {
        checkForFace(image: image) { isValid in
            if !isValid {
                onInvalidPicture(.unableToIdentifySingleFace)
            } else {
                onAcceptedPicture(image)
            }
        }
    }

    private func checkForFace(image: UIImage, completion: @escaping (Bool) -> Void) {
        guard let cgImage = image.cgImage else {
            completion(false)
            return
        }

        let requestHandler = VNImageRequestHandler(cgImage: cgImage, orientation: .up, options: [:])
        do {
            try requestHandler.perform([
                VNDetectFaceLandmarksRequest { request, error in
                    guard error == nil,
                          let observations = request.results as? [VNFaceObservation],
                          observations.count == 1 else {
                        completion(false)
                        return
                    }
                    completion(true)
                }
            ])
        } catch {
            completion(false)
        }
    }

    /// Verifies that the image has a single identifyble face
    private func identifySingleRectangle(_ image: UIImage,
                                         onInvalidPicture: @escaping (InvalidAttachmentPicture) -> Void,
                                         onAcceptedPicture: @escaping (UIImage) -> Void) {
        checkForRect(image: image) { isValid in
            if !isValid {
                onInvalidPicture(.unableToIdentifyRectangle)
            } else {
                onAcceptedPicture(image)
            }
        }
    }

    private func checkForRect(image: UIImage, completion: @escaping (Bool) -> Void) {
        guard let cgImage = image.cgImage else {
            completion(false)
            return
        }
        let requestHandler = VNImageRequestHandler(cgImage: cgImage, orientation: .up, options: [:])
        do {

            try requestHandler.perform([
                VNDetectRectanglesRequest { request, error in
                    guard error == nil,
                          let observations = request.results as? [VNRectangleObservation],
                          !observations.isEmpty,
                          let observation = observations.max(by: { $0.bottomRight.x + $0.bottomLeft.x > $1.bottomRight.x + $1.bottomLeft.x }) else {
                        completion(false)
                        return
                    }

                    let fillPercentage: CGFloat = 0.8

                    let observationSize = observation.bottomRight.x + observation.bottomLeft.x

                    if fillPercentage > observationSize {
                        completion(false)
                    } else {
                        completion(true)
                    }
                }
            ])
        } catch {
            completion(false)
        }
    }
}
