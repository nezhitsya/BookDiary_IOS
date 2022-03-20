//
//  ViewController.swift
//  Book
//
//  Created by 이다영 on 2022/02/17.
//

import UIKit
import Firebase

class ViewController: UIViewController {
    
    @IBOutlet var viewModel: LoginViewModel!
    
    var ref = Database.database().reference()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.login(completion: { (success) in
            if success {
                self.calendarView()
            } else {
//                self.calendarView()
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
