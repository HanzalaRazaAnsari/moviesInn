//
//  UIExtensions.swift
//  MoviesInn
//
//  Created by Admin on 08/09/2023.
//

import Foundation
import UIKit
import Kingfisher


extension UINavigationController {
    func setStatusBar(backgroundColor: UIColor) {
        let statusBarFrame: CGRect
        if #available(iOS 13.0, *) {
            statusBarFrame = view.window?.windowScene?.statusBarManager?.statusBarFrame ?? CGRect.zero
        } else {
            statusBarFrame = UIApplication.shared.statusBarFrame
        }
        let statusBarView = UIView(frame: statusBarFrame)
        statusBarView.backgroundColor = backgroundColor
        view.addSubview(statusBarView)
    }
}


extension UIImageView {
    public func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
    
    public func kingFisherImage(Url:String){
        let resources = ImageResource(downloadURL: URL(string: Url)!, cacheKey:Url)
        //                   let ImageViewSize = SizeOfView
        let processor = DownsamplingImageProcessor(size: self.frame.size)
        //        let processor = DownsamplingImageProcessor(size: )
        //                               >> RoundCornerImageProcessor(cornerRadius: ImageView.frame.width)
        self.kf.indicatorType = .activity
        self.kf.setImage(
            with: resources,
            placeholder: nil,
            options: [
                .processor(processor),
                .scaleFactor(UIScreen.main.scale),
                .transition(.flipFromTop(0.7)),
                .cacheOriginalImage,
                .downloadPriority(100)
                
            ])
    }
    
    public func kfCachedImageWithURL(imageURL: URL){
        // Setup:
        let resources = ImageResource(downloadURL: imageURL)
        let processor = DownsamplingImageProcessor(size: self.frame.size)
        self.kf.indicatorType = .activity
        
        // Animation:
        self.kf.setImage(
            with: resources,
            placeholder: nil,
            options: [
                .processor(processor),
                .scaleFactor(UIScreen.main.scale),
                .cacheOriginalImage,
                .downloadPriority(0.9)
                
            ])
    }
    
//    public func setImageWithPlaceHolder(path: String, completion: ((Bool) -> Void)? = nil){
//        self.sd_setImage(with: URL(string: path), placeholderImage:UIImage(named: "tokri_loading"), completed: { (image, error, cacheType, url) -> Void in
//            guard let action = completion else {return}
//            action(error != nil)
//        })
//    }
//
//    public func setImageWithPlaceHolder(loadingImage: String, path: String){
//        self.sd_setImage(with: URL(string: path), placeholderImage:UIImage(named: loadingImage))
//    }
}
