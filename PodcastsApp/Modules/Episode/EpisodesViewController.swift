//
//  EpisodesViewController.swift
//  PodcastsApp
//
//  Created by Bayu Yasaputro on 03/01/23.
//

import UIKit
import FeedKit

class EpisodesViewController: BaseViewController {
    @IBOutlet weak var tableView: UITableView!
    
    let searchController = UISearchController(searchResultsController: nil)
    
    var podcast: Podcast!
    var fullEpisodes: [RSSFeedItem] = []
    var episodes: [RSSFeedItem] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setup()
        
        loadEpisodes()
    }
    
    func setup() {
        title = podcast.trackName
        
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = true
        searchController.searchBar.delegate = self
        
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    func loadEpisodes() {
        APIService.shared.loadEpisodes(url: podcast.feedUrl) { episodes in
            self.fullEpisodes = episodes
            self.episodes = episodes
            self.tableView.reloadData()
        }
    }
    
    func filterEpisode(term: String) {
        if !term.isEmpty {
            episodes = fullEpisodes.filter({ episode in
                return (episode.title ?? "").lowercased().contains(term.lowercased())
            })
        }
        else {
            episodes = fullEpisodes
        }
    }
}

// MARK: - UITableViewDataSource
extension EpisodesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return episodes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "episode_cell_id", for: indexPath) as! EpisodeViewCell
        
        let episode = episodes[indexPath.row]
        cell.thumbImageView.kf.setImage(with: URL(string: episode.iTunes?.iTunesImage?.attributes?.href ?? ""))
        cell.dateLabel.text = episode.pubDate?.description
        cell.titleLabel.text = episode.title
        cell.descLabel.text = episode.iTunes?.iTunesSubtitle ?? episode.description
        
        return cell
    }
}

// MARK: - UITableViewDelegate
extension EpisodesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let episode = episodes[indexPath.row]
        presentPlayerViewController(episode: episode)
    }
}

// MARK: - UISearchBarDelegate
extension EpisodesViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filterEpisode(term: searchText)
        tableView.reloadData()
    }
}

extension UIViewController {
    func showEpisodesViewController(podcast: Podcast) {
        let storyboard = UIStoryboard(name: "Episode", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "episodes") as! EpisodesViewController
        viewController.podcast = podcast
        
        navigationController?.pushViewController(viewController, animated: true)
    }
}
