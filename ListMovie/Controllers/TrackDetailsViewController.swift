//
//  TrackDetailsViewController.swift
//  ListMovie
//
//  Created by Maheep on 23/06/19.
//  Copyright © 2019 Maheep. All rights reserved.
//

import Alamofire
import UIKit

class TrackDetailsViewController: UIViewController {
    
    let flowLayout = TrackDetailCollectionFlowLayout()
    
    var trackViewModel : TrackViewModel!

    @IBOutlet weak var backgroundImageView : UIImageView!

    @IBOutlet weak var displayMoviesCollectionView : UICollectionView!
    @IBOutlet weak var displayMoviesCastsCollectionView : UICollectionView!
    
    @IBOutlet weak var movieNameLabel : UILabel!
    @IBOutlet weak var movieGenreNameLabel : UILabel!
    @IBOutlet weak var movieDescription : UILabel!
    
    var selectedIndex = 0
    
    var selectedViewModel : TrackViewModel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        
    }
    
    func setupUI() {
        
        guard let collectionView = displayMoviesCollectionView else { fatalError() }
        //collectionView.decelerationRate = .fast // uncomment if necessary
        collectionView.dataSource = self
        collectionView.collectionViewLayout = flowLayout
        collectionView.delegate = self

        collectionView.isScrollEnabled = true
        
        guard let castsCollectionView = displayMoviesCastsCollectionView else { fatalError() }
        //collectionView.decelerationRate = .fast // uncomment if necessary
        castsCollectionView.dataSource = self
        
        self.selectedViewModel = trackViewModel.trackViewModel[selectedIndex]
        setupUIForViewModel(self.selectedViewModel)
        
        
        if selectedIndex != 0 {
            
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5) {
                self.displayMoviesCollectionView.scrollToItem(at: IndexPath.init(row: self.selectedIndex, section: 0), at: UICollectionView.ScrollPosition.left, animated: true)
            }
            
        }
        
    }
    
    func setupUIForViewModel(_ viewModel : TrackViewModel?) {
        
        if let _viewModel = viewModel {
            
            DispatchQueue.main.async {
                
                self.movieNameLabel.text = _viewModel.movieName
                self.movieGenreNameLabel.text = _viewModel.genreName
                self.movieDescription.text = _viewModel.longDes
                
                self.displayMoviesCastsCollectionView.reloadData()
            }

        }
    }
    
}



extension TrackDetailsViewController: UICollectionViewDataSource,  UICollectionViewDelegate, UIScrollViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if collectionView == self.displayMoviesCollectionView {
            return self.trackViewModel.trackViewModel.count
        }
        else {
            return 1
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == self.displayMoviesCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TrackViewDetailCell", for: indexPath) as! TrackViewDetailCell
            
            let trackViewModel = self.trackViewModel.trackViewModel[indexPath.row]
            
            cell.setupCell(trackViewModel)
            
            cell.blurEffect { (image) in
                DispatchQueue.main.async {
                    self.backgroundImageView.image = image
                }
            }
            
            return cell
        } else {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TrackViewDetailCastsCell", for: indexPath) as! TrackViewDetailCastsCell
            
            cell.setupCell(selectedViewModel)

            return cell
        }
    }
    
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
     
        var minValue = self.displayMoviesCollectionView.indexPathsForVisibleItems.first?.item ?? 0, maxValue = 0, currentIndex = -1;
        
        print(self.displayMoviesCollectionView.indexPathsForVisibleItems)
        
        for index in self.displayMoviesCollectionView.indexPathsForVisibleItems {
            
            if  minValue > index.item {
                minValue = index.item
            }
            
            if maxValue < index.item {
                maxValue = index.item
            }
            
        }
        
        currentIndex = Int(floor((Float(minValue) + Float(maxValue)))/Float(2))

        if self.displayMoviesCollectionView.indexPathsForVisibleItems.count < 3 {
            if minValue == 0 {
                currentIndex = 0
            }else if maxValue == self.trackViewModel.trackViewModel.count - 1 {
                currentIndex = maxValue
            }
        }
        
        if let cell = self.displayMoviesCollectionView.cellForItem(at: IndexPath.init(row: currentIndex, section: 0)) as? TrackViewDetailCell {
            
            cell.blurEffect { (image) in
                DispatchQueue.main.async {
                    self.backgroundImageView.image = image
                }
            }
        }
        

        
        self.selectedViewModel = self.trackViewModel.trackViewModel[currentIndex]
        
        setupUIForViewModel(self.selectedViewModel)
    }

}

