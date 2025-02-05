//
//  ConformationViewController.swift
//  CameraLibrary
//
//  Created by NIKHIL on 06/02/25.
//

import Foundation
import UIKit

class ConfirmationViewController: UIViewController {
    var imageView = UIImageView()
    var image: UIImage
    
    init(image: UIImage) {
        self.image = image
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.7)
        setupUI()
    }

    func setupUI() {
        imageView.image = image
        imageView.contentMode = .scaleAspectFit
        view.addSubview(imageView)

        let saveButton = UIButton(type: .system)
        saveButton.setTitle("✔️", for: .normal)
        saveButton.addTarget(self, action: #selector(savePhoto), for: .touchUpInside)
        
        let retakeButton = UIButton(type: .system)
        retakeButton.setTitle("❌", for: .normal)
        retakeButton.addTarget(self, action: #selector(dismissView), for: .touchUpInside)
        
        let stack = UIStackView(arrangedSubviews: [retakeButton, saveButton])
        stack.axis = .horizontal
        stack.spacing = 20
        
        view.addSubview(stack)
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            imageView.widthAnchor.constraint(equalToConstant: 300),
            imageView.heightAnchor.constraint(equalToConstant: 400),
            
            stack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stack.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 20)
        ])
    }

    @objc func savePhoto() {
        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
        dismiss(animated: true)
    }

    @objc func dismissView() {
        dismiss(animated: true)
    }
}
