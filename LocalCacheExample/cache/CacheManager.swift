//
//  CacheManager.swift
//  LocalCacheExample
//
//  Created by Pradeep kumar on 19/9/23.
//

import UIKit


protocol LocalInterface {
    
    func getData()
    func saveData()
    
}


class CacheImageManager {
    
    static let instance = CacheImageManager()
    
    private init() {
        
    }
    
    private var cacheManager: NSCache<NSString, UIImage>  {
        let manager = NSCache<NSString, UIImage>()
        manager.countLimit = 300
        manager.totalCostLimit = 500 * 1024 * 1024 //500 MB
        return manager
    }
    
    
    func saveData(_ key: String, image: UIImage) {
        cacheManager.setObject(image, forKey: key as NSString)
    }
    
    func getData(_ key: String) -> UIImage? {
        if let data = cacheManager.object(forKey: key as NSString) {
            return data
        }
        return nil
    }
}
