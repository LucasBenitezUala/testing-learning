import UIKit

public protocol WaveViewScrollable {
    func didScroll(ratio: CGFloat)
}

public class WaveView: UIView {
    
    public var bottomOffset: CGFloat = 0.0
    public var waveHeight: CGFloat = 0
    var backWave = CAShapeLayer()
    var frontWave = CAShapeLayer()
    var frontPath = WavePathGenerator.firstWave()
    var backPath = WavePathGenerator.secondWave()
    
    public override func draw(_ rect: CGRect) {
        setup()
    }
    
    public func setup() {
        frontWave.path = wavePath(frontPath)
        frontWave.fillColor = UIColor.white.cgColor
        layer.addSublayer(frontWave)
        
        backWave.path = wavePath(backPath)
        backWave.fillColor = UIColor(white: 1, alpha: 0.5).cgColor
        layer.addSublayer(backWave)
        
        guard bottomOffset > 0.0 else { return }
        
        let fill = CAShapeLayer()
        fill.zPosition = -1
        fill.path = UIBezierPath(rect: CGRect(x: 0.0,
                                              y: frame.size.height - bottomOffset,
                                              width: UIScreen.main.bounds.width,
                                              height: bottomOffset)).cgPath
        fill.fillColor = UIColor.white.cgColor
        layer.addSublayer(fill)
    }
    
    public func deletePaths() {
        backWave.removeFromSuperlayer()
        frontWave.removeFromSuperlayer()
    }
    
    public func setSingleWave() {
        backWave.removeFromSuperlayer()
        frontWave.path = wavePath(WavePathGenerator.singleWave())
    }
    
    public func setCustomPaths(frontPath: [PathInstruction], backPath: [PathInstruction]) {
        self.frontPath = frontPath
        self.backPath = backPath
        self.frontWave.path = wavePath(self.frontPath)
        self.backWave.path = wavePath(self.backPath)
    }
    
    private func wavePath(_ instructions: [PathInstruction], _ scale: CGFloat = 1) -> CGPath {
        let bezierPath = UIBezierPath()
        instructions.forEach({ $0.apply(path: bezierPath, scale: scale) })
        bezierPath.close()
        
        fit(bezierPath, into: frame)
        waveHeight = bezierPath.bounds.origin.y + bezierPath.bounds.size.height + bottomOffset
        translate(bezierPath)
        
        return bezierPath.cgPath
    }
    
    func translate(_ path: UIBezierPath) {
        let translate = CGAffineTransform(translationX: 0, y: frame.size.height - waveHeight)
        path.apply(translate)
    }
    
    func fit(_ path: UIBezierPath, into: CGRect) {
        let bounds = path.bounds
        let swRate = UIScreen.main.bounds.width/bounds.width
        let shRate = into.size.height/bounds.height
        let factor = min(swRate, max(shRate, 0.0))
        path.apply(CGAffineTransform(scaleX: factor, y: factor))
    }
}

extension WaveView: WaveViewScrollable {
    
    public func didScroll(ratio: CGFloat) {
        frontWave.path = wavePath(frontPath, ratio)
        backWave.path = wavePath(backPath, ratio)
    }
}
