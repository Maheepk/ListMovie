//
//  TrackViewDetailCell.swift
//  ListMovie
//
//  Created by Maheep on 30/06/19.
//  Copyright © 2019 Maheep. All rights reserved.
//

import Foundation
import UIKit
import SDWebImage
import CoreImage

class TrackViewDetailCell: UICollectionViewCell {
    
    @IBOutlet weak var movieImage: UIImageView!
    
    var trackViewModel : TrackViewModel?
    
    // Setup Cell for Track View Model
    
    var downloadedImage : UIImage?
    
    func setupCell(_ trackViewModel : TrackViewModel?)  {
        
        if let _trackViewModel = trackViewModel {
            
            self.movieImage.sd_setImage(with: URL(string: _trackViewModel.artworkUrl)) { (image, error, cache, url) in
                self.downloadedImage = image
            }
            
            self.movieImage.layer.cornerRadius = 6.0
            
            let manager = SDWebImageManager.shared
            
            manager.loadImage(with: URL(string: _trackViewModel.trackViewLargeUrl), options: SDWebImageOptions.continueInBackground, progress: nil) { (image, data, error, cache, success, url) in
                if image != nil {
                    self.movieImage.image = image
                }
            }
        }
    }
    
    var context = CIContext(options: nil)
    
    func blurEffect(_ blurredImage : @escaping ((UIImage?) -> ()))  {
        
        DispatchQueue.global(qos: DispatchQoS.QoSClass.background).async {
            if let image = self.downloadedImage {
                
                let currentFilter = CIFilter(name: "CIGaussianBlur")
                
                let beginImage = CIImage(image: image)
                currentFilter!.setValue(beginImage, forKey: kCIInputImageKey)
                currentFilter!.setValue(10, forKey: kCIInputRadiusKey)
                
                let cropFilter = CIFilter(name: "CICrop")
                cropFilter!.setValue(currentFilter!.outputImage, forKey: kCIInputImageKey)
                cropFilter!.setValue(CIVector(cgRect: beginImage!.extent), forKey: "inputRectangle")
                
                let output = cropFilter!.outputImage
                let cgimg = self.context.createCGImage(output!, from: output!.extent)
                let processedImage = UIImage(cgImage: cgimg!)
                
                blurredImage(processedImage)
            }
        }
        
        blurredImage(nil)
    }
    
}
