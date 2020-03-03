//
//  FirstViewController.swift
//  Chat
//
//  Created by 舞 on 2020/02/25.
//  Copyright © 2020 mai kanda. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth

class FirstViewController: UIViewController {

    @IBOutlet weak var registerMail: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var errorMessage: UITextView!
    var ref: DatabaseReference!
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func register(_ sender: Any) {
        let mail = self.registerMail.text
        let password = self.password.text
    
        Auth.auth().createUser(withEmail: mail!, password: password!) { (result, error) in
            if error == nil {
                print("created")
                Auth.auth().signIn(withEmail: mail!, password: password!) { [weak self] authResult, error in
                    if let error = error {
                        print("error")
                    }
                self?.performSegue(withIdentifier : "profileRegister", sender: self)
                    
                }
            } else {
                if let errCode = AuthErrorCode(rawValue: error!._code) {
                    switch errCode {
                    case .invalidEmail:
                        self.errorMessage.text = "メールアドレスの形式が違います"
                    case .emailAlreadyInUse:
                        self.errorMessage.text = "すでに使用されていますアドレスです"
                    case .weakPassword:
                        self.errorMessage.text = "パスワードは6文字以上で入力してください"
                    default:
                        self.errorMessage.text = "エラーです"
                    }
                }
            }
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
