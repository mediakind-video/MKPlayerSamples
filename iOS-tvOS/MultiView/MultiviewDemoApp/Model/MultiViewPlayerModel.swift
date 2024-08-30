//
//  MultiViewPlayerModel.swift
//  MultiviewDemoApp
//
//  Created by Karthi on 20/08/24.
//

import Foundation
import MKPlayer
import UIKit

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
        playerConfiguration.backendConfiguration = MKPBackendConfiguration(serverUrl: "https://ottapp-appgw-amp-a.proda.nba.tv3cloud.com", authToken: "AuthToken1jVLbbtQwEP2a5s2RPb4_5CG0lC1oQYKWd9-yG5HEi-2w3X493l5AQoAqWePRmXPOSEfTr34MiwvdvpRDvqD9BVzXl8J0GpfdwaRyag8petMu1rTlB3VTXH3r4lxZzU3Oa0h_aHPJ_5Gcub-pbh9mk9v7ecrRHNqYdhU95loAY16_xzL6sJSxnGrrJjPO5_li5tCtGWFtjfcDRkRwgxjHGinmMTLgBml1AOlpcxsWs5Qb3_kwmHUqTT9N8Rj8C55_De5ySJX3WuPeubg-OlMjrQkQELeWIealRFrzgBQH7J11g8OhuXra8rzkVZK_5jWPLsUch_Kc6kti6pyY-EdiKU6hy6vNLo02pKZfyz6m8cGUMS5bk791hGvCKKNccEIokcCZ0hKAEs2w0AqEUIoCYVwLBZwTTkBorrBWgmMgQDVQhgmtPZfAQPEangTVvL0_jCnkT0tXXaXQhINsLlMwJfgnkFcZqeCHcHq3jr4TmjFNOUXGSIwYIxhppgfEPRFWE4sZGZrNtr_8sumBiw7v-u3DgbkLGDZfxanI2pjvx-uPG0u9vvqM97D079dNJdj85k7Ve_U_AQ")
        let sourceConfig = MKPSourceConfiguration(mediaId: "NBATVD", isLive: true, applicationToken: "1023", title: "NBA")
        return MultiViewPlayerModel(playerConfiguration: playerConfiguration, parentView: parentView, sourceConfig: sourceConfig)
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
