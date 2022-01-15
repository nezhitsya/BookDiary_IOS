//
//  DetailViewController.swift
//  Book
//
//  Created by 이다영 on 2021/12/24.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet var viewModel: DetailViewModel!
    
    private var inputTopPadding: NSLayoutConstraint?
    private var isInputContainerOpened: Bool = false
    
    private lazy var scrollView: UIScrollView = {
        let view = UIScrollView()
        view.isAccessibilityElement = false
        view.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(titleLabel)
        view.addSubview(coverImage)
        view.addSubview(authorLabel)
        view.addSubview(descriptionLabel)
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

    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(scrollView)
        configure()
        
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
                }
                TextConverter.loadText(text: book.author) { authorText in
                    self?.authorLabel.attributedText = authorText
                    self?.authorLabel.textColor = .secondaryLabel
                }
                TextConverter.loadText(text: book.description) { descText in
                    self?.descriptionLabel.attributedText = descText
                }
            }
        }
        
        viewModel.detail()
    }
    
    private func configure() {
        
        let layouts = [
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            titleLabel.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 20),
            titleLabel.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            
            authorLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            authorLabel.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),

            coverImage.topAnchor.constraint(equalTo: authorLabel.bottomAnchor, constant: 20),
            coverImage.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 10),
            coverImage.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: 10),
            coverImage.heightAnchor.constraint(equalToConstant: 500),
            coverImage.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            
            descriptionLabel.topAnchor.constraint(equalTo: coverImage.bottomAnchor, constant: 10),
            descriptionLabel.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 20),
            descriptionLabel.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: 20),
            descriptionLabel.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -20)
        ]
        
        layouts.forEach { $0.isActive = true }
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
