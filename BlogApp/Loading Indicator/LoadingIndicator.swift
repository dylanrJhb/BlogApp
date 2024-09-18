//
//  LoadingIndicator.swift
//  BlogApp
//
//  Created by Reid, Dylan D on 2024/09/09.
//

import Foundation
import NVActivityIndicatorView

var activityIndicator: NVActivityIndicatorView?

class LoadingIndicator {
    
    var activityIndicator: NVActivityIndicatorView?
    
    func showLoadingIndicator(view: UIView) {
        let frame = CGRect(x: view.frame.width / 2 - 25, y: view.frame.height / 2 - 25, width: 50, height: 50)
        activityIndicator = NVActivityIndicatorView(frame: frame, type: .ballClipRotatePulse, color: .black, padding: nil)
        
        if let activityIndicator = activityIndicator {
            view.addSubview(activityIndicator)
            activityIndicator.startAnimating()
        }
    }
    
    func hideLoadingIndicator() {
        if let activityIndicator = activityIndicator {
            activityIndicator.stopAnimating()
            activityIndicator.removeFromSuperview()
        }
    }
}
