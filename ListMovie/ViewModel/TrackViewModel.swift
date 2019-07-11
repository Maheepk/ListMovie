//
//  TrackViewModel.swift
//  ListMovie
//
//  Created by Maheep on 23/06/19.
//  Copyright © 2019 Maheep. All rights reserved.
//

import Foundation
import Realm
import RealmSwift
import Reachability
import Alamofire

// Protocol TrackViewModelDelegate for Sending Values to Source Controller.

protocol TrackViewModelDelegate {
    
    func trackData(_ viewModel : TrackViewModel?)
    func trackDataGetError(_ error : Error?)
}

class TrackViewModel {
    
    // Private Track Model
    
    private var trackModel = TrackResponse()
    var trackViewModel = [TrackViewModel]()
    
    var allTrackViewModel = [TrackViewModel]()

    
    var delegate : TrackViewModelDelegate?
    
    var numberOfItemsShowing = 0

    var limit = 10
    
    init() {
        
    }
    
    init(trackModel: TrackResponse)
    {
        self.trackModel = trackModel
    }
    
    init( _ delegate : TrackViewModelDelegate)
    {
        self.delegate = delegate
    }
    
    func refreshCollectionView() {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+1) {
            
            if self.numberOfItemsShowing <= 200 {
                
                self.numberOfItemsShowing += self.limit
                
                if self.numberOfItemsShowing > self.allTrackViewModel.count  {
                    self.numberOfItemsShowing = self.allTrackViewModel.count
                }
                self.trackViewModel = Array(self.allTrackViewModel[0...(self.numberOfItemsShowing - 1)])
            }
            
            self.delegate?.trackData(self)
        }
        
    }
    
    func fetchTracks(searchString : String?) {
        
        // Here if search values is nil or Search Value contains less than 3 characters don't search..
        guard let _searchString = searchString, _searchString.count > 2 else {
            return
        }
        
        // Checking for Internet connection
        // And Get Data according to Internet Connection values.
        
        if NetworkReachabilityManager()!.isReachable {
            getFromServerDB(_searchString)
        } else {
            getFromLocalDB(_searchString)
        }
    }
    
    // Converting All Models into ViewModels
    
    func getTracksViewModel(_ items : [TrackResponse]?) -> [TrackViewModel] {
        
        var tracksViewModels = [TrackViewModel]()
        
        if let array = items {
            for obj in array {
                tracksViewModels.append(TrackViewModel(trackModel: obj))
            }
            return tracksViewModels
        }
        
        return tracksViewModels
    }
    
    // Calling Apis to Fetch Data from Remote Server DB
    
    func getFromServerDB(_ searchString : String) {
        
        // If _search String takes space, convert space into plus sign..
        // This is to make Url Convertible..
        let searchString = searchString.replacingOccurrences(of: " ", with: "+")
        
        self.fetchTracks(searchString: searchString) { (success, response, error) in
            if success {
                self.allTrackViewModel = self.getTracksViewModel(response?.results)
                
                 if self.allTrackViewModel.count > 0 {
                    
                    if self.numberOfItemsShowing == 0 {
                        self.numberOfItemsShowing  = self.limit
                    }
                    
                    if self.numberOfItemsShowing < self.limit && self.allTrackViewModel.count > self.numberOfItemsShowing {
                        self.numberOfItemsShowing = self.limit
                    }
                    
                    if self.numberOfItemsShowing > self.allTrackViewModel.count  {
                        self.numberOfItemsShowing = self.allTrackViewModel.count
                    }
                    
                    self.trackViewModel = Array(self.allTrackViewModel[0...(self.numberOfItemsShowing - 1)])
                
                } else {
                    self.trackViewModel = self.allTrackViewModel
                }
                

                self.delegate?.trackData(self)
            } else {
                self.delegate?.trackDataGetError(error)
            }
        }
    }
    
    // Fetching Local Data from Realm DB
    
    func getFromLocalDB(_ searchString : String) {
        
        self.fetchTracksFromLocalDB(searchString, requestCompleted: { (success, response, error) in
            if success {
                self.allTrackViewModel = self.getTracksViewModel(response?.results)
                
                if self.numberOfItemsShowing == 0 {
                    self.numberOfItemsShowing  = self.limit
                }
                
                if self.numberOfItemsShowing < self.limit && self.allTrackViewModel.count > self.numberOfItemsShowing {
                    self.numberOfItemsShowing = self.limit
                }
                
                if self.numberOfItemsShowing > self.allTrackViewModel.count  {
                    self.numberOfItemsShowing = self.allTrackViewModel.count
                }

                self.trackViewModel = Array(self.allTrackViewModel[0...(self.numberOfItemsShowing - 1)])
                self.delegate?.trackData(self)
            } else {
                self.delegate?.trackDataGetError(error)
            }
        })
    }
    
    // Fetching From Remote.
    func fetchTracks(searchString : String, requestCompleted : @escaping (_ succeeded: Bool, _ result: TrackListResponse?, _ error : Error?) -> ()) {
        
        TrackService().getTrack(searchValue: searchString, success: { (response) in
            
            // Save values to realm..
            self.storeValuesIntoLocalDB(response.results)
            
            requestCompleted(true, response, nil)
        }) { (error) in
            requestCompleted(false,nil,error)
            log.debug(error)
        }
        
    }
    
    // Fetching from Local DB
    
    func fetchTracksFromLocalDB(_ searchString : String, requestCompleted : @escaping (_ succeeded: Bool, _ result: TrackListResponse?, _ error : Error?) -> ()) {
        
        if let trackResponse =  TrackLocalDB.sharedManager.getMoviesFromLocalDB(searchString) {
            requestCompleted(true, trackResponse, nil)
        } else {
            requestCompleted(false, nil, NSError(domain: "Error", code: 1000, message: "You are offline, please try later."))
        }
    }
    
    
    // Storing into Local DB as Track Response.
    func storeValuesIntoLocalDB(_ response : [TrackResponse]?) {
        TrackLocalDB.sharedManager.saveMoviesToLocalDB(response)
    }
    
    public var releaseDate: String {
        let releaseDate = Utils.formatDateDDMMYYYY(trackModel.releaseDate)
        return  releaseDate
    }
    
    public var movieName: String {
        return trackModel.trackName ?? ""
    }
    
    public var artworkUrl: String {
        return trackModel.artworkUrl100 ?? ""
    }
    
    public var trackViewUrl: String {
        return trackModel.trackViewUrl ?? ""
    }
    
    public var artistName: String {
        return "Artist Name: \(trackModel.artistName ?? "")"
    }
    
    public var moviePrice: String {
        
        if let price =  trackModel.trackPrice , price <= 0 {
            return "NA"
        }
        
        return "Movie Price: \(trackModel.currency ?? "") \(trackModel.trackPrice ?? 0.0)"
    }
    
    public var genreName: String {
        return "Genre: \(trackModel.primaryGenreName ?? "")"
    }

    public var longDes: String {
        return trackModel.longDescription ?? ""
    }

    public var trackViewLargeUrl: String {
        return (trackModel.artworkUrl100 ?? "").replacingOccurrences(of: "100", with: "500")
    }

}
