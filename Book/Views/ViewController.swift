//
//  ViewController.swift
//  Book
//
//  Created by 이다영 on 2022/02/17.
//

import UIKit
import Firebase

class ViewController: UIViewController {
    
    var ref = Database.database().reference()

    override func viewDidLoad() {
        super.viewDidLoad()

        Auth.auth().signInAnonymously(completion: { (user, error) in
            if (error == nil) {
                self.ref.child("Users").child((user?.user.uid)!).child("uid").observeSingleEvent(of: DataEventType.value, with: { (snapshot: DataSnapshot) in
                    if (snapshot.exists()) {
                        self.ref.child("Users").child((user?.user.uid)!).child("uid").setValue((user?.user.uid)!)
                        self.calendarView()
                    } else {
                        self.calendarView()
                    }
                })
            }
        })
    }
    
    private func calendarView() {
        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let calendarViewController: UIViewController = mainStoryboard.instantiateViewController(withIdentifier: "Calendar")
        
        calendarViewController.modalPresentationStyle = .fullScreen
        self.present(calendarViewController, animated: true, completion: nil)
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
