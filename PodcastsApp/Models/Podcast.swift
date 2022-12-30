//
//  Podcast.swift
//  PodcastsApp
//
//  Created by Bayu Yasaputro on 27/12/22.
//

import Foundation

struct Podcast: Decodable {
    let track_id: Int
    let collectionId: String
    let trackName: String
    let artistName: String
    let artworkUrl: String
    let trackCount: Int
    let genres: [String]
    let feedUrl: String
    
    enum CodingKeys: String, CodingKey {
        case id = "trackId"
        case collectionId
        case trackName
        case artistName
        case artworkUrl = "artworkUrl600"
        case trackCount
        case genres
        case feedUrl
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        track_id = try container.decode(Int.self, forKey: .id)
        let colId: Int = try container.decode(Int.self, forKey: .collectionId)
        collectionId = "\(colId)"
        
        trackName = try container.decodeIfPresent(String.self, forKey: .trackName) ?? ""
        artistName = try container.decodeIfPresent(String.self, forKey: .artistName) ?? ""
        artworkUrl = try container.decodeIfPresent(String.self, forKey: .artworkUrl) ?? ""
        trackCount = try container.decodeIfPresent(Int.self, forKey: .trackCount) ?? 0
        genres = try container.decodeIfPresent([String].self, forKey: .genres) ?? []
        feedUrl = try container.decodeIfPresent(String.self, forKey: .feedUrl) ?? ""
    }
}
