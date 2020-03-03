//
//  UserProfileRegisterViewController.swift
//  Chat
//
//  Created by 舞 on 2020/02/28.
//  Copyright © 2020 mai kanda. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class UserProfileRegisterViewController: UIViewController {

    @IBOutlet weak var birthday: UIDatePicker!
    @IBOutlet weak var displayName: UITextField!
    @IBOutlet weak var registerBirth: UITextField!
    var ref : DatabaseReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()
        birthday.datePickerMode = UIDatePicker.Mode.date
        registerBirth.inputView = birthday
    }
    
    // ボタン押すとてtextFieldに日付が入る
    @IBAction func decide(_ sender: Any) {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy年MM月dd日"
        registerBirth.text = formatter.string(from: birthday.date)
    }
    
    // 登録ボタン押したときの処理
    @IBAction func profileRegister(_ sender: Any) {
        let displayName = self.displayName.text
        let birth = self.registerBirth.text
        let user = Auth.auth().currentUser
        let uid = user?.uid
        let userProfile = [
            "displayName": displayName!,
            "birthday" : birth!
        ]
        self.ref.child("users").child(uid!).setValue(userProfile)
        self.performSegue(withIdentifier: "firstLogin", sender: self)
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
