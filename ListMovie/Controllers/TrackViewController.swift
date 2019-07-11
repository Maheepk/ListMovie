//
//  TrackViewController.swift
//  ListMovie
//
//  Created by Maheep on 22/06/19.
//  Copyright © 2019 Maheep. All rights reserved.
//

import UIKit
import CCBottomRefreshControl

class TrackViewController: UIViewController {
    
    // Taken Track View Model Class for Getting Data to show on View
    
    var trackViewModel : TrackViewModel!
    
    @IBOutlet weak var collectionView : UICollectionView!
    
    @IBOutlet weak var activityIndicator : UIActivityIndicatorView!
    
    @IBOutlet weak var searchBarView : UISearchBar!
    
    // KSegueDetailScreen TableViewCell Identifier
    private let KSegueDetailScreen = "gotoDetailScreen"
    
    // SelectedIndex is for remembering count for Pressed Movie List
    private var selectedIndex = 0
    
    let refreshControl = UIRefreshControl()
    
    var flowLayout = TrackViewLayout()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupViewModel()
    }
    
    // Setting Up UI for This Controller
    private func setupUI() {
        activityIndicator.isHidden = true
        self.title = "Search Movie"
        
        self.collectionView.collectionViewLayout = flowLayout
        
        // Set the delegate
        if let layout = collectionView?.collectionViewLayout as? TrackViewLayout {
            layout.delegate = self
        }
        
        setupRefreshControl()
        
    }
    
    private func setupRefreshControl() {
        refreshControl.addTarget(self, action: #selector(refresh), for: UIControl.Event.valueChanged)
        refreshControl.triggerVerticalOffset = 100
        self.collectionView.bottomRefreshControl = refreshControl
    }
    
    // Setting Up View Model for This Controller
    private func setupViewModel() {
        trackViewModel = TrackViewModel(self)
    }
    
    @objc func refresh() {
        
        print("I am called")
        
        trackViewModel.refreshCollectionView()
    }
    
    // Preparing to Next Screen and Sending View Model to Next Detail Screen.
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == KSegueDetailScreen, let trackDetailsVC = segue.destination as? TrackDetailsViewController {
            
            trackDetailsVC.selectedIndex = self.selectedIndex
            trackDetailsVC.trackViewModel = trackViewModel
        }
    }
}

// Extension CollectionView Delegate and Data Source..

extension TrackViewController : UICollectionViewDelegate, UICollectionViewDataSource {
    
    // Returing Number of Rows for Movie List
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return trackViewModel.trackViewModel.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TrackViewCell", for: indexPath) as! TrackViewCell
        
        cell.setupCell(trackViewModel.trackViewModel[indexPath.row])
        
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
     
        self.selectedIndex = indexPath.row
        
        self.performSegue(withIdentifier: KSegueDetailScreen, sender: nil)
        
    }
}


//MARK: - TrackViewController LAYOUT DELEGATE
extension TrackViewController : TrackViewLayoutDelegate {
    
    // 1. Returns the photo height
    func collectionView(_ collectionView: UICollectionView, heightForPhotoAtIndexPath indexPath:IndexPath) -> CGFloat {
        return 250
    }
    
}


extension TrackViewController : UISearchBarDelegate {
    
    // SearchBar Bar for Text.
    func searchBar(_ searchBar: UISearchBar, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        
        let currentText = searchBar.text ?? ""
        guard let stringRange = Range(range, in: currentText) else { return false }
        let updatedText = currentText.replacingCharacters(in: stringRange, with: text)
        trackViewModel.fetchTracks(searchString: updatedText)
        
        return true
    }
    
}

// Extension for TrackViewModelDelegate..
extension TrackViewController : TrackViewModelDelegate {
    
    func trackData(_ viewModel: TrackViewModel?) {
        activityIndicator.isHidden = true
        
        DispatchQueue.main.async {
            self.refreshControl.endRefreshing()
            self.collectionView.bottomRefreshControl?.endRefreshing()
            
            self.flowLayout.contentHeight = 0
            
            self.collectionView.collectionViewLayout.invalidateLayout()
        
            self.collectionView.reloadData()
            
        }
    }
    
    func trackDataGetError(_ error: Error?) {
        activityIndicator.isHidden = true
        
        self.perform(#selector(self.alert(message:title:)), with: error?.localizedDescription ?? "", afterDelay: 1)
    }
    
}
