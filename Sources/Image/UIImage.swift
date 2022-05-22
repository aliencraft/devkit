import UIKit

extension UIImage {
    public static func qrCode(_ message: String?, correctionLevel: String = "L", scale: CGFloat = 16) -> UIImage? {
        guard let message = message else { return nil }
        guard let filter = CIFilter(name: "CIQRCodeGenerator") else { return nil }
        filter.setValue(message.data(using: .isoLatin1), forKey: "inputMessage")
        filter.setValue(correctionLevel, forKey: "inputCorrectionLevel")
        guard
            let output = filter.outputImage,
            let ciImage = output.transformed(by: CGAffineTransform(scaleX: scale, y: scale)).transparent,
            let cgImage = CIContext().createCGImage(ciImage, from: ciImage.extent)
        else { return nil }
        return UIImage(cgImage: cgImage)
    }

    public func withCaption(
        _ text: String,
        font: UIFont = .preferredFont(forTextStyle: .footnote),
        spacing: CGFloat = 4
    ) -> UIImage {
        let textSize = (text as NSString).size(withAttributes: [.font: font])
        let width = max(size.width, textSize.width)
        let height = size.height + spacing + textSize.height
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: width, height: height))
        return renderer.image { context in
            let textOrigin = CGPoint(x: (width - textSize.width) / 2, y: size.height + spacing)
            text.draw(at: textOrigin, withAttributes: [.font: font])
            draw(in: CGRect(origin: CGPoint(x: (width - size.width) / 2, y: 0), size: size))
        }
    }
}
