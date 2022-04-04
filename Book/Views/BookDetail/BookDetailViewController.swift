//
//  DetailViewController.swift
//  Book
//
//  Created by 이다영 on 2021/12/24.
//

import UIKit

class BookDetailViewController: UIViewController {
    
    @IBOutlet var viewModel: BookDetailViewModel!
    
    private var inputTopPadding: NSLayoutConstraint?
    private var isInputContainerOpened: Bool = false
    
    lazy private var commentTap = UITapGestureRecognizer(target: self, action: #selector(commentClicked))
    lazy private var writeTap = UITapGestureRecognizer(target: self, action: #selector(writeClicked))
    
    let screenHeight = UIScreen.main.bounds.height
    let scrollContentHeight = 1500 as CGFloat
    
    private lazy var scrollView: UIScrollView = {
        let view = UIScrollView()
        view.isAccessibilityElement = false
        view.translatesAutoresizingMaskIntoConstraints = false
        view.bounces = false
        view.addSubview(titleLabel)
        view.addSubview(coverImage)
        view.addSubview(authorLabel)
        view.addSubview(descriptionLabel)
        view.addSubview(commentTable)
        view.addSubview(commentButton)
        view.addSubview(writeButton)
        return view
    }()
    
    private lazy var titleLabel: UILabel = {
        let view = UILabel()
        view.isAccessibilityElement = false
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var coverImage: UIImageView = {
        let view = UIImageView()
        view.isAccessibilityElement = false
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var authorLabel: UILabel = {
        let view = UILabel()
        view.isAccessibilityElement = false
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let view = UILabel()
        view.isAccessibilityElement = false
        view.translatesAutoresizingMaskIntoConstraints = false
        view.numberOfLines = 0
        return view
    }()
    
    private lazy var commentTable: UITableView = {
        let view = UITableView()
        view.isAccessibilityElement = false
        view.translatesAutoresizingMaskIntoConstraints = false
        view.bounces = false
        view.isScrollEnabled = true
        view.register(UINib(nibName: "BookDetailTableViewCell", bundle: nil), forCellReuseIdentifier: "bookdetailCell")
        return view
    }()
    
    private lazy var commentButton: UIButton = {
        let view = UIButton()
        view.isAccessibilityElement = false
        view.translatesAutoresizingMaskIntoConstraints = false
        view.addGestureRecognizer(commentTap)
        view.setTitle("한줄평 남기기", for: .normal)
        view.titleLabel?.font = .boldSystemFont(ofSize: 15)
        view.setTitleColor(UIColor(named: "colorGreen"), for: .normal)
        return view
    }()
    
    private lazy var writeButton: UIButton = {
        let view = UIButton()
        view.isAccessibilityElement = false
        view.translatesAutoresizingMaskIntoConstraints = false
        view.addGestureRecognizer(writeTap)
        view.setTitle("독후감 작성하기", for: .normal)
        view.titleLabel?.font = .boldSystemFont(ofSize: 15)
        view.setTitleColor(UIColor(named: "colorGreen"), for: .normal)
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        configure()
        
        self.scrollView.delegate = self
        self.commentTable.delegate = self
        self.commentTable.dataSource = self
        
        viewModel.loadingStarted = { [weak self] in
        }
        
        viewModel.loadingEnded = { [weak self] in
        }
        
        viewModel.bookUpdated = { [weak self] book in
            ImageLoader.loadImage(url: book.image) { image in
                self?.coverImage.image = image
                
                TextConverter.loadText(text: book.title) { bookTitle in
                    self?.titleLabel.attributedText = bookTitle
                    self?.titleLabel.font = .boldSystemFont(ofSize: 25)
                    self?.titleLabel.textAlignment = .center
                    self?.titleLabel.adjustsFontSizeToFitWidth = true
                }
                TextConverter.loadText(text: book.author) { authorText in
                    self?.authorLabel.attributedText = authorText
                    self?.authorLabel.textColor = .secondaryLabel
                }
                TextConverter.loadText(text: book.description) { descText in
                    self?.descriptionLabel.attributedText = descText
                    self?.descriptionLabel.font = UIFont.systemFont(ofSize: 15)
                    self?.descriptionLabel.lineBreakMode = .byCharWrapping
                }
            }
        }
        
        viewModel.commentUpdated = { [weak self] in
            DispatchQueue.main.async {
                self?.commentTable.reloadData()
            }
        }
        
        viewModel.detail()
    }
    
    private func configure() {
        
        view.addSubview(scrollView)
        
        let layouts = [
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            titleLabel.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 20),
            titleLabel.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -20),
            
            authorLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            authorLabel.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),

            coverImage.topAnchor.constraint(equalTo: authorLabel.bottomAnchor, constant: 20),
            coverImage.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 10),
            coverImage.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -10),
            coverImage.heightAnchor.constraint(equalToConstant: 500),
            coverImage.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            
            descriptionLabel.topAnchor.constraint(equalTo: coverImage.bottomAnchor, constant: 10),
            descriptionLabel.bottomAnchor.constraint(equalTo: commentTable.topAnchor, constant: -30),
            descriptionLabel.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 20),
            descriptionLabel.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -20),
            
            commentTable.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 20),
            commentTable.heightAnchor.constraint(equalToConstant: 500),
            commentTable.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -60),
            commentTable.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            commentTable.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),

            commentButton.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -20),
            commentButton.leftAnchor.constraint(equalTo: scrollView.leftAnchor, constant: 50),

            writeButton.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -20),
            writeButton.rightAnchor.constraint(equalTo: scrollView.rightAnchor, constant: -50)
        ]
        
        layouts.forEach { $0.isActive = true }
    }
    
    @objc func commentClicked(_ sender: UITapGestureRecognizer) {
        let alertController = UIAlertController(title: "한줄평", message: "한줄평을 입력해주세요.", preferredStyle: .alert)
        alertController.addTextField { (textField) in
            textField.placeholder = "한줄평"
        }
        
        let cancelAction = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        let saveAction = UIAlertAction(title: "저장", style: .default) { _ in
            let inputComment = alertController.textFields![0].text
            self.viewModel.writeComment(comment: inputComment!)
        }
        alertController.addAction(cancelAction)
        alertController.addAction(saveAction)
        present(alertController, animated: true, completion: nil)
    }
    
    @objc func writeClicked(_ sender: UITapGestureRecognizer) {
        DispatchQueue.main.async { [self] in
            NotificationCenter.default.post(name: .bookInfo,
                                            object: nil,
                                            userInfo: ["title": viewModel.bookDetail!.title,
                                                       "image": viewModel.bookDetail!.image])
        }
        
        let vc = self.storyboard!.instantiateViewController(withIdentifier: "Write")
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
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

extension BookDetailViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.commentCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.commentTable.dequeueReusableCell(withIdentifier: "bookdetailCell", for: indexPath) as! BookDetailTableViewCell
        let comments = viewModel.comments(at: indexPath.row)

        cell.setComments(comments)
        
        return cell
    }
    
}

extension BookDetailViewController: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let yOffset = scrollView.contentOffset.y
        
        if scrollView == self.scrollView {
            if yOffset >= scrollContentHeight - screenHeight {
                scrollView.isScrollEnabled = false
                commentTable.isScrollEnabled = true
            }
        }
        
        if scrollView == self.commentTable {
            if yOffset <= 0 {
                self.scrollView.isScrollEnabled = true
                self.commentTable.isScrollEnabled = false
            }
        }
    }
    
}
