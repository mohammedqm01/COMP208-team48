//
//  ViewController.swift
//  Login Screen
//
//  Created by Shoog Alowaifeer on 4/2/23.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var textFieldUsername: UITextField!
    
    
    @IBOutlet weak var textFieldPassword: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textFieldUsername.delegate = self
        textFieldPassword.delegate = self
        
        self.navigationController?.navigationBar.isHidden = true
        
    }
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        self.textFieldUsername.resignFirstResponder()
        self.textFieldPassword.resignFirstResponder()
        return true
    }
    
    @IBAction func buttonSignInTapped(_ sender: Any) {
        if let textUsername = self.textFieldUsername.text, textUsername.isEmpty {
            return
        } else if let textPassword = self.textFieldPassword.text, textPassword.isEmpty {
            return
        }
        let textUsername = self.textFieldUsername.text
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let viewcontroller = storyboard.instantiateViewController(withIdentifier: "SecondViewController") as? SecondViewController{
            viewcontroller.textUsername = textUsername ?? ""
            self.navigationController?.pushViewController(viewcontroller, animated: false)
        }
        
        
    }
    
}
