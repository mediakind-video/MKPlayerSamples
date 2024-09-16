//
//  ViewController.swift
//  MultiviewDemoAppTVOS
//
//  Created by Karthi on 16/09/24.
//

import UIKit
import AVKit

class ViewController: UIViewController {

    @IBOutlet weak var playerView1: UIView!
    @IBOutlet weak var playerView2: UIView!
    @IBOutlet weak var playerView3: UIView!
    @IBOutlet weak var playerView4: UIView!
    
    
    var playerModels: [MultiViewPlayerModel] = []
    var playback1: MultiViewPlayerModel? =  nil;
    var playback2: MultiViewPlayerModel? =  nil;
    var playback3: MultiViewPlayerModel? =  nil;
    var playback4: MultiViewPlayerModel? =  nil;
    
    var avPlayerViewController: AVPlayerViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        avPlayerViewController = AVPlayerViewController()
        avPlayerViewController.view?.frame = playerView1.bounds
        
        addChild(avPlayerViewController)
       // avPlayerViewController.didMove(toParent: self)
        avPlayerViewController.contentOverlayView?.frame = playerView1.bounds
        avPlayerViewController.contentOverlayView?.isHidden = false
        avPlayerViewController.showsPlaybackControls = true
        playerView1.addSubview(avPlayerViewController.view)
        // Do any additional setup after loading the view.
        playerModels.append(MultiViewPlayerModels.nbaSitANBAtvdPlayback(playerViewController: avPlayerViewController))
        playerModels.append(MultiViewPlayerModels.nbaSitANBAtvdPlayback(parentView: playerView2))
        playerModels.append(MultiViewPlayerModels.nbaSitANBAtvdPlayback(parentView: playerView3))
        playerModels.append(MultiViewPlayerModels.nbaSitANBAtvdPlayback(parentView: playerView4))
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        for model in playerModels {
            model.load()
        }
    }



}

