//
//  CameraManager.swift
//  CameraLibrary
//
//  Created by NIKHIL on 06/02/25.
//

import Foundation
import UIKit
import AVFoundation
import Photos

class CameraManager {
    
    static let shared = CameraManager()
    
    private init() {} // Singleton to prevent multiple instances
    
    // MARK: - Request Camera Permission
    func requestCameraPermission(completion: @escaping (Bool) -> Void) {
        let status = AVCaptureDevice.authorizationStatus(for: .video)
        
        switch status {
        case .authorized:
            completion(true)
        case .notDetermined:
            AVCaptureDevice.requestAccess(for: .video) { granted in
                DispatchQueue.main.async {
                    completion(granted)
                }
            }
        default:
            completion(false)
        }
    }
    
    // MARK: - Request Photo Library Permission
    func requestPhotoLibraryPermission(completion: @escaping (Bool) -> Void) {
        let status = PHPhotoLibrary.authorizationStatus()
        
        switch status {
        case .authorized, .limited:
            completion(true)
        case .notDetermined:
            PHPhotoLibrary.requestAuthorization { newStatus in
                DispatchQueue.main.async {
                    completion(newStatus == .authorized || newStatus == .limited)
                }
            }
        default:
            completion(false)
        }
    }
    
    // MARK: - Save Image to Photo Library
    func savePhotoToLibrary(image: UIImage, completion: @escaping (Bool) -> Void) {
        requestPhotoLibraryPermission { granted in
            guard granted else {
                completion(false)
                return
            }
            
            UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
            completion(true)
        }
    }
}

