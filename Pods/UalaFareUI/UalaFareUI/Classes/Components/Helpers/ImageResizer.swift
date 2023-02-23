//
//  ImageResizer.swift
//  UalaFareUI
//
//  Created by Luis Perez on 30/09/22.
//

public final class ImageResizer {
    static public func resizeImage(_ dimension: CGFloat,
                            image: UIImage,
                            opaque: Bool,
                            contentMode: UIView.ContentMode = .scaleAspectFit) -> UIImage {
        var width: CGFloat
        var height: CGFloat
        var newImage: UIImage

        let size = image.size
        let aspectRatio =  size.width/size.height

        switch contentMode {
            case .scaleAspectFit:
            if aspectRatio > 1 {                            // Landscape image
                width = dimension
                height = dimension / aspectRatio
            } else {                                        // Portrait image
                height = dimension
                width = dimension * aspectRatio
            }
        default:
            return image
        }
        
        let renderFormat = UIGraphicsImageRendererFormat.default()
                    renderFormat.opaque = opaque
                    let renderer = UIGraphicsImageRenderer(size: CGSize(width: width, height: height), format: renderFormat)
                    newImage = renderer.image {
                        (context) in
                        image.draw(in: CGRect(x: 0, y: 0, width: width, height: height))
                    }

        return newImage
    }
}
