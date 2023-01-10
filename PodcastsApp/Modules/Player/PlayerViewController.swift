//
//  PlayerViewController.swift
//  PodcastsApp
//
//  Created by Bayu Yasaputro on 06/01/23.
//

import UIKit
import FeedKit

class PlayerViewController: UIViewController {
    @IBOutlet weak var thumbImageView: UIImageView!
    @IBOutlet weak var imageViewTrailingConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var currentTimeLabel: UILabel!
    @IBOutlet weak var durationLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var playButton: UIButton!
    
    
    var episode: Episode!
    var timer: Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setup()
    }
    
    deinit {
        timer?.invalidate()
    }
    
    // MARK: - Helpers
    
    func setup() {
        thumbImageView.kf.setImage(with: URL(string: episode.imageUrl))
        titleLabel.text = episode.epTitle
        
        updatePlayInfo()
        updatePlayTime()
    }
    
    
    var isPlaying: Bool {
        let provider = PlayerProvider.shared
        if provider.currentStreamUrl == episode.streamUrl {
            return provider.isPodcastPlaying()
        }
        return false
    }
    
    func updatePlayInfo() {
        if isPlaying {
            playButton.setBackgroundImage(UIImage(systemName: "pause.fill"), for: .normal)
            enlargeImageView()
        }
        else {
            playButton.setBackgroundImage(UIImage(systemName: "play.fill"), for: .normal)
            shrinkImageView()
        }
    }
    
    func enlargeImageView() {
        imageViewTrailingConstraint.constant = 20
        UIView.animate(withDuration: 0.75, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 1, options: .curveEaseOut) {
            self.view.layoutIfNeeded()
        }
    }
    
    func shrinkImageView() {
        imageViewTrailingConstraint.constant = 72
        UIView.animate(withDuration: 0.75, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 1, options: .curveEaseOut) {
            self.view.layoutIfNeeded()
        }
    }
    
    var currentTime: String {
        let provider = PlayerProvider.shared
        if provider.currentStreamUrl == episode.streamUrl {
            let time = provider.currentTime
            return Double(time).durationString
        }
        return "00:00"
    }
    
    var duration: String {
        let provider = PlayerProvider.shared
        if provider.currentStreamUrl == episode.streamUrl {
            let time = provider.duration
            return Double(time).durationString
        }
        return "00:00"
    }
    
    var progress: Float {
        let provider = PlayerProvider.shared
        if provider.currentStreamUrl == episode.streamUrl, provider.duration != 0 {
            return provider.currentTime / provider.duration
        }
        return 0
    }
    
    func updatePlayTime() {
        currentTimeLabel.text = currentTime
        durationLabel.text = duration
        slider.value = progress
    }
    
    func startTimer() {
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true, block: { [weak self] _ in
            self?.updatePlayTime()
        })
    }
    
    func goToProgress(_ value: Float) {
        let provider = PlayerProvider.shared
        if provider.currentStreamUrl == episode.streamUrl {
            let time = provider.duration * value
            provider.podcastGoTo(time: time)
        }
    }
    
    // MARK: - Actions
    
    @IBAction func sliderValueChanged(_ sender: UISlider) {
        let value = sender.value
        goToProgress(value)
    }
    
    @IBAction func playButtonTapped(_ sender: Any) {
        let provider = PlayerProvider.shared
        if provider.currentStreamUrl == episode.streamUrl {
            provider.podcastPlay()
        }
        else {
            provider.launchPodcastPlaylist(playlist: [episode])
        }
        updatePlayInfo()
        startTimer()
    }
    
    @IBAction func forwardButtonTapped(_ sender: Any) {
        let provider = PlayerProvider.shared
        if provider.currentStreamUrl == episode.streamUrl {
            provider.podcastForward(15)
        }
    }
    
    @IBAction func rewindButtonTapped(_ sender: Any) {
        let provider = PlayerProvider.shared
        if provider.currentStreamUrl == episode.streamUrl {
            provider.podcastRewind(15)
        }
    }
}

extension UIViewController {
    func presentPlayerViewController(episode: Episode) {
        let storyboard = UIStoryboard(name: "Player", bundle: nil)
        
        let viewController = storyboard.instantiateViewController(withIdentifier: "player") as! PlayerViewController
        viewController.episode = episode
        
        present(viewController, animated: true)
    }
}
