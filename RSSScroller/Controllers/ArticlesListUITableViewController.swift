//
//  ScrollerUITableViewController.swift
//  RSSScroller
//
//  Created by admin on 10/11/17.
//  Copyright © 2017 admin. All rights reserved.
//

import UIKit

class ArticlesListUITableViewController: UITableViewController {

    private var articlesList: [Article] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        splitViewController?.delegate = self
        self.splitViewController?.preferredDisplayMode = UISplitViewControllerDisplayMode.allVisible

        let feedUrl = URL(string: "http://feeds.bbci.co.uk/news/rss.xml")
        let rssDataManager = RSSDataManager()
        rssDataManager.delegate = self
        rssDataManager.getRSSDataFromFeedURL(feedURL: feedUrl!)

        // Auto layout constraints for rows' height in table view.
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 80
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articlesList.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "idCell", for: indexPath) as UITableViewCell
        cell.textLabel?.text = articlesList[indexPath.row].title
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "showDetail", sender: nil)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            let cellIndex = self.tableView.indexPathForSelectedRow! as IndexPath
            let currentArticleViewController = segue.destination as! CurrentArticleUIViewController
            currentArticleViewController.articleURL = articlesList[cellIndex.row].url
        }
    }
}

// MARK: - UISplitViewControllerDelegate
extension ArticlesListUITableViewController: UISplitViewControllerDelegate {
    func splitViewController(_ splitViewController: UISplitViewController, collapseSecondary secondaryViewController: UIViewController, onto primaryViewController: UIViewController) -> Bool {
        return true
    }
}

// MARK: - RSSDataDelegate
extension ArticlesListUITableViewController: RSSDataManagerDelegate {

    func dataLoaded(articles: [Article]) {
        for article in articles {
            articlesList.append(article)
        }
        self.tableView.reloadData()
    }
}
