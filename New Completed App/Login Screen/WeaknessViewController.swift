//
//  ViewController.swift
//  Weakness Analysis
//
//  Created by Kevon Rahimi on 29/03/2023.
//

import UIKit
var modules = [String:Int]()
var hours = Int()
class WeaknessViewController: UIViewController {
    var count = 0
    //Revision Hours-
    @IBOutlet weak var hoursText: UILabel!
    @IBOutlet weak var hoursButton: UIButton!
    @IBOutlet weak var hoursField: UITextField!
    
    //Module
    @IBOutlet weak var moduleField: UITextField!
    
    @IBOutlet weak var marksField: UITextField!
    
    @IBOutlet weak var moduletext: UILabel!
    
    @IBOutlet weak var marktext: UILabel!
    
    @IBOutlet weak var finishlabel: UILabel!
    
    //Buttons-
    @IBOutlet weak var label1: UILabel!
    
    @IBOutlet weak var label2: UILabel!
    
    
    
    
    
    @IBAction func newModuleButton(_ sender: Any)
    {
        if (moduleField.text == "")
        {
            moduletext.text = "Enter a module!"
        }
        if (marksField.text == "")
        {
            marktext.text = "Enter a percentage!"
        }
        var percent = Int(marksField.text!)
        if percent != nil
        {
            if (percent!>100 || percent!<0)
            {
                marktext.text = "Enter a percentage between 0-100!"
            }
            else
            {
                moduletext.text = ""
                marktext.text = ""
                
                modules[moduleField.text!] = Int(marksField.text!)
                marksField.text = ""
                moduleField.text = ""
                count+=1
                label2.text = String(count)
            }
        }
        else{
            marktext.text = "Enter a number!"
        }
        
    }
    
    @IBAction func finishButton(_ sender: Any)
    {
        if (hoursField.text == "")
        {
            finishlabel.text = "Enter the number of revision hours"
        }
        if (modules.count == 0)
        { moduletext.text = "Enter a module!" }
        if (Int(hoursField.text!) != nil)
        {
            finishlabel.text = ""
            hours = Int(hoursField.text!) ?? 0
            performSegue(withIdentifier: "toDetail", sender: nil)
        }
        else
        {   finishlabel.text = "Invalid entry"}
    }
    
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
    }
}

