//
//  HomeRecentViewCell.swift
//  PodcastsApp
//
//  Created by Bayu Yasaputro on 23/12/22.
//

import UIKit

class HomeRecentViewCell: UITableViewCell {
    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var thumbImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var moreButton: UIButton!
    
    weak var delegate: HomeRecentViewCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setup()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func setup() {
        thumbImageView.layer.cornerRadius = 3
        thumbImageView.layer.masksToBounds = true
    }
    
    @IBAction func moreButtonTapped(_ sender: Any) {
        delegate?.homeRecentViewCellMoreButtonTapped(cell: self)
    }
}

protocol HomeRecentViewCellDelegate: NSObjectProtocol {
    func homeRecentViewCellMoreButtonTapped(cell: HomeRecentViewCell)
}
