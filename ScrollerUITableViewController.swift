//
//  ScrollerUITableViewController.swift
//  RSSScroller
//
//  Created by admin on 10/11/17.
//  Copyright © 2017 admin. All rights reserved.
//

import UIKit

class ScrollerUITableViewController: UITableViewController, anXMLParserDelegate {

    var xmlParser: ScrollerXMLParser!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem

        let url = URL(string: "http://feeds.bbci.co.uk/news/rss.xml")
        xmlParser = ScrollerXMLParser()
        xmlParser.delegate = self
        xmlParser.startParsingContentFromURL(rssURL: url!)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return xmlParser.arrParsedData.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "idCell", for: indexPath) as UITableViewCell

        let currentDictionary = xmlParser.arrParsedData[indexPath.row] as Dictionary<String, String>
        cell.textLabel?.text = currentDictionary["title"]

        return cell
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let dictionary = xmlParser.arrParsedData[indexPath.row] as Dictionary<String, String>
        let topicLink = dictionary["link"]
        let publishDate = dictionary["pubDate"]

        let scrollerUIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "idScrollerUIViewController") as! ScrollerUIViewController
        scrollerUIViewController.articleURL = URL(string: topicLink!)
        scrollerUIViewController.publishDate = publishDate
        showDetailViewController(scrollerUIViewController, sender: self)
    }


    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    func parsingWasFinished() {
        self.tableView.reloadData()
    }

}
