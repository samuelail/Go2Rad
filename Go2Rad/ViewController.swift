//
//  ViewController.swift
//  Go2Rad
//
//  Created by Sonar on 2/11/19.
//  Copyright © 2019 Sonar. All rights reserved.
//

import UIKit
import Firebase

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        animateLogo()
        
        // Automatically dismiss the view after 5 seconds
        
       
            if  let user = Auth.auth().currentUser {
                let homeVC =
                    self.storyboard?.instantiateViewController(withIdentifier: "tabBar") as! UITabBarController
                homeVC.modalTransitionStyle = .crossDissolve
                self.present(homeVC, animated: true, completion: nil)
            }
            else {
                 DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                let loginVC =
                    self.storyboard?.instantiateViewController(withIdentifier: "LoginVC")
                loginVC?.modalTransitionStyle = .crossDissolve
                self.present(loginVC!, animated: true, completion: nil)
            }
            }
        }
    
    
    
    
    func animateLogo() {
        UIView.animate(withDuration: 3) {
        //    self.teslaLogo.alpha = 1.0
            //self.view.layoutIfNeeded()
        }
        
    }


}

