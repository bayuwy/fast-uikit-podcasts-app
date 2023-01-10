//
//  PlayerView.swift
//  PodcastsApp
//
//  Created by Bayu Yasaputro on 10/01/23.
//

import UIKit

protocol PlayerViewDelegate: NSObjectProtocol {
    func playerViewPlayButtonTapped(_ view: PlayerView)
    func playerViewRewindButtonTapped(_ view: PlayerView)
    func playerViewForwardButtonTapped(_ view: PlayerView)
    func playerViewViewTapped(_ view: PlayerView)
}

class PlayerView: UIView {
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var rewindButton: UIButton!
    @IBOutlet weak var forwardButton: UIButton!
   
    weak var delegate: PlayerViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    func setup() {
        Bundle.main.loadNibNamed("PlayerView", owner: self)
        self.addSubview(contentView)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            contentView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0),
            contentView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0),
            contentView.topAnchor.constraint(equalTo: self.topAnchor, constant: 0),
            contentView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0)
        ])
    }
    
    @IBAction func playButtonTapped(_ sender: Any) {
        delegate?.playerViewPlayButtonTapped(self)
    }
    
    @IBAction func rewindButtonTapped(_ sender: Any) {
        delegate?.playerViewRewindButtonTapped(self)
    }
    
    @IBAction func forwardButtonTapped(_ sender: Any) {
        delegate?.playerViewForwardButtonTapped(self)
    }
    
    @IBAction func viewTapped(_ sender: Any) {
        delegate?.playerViewViewTapped(self)
    }
}
