//
//  LoginViewController.swift
//  Chat
//
//  Created by 舞 on 2020/02/28.
//  Copyright © 2020 mai kanda. All rights reserved.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {

    @IBOutlet weak var loginMail: UITextField!
    @IBOutlet weak var password: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func loginButton(_ sender: Any) {
        let email = self.loginMail.text
        let password = self.password.text
        Auth.auth().signIn(withEmail: email!, password: password!) { [weak self] authResult, error in
            if let error = error {
                print("error")
            } else {
                print("login")
                self?.performSegue(withIdentifier : "mypage", sender: self)
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
