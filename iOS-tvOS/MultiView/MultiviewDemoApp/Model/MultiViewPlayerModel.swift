//
//  MultiViewPlayerModel.swift
//  MultiviewDemoApp
//
//  Created by Karthi on 20/08/24.
//

import Foundation
import MKPlayer
import UIKit
import AVKit

class MultiViewPlayerModel {
    private var player: MKPlayer? = nil
    let playerConfiguration: MKPPlayerConfiguration
    let parentView: UIView
    let sourceConfig: MKPSourceConfiguration
    
    init(playerConfiguration: MKPPlayerConfiguration, parentView: UIView, sourceConfig: MKPSourceConfiguration) {
        self.playerConfiguration = playerConfiguration
        self.parentView = parentView
        self.sourceConfig = sourceConfig
        player = MKPlayer(parentView: parentView, configuration: playerConfiguration)
        player?.addEvent(listener: self)
    }
    
    init(playerConfiguration: MKPPlayerConfiguration, playerViewController: AVPlayerViewController , sourceConfig: MKPSourceConfiguration) {
        self.playerConfiguration = playerConfiguration
        self.parentView = playerViewController.view
        self.sourceConfig = sourceConfig
        player = MKPlayer(playerViewController: playerViewController, configuration: playerConfiguration)
        player?.addEvent(listener: self)
    }
    
    func load() {
        guard let player = player else {
            print("Player is nil")
            return
        }
        player.load(sourceConfiguration: sourceConfig)
    }
    
}

extension MultiViewPlayerModel: MKPPlayerEventListener {
    func onPlay(event: MKPPlayEvent) {
        self.player?.scalingMode = .zoom
    }
}

struct MultiViewPlayerModels {
        
    static func nbaSitANBAtvdPlayback(parentView: UIView) -> MultiViewPlayerModel {
        let playerConfiguration = getPlayerConfiguration()
        playerConfiguration.backendConfiguration = MKPBackendConfiguration(serverUrl: "https://ottapp-appgw-amp-a.proda.nba.tv3cloud.com", authToken: "AuthToken1jVDLbtswEPwa60aBb5EHHYTYbYwmbQEn7ZmPlU1EEg2SSux-feU8WqBoiwCL3cXszA4w3ewDTA7aQynHvGLdin5YKsFwDtP-aFI518cUvakna-ryyNwQZ1-7OC6sapvzDOkPbS75P5IL9zfVHWA0uT6NQ47mWMe0X9CnvDSKsVjGcwsephLKeVndYMJ4uU9mhHbOCGtrvO8xIlIYxAXWSHGPkaGub6wG2nhW3cFkprL1rYfezEOpumGIT-Df8PzrcJ8hLbz3Pu6ci_PzZ2Yaa4ACEtZyxH3TIK0FICUo9s663mGo1i8urybvkvw1rzG4FHPsy2uqb4mpS2LyH4mlOECbZ5tdChZS1c3lEFP4YUqI063JDy0RmnDGmZCCEEYaKrjSDaWMaI6lVlRKpRglXGipqBBEECq1UFgrKTAllGnKOCZs2UVDOVViCa-hqtqcjiFB_jK1y1fFJeWSVVcJTAH_AopGLR6s-gTnj3PwLTYYc84NwmAc4lZ5pHqmEVhPtDdWOcqq69vuanfdUSHb8WZeG6Xj5xNNan8zrai9V98u4zv7Ou3uYBPG3bo3jwxvH8hmxfxP")
        let sourceConfig = MKPSourceConfiguration(mediaId: "NBATVD", isLive: true, applicationToken: "1023", title: "NBA")
        return MultiViewPlayerModel(playerConfiguration: playerConfiguration, parentView: parentView, sourceConfig: sourceConfig)
    }
    
    static func nbaSitANBAtvdPlayback(playerViewController: AVPlayerViewController) -> MultiViewPlayerModel {
        let playerConfiguration = getPlayerConfiguration()
        playerConfiguration.backendConfiguration = MKPBackendConfiguration(serverUrl: "https://ottapp-appgw-amp-a.proda.nba.tv3cloud.com", authToken: "AuthToken1jVDLbtswEPwa60aBb5EHHYTYbYwmbQEn7ZmPlU1EEg2SSux-feU8WqBoiwCL3cXszA4w3ewDTA7aQynHvGLdin5YKsFwDtP-aFI518cUvakna-ryyNwQZ1-7OC6sapvzDOkPbS75P5IL9zfVHWA0uT6NQ47mWMe0X9CnvDSKsVjGcwsephLKeVndYMJ4uU9mhHbOCGtrvO8xIlIYxAXWSHGPkaGub6wG2nhW3cFkprL1rYfezEOpumGIT-Df8PzrcJ8hLbz3Pu6ci_PzZ2Yaa4ACEtZyxH3TIK0FICUo9s663mGo1i8urybvkvw1rzG4FHPsy2uqb4mpS2LyH4mlOECbZ5tdChZS1c3lEFP4YUqI063JDy0RmnDGmZCCEEYaKrjSDaWMaI6lVlRKpRglXGipqBBEECq1UFgrKTAllGnKOCZs2UVDOVViCa-hqtqcjiFB_jK1y1fFJeWSVVcJTAH_AopGLR6s-gTnj3PwLTYYc84NwmAc4lZ5pHqmEVhPtDdWOcqq69vuanfdUSHb8WZeG6Xj5xNNan8zrai9V98u4zv7Ou3uYBPG3bo3jwxvH8hmxfxP")
        let sourceConfig = MKPSourceConfiguration(mediaId: "NBATVD", isLive: true, applicationToken: "1023", title: "NBA")
        return MultiViewPlayerModel(playerConfiguration: playerConfiguration, playerViewController: playerViewController, sourceConfig: sourceConfig)
    }
    
    static func nba2SitANBAtvdPlayback(parentView: UIView) -> MultiViewPlayerModel {
        let playerConfiguration = getPlayerConfiguration()
        playerConfiguration.backendConfiguration = MKPBackendConfiguration(serverUrl: "https://ottapp-appgw-amp-a.proda.nba.tv3cloud.com", authToken: "AuthToken1jVLbbtQwEP2a5s2RPb4_5CG0lC1oQYKWd9-yG5HEi-2w3X493l5AQoAqWePRmXPOSEfTr34MiwvdvpRDvqD9BVzXl8J0GpfdwaRyag8petMu1rTlB3VTXH3r4lxZzU3Oa0h_aHPJ_5Gcub-pbh9mk9v7ecrRHNqYdhU95loAY16_xzL6sJSxnGrrJjPO5_li5tCtGWFtjfcDRkRwgxjHGinmMTLgBml1AOlpcxsWs5Qb3_kwmHUqTT9N8Rj8C55_De5ySJX3WuPeubg-OlMjrQkQELeWIealRFrzgBQH7J11g8OhuXra8rzkVZK_5jWPLsUch_Kc6kti6pyY-EdiKU6hy6vNLo02pKZfyz6m8cGUMS5bk791hGvCKKNccEIokcCZ0hKAEs2w0AqEUIoCYVwLBZwTTkBorrBWgmMgQDVQhgmtPZfAQPEangTVvL0_jCnkT0tXXaXQhINsLlMwJfgnkFcZqeCHcHq3jr4TmjFNOUXGSIwYIxhppgfEPRFWE4sZGZrNtr_8sumBiw7v-u3DgbkLGDZfxanI2pjvx-uPG0u9vvqM97D079dNJdj85k7Ve_U_AQ")
        let sourceConfig = MKPSourceConfiguration(mediaId: "NBATVD", isLive: true, applicationToken: "1023", title: "NBA")
        return MultiViewPlayerModel(playerConfiguration: playerConfiguration, parentView: parentView, sourceConfig: sourceConfig)
    }
    
    static func getPlayerConfiguration() -> MKPPlayerConfiguration {
        let playerConfiguration = MKPPlayerConfiguration()
        playerConfiguration.key = "91c1e62d-1547-464b-a73c-4701fc5dea24"
        playerConfiguration.isMuted = true
        playerConfiguration.isUiEnabled = true
        playerConfiguration.isAutoplayEnabled = true
        playerConfiguration.isLoggingEnabled = true
        return playerConfiguration
    }
}
