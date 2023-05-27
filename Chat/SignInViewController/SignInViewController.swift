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
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var emailTextFoeld: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicator.isHidden = true
    }
    
    
    @IBAction func signInButtonPressed(_ sender: UIButton) {
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
        
        if let email = emailTextFoeld.text,
           let password = passwordTextField.text {
            Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
                if let error = error as NSError? {
                    print("Error code: \(error.code)")
                    print("Error description: \(error.localizedDescription)")
                }else{
                    self?.activityIndicator.stopAnimating()
                    let vc  = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ChatViewController") as! ChatViewController
                    self?.navigationController?.pushViewController(vc, animated: true)
                    
                }
            }
        }
    }
    
}
