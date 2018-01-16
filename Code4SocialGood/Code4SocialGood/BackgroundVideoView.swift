//
//  BackgroundVideoView.swift
//  Code4SocialGood
//
//  Created by Derek Carter on 1/15/18.
//  Copyright © 2018 Code 4 Social Good. All rights reserved.
//

import AVKit
import UIKit

class BackgroundVideoView: UIView {

    // Video player properties
    public var player: AVPlayer!
    private var playerLayer: AVPlayerLayer!
    private var videoView: UIView!
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.clear
        
        self.addVideoViewAndConstraints()
        
        let path = Bundle.main.path(forResource: "BackgroundVideo", ofType: "mp4")
        player = AVPlayer(url: URL(fileURLWithPath: path!))
        player!.actionAtItemEnd = AVPlayerActionAtItemEnd.none
        player!.seek(to: kCMTimeZero)
        
        NotificationCenter.default.addObserver(self, selector: #selector(playerItemDidReachEnd(_:)), name: Notification.Name.AVPlayerItemDidPlayToEndTime, object: player!.currentItem)
        
        playerLayer = AVPlayerLayer(player: player)
        playerLayer.videoGravity = .resizeAspectFill
        playerLayer.needsDisplayOnBoundsChange = true
        videoView.layer.addSublayer(playerLayer)
        
        player!.play()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.playerLayer.frame = self.bounds
    }
    
    
    // MARK: - UI Setup Methods
    
    private func addVideoViewAndConstraints() {
        videoView = UIView()
        videoView.translatesAutoresizingMaskIntoConstraints = false
        videoView.backgroundColor = UIColor.clear
        self.addSubview(videoView)
        
        videoView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        videoView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        videoView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        videoView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    }
    
    
    // MARK: - Notification Methods
    
    @objc func playerItemDidReachEnd(_ notification: NSNotification) {
        // Set to repeat
        player!.seek(to: kCMTimeZero)
    }
    
}
