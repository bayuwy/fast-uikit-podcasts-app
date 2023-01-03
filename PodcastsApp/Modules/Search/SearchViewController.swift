//
//  SearchViewController.swift
//  PodcastsApp
//
//  Created by Bayu Yasaputro on 30/12/22.
//

import UIKit
import Kingfisher

class SearchViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    var podcasts: [Podcast] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setup()
        
        searchPodcasts(term: "imre")
    }
    
    func setup() {
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    func searchPodcasts(term: String) {
        APIService.shared.searchPodcasts(term: term) { (podcasts) in
            self.podcasts = podcasts
            self.tableView.reloadData()
        }
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
        
        
    }
}
