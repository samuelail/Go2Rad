//
//  HomeViewController.swift
//  Go2Rad
//
//  Created by Sonar on 2/11/19.
//  Copyright © 2019 Sonar. All rights reserved.
//

import UIKit
import Firebase

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    

    @IBOutlet weak var dataTableview: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func handleLogout(_ sender: Any) {
        //logout
        try! Auth.auth().signOut()
        self.dismiss(animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard  let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as? CellData else { return UITableViewCell() }
        
       // cell.postTexts.text = post[indexPath.row].body
        //cell.userImg.layer.cornerRadius = cell.userImg.frame.height/2
        return cell
    }

}
