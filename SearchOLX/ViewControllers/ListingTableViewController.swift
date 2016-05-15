//
//  ListingTableViewController.swift
//  SearchOLX
//
//  Created by Javi on 5/12/16.
//  Copyright © 2016 FuzeIdea. All rights reserved.
//

import UIKit

class ListingTableViewController: UITableViewController, SearchLogic,SearchTableViewDelegate {

    var searchText: String?
    var results:Array<SearchResultItem> = Array<SearchResultItem>()
    
    var rowHeight:CGFloat = 310
    var dataHasBeenLoaded = false
    
    //MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = searchText
        
        self.tableView.allowsSelection = false
        self.tableView.sectionIndexBackgroundColor = self.tableView.backgroundColor
        self.tableView.registerNib(UINib(nibName: "SearchTableViewCell", bundle: nil), forCellReuseIdentifier: "SearchTableViewCell")
        

    }
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        self.title = searchText
        
        if !dataHasBeenLoaded {
            startSearch()
        }
        dataHasBeenLoaded = true
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - Functions
    func startSearch() {
        if let _ = searchText {
            searchItems(searchText!)
        }
        
    }
    
    //MARK: - SearchLogic
    func searchDidFinish(items: Array<SearchResultItem>) {
        results = items
        self.title =  "\(searchText!) (\(results.count))"
        tableView.reloadData()
    }
    
    //MARK: - SearchTableViewDelegate
    func buyItem(item: SearchResultItem) {
        print("buy \(item)")
    }
    
    func saveForLaterItem(item: SearchResultItem) {
        print("saveForLater \(item)")
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return results.count
    }
    
    override func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        let item = results[indexPath.row]
        let myCell = cell as! SearchTableViewCell

        myCell.itemLabel.text = item.title
        myCell.itemPrice.text = item.priceLabel
        
        myCell.item = item
        myCell.delegate = self
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW,0), {
            myCell.imagePreview.setImageURLToPreview(item.imageURL)
        })
        
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("SearchTableViewCell", forIndexPath: indexPath) as! SearchTableViewCell
        return cell
    }
    
    override func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return rowHeight
    }
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return rowHeight
    }
    
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
