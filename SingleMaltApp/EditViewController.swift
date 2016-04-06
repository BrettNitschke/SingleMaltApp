//
//  EditViewController.swift
//  SingleMaltApp
//
//  Created by Brett Nitschke on 1/22/16.
//  Copyright © 2016 Brett Nitschke. All rights reserved.
//

import UIKit

class EditViewController: UIViewController, UINavigationControllerDelegate, UITextFieldDelegate, UIImagePickerControllerDelegate {
    
    var grade: Int32 = 50
    var peatBool: Bool = false
    var image: UIImage!

    
    @IBOutlet weak var imageView: UIImageView!
   
    @IBOutlet weak var nameText: UILabel!
    
    @IBOutlet weak var peatSwitch: UISwitch!
    
    @IBOutlet weak var priceText: UITextField!
  
    @IBOutlet weak var ageText: UITextField!
    
    @IBOutlet weak var ratingSlider: UISlider!
    @IBAction func ratingSliderChanged(sender: UISlider) {
        
        let currentValue = Int(sender.value)
        
        grade = Int32(sender.value)
        scoreLabel.text = "\(currentValue)"
        
    }
    
    @IBAction func addPhotoTapped(sender: UIButton) {
        openPhotoAlert()
    }
    
    
    @IBOutlet weak var scoreLabel: UILabel!
    
    @IBOutlet weak var dateLabel: UILabel!
    
    //Save functions
    
    @IBAction func saveButtonTapped(sender: UIButton) {
        //only calls update functions if text is entered in the textfields
        if ageText.text != nil {
            SingleMaltManager.sharedInstance.updateAge(SingleMaltManager.sharedInstance.getIndex(), age: ageText.text!)
        }
        
        if priceText.text != nil {
            SingleMaltManager.sharedInstance.updatePrice(SingleMaltManager.sharedInstance.getIndex(), price: priceText.text!)
        }
        
        
        if peatSwitch.on {
            peatBool = true
        } else {
            peatBool = false
        }
        
        SingleMaltManager.sharedInstance.updatePeat(SingleMaltManager.sharedInstance.getIndex(), peat: peatBool)
        
        SingleMaltManager.sharedInstance.updateGrade(SingleMaltManager.sharedInstance.getIndex(), grade: grade)
        
        SingleMaltManager.sharedInstance.updateScore(SingleMaltManager.sharedInstance.getIndex(), score: scoreLabel.text!)
        
        if image != nil {
        SingleMaltManager.sharedInstance.updatePhoto(SingleMaltManager.sharedInstance.getIndex(), image: image)
        }
        
        
        
        self.navigationController?.popViewControllerAnimated(true)
        
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    override func touchesBegan(touches: Set<UITouch>,
        withEvent event: UIEvent?) {
            self.view.endEditing(true)
    }
    
    
    //Add Photo alert
    
    func openPhotoAlert() {
        //create alert controller
        let alert = UIAlertController(title: "Add Photo",
            message: "Take photo or choose from library",
            preferredStyle: UIAlertControllerStyle.Alert)
        
        //create cancel action
        let cancel = UIAlertAction(title: "Cancel",
            style: UIAlertActionStyle.Cancel,
            handler: nil)
        
        alert.addAction(cancel)
        
        let camera = UIAlertAction(title: "Camera",
            style: UIAlertActionStyle.Default) { (action: UIAlertAction) -> Void in
                let picker = UIImagePickerController()
                picker.delegate = self
                picker.sourceType = .Camera
                
                self.presentViewController(picker, animated: true, completion: nil)
        
    }
        alert.addAction(camera)
        
        
        //create photo library action
        let library = UIAlertAction(title: "Photo Library",
            style: UIAlertActionStyle.Default) { (action: UIAlertAction) -> Void in
                let picker = UIImagePickerController()
                picker.delegate = self
                picker.sourceType = .PhotoLibrary
                
                self.presentViewController(picker, animated: true, completion: nil)
                
            }
        
        alert.addAction(library)
        
        self.presentViewController(alert, animated: true, completion: nil)
        
        }
    
    
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        imageView.image = info[UIImagePickerControllerOriginalImage] as? UIImage; dismissViewControllerAnimated(true, completion: nil)
        
        image = imageView.image!
    }
    
    

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //loads appropriate single malt
        let thisSingleMalt = SingleMaltManager.sharedInstance.singleMaltAtIndex(SingleMaltManager.sharedInstance.getIndex())
        
        
        //sets name label
        nameText.text = thisSingleMalt.name
        
        if thisSingleMalt.image != nil {
            let image : UIImage = UIImage(data: thisSingleMalt.image!)!
            imageView.image = image
        }
        
       
        //if age is set, loads it to age text field
        if thisSingleMalt.age != nil {
            let age = thisSingleMalt.age
            ageText.text = age
            
        }
        
        //if price is set, loads into price text field
        if thisSingleMalt.price != nil {
            let price = thisSingleMalt.price
            priceText.text = price
        }
        
        
        //sets date label
        let formatter = NSDateFormatter()
        formatter.dateStyle = .FullStyle
        let date = NSDate(timeIntervalSince1970: thisSingleMalt.date)
        dateLabel.text = "Tasted:  \(formatter.stringFromDate(date))"
        
        
        //sets peat switch
        if thisSingleMalt.peat == true {
            peatSwitch.setOn(true, animated: true)
            
        } else {
            peatSwitch.setOn(false, animated: true)
        }
        
        if thisSingleMalt.score != nil {
            let score = Float(thisSingleMalt.score!)
            ratingSlider.value = score!
            scoreLabel.text = thisSingleMalt.score
        }
        
        grade = thisSingleMalt.grade
        
        ageText.delegate = self
        priceText.delegate = self
        
        

        // Do any additional setup after loading the view.
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
