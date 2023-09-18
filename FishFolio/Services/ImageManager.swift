//
//  ImageManager.swift
//  FishFolio
//
//  Created by Vlad Gershun on 9/13/23.
//

import SwiftUI

class ImageManager {
    
    static let shared = ImageManager()
    
    private init() { }
    
    func deleteImage(imageID: UUID, folderName: String) {
        
        guard let url = getURLForImage(imageID: imageID, folderName: folderName) else { return }
        guard FileManager.default.fileExists(atPath: url.path) else { return }
        
        do {
            try FileManager.default.removeItem(atPath: url.path)
        } catch {
            print("Could not delete image")
        }
    }
    
    func saveImage(image: UIImage, imageID: UUID, folderName: String) {
        
        createFolderIfNeeded(folderName: folderName)
        
        guard let data = image.jpegData(compressionQuality: 1) else { return }
        guard let url = getURLForImage(imageID: imageID, folderName: folderName) else { return }
        do {
            try data.write(to: url)
        } catch {
            print("Failed to write")
        }
    }
    
    func getImage(imageID: UUID, folderName: String) -> UIImage? {
        guard let url = getURLForImage(imageID: imageID, folderName: folderName) else { return nil }
        guard FileManager.default.fileExists(atPath: url.path) else { return nil }
        return UIImage(contentsOfFile: url.path)
    }
    
    private func createFolderIfNeeded(folderName: String) {
        guard let url = getURLForFolder(folderName: folderName) else { return }
        if !FileManager.default.fileExists(atPath: url.path) {
            do {
                try FileManager.default.createDirectory(at: url, withIntermediateDirectories: true, attributes: nil)
            } catch let error {
                print(error)
            }
        }
    }
    
    private func getURLForFolder(folderName: String) -> URL? {
        guard let url = FileManager.default.urls(for: .applicationSupportDirectory, in: .userDomainMask).first else { return nil }
        return url.appendingPathComponent(folderName)
    }
    
    private func getURLForImage(imageID: UUID, folderName: String) -> URL? {
        guard let folderURL = getURLForFolder(folderName: folderName) else { return nil }
        return folderURL.appendingPathExtension("\(imageID) + .jpg")
    }
}
