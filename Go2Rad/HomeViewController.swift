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
    
    let text = ["I need someone to help with my back", " I need a cardiologist in the D.C area", " I am looking got a nursing assistant to help my husband", "Any doctor in the baltimore area?"]
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
        return text.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard  let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as? CellData else { return UITableViewCell() }
        
       // cell.postTexts.text = post[indexPath.row].body
        cell.requestText.text = text[indexPath.row]
        //cell.bgView.layer.cornerRadius = 5
        //self.dataTableview.rowHeight = cell.bgView.frame.height
        return cell
    }

}
