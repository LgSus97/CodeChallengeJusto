//
//  YTVideoPlayerViewController.swift
//  CodeChallengeJusto
//
//  Created by Jesus Loaiza Herrera on 07/08/22.
//

import UIKit
import youtube_ios_player_helper

class YTVideoPlayerViewController: UIViewController, Storyboarded {
  
  @IBOutlet weak var player: YTPlayerView!
  
  var urlVideo : String? =  ""
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    playVideo(urlVideo: urlVideo)
    player.delegate = self
    // Do any additional setup after loading the view.
  }
  
  func setup(urlVideo:String?){
    self.urlVideo = urlVideo
  }
  
  func playVideo(urlVideo:String?){
    
    let playerVars: [String: Any] = [   // Controles
      "controls": 0,
      "modestbranding": 0,
      "playsinline": 0,
      "autohide" : 0,
      "disablekb" : 0,
      "rel": 0,
      "showinfo": 0,
      "autoplay": 1
    ]
    
    guard urlVideo != nil else {        // Valida que no llegue vacio la url
      showMessage(body: "Fail to load video", title: "Error")
      navigationController?.popViewController(animated: false)
      return
    }
    
    if urlVideo!.contains("short"){   // Valida si es un short video
      let id = Tools.getIdShortVideo(urlVideo: urlVideo ?? "")
      player.load(withVideoId: id , playerVars: playerVars)
    }else if let url = urlVideo?.youtubeID { // Cualquier otro tipo de video
      player.load(withVideoId: url , playerVars: playerVars)
    }else{
      showMessage(body: "Fail to load video", title: "Error")
      navigationController?.popViewController(animated: false)
    }
  }
  
  
  
}

extension YTVideoPlayerViewController: YTPlayerViewDelegate{
  func playerViewDidBecomeReady(_ playerView: YTPlayerView) {
    player.playVideo()
  }
  
  func playerView(_ playerView: YTPlayerView, didChangeTo state: YTPlayerState) {
    if state == .ended{
      print("** Finish video **")
      print("**              **")
      navigationController?.popViewController(animated: false)
    }
  }
  
  func playerView(_ playerView: YTPlayerView, receivedError error: YTPlayerError) {
    print(error)
  }
}


