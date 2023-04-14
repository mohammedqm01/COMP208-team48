//
//  SecondViewController.swift
//  Login Screen
//
//  Created by Shoog Alowaifeer on 4/2/23.
//

import UIKit

class SecondViewController: UIViewController {

    @IBOutlet weak var labelUsername: UILabel!
    var textUsername = ""
    
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.isHidden = true
        self.labelUsername.text = self.textUsername
 //       self.labelUsername.text = "Second View Controller"

        
    }
    

}
