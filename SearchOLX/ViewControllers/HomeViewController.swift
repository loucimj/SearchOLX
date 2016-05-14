//
//  HomeViewController.swift
//  SearchOLX
//
//  Created by Javi on 5/12/16.
//  Copyright © 2016 FuzeIdea. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController,UITextFieldDelegate {

    @IBOutlet weak var arrowImageView: UIImageView!
    @IBOutlet weak var searchView: UIView!
    @IBOutlet weak var searchField: UITextField!
    
    //MARK: - View LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchField.delegate = self
        self.title = "OLX"
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(search))
        arrowImageView.userInteractionEnabled = true
        arrowImageView.addGestureRecognizer(gesture)
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.setupKeyboardNotifcationListener()
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        self.removeKeyboardNotificationListeners()
    }
    
    //MARK: - Keyboard
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        search()
        return true
    }
    
    //MARK: - Functions
    
    func verifyData() -> Bool {
        if searchField.text?.trim() != "" {
            return true
        }
        return false
    }
    
    @objc func search() {
        if verifyData() {
            performSegueWithIdentifier("showSearch", sender: self)
        } else {
            searchView.shakeAndVibrate()
        }
    }
    
    //MARK: - Navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let vc = segue.destinationViewController as! ListingTableViewController
        vc.searchText = searchField.text?.trim()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
