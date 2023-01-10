//
//  HomeViewController.swift
//  PodcastsApp
//
//  Created by Bayu Yasaputro on 23/12/22.
//

import UIKit
import Kingfisher

class HomeViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    var newPodcasts: [Podcast] = []
    var recentPodcasts: [Podcast] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setup()
        loadData()
        loadRecentPodcasts()
    }
    
    func setup() {
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    func handleGetNewPodcasts(_ podcasts: [Podcast]) {
        self.newPodcasts = podcasts
        self.tableView.reloadData()
    }
    
    func loadData() {
        APIService.shared.getNewPodcasts(completion: handleGetNewPodcasts)
    }
    
    func loadRecentPodcasts() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.viewContext
        
        recentPodcasts = DPodcast.fetch(context: context)
    }
}

// MARK: - UITableViewDataSource
extension HomeViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return recentPodcasts.count
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "new_cell_id", for: indexPath) as! HomeNewPodcastsViewCell
            
            cell.collectionView.dataSource = self
            cell.collectionView.delegate = self
            cell.collectionView.reloadData()
            
            return cell
            
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "recent_cell_id", for: indexPath) as! HomeRecentViewCell
            
            let podcast: Podcast = recentPodcasts[indexPath.row]
            
            cell.numberLabel.text = String(format: "%02d", indexPath.row + 1)
            cell.thumbImageView.kf.setImage(with: URL(string: podcast.artworkUrl))
            cell.titleLabel.text = podcast.trackName
            cell.subtitleLabel.text = podcast.artistName
            
            cell.delegate = self
            
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "New Podcasts"
        default: //case 1:
            return "Recent Episodes"
        }
    }
}

// MARK: - UITableViewDelegate
extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard indexPath.section == 1 else {
            tableView.deselectRow(at: indexPath, animated: true)
            return
        }
        
        
        let podcast = self.recentPodcasts[indexPath.row]
        let alert = UIAlertController(title: "Row Selected", message: "\(podcast.trackName) is selected", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Oke", style: UIAlertAction.Style.default, handler: { (alertAction) in
            
            print("\(podcast.trackName) is selected")
            tableView.deselectRow(at: indexPath, animated: true)
        }))
        present(alert, animated: true)
    }
}

    // MARK: - HomeRecentViewCellDelegate
extension HomeViewController: HomeRecentViewCellDelegate {
    func homeRecentViewCellMoreButtonTapped(cell: HomeRecentViewCell) {
        if let indexPath = tableView.indexPath(for: cell) {
            
            let actionSheet = UIAlertController(title: "More at row \(indexPath.row + 1)", message: "Select an action bellow", preferredStyle: UIAlertController.Style.actionSheet)
            actionSheet.addAction(UIAlertAction(title: "Oke", style: UIAlertAction.Style.default, handler: { _ in
                print("Oke action tapped at \(indexPath.row + 1)")
            }))
            actionSheet.addAction(UIAlertAction(title: "Baiklah", style: UIAlertAction.Style.default, handler: { _ in
                print("Baiklah action tapped at \(indexPath.row + 1)")
            }))
            actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { _ in
                print("Cancel action tapped at \(indexPath.row + 1)")
            }))
            present(actionSheet, animated: true)
        }
    }
}

// MARK: - UICollectionViewDataSource
extension HomeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return newPodcasts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "podcast_cell_id", for: indexPath) as! HomePodcastViewCell
        
        let podcast = newPodcasts[indexPath.item]
        cell.imageView.kf.setImage(with: URL(string: podcast.artworkUrl))
        
        /*
        if let url = URL(string: podcast.artworkUrl) {
            
            DispatchQueue.global().async {
                do {
                    let data = try Data(contentsOf: url)
                    let image = UIImage(data: data)
                    DispatchQueue.main.async {
                        cell.imageView.image = image
                    }
                }
                catch {
                    
                }
            }
        }
        else {
            cell.imageView.image = nil
        }
         */
        
        cell.titleLabel.text = podcast.trackName
        cell.subtitleLabel.text = podcast.artistName
        
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension HomeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        return UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: 200, height: 200)
    }
}
