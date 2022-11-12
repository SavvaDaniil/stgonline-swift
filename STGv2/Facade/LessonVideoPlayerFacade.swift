//
//  LessonVideoPlayerFacade.swift
//  STGv2
//
//  Created by Daniil Savva on 05.11.2022.
//

import Foundation
import AVFoundation
import UIKit

class LessonVideoPlayerFacade {
    
    private var _player: AVPlayer?
    private var _playing: Bool = true
    private var _isPlayerFlip: Bool = false
    private var _isPlayerRotate: Bool = false
    
    private var _lessonVideoViewModel: LessonVideoViewModel
    private var _lessonVideoPlayerControlPanel : LessonVideoPlayerControlPanel?
    private var _lessonVideoPlayerView : LessonVideoPlayerView?
    private var _lessonVideoPlayerSpeedPanelView : LessonVideoPlayerSpeedPanelView?
    private var isControlPanelActive: Bool = true
    
    init(_ player: AVPlayer, _ lessonVideoViewModel: LessonVideoViewModel, _ lessonVideoPlayerControlPanel: LessonVideoPlayerControlPanel, _ lessonVideoPlayerView: LessonVideoPlayerView){
        self._player = player
        self._lessonVideoViewModel = lessonVideoViewModel
        self._lessonVideoPlayerControlPanel = lessonVideoPlayerControlPanel
        self._lessonVideoPlayerView = lessonVideoPlayerView
        self._lessonVideoPlayerSpeedPanelView = lessonVideoPlayerControlPanel.getSpeedPanel()
        
        
        lessonVideoPlayerControlPanel.btnPlayPause.addTarget(self, action: #selector(videoPlayPauseControl), for: .touchUpInside)
        lessonVideoPlayerControlPanel.btnMirror!.addTarget(self, action: #selector(flipPlayer), for: .touchUpInside)
        lessonVideoPlayerControlPanel.btnTurn!.addTarget(self, action: #selector(rotatePlayer), for: .touchUpInside)
        
        
        //добавление секций видео
        
        
        
        
        setFunctionsForBtnsSpeed()
    }
    
    public func changeActiveOfControlPanel(){
        if isControlPanelActive {
            _lessonVideoPlayerControlPanel?.hideControls(true)
        } else {
            _lessonVideoPlayerControlPanel?.hideControls(false)
        }
        isControlPanelActive.toggle()
    }
    
    @objc
    private func timeoutActiceVideoPlayerControlPanel(){
        self.changeActiveOfControlPanel()
    }
    
    @objc
    private func videoPlayPauseControl(){
        if _playing {
            _player?.pause()
            _lessonVideoPlayerControlPanel!.changeActiveOfBtnPlayPause(false)
        } else {
            _player?.play()
            _lessonVideoPlayerControlPanel!.changeActiveOfBtnPlayPause(true)
        }
        _playing.toggle()
    }
    
    @objc
    private func flipPlayer(){
        UIView.animate(withDuration: 0.0) { [unowned self] in
            _lessonVideoPlayerView!.transform = _lessonVideoPlayerView!.transform.concatenating(CGAffineTransform(scaleX: -1, y: 1))
        }
        if _isPlayerFlip {
            _lessonVideoPlayerControlPanel!.btnMirror!.changeActive(false)
        } else {
            _lessonVideoPlayerControlPanel!.btnMirror!.changeActive(true)
        }
        _isPlayerFlip.toggle()
    }
    
    @objc func rotatePlayer(){
        if _isPlayerRotate {
            UIView.animate(withDuration: 0.0) { [unowned self] in
                _lessonVideoPlayerView?.frame.origin.y = 0
            }
            _lessonVideoPlayerControlPanel!.btnTurn!.changeActive(false)
        } else {
            UIView.animate(withDuration: 0.0) { [unowned self] in
                _lessonVideoPlayerView?.frame.origin.y = -((_lessonVideoPlayerView?.frame.height)! / 2)
            }
            _lessonVideoPlayerControlPanel!.btnTurn!.changeActive(true)
        }
        _isPlayerRotate.toggle()
    }
    
    
    private func setFunctionsForBtnsSpeed(){
        let arrayOfSpeed: [Float] = [0.5, 0.75, 1.0, 1.5, 2.0]
        for speed: Float in arrayOfSpeed {
            self._lessonVideoPlayerSpeedPanelView?.getBtnSpeed(speed)!.addTarget(self, action: #selector(changePlayerSpeed), for: .touchUpInside)
        }
    }
    
    @objc
    private func changePlayerSpeed(sender:LessonVideoPlayerBtnSpeed) -> (){
        _lessonVideoPlayerSpeedPanelView?.setBtnSpeedActive(sender)
        _player?.rate = sender.getValue()
    }
    
    public func changeTimecodeByVideoSubsection(videoSubsectionLiteViewModel: VideoSubsectionLiteViewModel) -> (){
        let seekTime: CMTime = CMTimeMakeWithSeconds(TimecodeConverter.getSecondsFromVideoSubsection(videoSubsectionLiteViewModel: videoSubsectionLiteViewModel), preferredTimescale: 1)
        _player?.seek(to: seekTime)
    }
}
