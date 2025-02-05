//
//  CameraOverlayView.swift
//  CameraLibrary
//
//  Created by NIKHIL on 06/02/25.
//

import Foundation
import UIKit

class CameraOverlayView: UIView {
    let captureButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("📸", for: .normal)
        button.backgroundColor = .white
        button.layer.cornerRadius = 30
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        backgroundColor = UIColor.clear
        addSubview(captureButton)
        
        captureButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            captureButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            captureButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -50),
            captureButton.widthAnchor.constraint(equalToConstant: 60),
            captureButton.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
}
