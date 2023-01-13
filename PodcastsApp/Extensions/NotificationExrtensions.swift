//
//  NotificationExrtensions.swift
//  PodcastsApp
//
//  Created by Bayu Yasaputro on 13/01/23.
//

import Foundation

extension NSNotification.Name {
    static let favorites: NSNotification.Name = NSNotification.Name("kFavoritesNotificationName")
    
    static let downloadAdded: NSNotification.Name = NSNotification.Name("kDownloadAddedNotificationName")
    static let downloadProgress: NSNotification.Name = NSNotification.Name("kDownloadProgressNotificationName")
    static let downloadComplete: NSNotification.Name = NSNotification.Name("kDownloadCompleteNotificationName")
}
