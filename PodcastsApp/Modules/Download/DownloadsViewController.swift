//
//  DownloadsViewController.swift
//  PodcastsApp
//
//  Created by Bayu Yasaputro on 13/01/23.
//

import UIKit

class DownloadsViewController: BaseViewController {
    @IBOutlet weak var tableView: UITableView!
    
    var episodes: [Episode] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setup()
        loadEpisodes()
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.downloadAddedHandler(_:)), name: .downloadAdded, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.downloadCompleteHandler(_:)), name: .downloadComplete, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.downloadProgressHandler(_:)), name: .downloadProgress, object: nil)
    }
    
    func setup() {
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    func loadEpisodes() {
        episodes = UserDefaults.standard.downloadedEpisodes()
    }
    
    @objc func downloadAddedHandler(_ sender: Any) {
        loadEpisodes()
        tableView.reloadData()
    }
    
    @objc func downloadCompleteHandler(_ sender: Any) {
        loadEpisodes()
        tableView.reloadData()
    }
    
    @objc func downloadProgressHandler(_ sender: Notification) {
        if let userInfo = sender.userInfo,
           let streamUrl = userInfo["streamUrl"] as? String,
           let progress = userInfo["progress"] as? Double {
            
            if let index = episodes.firstIndex(where: { $0.streamUrl == streamUrl }),
               let cell = tableView.cellForRow(at: IndexPath(row: index, section: 0)) as? DownloadViewCell {
                cell.progressLabel.text = "\(Int(progress * 100))%"
                cell.progressLabel.isHidden = progress == 1
            }
        }
    }
}

// MARK: - UITableViewDataSource
extension DownloadsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return episodes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "download_cell", for: indexPath) as! DownloadViewCell
        
        let episode = episodes[indexPath.row]
        cell.thumbImageView.kf.setImage(with: URL(string: episode.imageUrl))
        cell.dateLabel.text = episode.publishDate.description
        cell.titleLabel.text = episode.epTitle
        cell.descriptionLabel.text = episode.epDescription
        
        return cell
    }
}

// MARK: - UITableViewDelegate
extension DownloadsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        presentPlayerViewController(episode: episodes[indexPath.row])
    }
}
