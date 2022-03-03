//
//  SearchViewController.swift
//  Book
//
//  Created by 이다영 on 2021/12/10.
//

import UIKit

class SearchViewController: UIViewController {
    
    @IBOutlet var viewModel: SearchViewModel!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var searchCollectionView: UICollectionView!
    
    private var persistencyManager: PersistencyManager!
    private var bookList: BookList?
    var date: String = ""
    var nextStart: Int = 1

    override func viewDidLoad() {
        super.viewDidLoad()

        persistencyManager = PersistencyManager()
        
        self.searchCollectionView.register(UINib(nibName: "SearchCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "searchCell")
        self.searchCollectionView.dataSource = self
        self.searchCollectionView.delegate = self
        self.searchBar.delegate = self
        
        searchCollectionView.refreshControl = UIRefreshControl()
        searchCollectionView.refreshControl?.addTarget(self, action: #selector(onRefresh), for: .valueChanged)

        let activity = UIActivityIndicatorView()
        view.addSubview(activity)
        activity.tintColor = .gray
        activity.translatesAutoresizingMaskIntoConstraints = false
        activity.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        activity.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true

        viewModel.loadingStarted = { [weak activity] in
            activity?.isHidden = false
            activity?.startAnimating()
        }

        viewModel.loadingEnded = { [weak activity] in
            activity?.stopAnimating()
        }

        viewModel.bookListUpdated = { [weak self] in
            DispatchQueue.main.async {
                self?.searchCollectionView.reloadData()
                self?.searchCollectionView.refreshControl?.endRefreshing()
            }
        }
        
    }
    
    func filterContentForSearchText(_ searchText: String) {
        let query: String = searchBar.text!
        persistencyManager.requestAPI(queryValue: query) { data in
            self.bookList = data
        }
    }
    
    @objc func onRefresh() {
        viewModel.list(s: searchBar.text!)
    }
    
// MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detail" {
            if let books = sender as? Books,
               let detail = segue.destination as? BookDetailViewController {
                detail.viewModel.bookDetail = books
            }
        }
    }

}

extension SearchViewController: UICollectionViewDelegate, UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.bookCount()
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "searchCell", for: indexPath) as! SearchCollectionViewCell
        let book = viewModel.book(at: indexPath.row)
        
        cell.setBook(book)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let book = viewModel.book(at: indexPath.row)
        performSegue(withIdentifier: "detail", sender: book)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        
        if offsetY > contentHeight - scrollView.frame.height {
            self.nextStart += 10
            viewModel.next(s: self.searchBar.text!, start: nextStart)
        }
    }
}

extension SearchViewController: UISearchBarDelegate {
    
    private func dismisskeyboard() {
        searchBar.resignFirstResponder()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        dismisskeyboard()
        self.nextStart = 1
        
        guard let searchTerm = searchBar.text, searchTerm.isEmpty == false else { return }
        
        viewModel.list(s: searchTerm)
        self.searchCollectionView.reloadData()
    }
}

extension SearchViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard let flowLayout = collectionViewLayout as? UICollectionViewFlowLayout else { return CGSize() }
        let numberOfCells: CGFloat = 3
        let cellWidth: CGFloat = searchCollectionView.frame.size.width - (flowLayout.minimumInteritemSpacing * (numberOfCells - 1))
        let cellHeight: CGFloat = searchCollectionView.frame.size.height - (flowLayout.minimumInteritemSpacing * 3)
        
        return CGSize(width: cellWidth / numberOfCells, height: cellHeight / 4)
    }
    
}

