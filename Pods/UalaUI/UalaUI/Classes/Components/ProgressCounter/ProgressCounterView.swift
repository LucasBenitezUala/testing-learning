//
//  ProgressView.swift
//  UalaCedears
//
//  Created by Miguel Jasso on 07/03/22.
//

import UIKit
import UalaUI
import UalaCore

public protocol ProgressCounterViewDelegate: AnyObject {
    func countDownFinished()
}

@IBDesignable
public class ProgressCounterView: XibView {
    
    @IBOutlet weak var leftTitleLabel: UILabel!
    @IBOutlet weak var rightTitleLabel: UILabel!
    @IBOutlet weak var progressView: UIProgressView!
    
    public struct ProgressCounterViewModel {
        let rightText: String
        let leftText: String
        
        public init(rightText: String, leftText: String) {
            self.rightText = rightText
            self.leftText = leftText
        }
    }
    
    public weak var delegate: ProgressCounterViewDelegate?
    var countTime: Int = 0
    var countTimeAux: Int = 0
    var timer: Timer?
    var timeLeft: Int = 10
    var titleSize: CGFloat = 12
    var totalProgress: Float = 1
    var firstStart: Bool = true

    override init(frame: CGRect) {
        super.init(frame: frame)
        customizeUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        customizeUI()
    }
    
    public func setup(with viewModel: ProgressCounterViewModel) {
        rightTitleLabel.text = viewModel.rightText
        leftTitleLabel.text = viewModel.leftText
    }
    
    public func startCounter(time: Int) {
        countTime = time
        countTimeAux = time
        if !firstStart {
            updateProgressColor()
            UIView.animate(withDuration: 0.01) {
                self.progressView.setProgress(self.totalProgress, animated: true)
            }
        }
        firstStart = false
        updateTimeLabel()
        
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateCounter), userInfo: nil, repeats: true)
    }
    
    public func stopTimer() {
        timer?.invalidate()
        timer = nil
    }
}

private extension ProgressCounterView {
    func customizeUI() {
        progressView.progress = totalProgress
        leftTitleLabel.customize(style: .regularBlackLeft(size: titleSize))
        rightTitleLabel.customize(style: .regularBlackLeft(size: titleSize))
        progressView.progressTintColor = UalaStyle.colors.blue50
        progressView.progress = totalProgress
    }
    
    @objc func updateCounter() {
        if countTimeAux > 1 {
            countTimeAux -= 1
            UIView.animate(withDuration: 1.0) {
                self.progressView.setProgress((Float(1)/Float(self.countTime))*Float(self.countTimeAux), animated: true)
                self.updateTimeLabel()
                self.updateProgressColor()
            }
        } else {
            delegate?.countDownFinished()
            stopTimer()
        }
    }
    
    func updateProgressColor() {
        if countTimeAux <= self.timeLeft {
            progressView.progressTintColor = UalaStyle.colors.red60
        } else {
            progressView.progressTintColor = UalaStyle.colors.blue50
        }
    }
    
    func updateTimeLabel() {
        rightTitleLabel.text = "\(countTimeAux)\""
    }
}
