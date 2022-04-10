//
//  CalendarViewController.swift
//  Book
//
//  Created by 이다영 on 2021/12/09.
//

import UIKit

class CalendarViewController: UIViewController {
    
    @IBOutlet var viewModel: CalendarViewModel!
    @IBOutlet weak var calendar: UICollectionView!
    @IBOutlet weak var yearMonthLabel: UILabel!
    
    let now = Date()
    var cal = Calendar.current
    let dateFormatter = DateFormatter()
    var components = DateComponents()
    var weeks: [String] = ["일", "월", "화", "수", "목", "금", "토"]
    var days: [String] = []
    var daysCountInMonth = 0 // 해당 월이 며칠까지 있는 지
    var weekdayStart = 0 // 시작일
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.calendar.delegate = self
        self.calendar.dataSource = self
        self.calendar.register(UINib(nibName: "CalendarCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "calendarCell")
        
        dateFormatter.dateFormat = "yyyy.MM"
        components.year = cal.component(.year, from: now)
        components.month = cal.component(.month, from: now)
        components.day = 1
        
        viewModel.loadingStarted = { [weak self] in
        }
        
        viewModel.loadingEnded = { [weak self] in
        }
        
        viewModel.diaryListUpdated = { [weak self] in
            DispatchQueue.main.async {
                self?.calendar.reloadData()
            }
        }
        
        viewModel.list()
        
        self.calendar.reloadData()
        self.calculation()
    }


    private func calculation() {
        let firstDayOfMonth = cal.date(from: components)
        let firstWeekday = cal.component(.weekday, from: firstDayOfMonth!) // 1은 일요일, 7은 토요일
        
        daysCountInMonth = cal.range(of: .day, in: .month, for: firstDayOfMonth!)!.count
        weekdayStart = 2 - firstWeekday
        
        self.yearMonthLabel.text = dateFormatter.string(from: firstDayOfMonth!)
        self.days.removeAll()
        
        for day in weekdayStart...daysCountInMonth {
            if day < 1 {
                self.days.append("")
            } else {
                self.days.append(String(day))
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "search" {
            if let cell = sender as? CalendarCollectionViewCell,
               let indexPath = calendar?.indexPath(for: cell),
               let search = segue.destination as? SearchViewController {
                search.date = days[indexPath.row]
            }
        }
    }
    
    @IBAction func didTapPrevButton(_ sender: UIButton) {
        components.month = components.month! - 1
        
        self.calculation()
        self.calendar.reloadData()
    }
    
    @IBAction func didTapNextButton(_ sender: UIButton) {
        components.month = components.month! + 1
        
        self.calculation()
        self.calendar.reloadData()
    }
}

extension CalendarViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        switch section {
//        case 0:
//            return 7
//        default:
//            return self.days.count
//        }
        return self.days.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = calendar.dequeueReusableCell(withReuseIdentifier: "calendarCell", for: indexPath) as! CalendarCollectionViewCell
        
        // 요일 별 색 지정
//        switch indexPath.section {
//        case 0:
//            cell.dateLabel.text = weeks[indexPath.row] // 요일
//        default:
//            cell.dateLabel.text = days[indexPath.row]
//        }
        
//        if indexPath.row % 7 == 0{ // 일요일
//            cell.dateLabel.textColor = .green
//        } else if indexPath.row % 7 == 6 { // 토요일
//            cell.dateLabel.textColor = .blue
//        } else { //평일
//            cell.dateLabel.textColor = .black
//        }
        
        cell.dateText(text: days[indexPath.row])
        cell.setImage(diary: viewModel.diaryList, year: components.year!, month: components.month!, day: cell.dateLabel.text ?? "")
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        UserDefaults.standard.set(components.year!, forKey: "year")
        UserDefaults.standard.set(components.month!, forKey: "month")
        UserDefaults.standard.set(Int(days[indexPath.row])!, forKey: "day")

        performSegue(withIdentifier: "search", sender: nil)
    }
    
}

extension CalendarViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard let flowLayout = collectionViewLayout as? UICollectionViewFlowLayout else { return CGSize() }
        let numberOfCells: CGFloat = 7
        let cellWidth: CGFloat = calendar.frame.size.width - (flowLayout.minimumInteritemSpacing * (numberOfCells - 1))
        let cellHeight: CGFloat = calendar.frame.size.height - (flowLayout.minimumInteritemSpacing * 5)
        
        return CGSize(width: cellWidth / numberOfCells, height: cellHeight / 6)
    }
    
}
