//
//  ViewController.swift
//  MultiviewDemoApp
//
//  Created by Karthi on 20/08/24.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var videoView1: UIView!
    @IBOutlet weak var videoView2: UIView!
    @IBOutlet weak var videoView3: UIView!
    @IBOutlet weak var videoView4: UIView!
    
    var playerModels: [MultiViewPlayerModel] = []
    var playback1: MultiViewPlayerModel? =  nil;
    var playback2: MultiViewPlayerModel? =  nil;
    var playback3: MultiViewPlayerModel? =  nil;
    var playback4: MultiViewPlayerModel? =  nil;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        playerModels.append(MultiViewPlayerModels.nbaSitANBAtvdPlayback(parentView: videoView1))
        playerModels.append(MultiViewPlayerModels.nbaSitANBAtvdPlayback(parentView: videoView2))
        playerModels.append(MultiViewPlayerModels.nbaSitANBAtvdPlayback(parentView: videoView3))
        playerModels.append(MultiViewPlayerModels.nbaSitANBAtvdPlayback(parentView: videoView4))
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        for model in playerModels {
            model.load()
        }
    }


}

