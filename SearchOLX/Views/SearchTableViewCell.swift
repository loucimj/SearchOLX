//
//  SearchTableViewCell.swift
//  SearchOLX
//
//  Created by Javi on 5/12/16.
//  Copyright © 2016 FuzeIdea. All rights reserved.
//

import UIKit


protocol SearchTableViewDelegate {
    func buyItem(item:SearchResultItem)
    func saveForLaterItem(item:SearchResultItem)
}


class SearchTableViewCell: UITableViewCell {

    @IBOutlet weak var imagePreview: ImagePreviewView!
    @IBOutlet weak var itemLabel: UILabel!
    @IBOutlet weak var itemPrice: UILabel!
    @IBOutlet weak var saveImageView: UIImageView!
    @IBOutlet weak var buyImageView: UIImageView!
 
    var delegate:SearchTableViewDelegate?
    var item:SearchResultItem?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.contentView.userInteractionEnabled = false
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCell(item:SearchResultItem) {
        itemLabel.text = item.title
        itemPrice.text = item.priceLabel
        
        let gesture1 = UITapGestureRecognizer(target: self, action: #selector(save))
        saveImageView.userInteractionEnabled = true
        saveImageView.addGestureRecognizer(gesture1)
        
        let gesture2 = UITapGestureRecognizer(target: self, action: #selector(buy))
        buyImageView.userInteractionEnabled = true
        buyImageView.addGestureRecognizer(gesture2)
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW,0), {
            self.imagePreview.setImageURLToPreview(item.imageURL)
        })
        
    }

    @objc func save() {
        if let _ = delegate {
            if let _ = item {
                delegate?.saveForLaterItem(self.item!)
            }
        }
    }
    @objc func buy() {
        if let _ = delegate {
            if let _ = item {
                delegate?.buyItem(self.item!)
            }
        }
    }
}
