//
//  LogInViewController.swift
//  Chat
//
//  Created by Pavel Shymanski on 17.05.23.
//

import UIKit
import FirebaseFirestore
import FirebaseAuth

class SignInViewController: UIViewController {
    
    @IBOutlet weak var emailTextFoeld: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    @IBAction func signInButtonPressed(_ sender: UIButton) {
        
        if let email = emailTextFoeld.text,
           let password = passwordTextField.text {
            Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
                if let error = error as NSError? {
                    print("Error code: \(error.code)")
                    print("Error description: \(error.localizedDescription)")
                }else{
                    let vc = ChatViewController(nibName: "ChatViewController", bundle: nil)
                    self?.navigationController?.pushViewController(vc, animated: true)
                    
                }
            }
        }
    }
}
     
