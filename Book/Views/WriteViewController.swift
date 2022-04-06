//
//  WriteViewController.swift
//  Book
//
//  Created by 이다영 on 2022/02/27.
//

import UIKit

class WriteViewController: UIViewController {
    
    @IBOutlet var viewModel: WriteViewModel!
    @IBOutlet var saveBtn: UIButton!
    @IBOutlet var cancelBtn: UIButton!
    @IBOutlet var descTextView: UITextView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var coverImage: UIImageView!
    @IBOutlet var datePicker: UIDatePicker!
    @IBOutlet var start1: UIButton!
    @IBOutlet var start2: UIButton!
    @IBOutlet var start3: UIButton!
    
    var yearData: Int = 0
    var monthData: Int = 0
    var dayData: Int = 0
    var imageData: String = ""
    var starScore: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.descTextView.delegate = self
        
        self.descTextView.textColor = UIColor.lightGray
        self.yearData = UserDefaults.standard.value(forKey: "year") as! Int
        self.monthData = UserDefaults.standard.value(forKey: "month") as! Int
        self.dayData = UserDefaults.standard.value(forKey: "day") as! Int
        
        let calendar: NSCalendar = NSCalendar.current as NSCalendar
        var components = calendar.components([NSCalendar.Unit.year, NSCalendar.Unit.month, NSCalendar.Unit.day], from: NSDate() as Date)
        components.year = yearData
        components.month = monthData
        components.day = dayData
        self.datePicker.setDate(calendar.date(from: components)!, animated: true)
        
        NotificationCenter.default.addObserver(self, selector: #selector(booknotificationReceived(_:)), name: .bookInfo, object: nil)
    }
    
    @objc func booknotificationReceived(_ notification: Notification) {
        guard let notificationUserInfo = notification.userInfo as? [String: String] else { return }
        
        TextConverter.loadText(text: notificationUserInfo["title"]!) { bookTitle in
            self.viewModel.title = bookTitle!.string
            self.titleLabel.attributedText = bookTitle
            self.titleLabel.font = .boldSystemFont(ofSize: 25)
            self.titleLabel.textAlignment = .center
            self.titleLabel.adjustsFontSizeToFitWidth = true
        }
        
        let data: Data = try! Data(contentsOf: URL(string: notificationUserInfo["image"]!)!)
        self.coverImage.image = UIImage(data: data)
        self.imageData = notificationUserInfo["image"]!
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    @IBAction func saveClicked(_ sender: UIButton) {
        self.viewModel.write(image: imageData, desc: descTextView.text, year: yearData, month: monthData, day: dayData, score: starScore)
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func cancelClicked(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func didTapOne(_ sender: UIImageView) {
        self.start1.setImage(UIImage(systemName: "star.fill"), for: .normal)
        self.start1.tintColor = UIColor.orange
        
        self.start2.setImage(UIImage(systemName: "star"), for: .normal)
        self.start2.tintColor = UIColor.secondaryLabel
        
        self.start3.setImage(UIImage(systemName: "star"), for: .normal)
        self.start3.tintColor = UIColor.secondaryLabel
        
        self.starScore = 1
    }
    
    @IBAction func didTapTwo(_ sender: UIImageView) {
        self.start1.setImage(UIImage(systemName: "star.fill"), for: .normal)
        self.start1.tintColor = UIColor.orange
        
        self.start2.setImage(UIImage(systemName: "star.fill"), for: .normal)
        self.start2.tintColor = UIColor.orange
        
        self.start3.setImage(UIImage(systemName: "star"), for: .normal)
        self.start3.tintColor = UIColor.secondaryLabel
        
        self.starScore = 2
    }
    
    @IBAction func didTapThree(_ sender: UIImageView) {
        self.start1.setImage(UIImage(systemName: "star.fill"), for: .normal)
        self.start1.tintColor = UIColor.orange
        
        self.start2.setImage(UIImage(systemName: "star.fill"), for: .normal)
        self.start2.tintColor = UIColor.orange
        
        self.start3.setImage(UIImage(systemName: "star.fill"), for: .normal)
        self.start3.tintColor = UIColor.orange
        
        self.starScore = 3
    }

}

extension WriteViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if(descTextView.textColor == UIColor.lightGray) {
            descTextView.text = ""
            descTextView.textColor = UIColor.black
        }
    }
}
