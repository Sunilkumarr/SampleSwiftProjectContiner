//
//  ViewController.swift
//  SampleSwiftProjectContiner
//
//  Created by apple on 08/03/21.
//

import UIKit
import Applozic

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func loginAndLaunch(_ sender: Any) {
        self.loginAndLaunch()
    }

    func loginAndLaunch()  {
        let alUser : ALUser =  ALUser()
        alUser.userId = "testing679"     // NOTE : +,*,? are not allowed chars in userId.
        alUser.displayName = "testing679"     // User's Display Name
        alUser.password = "testing679" //User password

        //Saving these details
        ALUserDefaultsHandler.setUserId(alUser.userId)
        ALUserDefaultsHandler.setEmailId(alUser.email)
        ALUserDefaultsHandler.setDisplayName(alUser.displayName)
        ALUserDefaultsHandler.setPassword(alUser.password)
        ALUserDefaultsHandler.setUserAuthenticationTypeId(Int16(APPLOZIC.rawValue))

        //Registering or Login in the User
        let chatManager = ALChatManager(applicationKey: "applozic-sample-app")
        chatManager.connectUserWithCompletion(alUser) { (response, error) in
            if (error == nil) {
                let continerViewController =  ContinerViewController();
                let nav = UINavigationController(rootViewController: continerViewController)
                nav.modalPresentationStyle = .fullScreen
                self.present(nav, animated: true)
                print("Error");
            } else {
                print("Login success")
            }
        }
    }

}

