//
//  SingleMaltManager.swift
//  SingleMaltApp
//
//  Created by Brett Nitschke on 1/20/16.
//  Copyright © 2016 Brett Nitschke. All rights reserved.
//

import UIKit
import CoreData

class SingleMaltManager {
    
    //singleton - only one instance of class can exist
    static let sharedInstance = SingleMaltManager()
    
    var singleMalts = [SingleMalt]()
    let context: NSManagedObjectContext!
    
    var singleMaltIndex = 0   //index is set when user clicks on a tableview cell
    
    var count: Int {
        get {
            return singleMalts.count
        }
    }
    
    func setIndex(index: Int) {
        singleMaltIndex = index 
        
    }
    
    
    //used to feed into singleMaltAtIndex function
    func getIndex() -> Int {
        return singleMaltIndex 
    }
    
    func singleMaltAtIndex(index: Int) -> SingleMalt {
        
        return singleMalts[index]
        }
    
    
    
    //used when user enters a picture along with name
    func addNewSingleMalt(name: String, date: NSDate, image: UIImage){
            
            let singleMalt = NSEntityDescription.insertNewObjectForEntityForName("SingleMalt",
                inManagedObjectContext: context) as! SingleMalt
                singleMalt.name = name
                singleMalt.date = date.timeIntervalSince1970
                singleMalt.peat = false
        
        
        let imageData = NSData(data: UIImageJPEGRepresentation(image, 1.0)!)
        singleMalt.image = imageData
        
        singleMalts.append(singleMalt)
        saveContext()
        }
    
    //used when user does not upload a picture
    func addNewSingleMalt(name: String, date: NSDate){
        
        let singleMalt = NSEntityDescription.insertNewObjectForEntityForName("SingleMalt",
            inManagedObjectContext: context) as! SingleMalt
        singleMalt.name = name
        singleMalt.date = date.timeIntervalSince1970
        singleMalt.peat = false 
        
       
        
        singleMalts.append(singleMalt)
        saveContext()
    }

    
    
    
    
    func removeSingleMaltAtIndex(index: Int) {
        
        context.deleteObject(singleMaltAtIndex(index))
        singleMalts.removeAtIndex(index)
        saveContext()
        
    }
    
    func saveContext() {
        do {
            try context.save()
        } catch let error as NSError {
            print("Error Saving context: \(error), \(error.userInfo)")
        }
    }
    
    func fetchSingleMalts(){
        let fetchRequest = NSFetchRequest(entityName: "SingleMalt")
        
        do {
            let results = try context.executeFetchRequest(fetchRequest)
            singleMalts = results as! [SingleMalt]
        } catch let error as NSError {
            print("Could not fetch singleMalts: \(error), \(error.userInfo)")
        }
    }
    
    
    
    //Edit Single Malt functions
    
    func updateAge(index: Int, age: String) {
        let singleMalt = singleMaltAtIndex(index)
        singleMalt.age = age
        saveContext()
        }
    
    func updatePeat(index: Int, peat: Bool) {
        let singleMalt = singleMaltAtIndex(index)
        singleMalt.peat = peat
        saveContext()
    }
    
    func updatePrice(index: Int, price: String){
        let singleMalt = singleMaltAtIndex(index)
        singleMalt.price = price
        saveContext()
    }
    
    func updateScore(index: Int, score: String){
        let singleMalt = singleMaltAtIndex(index)
        singleMalt.score = score
        saveContext()
        
    }
    
    
    //grade is same as the score, only stored as an int rather than a string
    func updateGrade(index: Int, grade: Int32){
        let singleMalt = singleMaltAtIndex(index)
        singleMalt.grade = grade
        print(grade)
        saveContext()
        
    }

    
    func updatePhoto(index: Int, image: UIImage) {
        let singleMalt = singleMaltAtIndex(index)
        let imageData = NSData(data: UIImageJPEGRepresentation(image, 1.0)!)
        singleMalt.image = imageData
        saveContext()
        }
    
    
    
    //MARK: init
    private init() {
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        context = appDelegate.managedObjectContext
        fetchSingleMalts()
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}
