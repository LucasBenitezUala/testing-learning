//
//  
//  WebViewViewController.swift
//  UalaUtils
//
//  Created by Andrés Abraham Bonilla Gómex on 12/10/21.
//
//

import UIKit
import WebKit
import PromiseKit

public class WebViewViewController: UIViewController {
    
    @IBOutlet weak var webView: WKWebView!
    weak public var presenter: WebViewPresenterType?
    
    public override var preferredStatusBarStyle: UIStatusBarStyle {
        return .default
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public init(presenter: WebViewPresenterType) {
        self.presenter = presenter
        
        super.init(nibName: WebViewViewController.typeName, bundle: Bundle(for: type(of: self)))
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter?.interactor?.setup()
    }	
}

extension WebViewViewController: WebViewViewType {
    
    @MainActor
    public func showURL(url: URL?) {
        
        guard let url: URL = url else { return }
        webView.load(URLRequest(url: url))
    }
}
