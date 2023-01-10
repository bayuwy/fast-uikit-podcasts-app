//
//  DPodcast+CoreDataProperties.swift
//  PodcastsApp
//
//  Created by Bayu Yasaputro on 10/01/23.
//
//

import Foundation
import CoreData


extension DPodcast {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<DPodcast> {
        return NSFetchRequest<DPodcast>(entityName: "DPodcast")
    }

    @NSManaged public var trackName: String?
    @NSManaged public var artistName: String?
    @NSManaged public var feedUrl: String?
    @NSManaged public var artworkUrl: String?
    @NSManaged public var trackCount: Int16
    @NSManaged public var trackId: Int64

}

extension DPodcast : Identifiable {

}
