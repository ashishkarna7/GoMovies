//
//  CacheEntryObject.swift
//  GoMovies
//
//  Created by Ashish Karna on 13/07/2025.
//

import Foundation
import UIKit

final class CacheEntryObject {
    
    let entry: CacheEntry
    
    init(entry: CacheEntry) {
        self.entry = entry
    }
}

enum CacheEntry {
    case inProgress(Task<UIImage, Error>)
    case ready(UIImage)
}
