//
//  LoginViewController.swift
//  Go2Rad
//
//  Created by Sonar on 2/11/19.
//  Copyright © 2019 Sonar. All rights reserved.
//

import UIKit
import Firebase
import PopupDialog

class LoginViewController: UIViewController {

    @IBOutlet weak var emailField: HoshiTextField!
    @IBOutlet weak var passwordField: HoshiTextField!
    @IBOutlet weak var loginBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        loginBtn.layer.cornerRadius = loginBtn.frame.height/2
    }
    
    @IBAction func handleLogin(_ sender: Any) {
        if emailField.text == "" || passwordField.text == "" {
            let title = "Error"
            let message = "Email or password field can not be empty"
            let popup = PopupDialog(title: title, message: message)
            let buttonOne = CancelButton(title: "CANCEL") {
                print("Alert dismissed")
            }
            popup.addButtons([buttonOne])
            self.present(popup, animated: true, completion: nil)
            print("Email or password field can not be empty")
        } else {
            //Handle login with firebase
            let email = emailField.text
            let pass = passwordField.text
            Auth.auth().signIn(withEmail: email!, password: pass!) { user, error in
                if error == nil {
                    self.dismiss(animated: true, completion: nil)
                }
                else {
                    let title = "Error"
                    let message = "Incorrect username or password"
                    let popup = PopupDialog(title: title, message: message)
                    let buttonOne = CancelButton(title: "CANCEL") {
                        print("Alert dismissed")
                    }
                    popup.addButtons([buttonOne])
                    self.present(popup, animated: true, completion: nil)
                    print("Error occured", error?.localizedDescription)
                }
            }
        }
    }
    
    
    //dismiss keyboard
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

}
