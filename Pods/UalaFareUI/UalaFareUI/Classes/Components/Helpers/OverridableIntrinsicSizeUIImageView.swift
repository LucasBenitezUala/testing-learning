//
//  OverridableIntrinsicSizeUIImageView.swift
//  UalaFareUI
//
//  Created by Luis Perez on 27/07/22.
//
import UIKit

final class OverridableIntrinsicSizeUIImageView: UIImageView {
    var customSize: CGSize?
    
    public override var intrinsicContentSize: CGSize {
        return customSize ?? super.intrinsicContentSize
    }
}

final class TitleLabelSizedButton: UIButton {
    override var intrinsicContentSize: CGSize {
        return titleLabel?.intrinsicContentSize ?? super.intrinsicContentSize
    }
}

final class OverridableIntrinsicSizeUILabel: UILabel {
    var customSize: CGSize?
    
    public override var intrinsicContentSize: CGSize {
        return customSize ?? super.intrinsicContentSize
    }
}

final class OverridableIntrinsicSizeView: UIView {
    var customSize: CGSize?
    
    public override var intrinsicContentSize: CGSize {
        return customSize ?? super.intrinsicContentSize
    }
}
