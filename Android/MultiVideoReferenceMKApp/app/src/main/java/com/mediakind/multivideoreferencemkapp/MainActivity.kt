package com.mediakind.multivideoreferencemkapp

import android.os.Bundle
import android.widget.RelativeLayout
import androidx.appcompat.app.AppCompatActivity
import com.mediakind.mkplayer.MKPlayer
import com.mediakind.mkplayer.config.MKSourceConfig
import com.mediakind.mkplayer.config.MKPSourceConfiguration
import com.mediakind.mkplayer.config.MKPBackendConfiguration
import com.mediakind.mkplayer.config.MKPlayerConfiguration
import com.mediakind.mkplayer.config.MKPAnalyticsConfiguration
import com.mediakind.mkplayer.config.MKPTweaksConfiguration

import org.json.JSONObject
import java.io.InputStream
import com.mediakind.multivideoreferencemkapp.databinding.ActivityMainBinding


class MainActivity : AppCompatActivity() {
    private var player1: MKPlayer? = null
    private var player2: MKPlayer? = null
    private var player3: MKPlayer? = null
    private var player4: MKPlayer? = null
    private var authToken : String? = null

    private lateinit var binding: ActivityMainBinding

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        binding = ActivityMainBinding.inflate(layoutInflater)
        setContentView(binding.root)

        val configData = readConfigFromJson()

        initializePlayerViews(configData)

        initializePlayer(player1, configData[0])
        initializePlayer(player2, configData[1])
        initializePlayer(player3, configData[2])
        initializePlayer(player4, configData[3])
    }

    override fun onStart() {
        super.onStart()
        listOf(player1, player2, player3, player4).forEach { it?.play() }
//        listOf(player1).forEach { it?.play() }
    }

    override fun onResume() {
        super.onResume()
        listOf(player1, player2, player3, player4).forEach { it?.play() }
//        listOf(player1).forEach { it?.play() }
    }

    override fun onPause() {
//        listOf(player1).forEach { it?.pause() }
        listOf(player1, player2, player3, player4).forEach { it?.pause() }
        super.onPause()
    }

    override fun onStop() {
//        listOf(player1).forEach { it?.destroy() }
        listOf(player1, player2, player3, player4).forEach { it?.destroy() }
        super.onStop()
    }

    override fun onDestroy() {
//        listOf(player1).forEach { it?.destroy() }
        listOf(player1, player2, player3, player4).forEach { it?.destroy() }
        super.onDestroy()
    }

    private fun initializePlayerViews(configData: List<JSONObject>) {
        val playerViewContainer1 = binding.playerViewContainer1
        val playerViewContainer2 = binding.playerViewContainer2
        val playerViewContainer3 = binding.playerViewContainer3
        val playerViewContainer4 = binding.playerViewContainer4

        player1 = createPlayerWithConfig(playerViewContainer1, configData[0])
        player2 = createPlayerWithConfig(playerViewContainer2, configData[1])
        player3 = createPlayerWithConfig(playerViewContainer3, configData[2])
        player4 = createPlayerWithConfig(playerViewContainer4, configData[3])


        player1?.setInHomeStatus(true)
        player2?.setInHomeStatus(true)
        player3?.setInHomeStatus(true)
        player4?.setInHomeStatus(true)

        player1?.setLocationDetails("eyJQb3N0YWxDb2RlIjoiMTAwMDEiLCJDb3VudHJ5Q29kZSI6IlVTIn0=")
        player2?.setLocationDetails("eyJQb3N0YWxDb2RlIjoiMTAwMDEiLCJDb3VudHJ5Q29kZSI6IlVTIn0=")
        player3?.setLocationDetails("eyJQb3N0YWxDb2RlIjoiMTAwMDEiLCJDb3VudHJ5Q29kZSI6IlVTIn0=")
        player4?.setLocationDetails("eyJQb3N0YWxDb2RlIjoiMTAwMDEiLCJDb3VudHJ5Q29kZSI6IlVTIn0=")
    }

    private fun createPlayerWithConfig(container: RelativeLayout, config: JSONObject): MKPlayer {
        val serverUrl = config.optString("serverUrl", null)
        val clientUrl = config.optString("clientUrl", null)  // Assuming you have this in your config
        val authToken = config.optString("stsToken", null)
        this.authToken = authToken

        var backendConfiguration: MKPBackendConfiguration? = null

        if (!serverUrl.isNullOrEmpty() && !authToken.isNullOrEmpty() && !clientUrl.isNullOrEmpty()) {
            backendConfiguration = MKPBackendConfiguration(
                serverUrl = serverUrl,
                authToken = authToken,
                ownerUid = "azuki"
            )
        }

        val tweaksConfiguration = MKPTweaksConfiguration(
            bandwidthEstimateWeightLimit = 2000,
            exoPlayerCache = null,
            languagePropertyNormalization = true,
            localDynamicDashWindowUpdateInterval = null,
            timeChangedInterval = 0.2,
            useFiletypeExtractorFallbackForHls = false,
            minForwardBufferLevelForQualityIncrease = 2.0,
            allowChunklessPreparationForHls = true,
            preferSoftwareDecodingForAds = false,
            preferSoftwareDecoding = true   // Most Important Setting for MultiVideo
        )

        val playerConfig = MKPlayerConfiguration().apply {
            isUiEnabled = true
            isLoggingEnabled = true
            if (backendConfiguration != null) {
                this.backendConfiguration = backendConfiguration
            }
            this.setTweaksConfiguration(tweaksConfiguration)
        }

        return MKPlayer(this, container, playerConfig)
    }


    private fun initializePlayer(player: MKPlayer?, config: JSONObject) {
        val sourceConfigJson = config.getJSONObject("sourceConfig")
        val title = sourceConfigJson.getString("title")
        val mediaId = sourceConfigJson.optString("mediaId", "")
        val applicationToken = sourceConfigJson.optString("applicationToken", "")
        val isLive = sourceConfigJson.getBoolean("isLive")
        val posterSource = sourceConfigJson.optString("posterSource","")
        val metadata = sourceConfigJson.optJSONObject("metadata")

        // Check if the external manifest URL is provided
        val externalManifestUrl = sourceConfigJson.optString("externalManifestUrl", null)

        val sourceConfig = if (externalManifestUrl.isNullOrEmpty()) {
            MKSourceConfig(
                mediaUid = mediaId,
                applicationToken = applicationToken,
                isLive = isLive,
                stsToken = this.authToken,
                posterSource = posterSource,
                metadata = metadata?.toMap()
            )
        } else {
            // Use the external manifest URL instead of the default source configuration
            MKSourceConfig(
                externalSourceUrl = externalManifestUrl,
                isLive = isLive,
            )
        }

        val startOffset = null
        val analyticsConfig: MKPAnalyticsConfiguration? = null
        player?.load(MKPSourceConfiguration(sourceConfig, analyticsConfig, options = startOffset))
    }

    private fun readConfigFromJson(): List<JSONObject> {
        val inputStream: InputStream = assets.open("player_config.json")
        val json = inputStream.bufferedReader().use { it.readText() }
        val jsonObject = JSONObject(json)
        val playersArray = jsonObject.getJSONArray("players")

        return List(playersArray.length()) { i -> playersArray.getJSONObject(i) }
    }

    private fun JSONObject.toMap(): Map<String, String> {
        val map = mutableMapOf<String, String>()
        val keys = keys()
        while (keys.hasNext()) {
            val key = keys.next()
            map[key] = getString(key)
        }
        return map
    }
}
