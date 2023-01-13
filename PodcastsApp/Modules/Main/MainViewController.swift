//
//  MainViewController.swift
//  PodcastsApp
//
//  Created by Bayu Yasaputro on 16/12/22.
//

import UIKit

class MainViewController: UITabBarController {
    weak var playerView: PlayerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setup()
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(self.playerProviderStateDidChange(_:)),
            name: .PlayerProviderStateDidChange,
            object: nil
        )
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(self.playerProviderNowPlayingInfoDidChange(_:)),
            name: .PlayerProviderNowPlayingInfoDidChange,
            object: nil
        )
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: .PlayerProviderStateDidChange, object: nil)
        NotificationCenter.default.removeObserver(self, name: .PlayerProviderNowPlayingInfoDidChange, object: nil)
    }

    func setup() {
        let playerView = PlayerView(frame: .zero) //CGRect(x: 0, y: 0, width: 0, height: 0)
        view.addSubview(playerView)
        self.playerView = playerView
        playerView.isHidden = true
        playerView.delegate = self
        playerView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            playerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            playerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            playerView.bottomAnchor.constraint(equalTo: tabBar.topAnchor)
        ])
        
        view.bringSubviewToFront(playerView)
    }
    
    @objc func playerProviderStateDidChange(_ sender: Any) {
        playerProviderNowPlayingInfoDidChange(sender)
        playerView.isHidden = false
    }
    
    @objc func playerProviderNowPlayingInfoDidChange(_ sender: Any) {
        let playerProvider = PlayerProvider.shared
        let episode = playerProvider.currentEpisode
        
        playerView.titleLabel.text = episode?.epTitle
        playerView.imageView.kf.setImage(with: URL(string: episode?.imageUrl ?? ""))
        let imageName = playerProvider.isPodcastPlaying() ? "pause.fill" : "play.fill"
        playerView.playButton.setImage(UIImage(systemName: imageName), for: .normal)
    }
}

// MARK: - PlayerViewDelegate
extension MainViewController: PlayerViewDelegate {
    func playerViewPlayButtonTapped(_ view: PlayerView) {
        PlayerProvider.shared.podcastPlay()
    }
    
    func playerViewRewindButtonTapped(_ view: PlayerView) {
        PlayerProvider.shared.podcastRewind()
    }
    
    func playerViewForwardButtonTapped(_ view: PlayerView) {
        PlayerProvider.shared.podcastForward()
    }
    
    func playerViewViewTapped(_ view: PlayerView) {
        if let episode = PlayerProvider.shared.currentEpisode {
            presentPlayerViewController(episode: episode)
        }
    }
}
