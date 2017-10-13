//
//  ScrollerUIViewController.swift
//  RSSScroller
//
//  Created by admin on 10/11/17.
//  Copyright © 2017 admin. All rights reserved.
//

import UIKit
import WebKit

class ScrollerUIViewController: UIViewController {

    var articleURL : URL!
    var publishDate : String!
    @IBOutlet weak var webView: WKWebView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func showPublishDate(sender: AnyObject) {
        // Implementation of showPublishDate.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
