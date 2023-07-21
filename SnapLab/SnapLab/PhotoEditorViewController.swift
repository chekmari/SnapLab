//
//  PhotoEditorViewController.swift
//  SnapLab
//
//  Created by macbook on 30.04.2023.
//

import UIKit
import SnapKit

class PhotoEditorViewController: UIViewController {
    
    private let imageView = UIImageView()
    private let metalView = MetalView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        imageView.contentMode = .scaleAspectFit
        view.addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(20)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-20)
        }
        
        view.addSubview(metalView)
        metalView.snp.makeConstraints { make in
            make.edges.equalTo(imageView)
        }
    }
    
    func setPhoto(_ photo: UIImage) {
        imageView.image = photo
        metalView.setPhoto(photo)
    }
    
}

