import UIKit

extension CIImage {
    /// Inverts the colors and creates a transparent image by converting the mask to alpha.
    /// Input image should be black and white.
    var transparent: CIImage? {
        inverted?.maskToAlpha
    }

    /// Inverts the colors.
    var inverted: CIImage? {
        guard let colorInvertFilter = CIFilter(name: "CIColorInvert") else { return nil }
        colorInvertFilter.setValue(self, forKey: "inputImage")
        return colorInvertFilter.outputImage
    }

    /// Converts all black to transparent.
    var maskToAlpha: CIImage? {
        guard let maskToAlphaFilter = CIFilter(name: "CIMaskToAlpha") else { return nil }
        maskToAlphaFilter.setValue(self, forKey: "inputImage")
        return maskToAlphaFilter.outputImage
    }

    /// Applies the given color as a tint color.
    func tinted(using color: UIColor) -> CIImage? {
        guard
            let backgroundImage = transparent,
            let colorFilter = CIFilter(name: "CIConstantColorGenerator"),
            let multiplyFilter = CIFilter(name: "CIMultiplyCompositing")
        else { return nil }
        colorFilter.setValue(CIColor(color: color), forKey: kCIInputColorKey)
        multiplyFilter.setValue(colorFilter.outputImage, forKey: kCIInputImageKey)
        multiplyFilter.setValue(backgroundImage, forKey: kCIInputBackgroundImageKey)
        return multiplyFilter.outputImage
    }

    /// Combines the current image with the given image centered.
    func combined(with image: CIImage) -> CIImage? {
        guard let filter = CIFilter(name: "CISourceOverCompositing") else { return nil }
        let centerTransform = CGAffineTransform(
            translationX: extent.midX - (image.extent.width / 2),
            y: extent.midY - (image.extent.height / 2)
        )
        filter.setValue(image.transformed(by: centerTransform), forKey: "inputImage")
        filter.setValue(self, forKey: "inputBackgroundImage")
        return filter.outputImage
    }
}

/// Reference:
/// QR Code generation with a custom logo and color using Swift
/// https://www.avanderlee.com/swift/qr-code-generation-swift/
/// https://github.com/AvdLee/QR-Code-Custom
