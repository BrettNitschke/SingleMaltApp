//
//  ViewController.swift
//  SingleMaltApp
//
//  Created by Brett Nitschke on 1/20/16.
//  Copyright © 2016 Brett Nitschke. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    //MARK: IBOutlets
    @IBOutlet weak var tableView: UITableView!

    //MARK: Tableview datasource methods
    
    
    func tableView(tableview: UITableView,
        numberOfRowsInSection section: Int) -> Int {
        
        return SingleMaltManager.sharedInstance.count
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView,
        cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
            let cell = tableView.dequeueReusableCellWithIdentifier("cell")!
            
            let singleMalt = SingleMaltManager.sharedInstance.singleMaltAtIndex(indexPath.row)
            cell.textLabel!.text = singleMalt.name
            
            let formatter = NSDateFormatter()
            formatter.dateStyle = .FullStyle
            let date = NSDate(timeIntervalSince1970: singleMalt.date)
            cell.detailTextLabel?.text = formatter.stringFromDate(date)
            
            
            //this code is an alternate version which displays the image from core data rather than a grade
            /*if singleMalt.image != nil {
            let image : UIImage = UIImage(data: singleMalt.image!)!
            
                cell.imageView!.image = image
            
            } else {
                let addPhoto = UIImage(named: "addphoto")
                cell.imageView!.image = addPhoto
                
            }*/
            
            let image: UIImage = getLetterGradeImage(singleMalt.grade)
            cell.imageView!.image = image
            
            
            
            
            return cell
            
            
            
            
    }
    
    
    //assigns appropriate letter grade image based on score 
    func getLetterGradeImage(grade: Int32) -> UIImage {
        let letterGrade = grade
        if letterGrade >= 95 {
            return UIImage(named: "A+")!
        } else if letterGrade >= 90 && letterGrade < 95 {
            return UIImage(named: "A")!
        } else if letterGrade >= 85 && letterGrade < 90 {
            return UIImage(named: "B+")!
        } else if letterGrade >= 80 && letterGrade < 85 {
            return UIImage(named: "B")!
        } else if letterGrade >= 75 && letterGrade < 80 {
            return UIImage(named: "C+")!
        } else if letterGrade >= 70 && letterGrade < 75 {
            return UIImage(named: "C")!
        } else if letterGrade >= 60 && letterGrade < 70 {
            return UIImage(named: "D")!
        } else {
            
            return UIImage(named: "F")!
        }


}
    
    
       
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let index = indexPath.row
        SingleMaltManager.sharedInstance.setIndex(index)
        print(SingleMaltManager.sharedInstance.getIndex())
        
    }
    

    
    //MARK: Tableview delegate methods
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    
    func tableView(tableView: UITableView,
        commitEditingStyle editingStyle: UITableViewCellEditingStyle,
        forRowAtIndexPath indexPath: NSIndexPath) {
            if editingStyle == .Delete {
                SingleMaltManager.sharedInstance.removeSingleMaltAtIndex(indexPath.row)
                tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Left)
            }
    }
    
    //MARK: View lifecycle methods
    
    override func viewWillAppear(animated: Bool) {
        tableView.reloadData()
    }
    
    
    
    
    
    
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

