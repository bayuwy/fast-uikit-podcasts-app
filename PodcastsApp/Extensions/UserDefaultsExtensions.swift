//
//  UserDefaultsExtensions.swift
//  PodcastsApp
//
//  Created by Bayu Yasaputro on 13/01/23.
//

import Foundation

extension UserDefaults {
    static let downloadedEpisodesKey: String = "kdownloadedEpisodesKey"
    
    func downloadedEpisodes() -> [DownloadedEpisode] {
        guard let data = data(forKey: UserDefaults.downloadedEpisodesKey) else {
            return []
        }
        
        do {
            let episodes = try JSONDecoder().decode([DownloadedEpisode].self, from: data)
            return episodes
        }
        catch {
            return []
        }
    }
    
    func save(episode: Episode) {
        let downloadedEpisode = DownloadedEpisode(episode: episode)
        
        var episodes = downloadedEpisodes()
        episodes.append(downloadedEpisode)
        
        do {
            let data = try JSONEncoder().encode(episodes)
            UserDefaults.standard.set(data, forKey: UserDefaults.downloadedEpisodesKey)
            
            NotificationCenter.default.post(name: .downloadAdded, object: nil)
        }
        catch {
            print("Failed to encode: \(error)")
        }
    }
    
    func sava(episodes: [DownloadedEpisode]) {
        do {
            let data = try JSONEncoder().encode(episodes)
            UserDefaults.standard.set(data, forKey: UserDefaults.downloadedEpisodesKey)
        }
        catch {
            print("Failed to encode: \(error)")
        }
    }
}
