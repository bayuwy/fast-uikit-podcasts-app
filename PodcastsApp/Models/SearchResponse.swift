//
//  SearchResponse.swift
//  PodcastsApp
//
//  Created by Bayu Yasaputro on 30/12/22.
//

import Foundation

struct SearchResponse: Decodable {
    let resultCount: Int
    let results: [Podcast]
}
