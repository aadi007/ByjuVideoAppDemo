//
//  MovieDataViewCell.swift
//  ByjuVideoAppDemo
//
//  Created by Parth Desai on 30/11/15.
//  Copyright © 2015 @@DI007. All rights reserved.
//

import UIKit

class MovieDataViewCell: UITableViewCell {

    @IBOutlet weak var thumbnailImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var sourceLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
