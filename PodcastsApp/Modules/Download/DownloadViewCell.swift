//
//  DownloadViewCell.swift
//  PodcastsApp
//
//  Created by Bayu Yasaputro on 13/01/23.
//

import UIKit

class DownloadViewCell: UITableViewCell {
    @IBOutlet weak var thumbImageView: UIImageView!
    @IBOutlet weak var progressLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
