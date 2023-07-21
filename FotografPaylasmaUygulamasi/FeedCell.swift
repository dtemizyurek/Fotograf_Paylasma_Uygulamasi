//
//  FeedCell.swift
//  FotografPaylasmaUygulamasi
//
//  Created by Doğukan Temizyürek on 21.07.2023.
//

import UIKit

class FeedCell: UITableViewCell {

    @IBOutlet weak var emailText: UILabel!
    
    @IBOutlet weak var postImageView: UIImageView!
    
    @IBOutlet weak var commentText: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }

}
