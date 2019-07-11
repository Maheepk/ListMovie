//
//  TrackViewDetailCastsCell.swift
//  ListMovie
//
//  Created by Maheep on 30/06/19.
//  Copyright © 2019 Maheep. All rights reserved.
//

import UIKit

class TrackViewDetailCastsCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    var trackViewModel : TrackViewModel?
    
    // Setup Cell for Track View Model
    
    func setupCell(_ trackViewModel : TrackViewModel?)  {
        
        self.imageView.layer.cornerRadius = 35
        
        if let _trackViewModel = trackViewModel {
            
            self.titleLabel.text = _trackViewModel.artistName
            
        }
    }
    
}
