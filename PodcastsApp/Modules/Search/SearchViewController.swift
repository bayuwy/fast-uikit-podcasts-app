//
//  SearchViewController.swift
//  PodcastsApp
//
//  Created by Bayu Yasaputro on 30/12/22.
//

import UIKit
import Kingfisher

class SearchViewController: BaseViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchTextField: UITextField?
    
    let searchController = UISearchController(searchResultsController: nil)
    var podcasts: [Podcast] = []
    var searchTimer: Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setup()
    }
    
    func setup() {
        navigationController?.navigationBar.prefersLargeTitles = true
        
        tableView.dataSource = self
        tableView.delegate = self
        
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = true
        searchController.searchBar.delegate = self
        searchTextField?.delegate = self
    }
    
    func searchPodcasts(term: String) {
        searchTimer?.invalidate()
        searchTimer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false, block: { _ in
            APIService.shared.searchPodcasts(term: term) { (podcasts) in
                self.podcasts = podcasts
                self.tableView.reloadData()
            }
        })
    }
}

// MARK: - UITableViewDataSource
extension SearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return podcasts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "podcast_cell_id", for: indexPath) as! SearchPodcastViewCell
        
        let podcast = podcasts[indexPath.row]
        cell.thumbImageView.kf.setImage(with: URL(string: podcast.artworkUrl))
        cell.nameLabel.text = podcast.trackName
        cell.artistLabel.text = podcast.artistName
        cell.episodeLabel.text = "\(podcast.trackCount) episode(s)"
        
        return cell
    }
}

// MARK: - UITableViewDelegate
extension SearchViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let podcast = podcasts[indexPath.row]
        showEpisodesViewController(podcast: podcast)
    }
}

// MARK: - UISearchBarDelegate
extension SearchViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.count >= 3 {
            searchPodcasts(term: searchText)
        }
    }
}

// MARK: - UISearchBarDelegate
extension SearchViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let newString = NSString(string: textField.text ?? "").replacingCharacters(in: range, with: string)
        if newString.count >= 3 {
            searchPodcasts(term: newString)
        }
        
        return true
    }
}
