import Foundation

public extension UIViewController {
    
    static func loadXib<T: UIViewController>() -> T {
        let bundle = Bundle(for: T.self)
        return T(nibName: "\(self)", bundle: bundle)
    }
    
    public func updateModalDrag(enabled: Bool) {
        isModalInPresentation = !enabled
    }
}

// MARK: - NibName as Controller name

extension UIViewController {
    static var nibName: String { String(describing: Self.self) }
}
