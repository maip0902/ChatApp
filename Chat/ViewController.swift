//
//  ViewController.swift
//  Chat
//
//  Created by 舞 on 2020/02/21.
//  Copyright © 2020 mai kanda. All rights reserved.
//

import UIKit
import FirebaseDatabase

class ViewController: UIViewController {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var messageTextField: UITextField!
    @IBOutlet weak var textView: UITextView!
    
    var ref: DatabaseReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()
        self.ref.observe(DataEventType.childAdded, with: { (snapshot) in
          let postDict = snapshot.value as? [String : AnyObject] ?? [:]
            if let name = postDict["name"] as? String, let message = postDict["message"] as? String {
                let text = self.textView.text
                let add = name + ":" + message
                self.textView.text = (text ?? "") + "\n" + add
            }
        })
        // Do any additional setup after loading the view.
    }

    @IBAction func didTapSendButton(_ sender: Any) {
        if let name = nameTextField.text, let message = messageTextField.text {
            let messageData = [
                "name": name,
                "message" : message
            ]
            self.ref.childByAutoId().setValue(messageData)
        }
    }
    
}

