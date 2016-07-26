//
//  ViewController.swift
//  CollegeProfileBuilder
//
//  Created by Diva Harsoor on 7/25/16.
//  Copyright © 2016 Mobile Makers. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var editButton: UIBarButtonItem!
    var colleges : [College] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        editButton.tag = 0
        colleges.append(College(name: "University of Salamanca", location: "Spain", enrollment: 32000, website: "http://www0.usal.es/webusal/en", image: UIImage(named: "Salamanca")!))
        colleges.append(College(name: "Al-Azhar University", location: "Egypt", enrollment: 45000, website: "http://www.azhar.edu.eg/En/u.htm", image: UIImage(named: "Al-Azhar")!))
        colleges.append(College(name: "University of Padua", location: "Italy", enrollment: 63000, website: "http://www.unipd.it/en/", image: UIImage(named: "Padua")!))
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return colleges.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath)
        cell.textLabel?.text = colleges[indexPath.row].name
        return cell
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            colleges.removeAtIndex(indexPath.row)
            tableView.reloadData()
        }
    }
    @IBAction func onTappedPlusButton(sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "Add City", message: nil, preferredStyle: .Alert)
        alert.addTextFieldWithConfigurationHandler { (textField) in
            textField.placeholder = "Add City Here"
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel, handler: nil)
        alert.addAction(cancelAction)
        let addAction = UIAlertAction(title: "Add", style: .Default) { (action) in
            let collegeTextField = alert.textFields![0] as UITextField
            self.colleges.append(College(name: collegeTextField.text!))
            self.tableView.reloadData()
        }
        alert.addAction(addAction)
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    func tableView(tableView: UITableView, moveRowAtIndexPath sourceIndexPath: NSIndexPath, toIndexPath destinationIndexPath: NSIndexPath) {
        let college = colleges[sourceIndexPath.row]
        colleges.removeAtIndex(sourceIndexPath.row)
        colleges.insert(college, atIndex: destinationIndexPath.row)
    }
    
    @IBAction func onTappedEditButton(sender: UIBarButtonItem) {
        if sender.tag == 0 {
            tableView.editing = true
            sender.tag = 1
        }
        else {
            tableView.editing = false
            sender.tag = 0
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let dvc = segue.destinationViewController as! DetailViewController
        let index = tableView.indexPathForSelectedRow?.row
        dvc.college = colleges[index!]
    }
}

