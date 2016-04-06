//
//  AddSingleMaltViewController.swift
//  SingleMaltApp
//
//  Created by Brett Nitschke on 1/20/16.
//  Copyright © 2016 Brett Nitschke. All rights reserved.
//

import UIKit

class AddSingleMaltViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    //MARK:  IBOutlet

    @IBOutlet weak var nameText: UITextField!
        
    @IBOutlet weak var dateText: UITextField!
    
    var date: NSDate!
    
   var image: UIImage!
    
    
   
    
    
    
    @IBAction func saveButtonTapped(sender: UIButton) {
        if image != nil{
            image = imageView.image!
        
        SingleMaltManager.sharedInstance.addNewSingleMalt(nameText.text!, date: date, image: image)
        } else {
            SingleMaltManager.sharedInstance.addNewSingleMalt(nameText.text!, date: date)
        
        }
        
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    @IBAction func cancelButtonTapped(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    @IBAction func photoButtonTapped(sender: UIButton) {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .Camera
        
        presentViewController(picker, animated: true, completion: nil)
    }
    
    @IBAction func libraryButtonTapped(sender: UIButton) {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .PhotoLibrary
        
        presentViewController(picker, animated: true, completion: nil)
        
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        imageView.image = info[UIImagePickerControllerOriginalImage] as? UIImage; dismissViewControllerAnimated(true, completion: nil)
        
        image = imageView.image!
    }

    
    @IBOutlet weak var imageView: UIImageView!
    
    
    
       
    //MARK: Text Field Delegate
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
        
    }
    
    func textFieldDidBeginEditing(textField: UITextField) {
        if textField == dateText {
        let datePicker = UIDatePicker()
        textField.inputView = datePicker
        datePicker.addTarget(self, action: "datePickerChanged:", forControlEvents: .ValueChanged)
        }
    }
    
    func datePickerChanged(sender: UIDatePicker) {
       displayDate(sender.date)
    }
    
    func displayDate(date: NSDate) {
        let formatter = NSDateFormatter()
        formatter.dateStyle = .FullStyle
        dateText.text = formatter.stringFromDate(date)
        self.date = date
    }
    
    //MARK: Touch events
    override func touchesBegan(touches: Set<UITouch>,
        withEvent event: UIEvent?) {
            self.view.endEditing(true)
    }

    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        date = NSDate()
        displayDate(date)
    }

    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameText.delegate = self
        dateText.delegate = self
        
        date = NSDate()
        
        
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
        //number of columns of data in picker
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
