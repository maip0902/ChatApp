//
//  TopViewController.swift
//  Chat
//
//  Created by 舞 on 2020/02/25.
//  Copyright © 2020 mai kanda. All rights reserved.
//

import UIKit
import FirebaseDatabase

class TpViewController: UIViewController {

    @IBOutlet weak var registerName: UITextField!
    @IBOutlet weak var registerAdress: UITextField!
    
    var ref: DatabaseReference!
    
    override func viewDidLoad() {
        ref = Database.database().reference()
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
//    @IBAction func register(_ sender: Any) {
////        var name = self.registerName
////        var mail = self.registerAdress
////        var userData = ["name": "name", "mail": "adress"]
//        self.ref.childByAutoId().setValue(["name": "name"])
//    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
