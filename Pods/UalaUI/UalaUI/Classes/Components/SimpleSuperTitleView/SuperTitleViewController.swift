//
//  SimpleSuperTitleViewController.swift
//  UalaUI
//
//  Created by Aldana Rastrelli on 27/04/2022.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import UIKit

public class SuperTitleViewModule {
    public static func build(withTitle title: String, superTitle: String, hasBanner: Bool, bannerIcon: String?, bannerLabel: String?) -> UIViewController {
        
        let view: SuperTitleViewController = SuperTitleViewController.loadXib()
        
        view.configure(withTitle: title, superTitle: superTitle, showingBlueBanner: hasBanner, withIconName: bannerIcon, andText: bannerLabel)
        
        return view
    }
}

public class SuperTitleViewController: UIViewController {
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var superTitleLbl: UILabel!
    @IBOutlet weak var blueBanner: UIView!
    @IBOutlet weak var blueBannerImg: UIImageView!
    @IBOutlet weak var blueBannerLbl: UILabel!
    
    var titleLblText: String = ""
    var superTitleLblText: String = ""
    var showBlueBanner: Bool = false
    var blueBannerImgName: String = ""
    var blueBannerLblText: String = ""

    public override func viewDidLoad() {
        super.viewDidLoad()
        setInformation()
        customize()
    }
    
    func customize() {
        titleLbl.customize(style: .semiBoldFarePrimaryCenter(size: 16))
        superTitleLbl.customize(style: .lightWarmGreyCenter(size: 26))
        blueBannerLbl.customize(style: .semiBoldFarePrimaryCenter(size: 12))
        blueBannerLbl.setLineSpacing(lineSpacing: 2.0)
        
        blueBanner.backgroundColor = UalaStyle.colors.blue05
        blueBannerImg.height = 20
        blueBannerImg.width = 20
    }
    
    public func configure(withTitle title: String, superTitle: String, showingBlueBanner: Bool, withIconName bannerIconName: String?, andText bannerText: String?) {
        self.titleLblText = title
        self.superTitleLblText = superTitle
        self.showBlueBanner = showingBlueBanner
        self.blueBannerImgName = bannerIconName ?? ""
        self.blueBannerLblText = bannerText ?? ""
    }
    
    func setInformation() {
        self.titleLbl.text = self.titleLblText
        self.superTitleLbl.text = self.superTitleLblText
        if self.showBlueBanner {
            let iconName = self.blueBannerImgName
            self.blueBannerImg.setImage(BundleImage(bundle: .Common, named: iconName))
            let bannerMsg = self.blueBannerLblText
            self.blueBannerLbl.text = bannerMsg
        }
    }
}
