//
//  CameraViewController.swift
//  CameraLibrary
//
//  Created by NIKHIL on 06/02/25.
//

import Foundation
import UIKit
import AVFoundation

class CameraViewController: UIViewController {
    var captureSession: AVCaptureSession!
    var photoOutput: AVCapturePhotoOutput!
    var previewLayer: AVCaptureVideoPreviewLayer!
    
    let overlayView = CameraOverlayView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCamera()
        setupUI()
    }

    func setupCamera() {
        captureSession = AVCaptureSession()
        captureSession.sessionPreset = .photo
        guard let backCamera = AVCaptureDevice.default(for: .video) else { return }
        let input = try? AVCaptureDeviceInput(device: backCamera)
        captureSession.addInput(input!)
        
        photoOutput = AVCapturePhotoOutput()
        captureSession.addOutput(photoOutput)
        
        previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        previewLayer.videoGravity = .resizeAspectFill
        previewLayer.frame = view.layer.bounds
        view.layer.addSublayer(previewLayer)
        
        captureSession.startRunning()
    }

    func setupUI() {
        view.addSubview(overlayView)
        overlayView.frame = view.bounds
        overlayView.captureButton.addTarget(self, action: #selector(capturePhoto), for: .touchUpInside)
    }

    @objc func capturePhoto() {
        let settings = AVCapturePhotoSettings()
        photoOutput.capturePhoto(with: settings, delegate: self)
    }
}

extension CameraViewController: AVCapturePhotoCaptureDelegate {
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        guard let imageData = photo.fileDataRepresentation(),
              let image = UIImage(data: imageData) else { return }
        
        let confirmationVC = ConfirmationViewController(image: image)
        confirmationVC.modalPresentationStyle = .overFullScreen
        present(confirmationVC, animated: true)
    }
}
