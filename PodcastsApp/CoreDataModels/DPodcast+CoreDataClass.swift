//
//  DPodcast+CoreDataClass.swift
//  PodcastsApp
//
//  Created by Bayu Yasaputro on 10/01/23.
//
//

import Foundation
import CoreData

@objc(DPodcast)
public class DPodcast: NSManagedObject {
    
    class func save(_ podcast: Podcast, context: NSManagedObjectContext) {
        let request: NSFetchRequest<DPodcast> = DPodcast.fetchRequest()
        request.predicate = NSPredicate(format: "trackId = \(podcast.track_id)")
        
        let entity: DPodcast
        if let dPodcast = try? context.fetch(request).first {
            entity = dPodcast
        }
        else {
            let dPodcast = NSEntityDescription.entity(forEntityName: "DPodcast", in: context)!
            entity = NSManagedObject(entity: dPodcast, insertInto: context) as! DPodcast
        }
        
        entity.trackId = Int64(podcast.track_id)
        entity.trackName = podcast.trackName
        entity.artistName = podcast.artistName
        entity.artworkUrl = podcast.artworkUrl
        entity.trackCount = Int16(podcast.trackCount)
        entity.feedUrl = podcast.feedUrl
        
        NotificationCenter.default.post(name: .favorites, object: nil)
        
        try? context.save()
    }
    
    class func fetch(context: NSManagedObjectContext) -> [Podcast] {
        let request: NSFetchRequest<DPodcast> = DPodcast.fetchRequest()
        let dPodcasts = (try? context.fetch(request)) ?? []
        
//        let podcasts = dPodcasts.compactMap({ data in
//            return Podcast(data: data)
//        })
        
        let podcasts = dPodcasts.compactMap { Podcast(data: $0) }
        
        return podcasts
    }
    
    class func fetch(trackId: Int, context: NSManagedObjectContext) -> Podcast? {
        let request: NSFetchRequest<DPodcast> = DPodcast.fetchRequest()
        request.predicate = NSPredicate(format: "trackId = \(trackId)")
        if let dPodcast = try? context.fetch(request).first {
            let podcast = Podcast(data: dPodcast)
            return podcast
        }
        else {
            return nil
        }
    }
    
    class func delete(trackId: Int, context: NSManagedObjectContext) {
        let request: NSFetchRequest<DPodcast> = DPodcast.fetchRequest()
        request.predicate = NSPredicate(format: "trackId = \(trackId)")
        if let dPodcast = try? context.fetch(request).first {
            context.delete(dPodcast)
            
            NotificationCenter.default.post(name: .favorites, object: nil)
        }
    }
}
