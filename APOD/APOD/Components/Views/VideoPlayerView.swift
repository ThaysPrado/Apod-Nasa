//
//  VideoPlayerView.swift
//  APOD
//
//  Created by Thays Prado on 01/02/25.
//

import SwiftUI
import WebKit

struct VideoPlayerView: UIViewControllerRepresentable {
    var videoURL: String
    
    func makeUIViewController(context: Context) -> UIViewController {
        let webView = WKWebView(frame: .zero)
        let url = URL(string: videoURL)!
        let request = URLRequest(url: url)
        webView.load(request)
        
        let viewController = UIViewController()
        viewController.view = webView
        return viewController
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {}
}
