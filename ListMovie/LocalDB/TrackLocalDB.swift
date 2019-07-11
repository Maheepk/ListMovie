//
//  TrackLocalDB.swift
//  ListMovie
//
//  Created by Maheep on 23/06/19.
//  Copyright © 2019 Maheep. All rights reserved.
//

import Foundation
import Realm
import RealmSwift

class TrackLocalDB {
    
    static let sharedManager = TrackLocalDB()
    
    var realm : Realm!
    
    // Saving Movies to Local DB
    // First We are deleting all objects from DB and then we are saving New Objects into DB.
    // Later On Need to Sync if alredy existed Objects with same Track Id found then No Need to append them into Realm DB.
    
    func saveMoviesToLocalDB(_ response : [TrackResponse]?)  {
        
        DispatchQueue.main.async {
            do {
                
                self.realm = try Realm()
                
                try self.realm.write({
                    
                    for object in response ?? [] {
                        
                        let realmObject = StoredTrack()
                        realmObject.trackId = String(object.trackId ?? 0)
                        realmObject.artistName = object.artistName ?? ""
                        realmObject.artworkUrl100 = object.artworkUrl100 ?? ""
                        realmObject.trackName = object.trackName ?? ""
                        realmObject.releaseDate = object.releaseDate ?? ""
                        realmObject.primaryGenreName = object.primaryGenreName ?? ""
                        realmObject.trackViewUrl = object.trackViewUrl ?? ""
                        realmObject.trackPrice = "\(object.trackPrice ?? 0.0)"
                        realmObject.currency = object.currency ?? ""
                        realmObject.longDescription = object.longDescription ?? ""
                        
                        self.realm.add(realmObject)
                    }
                })
            } catch let error as NSError {
                print(error)
            }

        }
        
    }
    
    // Getting Movies List from Realm DB based on Search String which will compare Movie Name
    
    func getMoviesFromLocalDB(_ searchString : String) -> TrackListResponse? {
        
        do {
            
            self.realm = try Realm()
            
            let trackList : Results<StoredTrack>? = self.realm.objects(StoredTrack.self).filter(NSPredicate(format: "self.trackName CONTAINS[c] %@",searchString))
            
            if trackList?.count ?? 0 > 0 {
                
                var trackLists = [TrackResponse]()
                
                for object in trackList! {
                    
                    let trackResponse = TrackResponse(trackId: Int64(object.trackId), artistName: object.artistName, artworkUrl100: object.artworkUrl100, trackName: object.trackName, releaseDate: object.releaseDate, primaryGenreName: object.primaryGenreName, trackViewUrl: object.trackViewUrl, trackPrice: Double(object.trackPrice), currency: object.currency, longDescription: object.longDescription)
                    
                    if let _ = (trackLists.filter { $0.trackId == Int64(object.trackId)}).first {
                        // Don't add into array..
                    } else {
                        trackLists.append(trackResponse)
                    }
                    
                    
                }
                
                let trackResponse = TrackListResponse(resultCount: trackLists.count, results: trackLists)
                return trackResponse
            }
            
            return nil
            
        }catch let error as NSError {
            print(error)
        }
        
        return nil
    }
    
}
