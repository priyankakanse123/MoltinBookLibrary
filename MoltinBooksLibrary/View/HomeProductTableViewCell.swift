//
//  HomeProductTableViewCell.swift
//  MoltinBooksLibrary
//
//  Created by Priyanka on 22/04/19.
//  Copyright © 2019 Priyanka. All rights reserved.
//

import UIKit

class HomeProductTableViewCell: UITableViewCell {
    
    @IBOutlet weak var productTitle: UILabel!
    
    @IBOutlet weak var productDescription: UILabel!
    
    @IBOutlet weak var productPrice: UILabel!
    
    @IBOutlet weak var selectedImgView: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
