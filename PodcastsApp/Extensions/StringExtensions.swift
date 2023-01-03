//
//  StringExtensions.swift
//  PodcastsApp
//
//  Created by Bayu Yasaputro on 03/01/23.
//

import Foundation

extension String {
    var isValidEmail: Bool {
        let reqularExpression = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let predicate = NSPredicate(format: "SELF MATCHES %@", reqularExpression)
        return predicate.evaluate(with: self)
    }
}
