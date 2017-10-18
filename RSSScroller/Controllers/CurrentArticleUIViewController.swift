//
//  ScrollerUIViewController.swift
//  RSSScroller
//
//  Created by admin on 10/11/17.
//  Copyright © 2017 admin. All rights reserved.
//

import UIKit
import WebKit

class CurrentArticleUIViewController: UIViewController {

  @IBOutlet weak var webView: WKWebView!
  public var articleURL: URL!
    
  override func viewDidLoad() {
    super.viewDidLoad()
    webView.isHidden = true
  }

  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)

    if articleURL != nil {
      let request: URLRequest = URLRequest(url: articleURL)
      webView.load(request)

      if webView.isHidden {
        webView.isHidden = false
      }
    }
  }
}
