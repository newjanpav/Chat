//
//  ChatViewController.swift
//  Chat
//
//  Created by Pavel Shymanski on 17.05.23.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore


class ChatViewController: UIViewController {
    
    var fireStoreCollectionName = "message"
    var senderField = "sender"
    var bodyField = "body"
    var messages = [Message]()
  
    
    
    @IBOutlet weak var chatTableView: UITableView!
    @IBOutlet weak var messageTextField: UITextField!
    
    let db = Firestore.firestore()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Chat"
        navigationItem.hidesBackButton = true
        chatTableView.dataSource = self
        chatTableView.delegate = self
        chatTableView.register(UINib.init(nibName: "TableViewCell", bundle: nil),
                               forCellReuseIdentifier: "Message")
        loadMessages()
        
    }
    
    @IBAction func logOutButtonPressed(_ sender: UIButton) {
        
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
            navigationController?.popToRootViewController(animated: true)
        } catch let signOutError as NSError {
            print("Error signing out: %@", signOutError)
        }
    }
    
    
    @IBAction func sendMessagebuttonPressed(_ sender: UIButton) {
        
        if let message = messageTextField.text,
           let messageSender = Auth.auth().currentUser?.email {
            db.collection(fireStoreCollectionName).addDocument(data: [senderField : messageSender,
                                                                         bodyField:message ])
            { error in
                if let e = error {
                    print("There was an issue saving data to firestore,\(e)")
                }else{
                    print("success")
                }
            }
        }
    }
    
    func loadMessages(){
      
        db.collection(fireStoreCollectionName).addSnapshotListener { querySnapshot, error in
            self.messages = []
            
            if let e = error {
                print("There was an issue retrieving data from Firestore.\(e)")
            }else{
                if let snapShotDocuments = querySnapshot?.documents {
                    for doc in snapShotDocuments {
                       let data = doc.data()
                        if let messageSender = data[self.senderField] as? String, let messageBody = data[self.bodyField] as? String {
                            let safeMessage = Message(sender: messageSender, body: messageBody)
                            self.messages.append(safeMessage)
                            
                            
                            DispatchQueue.main.async {
                                self.chatTableView.reloadData()
                            }
                        }
                    }
                }
            }
        }
    }
}

extension ChatViewController: UITableViewDataSource,
                              UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = chatTableView.dequeueReusableCell(withIdentifier: "Message", for: indexPath) as! TableViewCell
        cell.labelMessage.text = messages[indexPath.row].body
        return cell
    }
    
    //    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    //        <#code#>
    //    }
}
