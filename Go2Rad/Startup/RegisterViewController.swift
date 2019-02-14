//
//  RegisterViewController.swift
//  Go2Rad
//
//  Created by Sonar on 2/11/19.
//  Copyright © 2019 Sonar. All rights reserved.
//

import UIKit
import Firebase
import PopupDialog

class RegisterViewController: UIViewController {

    @IBOutlet var workerSwitch: UISwitch!
    @IBOutlet var fullName: HoshiTextField!
    @IBOutlet var emailField: HoshiTextField!
    @IBOutlet var phoneNumber: HoshiTextField!
    @IBOutlet var passwordField: HoshiTextField!
    @IBOutlet var registerBtn: UIButton!
    
    var ref: DatabaseReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // create a database reference
        ref = Database.database().reference()
        
        
        //Listen for keyboard events
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
        
        //set view frame to 0 by default
        self.view.frame.origin.y = 0
        
        
        // check for app state
        let state = UIApplication.shared.applicationState
        if state == .active {
            // do something
        }
    }
    
    //STOP LISTENING
    deinit {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
    }
    
    @IBAction func registerAction(_ sender: Any) {
        if fullName.text == "" || emailField.text == "" || phoneNumber.text == "" || passwordField.text == "" {
            let title = "Error"
            let message = "Please ensure that all fields are filled!"
            let popup = PopupDialog(title: title, message: message)
            let buttonOne = CancelButton(title: "CANCEL") {
                print("Alert dismissed")
            }
            popup.addButtons([buttonOne])
            self.present(popup, animated: true, completion: nil)
            print("No field may be empty")
        } else {
            guard let username = fullName.text else { return }
            guard let email = emailField.text else { return }
            guard let phonenumber = phoneNumber.text else { return }
            guard let password = passwordField.text else { return }
            
            Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                
                if error == nil {
                    print ("user created")
                    
                   guard let user = authResult?.user else { return }
                    
                    self.ref.child("users").child(user.uid).setValue(["Fullname": username, "Email": email, "PhoneNumber": phonenumber])
                    
                    let ChangeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
                    ChangeRequest?.displayName = username
                    ChangeRequest?.commitChanges { error in
                        if error == nil {
                            print ("Username Created")
                            let loginVC =
                                self.storyboard?.instantiateViewController(withIdentifier: "InitialVC")
                            loginVC?.modalTransitionStyle = .crossDissolve
                            self.present(loginVC!, animated: true, completion: nil)
                        }
                        else {
                            //Incase of crash change ! to ?
                            print ("Error creating username", error!.localizedDescription)
                        }
                    }
                }
                else {
                    //Incase of crash, change ! to ?
                    print (error!.localizedDescription)
                }
            }
        }
    }
  
    
    //dismiss keyboard
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
        UIView.animate(withDuration: 0.2) {
            self.view.layoutIfNeeded()
            self.view.frame.origin.y = 0
        }
    }
    
    //remove the status bar
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    
    //Move the view when the keyboard appears
    @objc func keyboardWillChange(notification: Notification) {
        //   print("\(notification.name.rawValue)")
        guard let KeyboardHeight = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
            return
        }
        view.frame.origin.y = -KeyboardHeight.height+20
    }

}
