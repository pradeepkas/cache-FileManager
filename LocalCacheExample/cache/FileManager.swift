//
//  FileManager.swift
//  LocalCacheExample
//
//  Created by Pradeep kumar on 19/9/23.
//

import UIKit


class FileImageManager {
    
    static let instance = FileImageManager()
    
    private init() {
        
        
    }
    
    private let folderName = "demo_image"
    
    func createFolderIfNotThere() {
       guard let folderpath = getFolderPath() else {
           return
        }
        if !FileManager.default.fileExists(atPath: folderpath.absoluteString) {
            do {
                try FileManager.default.createDirectory(at: folderpath, withIntermediateDirectories: true)
            }catch let error {
                print(error.localizedDescription)
            }
        }
    }

    func getFolderPath() -> URL? {
        return FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first?.appendingPathComponent(folderName)
    }
    
    func getImagePath(_ key: String) -> URL? {
        guard let folderPath = getFolderPath() else {return nil}

        return folderPath.appendingPathComponent(key)
    }
    
    
    func saveData(_ key: String, image: UIImage) {
        guard let folderPath = getImagePath(key),
              let data = image.pngData() else { return }
        do {
            try data.write(to: folderPath)
        } catch let error {
            print("error \(error.localizedDescription)")
        }
    }
    
    func getData(_ key: String) -> UIImage? {
        guard let folderPath = getImagePath(key),
              !FileManager.default.fileExists(atPath: folderName) else {return nil }
        return UIImage(contentsOfFile: folderPath.path)
    }

}
