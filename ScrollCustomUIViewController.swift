//
//  ScrollCustomUIViewController.swift
//  RSSScroller
//
//  Created by admin on 10/11/17.
//  Copyright © 2017 admin. All rights reserved.
//

import UIKit

class ScrollCustomUIViewController: UIViewController {

    var viewController: UISplitViewController!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func setEmbeddedViewController(splitViewController: UISplitViewController!) {
        if splitViewController != nil {
            viewController = splitViewController

            self.addChildViewController(viewController)
            self.view.addSubview(viewController.view)
            viewController.didMove(toParentViewController: self)

            self.setOverrideTraitCollection(UITraitCollection(horizontalSizeClass: UIUserInterfaceSizeClass.regular), forChildViewController: viewController)
        }
    }

    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        if self.traitCollection.verticalSizeClass == UIUserInterfaceSizeClass.regular {
        }
        else {
            self.setOverrideTraitCollection(nil, forChildViewController: viewController)
        }

        super.viewWillTransition(to: size, with: coordinator)
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
