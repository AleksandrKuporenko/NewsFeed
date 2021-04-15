//
//  ViewController.swift
//  NewsFeed
//
//  Created by Александр on 12.01.2021.
//

import UIKit

class AuthViewController: UIViewController {

    private  var authService: AuthServise!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
         
        loginButtom.layer.cornerRadius = 6
        
        authService = SceneDelegate.shared().authService
        
    }

    
    @IBOutlet weak var loginButtom: UIButton!
    
    
    @IBAction func signinTouch(_ sender: UIButton) {
        authService.wakeUpSession()
    }
    
    
}

