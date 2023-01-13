//
//  APIService.swift
//  PodcastsApp
//
//  Created by Bayu Yasaputro on 30/12/22.
//

import Foundation
import Alamofire
import FeedKit

class APIService {
    static let shared: APIService = APIService()
    private init() { }
    
    let SEARCH_URL: String = "https://itunes.apple.com/search"
    
    func download(episode: Episode) {
        UserDefaults.standard.save(episode: episode)
        let request = DownloadRequest.suggestedDownloadDestination()
        AF.download(episode.streamUrl, to: request)
            .downloadProgress { (progress) in
                NotificationCenter.default.post(
                    name: .downloadProgress,
                    object: nil,
                    userInfo: [
                        "streamUrl": episode.streamUrl,
                        "progress": progress.fractionCompleted
                    ]
                )
            }
            .response { (respose) in
                var episodes = UserDefaults.standard.downloadedEpisodes()
                if let index = episodes.firstIndex(where: { $0.streamUrl == episode.streamUrl }) {
                    episodes[index].fileUrl = respose.fileURL?.absoluteString
                    
                    UserDefaults.standard.sava(episodes: episodes)
                    
                    NotificationCenter.default.post(name: .downloadComplete, object: nil)
                }
            }
    }
    
    func loadEpisodes(url: String, completion: @escaping (_ episodes: [RSSFeedItem]) -> Void) {
        if let feedUrl = URL(string: url) {
            let parser = FeedParser(URL: feedUrl)
            parser.parseAsync { (result) in
                DispatchQueue.main.async {
                    switch result {
                    case .success(let feed):
                        completion(feed.rssFeed?.items ?? [])
                        
                    case .failure(let error):
                        print(error.localizedDescription)
                        completion([])
                    }
                }
            }
        }
        else {
            completion([])
        }
    }
    
    func searchPodcasts(term: String, completion: @escaping (_ podcasts: [Podcast]) -> Void) {
        let parameters: [String: Any] = [
            "media": "podcast",
            "term": term,
            "limit": 20
        ]
        
        AF.request(SEARCH_URL, method: .get, parameters: parameters, encoding: URLEncoding.default)
            .responseDecodable(of: SearchResponse.self) { response in
                switch response.result {
                case .success(let searchResponse):
                    completion(searchResponse.results)
                case .failure(let error):
                    print(error.errorDescription)
                    completion([])
                }
            }
    }
    
    func getNewPodcasts(completion: @escaping (_ podcasts: [Podcast]) -> Void) {
        let parameters: [String: Any] = [
            "media": "podcast",
            "term": "swift",
            "limit": 7
        ]
        
        AF.request(SEARCH_URL, method: .get, parameters: parameters, encoding: URLEncoding.default)
            .responseDecodable(of: SearchResponse.self) { response in
                switch response.result {
                case .success(let searchResponse):
                    completion(searchResponse.results)
                case .failure(let error):
                    print(error.errorDescription)
                    completion([])
                }
            }
        
        /*
            .responseData { response in
                if let data = response.data {
                    do {
                        let searchResponse = try JSONDecoder().decode(SearchResponse.self, from: data)
                        let podcasts = searchResponse.results
                        
                        completion(podcasts)
                    }
                    catch {
                        print(error.localizedDescription)
                    }
                }
            }
         */
    }
    
    
    /*
    func getNewPodcasts(completion: @escaping (_ podcasts: [Podcast]) -> Void) {
        let media = "podcast"
        let term = "swift"
        let limit = 7
        
        let url = URL(string: SEARCH_URL + "?media=\(media)&term=\(term)&limit=\(limit)")!
        let request = URLRequest(url: url)
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                do {
                    let searchResponse = try JSONDecoder().decode(SearchResponse.self, from: data)
                    let podcasts = searchResponse.results
                    
                    DispatchQueue.main.async {
                        completion(podcasts)
                    }
                }
                catch {
                    print(error.localizedDescription)
                }
            }
        }
        task.resume()
    }
     */
}
