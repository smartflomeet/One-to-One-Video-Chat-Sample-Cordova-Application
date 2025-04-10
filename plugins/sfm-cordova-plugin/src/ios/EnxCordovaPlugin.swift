//
//  EnxCordovaPlugin.swift
//  SampleApp
//
//  Created by smartflowMeet on 16/05/24.
//

import UIKit
//import Cordova
import Foundation
import EnxRTCiOS
import AVFoundation


open class EnxCordovaPlugin: CDVPlugin {
    
    var mEnxRtc : EnxRtc!
    var mEnxRoom : EnxRoom!
    var mLocalStream : EnxStream!
    var mlocalView  : EnxPlayerView!
    var eventListional : [String : Any] = [:]
    var scale : Float = 0.0
    var parentView : UIView!
    var mRemoteView : UIView!
    var mOptionView : UIView!
    var mOptionStream : EnxStream!
    var mOptionPlayer : EnxPlayerView!
    var firstX : CGFloat = 0.0
    var firstY : CGFloat = 0.0
    var roomMode : String!
    
    //MARK: - Publice /Enxternal Apis
    //Register Event Listerenr
    @objc
    public func onRoomConnected(_ command : CDVInvokedUrlCommand){
        updateEventList(command: command, forKey: "onRoomConnected")
    }
    @objc
    public func onRoomDisConnected(_ command : CDVInvokedUrlCommand){
        updateEventList(command: command, forKey: "onRoomDisConnected")
    }
    @objc
    public func onEventError(_ command : CDVInvokedUrlCommand){
        updateEventList(command: command, forKey: "onEventError")
    }
    @objc
    public func onPublishStream(_ command : CDVInvokedUrlCommand){
        updateEventList(command: command, forKey: "onPublishStream")
    }
    @objc
    public func onAddedStream(_ command : CDVInvokedUrlCommand){
        updateEventList(command: command, forKey: "onAddedStream")
    }
    @objc
    public func onSubscribeStream(_ command : CDVInvokedUrlCommand){
        updateEventList(command: command, forKey: "onSubscribeStream")
    }
    @objc
    public func onAudioEvent(_ command : CDVInvokedUrlCommand){
        updateEventList(command: command, forKey: "onAudioEvent")
    }
    @objc
    public func onVideoEvent(_ command : CDVInvokedUrlCommand){
        updateEventList(command: command, forKey: "onVideoEvent")
    }
    @objc
    public func onNotifyDeviceUpdate(_ command : CDVInvokedUrlCommand){
        updateEventList(command: command, forKey: "onNotifyDeviceUpdate")
    }
    @objc
    public func onUserConnected(_ command : CDVInvokedUrlCommand){
        updateEventList(command: command, forKey: "onUserConnected")
    }
    @objc
    public func onUserDisConnected(_ command : CDVInvokedUrlCommand){
        updateEventList(command: command, forKey: "onUserDisConnected")
    }
    @objc
    public func onRoomError(_ command : CDVInvokedUrlCommand){
        updateEventList(command: command, forKey: "onRoomError")
    }
    @objc
    public func onEventInfo(_ command : CDVInvokedUrlCommand){
        updateEventList(command: command, forKey: "onEventInfo")
    }
    @objc
    public func onGetTalkerCount(_ command : CDVInvokedUrlCommand){
        updateEventList(command: command, forKey: "onGetTalkerCount")
    }
    @objc
    public func onMaxTalkerCount(_ command : CDVInvokedUrlCommand){
        updateEventList(command: command, forKey: "onMaxTalkerCount")
    }
    @objc
    public func onSetTalkerCount(_ command : CDVInvokedUrlCommand){
        updateEventList(command: command, forKey: "onSetTalkerCount")
    }
    @objc
    public func onAckLockRoom(_ command : CDVInvokedUrlCommand){
        updateEventList(command: command, forKey: "onAckLockRoom")
    }
    @objc
    public func onAckUnLockRoom(_ command : CDVInvokedUrlCommand){
        updateEventList(command: command, forKey: "onAckUnLockRoom")
    }
    @objc
    public func onLockedRoom(_ command : CDVInvokedUrlCommand){
        updateEventList(command: command, forKey: "onLockedRoom")
    }
    @objc
    public func onUnLockedRoom(_ command : CDVInvokedUrlCommand){
        updateEventList(command: command, forKey: "onUnLockedRoom")
    }
    @objc
    public func onAckDropUser(_ command : CDVInvokedUrlCommand){
        updateEventList(command: command, forKey: "onAckDropUser")
    }
    @objc
    public func onAckDestroy(_ command : CDVInvokedUrlCommand){
        updateEventList(command: command, forKey: "onAckDestroy")
    }
    @objc
    public func onLogUploaded(_ command : CDVInvokedUrlCommand){
        updateEventList(command: command, forKey: "onLogUploaded")
    }
    @objc
    public func onHardMutedAudio(_ command : CDVInvokedUrlCommand){
        updateEventList(command: command, forKey: "onHardMutedAudio")
    }
    @objc
    public func onHardUnMutedAudio(_ command : CDVInvokedUrlCommand){
        updateEventList(command: command, forKey: "onHardUnMutedAudio")
    }
    @objc
    public func onReceivedHardMuteAudio(_ command : CDVInvokedUrlCommand){
        updateEventList(command: command, forKey: "onReceivedHardMuteAudio")
    }
    @objc
    public func onReceivedHardUnMuteAudio(_ command : CDVInvokedUrlCommand){
        updateEventList(command: command, forKey: "onReceivedHardUnMuteAudio")
    }
    @objc
    public func onHardMutedVideo(_ command : CDVInvokedUrlCommand){
        updateEventList(command: command, forKey: "onHardMutedVideo")
    }
    @objc
    public func onHardUnMutedVideo(_ command : CDVInvokedUrlCommand){
        updateEventList(command: command, forKey: "onHardUnMutedVideo")
    }
    @objc
    public func onReceivedHardMuteVideo(_ command : CDVInvokedUrlCommand){
        updateEventList(command: command, forKey: "onReceivedHardMuteVideo")
    }
    @objc
    public func onReceivedHardUnMuteVideo(_ command : CDVInvokedUrlCommand){
        updateEventList(command: command, forKey: "onReceivedHardUnMuteVideo")
    }
    @objc
    public func onHardMuted(_ command : CDVInvokedUrlCommand){
        updateEventList(command: command, forKey: "onHardMuted")
    }
    @objc
    public func onReceivedHardMute(_ command : CDVInvokedUrlCommand){
        updateEventList(command: command, forKey: "onReceivedHardMute")
    }
    @objc
    public func onHardUnMuted(_ command : CDVInvokedUrlCommand){
        updateEventList(command: command, forKey: "onHardUnMuted")
    }
    @objc
    public func onReceivedHardUnMute(_ command : CDVInvokedUrlCommand){
        updateEventList(command: command, forKey: "onReceivedHardUnMute")
    }
    @objc
    public func onAcknowledgedSendData(_ command : CDVInvokedUrlCommand){
        updateEventList(command: command, forKey: "onAcknowledgedSendData")
    }
    @objc
    public func onMessageReceived(_ command : CDVInvokedUrlCommand){
        updateEventList(command: command, forKey: "onMessageReceived")
    }
    @objc
    public func onSwitchedUserRole(_ command : CDVInvokedUrlCommand){
        updateEventList(command: command, forKey: "onSwitchedUserRole")
    }
    @objc
    public func onUserRoleChanged(_ command : CDVInvokedUrlCommand){
        updateEventList(command: command, forKey: "onUserRoleChanged")
    }
    @objc
    public func onConferencessExtended(_ command : CDVInvokedUrlCommand){
        updateEventList(command: command, forKey: "onConferencessExtended")
    }
    @objc
    public func onConferenceRemainingDuration(_ command : CDVInvokedUrlCommand){
        updateEventList(command: command, forKey: "onConferenceRemainingDuration")
    }
    @objc
    public func onBandWidthUpdated(_ command : CDVInvokedUrlCommand){
        updateEventList(command: command, forKey: "onBandWidthUpdated")
    }
    @objc
    public func onShareStreamEvent(_ command : CDVInvokedUrlCommand){
        updateEventList(command: command, forKey: "onShareStreamEvent")
    }
    @objc
    public func onCanvasStreamEvent(_ command : CDVInvokedUrlCommand){
        updateEventList(command: command, forKey: "onCanvasStreamEvent")
    }
    @objc
    public func onConnectionInterrupted(_ command : CDVInvokedUrlCommand){
        updateEventList(command: command, forKey: "onConnectionInterrupted")
    }
    @objc
    public func onConnectionLost(_ command : CDVInvokedUrlCommand){
        updateEventList(command: command, forKey: "onConnectionLost")
    }
    @objc
    public func onOutBoundCallInitiated(_ command : CDVInvokedUrlCommand){
        updateEventList(command: command, forKey: "onOutBoundCallInitiated")
    }
    @objc
    public func onDialStateEvents(_ command : CDVInvokedUrlCommand){
        updateEventList(command: command, forKey: "onDialStateEvents")
    }
    @objc
    public func onDTMFCollected(_ command : CDVInvokedUrlCommand){
        updateEventList(command: command, forKey: "onDTMFCollected")
    }
    @objc
    public func onOutBoundCallCancel(_ command : CDVInvokedUrlCommand){
        updateEventList(command: command, forKey: "onOutBoundCallCancel")
    }
    @objc
    public func onPlayerStats(_ command : CDVInvokedUrlCommand){
        updateEventList(command: command, forKey: "onPlayerStats")
    }
    @objc
    public func onReconnect(_ command : CDVInvokedUrlCommand){
        updateEventList(command: command, forKey: "onReconnect")
    }
    @objc
    public func onUserReconnectSuccess(_ command : CDVInvokedUrlCommand){
        updateEventList(command: command, forKey: "onUserReconnectSuccess")
    }
    @objc
    public func onStartRecordingEvent(_ command : CDVInvokedUrlCommand){
        updateEventList(command: command, forKey: "onStartRecordingEvent")
    }
    @objc
    public func onRoomRecordingOn(_ command : CDVInvokedUrlCommand){
        updateEventList(command: command, forKey: "onRoomRecordingOn")
    }
    @objc
    public func onStopRecordingEvent(_ command : CDVInvokedUrlCommand){
        updateEventList(command: command, forKey: "onStopRecordingEvent")
    }
    @objc
    public func onRoomRecordingOff(_ command : CDVInvokedUrlCommand){
        updateEventList(command: command, forKey: "onRoomRecordingOff")
    }
    @objc
    public func onAcknowledgeStats(_ command : CDVInvokedUrlCommand){
        updateEventList(command: command, forKey: "onAcknowledgeStats")
    }
    @objc
    public func onReceivedStats(_ command : CDVInvokedUrlCommand){
        updateEventList(command: command, forKey: "onReceivedStats")
    }
    @objc
    public func onRemoteStreamAudioMute(_ command : CDVInvokedUrlCommand){
        updateEventList(command: command, forKey: "onRemoteStreamAudioMute")
    }
    @objc
    public func onAdvancedOptionsUpdate(_ command : CDVInvokedUrlCommand){
        updateEventList(command: command, forKey: "onAdvancedOptionsUpdate")
    }
    @objc
    public func onGetAdvancedOptions(_ command : CDVInvokedUrlCommand){
        updateEventList(command: command, forKey: "onGetAdvancedOptions")
    }
    @objc
    public func onFileUploadStarted(_ command : CDVInvokedUrlCommand){
        updateEventList(command: command, forKey: "onFileUploadStarted")
    }
    @objc
    public func onFileAvailable(_ command : CDVInvokedUrlCommand){
        updateEventList(command: command, forKey: "onFileAvailable")
    }
    @objc
    public func onInitFileUpload(_ command : CDVInvokedUrlCommand){
        updateEventList(command: command, forKey: "onInitFileUpload")
    }
    @objc
    public func onFileUploaded(_ command : CDVInvokedUrlCommand){
        updateEventList(command: command, forKey: "onFileUploaded")
    }
    @objc
    public func onFileUploadCancelled(_ command : CDVInvokedUrlCommand){
        updateEventList(command: command, forKey: "onFileUploadCancelled")
    }
    @objc
    public func onFileUploadFailed(_ command : CDVInvokedUrlCommand){
        updateEventList(command: command, forKey: "onFileUploadFailed")
    }
    @objc
    public func onFileDownloaded(_ command : CDVInvokedUrlCommand){
        updateEventList(command: command, forKey: "onFileDownloaded")
    }
    @objc
    public func onFileDownloadCancelled(_ command : CDVInvokedUrlCommand){
        updateEventList(command: command, forKey: "onFileDownloadCancelled")
    }
    @objc
    public func onFileDownloadFailed(_ command : CDVInvokedUrlCommand){
        updateEventList(command: command, forKey: "onFileDownloadFailed")
    }
    @objc
    public func onInitFileDownload(_ command : CDVInvokedUrlCommand){
        updateEventList(command: command, forKey: "onInitFileDownload")
    }
    @objc
    public func onScreenSharedStarted(_ command : CDVInvokedUrlCommand){
        updateEventList(command: command, forKey: "onScreenSharedStarted")
    }
    @objc
    public func onScreenSharedStopped(_ command : CDVInvokedUrlCommand){
        updateEventList(command: command, forKey: "onScreenSharedStopped")
    }
    @objc
    public func onCanvasStarted(_ command : CDVInvokedUrlCommand){
        updateEventList(command: command, forKey: "onCanvasStarted")
    }
    @objc
    public func onCanvasStopped(_ command : CDVInvokedUrlCommand){
        updateEventList(command: command, forKey: "onCanvasStopped")
    }
    @objc
    public func onAnnotationStarted(_ command : CDVInvokedUrlCommand){
        updateEventList(command: command, forKey: "onAnnotationStarted")
    }
    @objc
    public func onStartAnnotationAck(_ command : CDVInvokedUrlCommand){
        updateEventList(command: command, forKey: "onStartAnnotationAck")
    }
    @objc
    public func onAnnotationStopped(_ command : CDVInvokedUrlCommand){
        updateEventList(command: command, forKey: "onAnnotationStopped")
    }
    @objc
    public func onStoppedAnnotationAck(_ command : CDVInvokedUrlCommand){
        updateEventList(command: command, forKey: "onStoppedAnnotationAck")
    }
    @objc
    public func onRemoteStreamAudioUnMute(_ command : CDVInvokedUrlCommand){
        updateEventList(command: command, forKey: "onRemoteStreamAudioUnMute")
    }
    @objc
    public func onRemoteStreamVideoMute(_ command : CDVInvokedUrlCommand){
        updateEventList(command: command, forKey: "onRemoteStreamVideoMute")
    }
    @objc
    public func onRemoteStreamVideoUnMute(_ command : CDVInvokedUrlCommand){
        updateEventList(command: command, forKey: "onRemoteStreamVideoUnMute")
    }
    @objc
    public func OnCapturedView(_ command : CDVInvokedUrlCommand){
        updateEventList(command: command, forKey: "OnCapturedView")
    }
    @objc
    public func onUserDataReceived(_ command : CDVInvokedUrlCommand){
        updateEventList(command: command, forKey: "onUserDataReceived")
    }
    @objc
    public func onRoomBandwidthAlert(_ command : CDVInvokedUrlCommand){
        updateEventList(command: command, forKey: "onRoomBandwidthAlert")
    }
    //MARK: - CC Callback
    @objc
    public func onFloorRequested(_ command : CDVInvokedUrlCommand){
        updateEventList(command: command, forKey: "onFloorRequested")
    }
    @objc
    public func onFloorRequestReceived(_ command : CDVInvokedUrlCommand){
        updateEventList(command: command, forKey: "onFloorRequestReceived")
    }
    @objc
    public func onProcessFloorRequested(_ command : CDVInvokedUrlCommand){
        updateEventList(command: command, forKey: "onProcessFloorRequested")
    }
    @objc
    public func onGrantedFloorRequest(_ command : CDVInvokedUrlCommand){
        updateEventList(command: command, forKey: "onGrantedFloorRequest")
    }
    @objc
    public func onDeniedFloorRequest(_ command : CDVInvokedUrlCommand){
        updateEventList(command: command, forKey: "onDeniedFloorRequest")
    }
    @objc
    public func onReleasedFloorRequest(_ command : CDVInvokedUrlCommand){
        updateEventList(command: command, forKey: "onReleasedFloorRequest")
    }
    @objc
    public func onFloorCancelled(_ command : CDVInvokedUrlCommand){
        updateEventList(command: command, forKey: "onFloorCancelled")
    }
    @objc
    public func onFloorFinished(_ command : CDVInvokedUrlCommand){
        updateEventList(command: command, forKey: "onFloorFinished")
    }
    @objc
    public func onCancelledFloorRequest(_ command : CDVInvokedUrlCommand){
        updateEventList(command: command, forKey: "onCancelledFloorRequest")
    }
    @objc
    public func onFinishedFloorRequest(_ command : CDVInvokedUrlCommand){
        updateEventList(command: command, forKey: "onFinishedFloorRequest")
    }
    @objc
    public func onACKInviteToFloorRequested(_ command : CDVInvokedUrlCommand){
        updateEventList(command: command, forKey: "onACKInviteToFloorRequested")
    }
    @objc
    public func onInviteToFloorRequested(_ command : CDVInvokedUrlCommand){
        updateEventList(command: command, forKey: "onInviteToFloorRequested")
    }
    @objc
    public func onInvitedForFloorAccess(_ command : CDVInvokedUrlCommand){
        updateEventList(command: command, forKey: "onInvitedForFloorAccess")
    }
    @objc
    public func onCanceledFloorInvite(_ command : CDVInvokedUrlCommand){
        updateEventList(command: command, forKey: "onCanceledFloorInvite")
    }
    @objc
    public func onRejectedInviteFloor(_ command : CDVInvokedUrlCommand){
        updateEventList(command: command, forKey: "onRejectedInviteFloor")
    }
    @objc
    public func onAcceptedFloorInvite(_ command : CDVInvokedUrlCommand){
        updateEventList(command: command, forKey: "onAcceptedFloorInvite")
    }
    //MARK: - pin/unpin/spotlight Callback
    @objc
    public func onAckPinUsers(_ command : CDVInvokedUrlCommand){
        updateEventList(command: command, forKey: "onAckPinUsers")
    }
    @objc
    public func onAckUnpinUsers(_ command : CDVInvokedUrlCommand){
        updateEventList(command: command, forKey: "onAckUnpinUsers")
    }
    @objc
    public func onPinnedUsers(_ command : CDVInvokedUrlCommand){
        updateEventList(command: command, forKey: "onPinnedUsers")
    }
    @objc
    public func onAckAddSpotlightUsers(_ command : CDVInvokedUrlCommand){
        updateEventList(command: command, forKey: "onAckAddSpotlightUsers")
    }
    @objc
    public func onAckRemoveSpotlightUsers(_ command : CDVInvokedUrlCommand){
        updateEventList(command: command, forKey: "onAckRemoveSpotlightUsers")
    }
    @objc
    public func onUpdateSpotlightUsers(_ command : CDVInvokedUrlCommand){
        updateEventList(command: command, forKey: "onUpdateSpotlightUsers")
    }
    
    //MARK: - Audio Energy Callback
    @objc
    public func onAckSubscribeTalkerNotification(_ command : CDVInvokedUrlCommand){
        updateEventList(command: command, forKey: "onAckSubscribeTalkerNotification")
    }
    @objc
    public func onAckUnsubscribeTalkerNotification(_ command : CDVInvokedUrlCommand){
        updateEventList(command: command, forKey: "onAckUnsubscribeTalkerNotification")
    }
    @objc
    public func onTalkerNtification(_ command : CDVInvokedUrlCommand){
        updateEventList(command: command, forKey: "onTalkerNtification")
    }
    //MARK: - switched Room Callback
    @objc
    public func onAckSwitchedRoom(_ command : CDVInvokedUrlCommand){
        updateEventList(command: command, forKey: "onAckSwitchedRoom")
    }
    @objc
    public func onRoomModeSwitched(_ command : CDVInvokedUrlCommand){
        updateEventList(command: command, forKey: "onRoomModeSwitched")
    }
    @objc
    public func onAckHardMuteUserAudio(_ command : CDVInvokedUrlCommand){
        updateEventList(command: command, forKey: "onAckHardMuteUserAudio")
    }
    @objc
    public func onAckHardunMuteUserAudio(_ command : CDVInvokedUrlCommand){
        updateEventList(command: command, forKey: "onAckHardunMuteUserAudio")
    }
    @objc
    public func onAckHardMuteUserVideo(_ command : CDVInvokedUrlCommand){
        updateEventList(command: command, forKey: "onAckHardMuteUserVideo")
    }
    @objc
    public func onAckHardUnMuteUserVideo(_ command : CDVInvokedUrlCommand){
        updateEventList(command: command, forKey: "onAckHardUnMuteUserVideo")
    }
    @objc
    public func onACKStartLiveTranscription(_ command : CDVInvokedUrlCommand){
        updateEventList(command: command, forKey: "onACKStartLiveTranscription")
    }
    @objc
    public func onACKStopLiveTranscription(_ command : CDVInvokedUrlCommand){
        updateEventList(command: command, forKey: "onACKStopLiveTranscription")
    }
    @objc
    public func onTranscriptionEvents(_ command : CDVInvokedUrlCommand){
        updateEventList(command: command, forKey: "onTranscriptionEvents")
    }
    
    //Initialised Plugin
    public override func pluginInitialize(){
        getPrivacyAccess()
        checkForObjectRef()
    }
    // The hooks for our plugin commands
  @objc  public func getPrint(_ command : CDVInvokedUrlCommand){
        print("my print Value")
    }
    /*Join room method Which take Token,Publish info,Roominfo,AdvanceOption Details as as argument*/
    @objc public func joinRoom(_ command : CDVInvokedUrlCommand){
        checkForObjectRef()
        updateEventList(command: command, forKey: "joinRoom")
        if  let phrase = getRequestArgument(command: command){
            if var roomDict = phrase["roomInfo"] as? [String : Any]{
                roomDict.updateValue("view", forKey: "activeviews")
                if let localStream = mEnxRtc.joinRoom((phrase["token"] as! String), delegate: self, publishStreamInfo: (phrase["publishStreamInfo"] as! [String: Any]), roomInfo: roomDict, advanceOptions: nil){
                    mLocalStream = localStream
                    mLocalStream.delegate = self
                    trigger(succussJSEvent: "joinRoom", actionName: "joinRoom", requestData: "Joined Room called Success")
                }
            }
        }
    }
    //Create LocalView
    @objc public func initLocalView(_ command : CDVInvokedUrlCommand){
        updateEventList(command: command, forKey: "initLocalView")
        guard mLocalStream != nil else {
            return
        }
        guard let phrase = getRequestArgument(command: command) else {
            return
        }
        if let localviewOptions = phrase["localviewOptions"] as? [String : Any] {
            if mLocalStream.enxPlayerView == nil{
                mlocalView = EnxPlayerView(withLocalView: .zero)
                mLocalStream.attachRenderer(mlocalView)
                parentView.addSubview(mlocalView)
                parentView.bringSubviewToFront(mlocalView)
                addConstant(forlocalView: mlocalView, withDetails: localviewOptions)
                trigger(succussJSEvent: "initLocalView", actionName: "initLocalView", requestData: "Success")
            }
        }
    }
    //Create RemoteView
    @objc public func initRemoteView(_ command : CDVInvokedUrlCommand){
        updateEventList(command: command, forKey: "initRemoteView")
        guard let phrase = getRequestArgument(command: command) else {
            return
        }
        if let remoteViewOptions = phrase["remoteviewOptions"] as? [String : Any] {
            if mRemoteView == nil{
                mRemoteView = UIView(frame: .zero)
                parentView.addSubview(mRemoteView)
                mRemoteView.backgroundColor = .black
\                parentView.bringSubviewToFront(mRemoteView)
                parentView.bringSubviewToFront(mlocalView)
            
                addConstant(forRemoteView: remoteViewOptions)
                trigger(succussJSEvent: "initRemoteView", actionName: "initRemoteView", requestData: "Success")
            }
        }
    }
    /*Disconnect Method*/
    @objc
    public func disconnect(_ command : CDVInvokedUrlCommand){
        updateEventList(command: command, forKey: "disconnect")
        guard mEnxRoom != nil else {
            return
        }
        mEnxRoom.disconnect()
    }
    /*Mute/unMute self Audio*/
    @objc
    public func muteSelfAudio(_ command : CDVInvokedUrlCommand){
        updateEventList(command: command, forKey: "muteSelfAudio")
        guard let phrase = getRequestArgument(command: command) else {
            return
        }
        if let flag = phrase["muteAudio"] as? Bool{
            guard mLocalStream != nil else {
                reportErrorToJS("Object is not initialize : LocalStream")
                return
            }
            mLocalStream.muteSelfAudio(flag)
        }
    }
    /*Mute/unMute self Vidoe*/
    @objc
    public func muteSelfVideo(_ command : CDVInvokedUrlCommand){
        updateEventList(command: command, forKey: "muteSelfVideo")
        guard let phrase = getRequestArgument(command: command) else {
            return
        }
        if let flag = phrase["muteVideo"] as? Bool{
            guard mLocalStream != nil else {
                reportErrorToJS("Object is not initialize : LocalStream")
                return
            }
            mLocalStream.muteSelfVideo(flag)
        }
    }
    /* Switch Camera*/
    @objc
    public func switchCamera(_ command : CDVInvokedUrlCommand){
        updateEventList(command: command, forKey: "switchCamera")
        guard mLocalStream != nil else {
            reportErrorToJS("Object is not initialize : LocalStream")
            return
        }
       let _ = mLocalStream.switchCamera()
        trigger(succussJSEvent: "switchCamera", actionName: "switchCamera", requestData: "Success")
    }
    /*Hide SelfView*/
    @objc
    public func hideSelfView(_ command : CDVInvokedUrlCommand){
        updateEventList(command: command, forKey: "hideSelfView")
        guard let argu = getRequestArgument(command: command) else {
            return
        }
        if let flag = argu["hide"] as? Bool{
            mlocalView.isHidden = flag
            trigger(succussJSEvent: "hideSelfView", actionName: "hideSelfView", requestData: "Success")
        }
    }
    /*Resize Local View*/
    @objc
    public func resizeLocalView(_ command : CDVInvokedUrlCommand){
        updateEventList(command: command, forKey: "resizeLocalView")
        guard let argu = getRequestArgument(command: command) else {
            return
        }
        guard let resizeOptions = argu["resizeOptions"] as? [String : Any] else {
            return
        }
        removeAllConstance(fromLocal: resizeOptions)
    }
    /*Resize Remote View*/
    @objc
    public func resizeRemoteView(_ command : CDVInvokedUrlCommand){
        updateEventList(command: command, forKey: "resizeRemoteView")
        guard let argu = getRequestArgument(command: command) else {
            return
        }
        guard let resizeOptions = argu["resizeOptions"] as? [String : Any] else {
            return
        }
        removeAllConstanceFromRemote(fromLocal: resizeOptions)
    }
    /*Switch Media Device*/
    @objc
    public func switchMediaDevice(_ command : CDVInvokedUrlCommand){
        updateEventList(command: command, forKey: "resizeRemoteView")
        guard let argu = getRequestArgument(command: command) else {
            reportErrorToJS("Not a valid media name : switchMediaDevice")
            return
        }
        guard let device = argu["device"] as? String , mEnxRoom != nil else {
            reportErrorToJS("Object is not initialize : EnxRoom")
            return
            
        }
        mEnxRoom.switchMediaDevice(device)
        trigger(succussJSEvent: "switchMediaDevice", actionName: "switchMediaDevice", requestData: "Success")
    }
    /*get all connected Media Device List*/
    @objc
    public func getDevices(_ command : CDVInvokedUrlCommand){
        updateEventList(command: command, forKey: "getDevices")
        guard  mEnxRoom != nil else {
            reportErrorToJS("Object is not initialize : EnxRoom")
            return
            
        }
       let listOfDevice =  mEnxRoom.getDevices()
        trigger(succussJSEvent: "getDevices", actionName: "getDevices", requestData: listOfDevice!)
    }
    /*get Current working Media Device name*/
    @objc
    public func getSelectedDevice(_ command : CDVInvokedUrlCommand){
        updateEventList(command: command, forKey: "getSelectedDevice")
        guard  mEnxRoom != nil else {
            reportErrorToJS("Object is not initialize : EnxRoom")
            return
            
        }
        let currentMedia = mEnxRoom.getSelectedDevice()
        trigger(succussJSEvent: "getSelectedDevice", actionName: "getSelectedDevice", requestData: currentMedia!)
    }
    /* Get List of available user in Room*/
    @objc
    public func getUserList(_ command : CDVInvokedUrlCommand){
        updateEventList(command: command, forKey: "getUserList")
        guard  mEnxRoom != nil else {
            reportErrorToJS("Object is not initialize : EnxRoom")
            return
            
        }
        let userList = mEnxRoom.getUserList()
        trigger(succussJSEvent: "getUserList", actionName: "getUserList", requestData: userList!)
    }
    /* Get Room MetaData*/
    @objc
    public func getRoomMetadata(_ command : CDVInvokedUrlCommand){
        updateEventList(command: command, forKey: "getRoomMetadata")
        guard  mEnxRoom != nil else {
            reportErrorToJS("Object is not initialize : EnxRoom")
            return
            
        }
        let metaData = mEnxRoom.roomMetadata
        trigger(succussJSEvent: "getRoomMetadata", actionName: "getRoomMetadata", requestData: metaData!)
    }
    /*Get Client ID*/
    @objc
    public func getClientId(_ command : CDVInvokedUrlCommand){
        updateEventList(command: command, forKey: "getClientId")
        guard  mEnxRoom != nil else {
            reportErrorToJS("Object is not initialize : EnxRoom")
            return
            
        }
        let clientId = mEnxRoom.clientId
        trigger(succussJSEvent: "getClientId", actionName: "getClientId", requestData: clientId!)
    }
    /*Get Client ID*/
    @objc
    public func getRoomId(_ command : CDVInvokedUrlCommand){
        updateEventList(command: command, forKey: "getRoomId")
        guard  mEnxRoom != nil else {
            reportErrorToJS("Object is not initialize : EnxRoom")
            return
            
        }
        let roomID = mEnxRoom.roomId
        trigger(succussJSEvent: "getRoomId", actionName: "getRoomId", requestData: roomID!)
    }
    /*Get Client Name*/
    @objc
    public func getClientName(_ command : CDVInvokedUrlCommand){
        updateEventList(command: command, forKey: "getClientName")
        guard  mEnxRoom != nil else {
            reportErrorToJS("Object is not initialize : EnxRoom")
            return
            
        }
        let cName = mEnxRoom.clientName
        trigger(succussJSEvent: "getClientName", actionName: "getClientName", requestData: cName!)
    }
    /*Get local Stream IDS*/
    @objc
    public func getLocalStreamID(_ command : CDVInvokedUrlCommand){
        updateEventList(command: command, forKey: "getLocalStreamID")
        guard  mEnxRoom != nil else {
            reportErrorToJS("Object is not initialize : EnxRoom")
            return
            
        }
        let sID = mEnxRoom.publishStream.streamId
        trigger(succussJSEvent: "getLocalStreamID", actionName: "getLocalStreamID", requestData: sID!)
    }
    /*Get Is connected*/
    @objc
    public func isConnected(_ command : CDVInvokedUrlCommand){
        updateEventList(command: command, forKey: "isConnected")
        guard  mEnxRoom != nil else {
            reportErrorToJS("Object is not initialize : EnxRoom")
            return
            
        }
        let isConnected = mEnxRoom.status
        let connected = (isConnected == .connected) ? true : false
        trigger(succussJSEvent: "isConnected", actionName: "isConnected", requestData: connected)
    }
    /*Get Room Mode*/
    @objc
    public func getMode(_ command : CDVInvokedUrlCommand){
        updateEventList(command: command, forKey: "getMode")
        guard  mEnxRoom != nil else {
            reportErrorToJS("Object is not initialize : EnxRoom")
            return
        }
        trigger(succussJSEvent: "getMode", actionName: "getMode", requestData: mEnxRoom.getRoomMode())
    }
    
    /*Get Role of self*/
    @objc
    public func getRole(_ command : CDVInvokedUrlCommand){
        updateEventList(command: command, forKey: "getRole")
        guard  mEnxRoom != nil else {
            reportErrorToJS("Object is not initialize : EnxRoom")
            return
        }
        trigger(succussJSEvent: "getRole", actionName: "getRole", requestData: mEnxRoom.userRole)
    }
    /*Get self info*/
    @objc
    public func whoAmI(_ command : CDVInvokedUrlCommand){
        updateEventList(command: command, forKey: "whoAmI")
        guard  mEnxRoom != nil else {
            reportErrorToJS("Object is not initialize : EnxRoom")
            return
        }
        trigger(succussJSEvent: "whoAmI", actionName: "whoAmI", requestData: mEnxRoom.whoami()!)
    }
    /*Start Draging View*/
    @objc
    public func startDragging(_ command : CDVInvokedUrlCommand){
        updateEventList(command: command, forKey: "startDragging")
        guard let argu = getRequestArgument(command: command) else {
            return
        }
        guard let str = argu["view"] as? String , let drag = argu["drag"] as? Bool else {
            reportErrorToJS("Wrong JSON  : \(argu)")
            return
        }
        //Handle Local View
        if str.caseInsensitiveCompare("local") == .orderedSame{
            guard mlocalView != nil else {
                reportErrorToJS("local view is not initialize : initLocalView")
                return
            }
            startLocalTouchListener(drag)
            parentView.bringSubviewToFront(mlocalView)
            
        }
        //Handle Remote View
        else{
            guard mRemoteView != nil else {
                reportErrorToJS("remote view is not initialize : initRemoteView")
                return
            }
            startRemoteTouchListener(drag)
            parentView.bringSubviewToFront(mRemoteView)
            parentView.bringSubviewToFront(mlocalView)
        }
    }
    /*Hide RemoteView*/
    @objc
    public func hideRemoteView(_ command : CDVInvokedUrlCommand){
        updateEventList(command: command, forKey: "hideRemoteView")
        guard let argu = getRequestArgument(command: command) else {
            return
        }
        guard let hide = argu["hide"] as? Bool else {
            reportErrorToJS("Wrong JSON  : \(argu)")
            return
        }
        mRemoteView.isHidden = hide
        trigger(succussJSEvent: "hideRemoteView", actionName: "hideRemoteView", requestData: "Success")
    }
    
    /*Hide ScreenShare*/
    @objc
    public func hideScreenShareView(_ command : CDVInvokedUrlCommand){
        updateEventList(command: command, forKey: "hideScreenShareView")
        guard let argu = getRequestArgument(command: command) else {
            return
        }
        guard let hide = argu["hide"] as? Bool else {
            reportErrorToJS("Wrong JSON  : \(argu)")
            return
        }
        guard mOptionView != nil else {
            return
        }
        mOptionView.isHidden = hide
        trigger(succussJSEvent: "hideScreenShareView", actionName: "hideScreenShareView", requestData: "Success")
    }
    /*Hide Hide Canvas*/
    @objc
    public func hideCanvasScreen(_ command : CDVInvokedUrlCommand){
        updateEventList(command: command, forKey: "hideCanvasScreen")
        guard let argu = getRequestArgument(command: command) else {
            return
        }
        guard let hide = argu["hide"] as? Bool else {
            reportErrorToJS("Wrong JSON  : \(argu)")
            return
        }
        guard mOptionView != nil else {
            return
        }
        mOptionView.isHidden = hide
        trigger(succussJSEvent: "hideCanvasScreen", actionName: "hideCanvasScreen", requestData: "Success")
    }
    /*get Current Available Talker in room*/
    @objc
    public func getTalkerCount(_ command : CDVInvokedUrlCommand){
        updateEventList(command: command, forKey: "getTalkerCount")
        guard mEnxRoom != nil else {
            reportErrorToJS("Object is not initialize : EnxRoom")
            return
        }
        mEnxRoom.getTalkerCount()
    }
    /*get Max possible Talker In room*/
    @objc
    public func getMaxTalkers(_ command : CDVInvokedUrlCommand){
        updateEventList(command: command, forKey: "getMaxTalkers")
        guard mEnxRoom != nil else {
            reportErrorToJS("Object is not initialize : EnxRoom")
            return
        }
        mEnxRoom.getMaxTalkers()
    }
    /*Set Talket Count in room*/
    @objc
    public func setTalkerCount(_ command : CDVInvokedUrlCommand){
        updateEventList(command: command, forKey: "setTalkerCount")
        guard let argu = getRequestArgument(command: command) else {
            return
        }
        guard let talker = argu["count"] as? Int else {
            reportErrorToJS("Wrong JSON  : \(argu)")
            return
        }
        guard mEnxRoom != nil else {
            reportErrorToJS("Object is not initialize : EnxRoom")
            return
        }
        mEnxRoom.setTalkerCount(talker)
    }
    /*Post Client Logs*/
    @objc
    public func postClientLogs(_ command : CDVInvokedUrlCommand){
        updateEventList(command: command, forKey: "postClientLogs")
        guard mEnxRoom != nil else {
            reportErrorToJS("Object is not initialize : EnxRoom")
            return
        }
        mEnxRoom.postClientLogs()
        trigger(succussJSEvent: "postClientLogs", actionName: "postClientLogs", requestData: "Success")
    }
    /*Enable Logs*/
    @objc
    public func enableLogs(_ command : CDVInvokedUrlCommand){
        updateEventList(command: command, forKey: "enableLogs")
        guard let argu = getRequestArgument(command: command) else {
            return
        }
        EnxUtilityManager.shareInstance.startLog()
    }
    /*Mute Subscribe Stream Audio*/
    @objc
    public func muteSubscribeStreamsAudio(_ command : CDVInvokedUrlCommand){
        updateEventList(command: command, forKey: "muteSubscribeStreamsAudio")
        guard let argu = getRequestArgument(command: command) else {
            return
        }
        guard let flag = argu["mute"] as? Bool else{
            reportErrorToJS("Wrong JSON  : \(argu)")
            return
        }
        guard mEnxRoom != nil else {
            reportErrorToJS("Object is not initialize : EnxRoom")
            return
        }
        mEnxRoom.muteSubscribeStreamsAudio(flag)
        trigger(succussJSEvent: "muteSubscribeStreamsAudio", actionName: "muteSubscribeStreamsAudio", requestData: "Success")
    }
    /*Set Current Call to audio only */
    @objc
    public func setAudioOnlyMode(_ command : CDVInvokedUrlCommand){
        updateEventList(command: command, forKey: "setAudioOnlyMode")
        guard let argu = getRequestArgument(command: command) else {
            return
        }
        guard let flag = argu["audioOnly"] as? Bool else{
            reportErrorToJS("Wrong JSON  : \(argu)")
            return
        }
        guard mEnxRoom != nil else {
            reportErrorToJS("Object is not initialize : EnxRoom")
            return
        }
        mEnxRoom.setAudioOnlyMode(flag)
        trigger(succussJSEvent: "setAudioOnlyMode", actionName: "setAudioOnlyMode", requestData: "Success")
    }
    /*Get current video Quility config */
    @objc
    public func getReceiveVideoQuality(_ command : CDVInvokedUrlCommand){
        updateEventList(command: command, forKey: "setAudioOnlyMode")
        guard let argu = getRequestArgument(command: command) else {
            return
        }
        guard let streamType = argu["streamType"] as? String else{
            reportErrorToJS("Wrong JSON  : \(argu)")
            return
        }
        guard mEnxRoom != nil else {
            reportErrorToJS("Object is not initialize : EnxRoom")
            return
        }
        let videoQuality = mEnxRoom.getReceiveVideoQuality(streamType)
        trigger(succussJSEvent: "getReceiveVideoQuality", actionName: "getReceiveVideoQuality", requestData: videoQuality!)
    }
    /*Set video Quility config */
    @objc
    public func setReceiveVideoQuality(_ command : CDVInvokedUrlCommand){
        updateEventList(command: command, forKey: "setReceiveVideoQuality")
        guard let argu = getRequestArgument(command: command) else {
            return
        }
        guard let videoQualityOptions = argu["videoQualityOptions"] as? [String : Any] else{
            reportErrorToJS("Wrong JSON  : \(argu)")
            return
        }
        guard mEnxRoom != nil else {
            reportErrorToJS("Object is not initialize : EnxRoom")
            return
        }
        mEnxRoom.setReceiveVideoQuality(videoQualityOptions)
        trigger(succussJSEvent: "setReceiveVideoQuality", actionName: "setReceiveVideoQuality", requestData: "Success")
    }
    /*Adjuest Remote View Layout*/
    @objc
    public func adjustLayout(_ command : CDVInvokedUrlCommand){
        updateEventList(command: command, forKey: "adjustLayout")
        guard mEnxRoom != nil else {
            reportErrorToJS("Object is not initialize : EnxRoom")
            return
        }
        mEnxRoom.adjustLayout()
        trigger(succussJSEvent: "adjustLayout", actionName: "adjustLayout", requestData: "Success")
    }
    /*updateConfiguration for local player*/
    @objc
    public func updateConfiguration(_ command : CDVInvokedUrlCommand){
        updateEventList(command: command, forKey: "updateConfiguration")
        guard let argu = getRequestArgument(command: command) else {
            return
        }
        guard let configuartionOptions = argu["configuartionOptions"] as? [String : Any] else{
            reportErrorToJS("Wrong JSON  : \(argu)")
            return
        }
        guard mLocalStream != nil else {
            reportErrorToJS("Object is not initialize : EnxStream")
            return
        }
        mLocalStream.updateConfiguration(configuartionOptions)
        trigger(succussJSEvent: "configuartionOptions", actionName: "configuartionOptions", requestData: "Success")
    }
    /*Extend Duration of confrence*/
    @objc
    public func extendConferenceDuration(_ command : CDVInvokedUrlCommand){
        updateEventList(command: command, forKey: "extendConferenceDuration")
        guard mEnxRoom != nil else {
            reportErrorToJS("Object is not initialize : EnxRoom")
            return
        }
        mEnxRoom.extendConferenceDuration()
    }
    /*lock ongoing room*/
    @objc
    public func lockRoom(_ command : CDVInvokedUrlCommand){
        updateEventList(command: command, forKey: "lockRoom")
        guard mEnxRoom != nil else {
            reportErrorToJS("Object is not initialize : EnxRoom")
            return
        }
        mEnxRoom.lockRoom()
    }
    /*lockRoom ongoing room*/
    @objc
    public func unLockRoom(_ command : CDVInvokedUrlCommand){
        updateEventList(command: command, forKey: "unLockRoom")
        guard mEnxRoom != nil else {
            reportErrorToJS("Object is not initialize : EnxRoom")
            return
        }
        mEnxRoom.unlockRoom()
    }
    /*dropUser Any participent from ongoing room*/
    @objc
    public func dropUser(_ command : CDVInvokedUrlCommand){
        updateEventList(command: command, forKey: "dropUser")
        guard let argu = getRequestArgument(command: command) else {
            return
        }
        guard let clientIds = argu["clientIds"] as? [String] else{
            reportErrorToJS("Wrong JSON  : \(argu)")
            return
        }
        guard mEnxRoom != nil else {
            reportErrorToJS("Object is not initialize : EnxRoom")
            return
        }
        mEnxRoom.dropUser(clientIds)
    }
    /*destroy current ongoing room*/
    @objc
    public func destroy(_ command : CDVInvokedUrlCommand){
        updateEventList(command: command, forKey: "destroy")
        guard mEnxRoom != nil else {
            reportErrorToJS("Object is not initialize : EnxRoom")
            return
        }
        mEnxRoom.destroy()
    }
    /*Room Mute*/
    @objc
    public func hardMute(_ command : CDVInvokedUrlCommand){
        updateEventList(command: command, forKey: "hardMute")
        guard mEnxRoom != nil else {
            reportErrorToJS("Object is not initialize : EnxRoom")
            return
        }
        mEnxRoom.hardMute()
    }
    /*Room unmute*/
    @objc
    public func hardUnMute(_ command : CDVInvokedUrlCommand){
        updateEventList(command: command, forKey: "hardUnMute")
        guard mEnxRoom != nil else {
            reportErrorToJS("Object is not initialize : EnxRoom")
            return
        }
        mEnxRoom.hardUnMute()
    }
    /*Start Recording in confrence*/
    @objc
    public func startRecord(_ command : CDVInvokedUrlCommand){
        updateEventList(command: command, forKey: "startRecord")
        guard mEnxRoom != nil else {
            reportErrorToJS("Object is not initialize : EnxRoom")
            return
        }
        mEnxRoom.startRecord()
    }
    /*Stop Recording in confrence*/
    @objc
    public func stopRecord(_ command : CDVInvokedUrlCommand){
        updateEventList(command: command, forKey: "stopRecord")
        guard mEnxRoom != nil else {
            reportErrorToJS("Object is not initialize : EnxRoom")
            return
        }
        mEnxRoom.stopRecord()
    }
    /*Stop captcha when in background*/
    @objc
    public func stopVideoTracksOnApplicationBackground(_ command : CDVInvokedUrlCommand){
        updateEventList(command: command, forKey: "stopVideoTracksOnApplicationBackground")
        guard mEnxRoom != nil else {
            reportErrorToJS("Object is not initialize : EnxRoom")
            return
        }
        mEnxRoom.stopVideoTracksOnApplication(background: true)
    }
    /*Stop captcha when in background*/
    @objc
    public func startVideoTracksOnApplicationForeground(_ command : CDVInvokedUrlCommand){
        updateEventList(command: command, forKey: "startVideoTracksOnApplicationForeground")
        guard mEnxRoom != nil else {
            reportErrorToJS("Object is not initialize : EnxRoom")
            return
        }
        mEnxRoom.stopVideoTracksOnApplication(background: false)
    }
    /*Enable Stats in room*/
    @objc
    public func enableStats(_ command : CDVInvokedUrlCommand){
        updateEventList(command: command, forKey: "enableStats")
        guard let argu = getRequestArgument(command: command) else {
            return
        }
        guard let flag = argu["enableStats"] as? Bool else{
            reportErrorToJS("Wrong JSON  : \(argu)")
            return
        }
        guard mEnxRoom != nil else {
            reportErrorToJS("Object is not initialize : EnxRoom")
            return
        }
        mEnxRoom.enableStats(flag)
    }
    /*Handover self authority to other user in same room*/
    @objc
    public func switchUserRole(_ command : CDVInvokedUrlCommand){
        updateEventList(command: command, forKey: "switchUserRole")
        guard let argu = getRequestArgument(command: command) else {
            return
        }
        guard let clientId = argu["clientId"] as? String else{
            reportErrorToJS("Wrong JSON  : \(argu)")
            return
        }
        guard mEnxRoom != nil else {
            reportErrorToJS("Object is not initialize : EnxRoom")
            return
        }
        mEnxRoom.switchUserRole(clientId)
    }
    /*Make out bond call to any numble*/
    @objc
    public func makeOutboundCall(_ command : CDVInvokedUrlCommand){
        updateEventList(command: command, forKey: "makeOutboundCall")
        guard let argu = getRequestArgument(command: command) else {
            return
        }
        guard let callerId = argu["callerId"] as? String, let number = argu["number"] as? String else{
            reportErrorToJS("Wrong JSON  : \(argu)")
            return
        }
        guard mEnxRoom != nil else {
            reportErrorToJS("Object is not initialize : EnxRoom")
            return
        }
        var dialOptions : [String : Any]!
        if let dOptions = argu["dialOptions"] as? [String : Any]{
            dialOptions = dOptions
        }
        mEnxRoom.makeOutboundCall(number, callerId: callerId, withDialOptions: dialOptions)
    }
    /*Make out bond call to any numble*/
    /*Make out bond call to any numble*/
    @objc
    public func cancelOutboundCall(_ command : CDVInvokedUrlCommand){
        updateEventList(command: command, forKey: "cancelOutboundCall")
        guard let argu = getRequestArgument(command: command) else {
            return
        }
        guard let number = argu["number"] as? String else{
            reportErrorToJS("Wrong JSON  : \(argu)")
            return
        }
        guard mEnxRoom != nil else {
            reportErrorToJS("Object is not initialize : EnxRoom")
            return
        }
        mEnxRoom.cancelOutboundCall(number)
    }
    /*Send chat message in room*/
    @objc
    public func sendMessage(_ command : CDVInvokedUrlCommand){
        updateEventList(command: command, forKey: "sendMessage")
        guard let argu = getRequestArgument(command: command) else {
            return
        }
        guard let textMsg = argu["text"] as? String, let isBroadCase = argu["broadcast"] as? Bool else{
            reportErrorToJS("Wrong JSON  : \(argu)")
            return
        }
        guard mEnxRoom != nil else {
            reportErrorToJS("Object is not initialize : EnxRoom")
            return
        }
        if !isBroadCase{
            if let clientIds = argu["clientIds"] as? [String]{
                mEnxRoom.sendMessage(textMsg, isBroadCast: isBroadCase, recipientIDs: clientIds)
            }else{
                reportErrorToJS("Invalid Receipent IDS")
            }
        }
        else{
            mEnxRoom.sendMessage(textMsg, isBroadCast: isBroadCase, recipientIDs: nil)
        }
    }
    /*Send any tuype of data in room*/
    @objc
    public func sendUserData(_ command : CDVInvokedUrlCommand){
        updateEventList(command: command, forKey: "sendUserData")
        guard let argu = getRequestArgument(command: command) else {
            return
        }
        guard let msg = argu["message"] as? [String:Any], let isBroadCase = argu["broadcast"] as? Bool else{
            reportErrorToJS("Wrong JSON  : \(argu)")
            return
        }
        guard mEnxRoom != nil else {
            reportErrorToJS("Object is not initialize : EnxRoom")
            return
        }
        if !isBroadCase{
            if let clientIds = argu["clientIds"] as? [String]{
                mEnxRoom.sendUserData(msg, isBroadCast: isBroadCase, recipientIDs: clientIds)
            }else{
                reportErrorToJS("Invalid Receipent IDS")
            }
        }
        else{
            mEnxRoom.sendUserData(msg, isBroadCast: isBroadCase, recipientIDs: nil)
        }
    }
    /*Set Advance option in room*/
    @objc
    public func setAdvancedOptions(_ command : CDVInvokedUrlCommand){
        updateEventList(command: command, forKey: "setAdvancedOptions")
        guard let argu = getRequestArgument(command: command) else {
            return
        }
        guard let option = argu["array"] as? [Any]else{
            reportErrorToJS("Wrong JSON  : \(argu)")
            return
        }
        guard mEnxRoom != nil else {
            reportErrorToJS("Object is not initialize : EnxRoom")
            return
        }
        mEnxRoom.setAdvanceOptions(option)
    }
    /*Get Advance option in room*/
    @objc
    public func getAdvancedOptions(_ command : CDVInvokedUrlCommand){
        updateEventList(command: command, forKey: "getAdvancedOptions")
        guard mEnxRoom != nil else {
            reportErrorToJS("Object is not initialize : EnxRoom")
            return
        }
        mEnxRoom.getAdvanceOptions()
    }
    /*Send file in same room*/
    @objc
    public func sendFiles(_ command : CDVInvokedUrlCommand){
        updateEventList(command: command, forKey: "sendFiles")
        guard let argu = getRequestArgument(command: command) else {
            return
        }
        guard  let isBroadCase = argu["broadcast"] as? Bool else{
            reportErrorToJS("Wrong JSON  : \(argu)")
            return
        }
        guard mEnxRoom != nil else {
            reportErrorToJS("Object is not initialize : EnxRoom")
            return
        }
        if !isBroadCase{
            if let clientIds = argu["array"] as? [Any]{
                var clientIdsList : [String] = []
                for item in clientIds{
                    clientIdsList.append(((item as! [String : Any])["clientId"] as! String))
                }
                mEnxRoom.sendFiles(isBroadCase, clientIds: clientIdsList)
            }else{
                reportErrorToJS("Invalid Receipent IDS")
            }
        }
        else{
            mEnxRoom.sendFiles(isBroadCase, clientIds: [])
        }
    }
    /*Download Available file */
    @objc
    public func downloadFile(_ command : CDVInvokedUrlCommand){
        updateEventList(command: command, forKey: "downloadFile")
        guard let argu = getRequestArgument(command: command) else {
            return
        }
        guard  let isAutoSave = argu["isAutoSave"] as? Bool, let json = argu["json"] as? [String: Any] else{
            reportErrorToJS("Wrong JSON  : \(argu)")
            return
        }
        guard mEnxRoom != nil else {
            reportErrorToJS("Object is not initialize : EnxRoom")
            return
        }
        mEnxRoom.downloadFile(json, autoSave: isAutoSave)
    }
    /*CAncel upload file in room*/
    @objc
    public func cancelUpload(_ command : CDVInvokedUrlCommand){
        updateEventList(command: command, forKey: "cancelUpload")
        guard let argu = getRequestArgument(command: command) else {
            return
        }
        guard  let jobId = argu["jobId"] as? Int else{
            reportErrorToJS("Wrong JSON  : \(argu)")
            return
        }
        guard mEnxRoom != nil else {
            reportErrorToJS("Object is not initialize : EnxRoom")
            return
        }
        mEnxRoom.cancelUpload(jobId)
    }
    /*cancle Download files in room*/
    @objc
    public func cancelDownload(_ command : CDVInvokedUrlCommand){
        updateEventList(command: command, forKey: "cancelDownload")
        guard let argu = getRequestArgument(command: command) else {
            return
        }
        guard  let jobId = argu["jobId"] as? Int else{
            reportErrorToJS("Wrong JSON  : \(argu)")
            return
        }
        guard mEnxRoom != nil else {
            reportErrorToJS("Object is not initialize : EnxRoom")
            return
        }
        mEnxRoom.cancelDownload(jobId)
    }
    /*Cancel All Upload file in room*/
    @objc
    public func cancelAllUploads(_ command : CDVInvokedUrlCommand){
        updateEventList(command: command, forKey: "cancelAllUploads")
        guard mEnxRoom != nil else {
            reportErrorToJS("Object is not initialize : EnxRoom")
            return
        }
        mEnxRoom.cancelAllUploads()
    }
    /*Cancel All Download file in room*/
    @objc
    public func cancelAllDownloads(_ command : CDVInvokedUrlCommand){
        updateEventList(command: command, forKey: "cancelAllUploads")
        guard mEnxRoom != nil else {
            reportErrorToJS("Object is not initialize : EnxRoom")
            return
        }
        mEnxRoom.cancelAllDownloads()
    }
    /*Get list of available files in room*/
    @objc public func getAvailableFiles(_ command : CDVInvokedUrlCommand){
        updateEventList(command: command, forKey: "getAvailableFiles")
        guard mEnxRoom != nil else {
            reportErrorToJS("Object is not initialize : EnxRoom")
            return
        }
        let fileList = mEnxRoom.getAvailableFiles()
        
        trigger(succussJSEvent: "getAvailableFiles", actionName: "getAvailableFiles", requestData: fileList!)
    }
    /*Handle Screen when screen share started*/
    @objc public func addScreenShare(_ command : CDVInvokedUrlCommand){
        updateEventList(command: command, forKey: "addScreenShare")
        guard let argu = getRequestArgument(command: command) else {
            return
        }
        guard  let viewOptions = argu["viewOptions"] as? [String : Any] else{
            reportErrorToJS("Wrong JSON  : \(argu)")
            return
        }
        createOptionView(viewOptions)
        trigger(succussJSEvent: "addScreenShare", actionName: "addScreenShare", requestData: "Success")
    }
    /*Handle Screen when Canvas started*/
    @objc public func addCanvasScreen(_ command : CDVInvokedUrlCommand){
        updateEventList(command: command, forKey: "addCanvasScreen")
        guard let argu = getRequestArgument(command: command) else {
            return
        }
        guard  let viewOptions = argu["viewOptions"] as? [String : Any] else{
            reportErrorToJS("Wrong JSON  : \(argu)")
            return
        }
        createOptionView(viewOptions)
        trigger(succussJSEvent: "addCanvasScreen", actionName: "addCanvasScreen", requestData: "Success")
    }
    /*Handle Screen when Annotation started*/
    @objc public func addAnnotationScreen(_ command : CDVInvokedUrlCommand){
        updateEventList(command: command, forKey: "addAnnotationScreen")
        guard let argu = getRequestArgument(command: command) else {
            return
        }
        guard  let viewOptions = argu["viewOptions"] as? [String : Any] else{
            reportErrorToJS("Wrong JSON  : \(argu)")
            return
        }
        createOptionView(viewOptions)
        trigger(succussJSEvent: "addAnnotationScreen", actionName: "addAnnotationScreen", requestData: "Success")
    }
    /*Handle Screen when screen share stoped*/
    @objc public func removeScreenShare(_ command : CDVInvokedUrlCommand){
        updateEventList(command: command, forKey: "removeScreenShare")
        cleanOptionView()
        trigger(succussJSEvent: "removeScreenShare", actionName: "removeScreenShare", requestData: "Success")
    }
    /*Handle Screen when Canvas stoped*/
    @objc public func removeCanvasScreen(_ command : CDVInvokedUrlCommand){
        updateEventList(command: command, forKey: "removeCanvasScreen")
        cleanOptionView()
        trigger(succussJSEvent: "removeCanvasScreen", actionName: "removeCanvasScreen", requestData: "Success")
    }
    /*Handle Screen when Annotation stoped*/
    @objc public func removeAnnotationScreen(_ command : CDVInvokedUrlCommand){
        updateEventList(command: command, forKey: "removeAnnotationScreen")
        cleanOptionView()
        trigger(succussJSEvent: "removeAnnotationScreen", actionName: "removeAnnotationScreen", requestData: "Success")
    }
    /*Hide Annotation Screen*/
    @objc public func hideAnnotationScreen(_ command : CDVInvokedUrlCommand){
        updateEventList(command: command, forKey: "hideAnnotationScreen")
        guard let argu = getRequestArgument(command: command) else {
            return
        }
        guard let hide = argu["hide"] as? Bool else {
            reportErrorToJS("Wrong JSON  : \(argu)")
            return
        }
        mOptionView.isHidden = hide
        trigger(succussJSEvent: "hideAnnotationScreen", actionName: "hideAnnotationScreen", requestData: "Success")
    }
    //MARK: - Chair Controller Methods
    /*This method for participent, Where he/she request for floor access*/
    @objc public func requestFloor(_ command : CDVInvokedUrlCommand){
        updateEventList(command: command, forKey: "requestFloor")
        guard mEnxRoom != nil else {
            reportErrorToJS("Object is not initialize : EnxRoom")
            return
        }
        mEnxRoom.requestFloor()
    }
    /*This method for participent, Where he/she can cancle request his request floor*/
    @objc public func cancelFloor(_ command : CDVInvokedUrlCommand){
        updateEventList(command: command, forKey: "cancelFloor")
        guard mEnxRoom != nil else {
            reportErrorToJS("Object is not initialize : EnxRoom")
            return
        }
        mEnxRoom.cancelFloor()
    }
    /*This method for participent, Where he/she can finished request his Fool access*/
    @objc public func finishFloor(_ command : CDVInvokedUrlCommand){
        updateEventList(command: command, forKey: "finishFloor")
        guard mEnxRoom != nil else {
            reportErrorToJS("Object is not initialize : EnxRoom")
            return
        }
        mEnxRoom.finishFloor()
    }
    /*This method for Modaitore, Where he/she can accept any particepnt floor request*/
    @objc public func grantFloor(_ command : CDVInvokedUrlCommand){
        updateEventList(command: command, forKey: "grantFloor")
        guard let argu = getRequestArgument(command: command) else {
            return
        }
        guard  let clientId = argu["clientId"] as? String  else{
            reportErrorToJS("Wrong JSON  : \(argu)")
            return
        }
        guard mEnxRoom != nil else {
            reportErrorToJS("Object is not initialize : EnxRoom")
            return
        }
        mEnxRoom.grantFloor(clientId)
    }
    /*This method for Modaitore, Where he/she can denyFloor any particepnt floor request*/
    @objc public func denyFloor(_ command : CDVInvokedUrlCommand){
        updateEventList(command: command, forKey: "denyFloor")
        guard let argu = getRequestArgument(command: command) else {
            return
        }
        guard  let clientId = argu["clientId"] as? String  else{
            reportErrorToJS("Wrong JSON  : \(argu)")
            return
        }
        guard mEnxRoom != nil else {
            reportErrorToJS("Object is not initialize : EnxRoom")
            return
        }
        mEnxRoom.denyFloor(clientId)
    }
    /*This method for Modaitore, Where he/she can releaseFloor any particepnt floor request*/
    @objc public func releaseFloor(_ command : CDVInvokedUrlCommand){
        updateEventList(command: command, forKey: "releaseFloor")
        guard let argu = getRequestArgument(command: command) else {
            return
        }
        guard  let clientId = argu["clientId"] as? String  else{
            reportErrorToJS("Wrong JSON  : \(argu)")
            return
        }
        guard mEnxRoom != nil else {
            reportErrorToJS("Object is not initialize : EnxRoom")
            return
        }
        mEnxRoom.releaseFloor(clientId)
    }
    /*inviteToFloor*/
    @objc public func inviteToFloor(_ command : CDVInvokedUrlCommand){
        updateEventList(command: command, forKey: "inviteToFloor")
        guard let argu = getRequestArgument(command: command) else {
            return
        }
        guard  let clientId = argu["clientId"] as? String  else{
            reportErrorToJS("Wrong JSON  : \(argu)")
            return
        }
        guard mEnxRoom != nil else {
            reportErrorToJS("Object is not initialize : EnxRoom")
            return
        }
        mEnxRoom.invite(toFloor: clientId)
    }
    /*Cancel inviteToFloor*/
    @objc public func cancelFloorInvite(_ command : CDVInvokedUrlCommand){
        updateEventList(command: command, forKey: "cancelFloorInvite")
        guard let argu = getRequestArgument(command: command) else {
            return
        }
        guard  let clientId = argu["clientId"] as? String  else{
            reportErrorToJS("Wrong JSON  : \(argu)")
            return
        }
        guard mEnxRoom != nil else {
            reportErrorToJS("Object is not initialize : EnxRoom")
            return
        }
        mEnxRoom.cancelFloorInvite(clientId)
    }
    /*Reject inviteToFloor*/
    @objc public func rejectInviteFloor(_ command : CDVInvokedUrlCommand){
        updateEventList(command: command, forKey: "rejectInviteFloor")
        guard let argu = getRequestArgument(command: command) else {
            return
        }
        guard  let clientId = argu["clientId"] as? String  else{
            reportErrorToJS("Wrong JSON  : \(argu)")
            return
        }
        guard mEnxRoom != nil else {
            reportErrorToJS("Object is not initialize : EnxRoom")
            return
        }
        mEnxRoom.rejectInviteFloor(clientId)
    }
    /*Accept inviteToFloor*/
    @objc public func acceptInviteFloorRequest(_ command : CDVInvokedUrlCommand){
        updateEventList(command: command, forKey: "acceptInviteFloorRequest")
        guard let argu = getRequestArgument(command: command) else {
            return
        }
        guard  let clientId = argu["clientId"] as? String  else{
            reportErrorToJS("Wrong JSON  : \(argu)")
            return
        }
        guard mEnxRoom != nil else {
            reportErrorToJS("Object is not initialize : EnxRoom")
            return
        }
        mEnxRoom.acceptInviteFloorRequest(clientId)
    }
    
    //MARK: - Pin/Unpin user
    /*This method for Modaitore, Where he/she can releaseFloor any particepnt floor request*/
    @objc public func pinUsers(_ command : CDVInvokedUrlCommand){
        updateEventList(command: command, forKey: "pinUsers")
        guard let argu = getRequestArgument(command: command) else {
            return
        }
        guard  let clientIds = argu["clientIds"] as? [String]  else{
            reportErrorToJS("Wrong JSON  : \(argu)")
            return
        }
        guard mEnxRoom != nil else {
            reportErrorToJS("Object is not initialize : EnxRoom")
            return
        }
        mEnxRoom.pinUsers(clientIds)
    }
    /*This method for Modaitore, Where he/she can releaseFloor any particepnt floor request*/
    @objc public func unpinUsers(_ command : CDVInvokedUrlCommand){
        updateEventList(command: command, forKey: "unpinUsers")
        guard let argu = getRequestArgument(command: command) else {
            return
        }
        guard  let clientIds = argu["clientIds"] as? [String]  else{
            reportErrorToJS("Wrong JSON  : \(argu)")
            return
        }
        guard mEnxRoom != nil else {
            reportErrorToJS("Object is not initialize : EnxRoom")
            return
        }
        mEnxRoom.unpinUsers(clientIds)
    }
    //MARK: - Spotlight user
    /*This method add spotlight user*/
    @objc public func addSpotlightUsers(_ command : CDVInvokedUrlCommand){
        updateEventList(command: command, forKey: "addSpotlightUsers")
        guard let argu = getRequestArgument(command: command) else {
            return
        }
        guard  let clientIds = argu["clientIds"] as? [String]  else{
            reportErrorToJS("Wrong JSON  : \(argu)")
            return
        }
        guard mEnxRoom != nil else {
            reportErrorToJS("Object is not initialize : EnxRoom")
            return
        }
        mEnxRoom.addSpotlightUsers(clientIds)
    }
    /*This method for remove spotlight user*/
    @objc public func removeSpotlightUsers(_ command : CDVInvokedUrlCommand){
        updateEventList(command: command, forKey: "removeSpotlightUsers")
        guard let argu = getRequestArgument(command: command) else {
            return
        }
        guard  let clientIds = argu["clientIds"] as? [String]  else{
            reportErrorToJS("Wrong JSON  : \(argu)")
            return
        }
        guard mEnxRoom != nil else {
            reportErrorToJS("Object is not initialize : EnxRoom")
            return
        }
        mEnxRoom.removeSpotlightUsers(clientIds)
    }
    /*Audio Energy /Talker Notification*/
    @objc public func subscribeForTalkerNotification(_ command : CDVInvokedUrlCommand){
        updateEventList(command: command, forKey: "subscribeForTalkerNotification")
        guard let argu = getRequestArgument(command: command) else {
            return
        }
        guard  let flag = argu["isTalkerNofitication"] as? Bool  else{
            reportErrorToJS("Wrong JSON  : \(argu)")
            return
        }
        guard mEnxRoom != nil else {
            reportErrorToJS("Object is not initialize : EnxRoom")
            return
        }
        mEnxRoom.subscribe(forTalkerNotification: flag)
    }
    //MARK: - switch Room
    /*Switch Room mode*/
    @objc public func switchRoomMode(_ command : CDVInvokedUrlCommand){
        updateEventList(command: command, forKey: "switchRoomMode")
        guard let argu = getRequestArgument(command: command) else {
            return
        }
        guard  let roomMode = argu["roomMode"] as? String  else{
            reportErrorToJS("Wrong JSON  : \(argu)")
            return
        }
        guard mEnxRoom != nil else {
            reportErrorToJS("Object is not initialize : EnxRoom")
            return
        }
        mEnxRoom.switchRoomMode(roomMode)
    }
    /* Single Mute Audio */
    @objc public func hardMuteUserAudio(_ command : CDVInvokedUrlCommand){
        updateEventList(command: command, forKey: "hardMuteUserAudio")
        guard let argu = getRequestArgument(command: command) else {
            return
        }
        guard  let clientId = argu["clientId"] as? String  else{
            reportErrorToJS("Wrong JSON  : \(argu)")
            return
        }
        guard mEnxRoom != nil else {
            reportErrorToJS("Object is not initialize : EnxRoom")
            return
        }
        mEnxRoom.hardMuteUserAudio(clientId)
    }
    /* Single UnMute Audio */
    @objc public func hardUnmuteUserAudio(_ command : CDVInvokedUrlCommand){
        updateEventList(command: command, forKey: "hardUnmuteUserAudio")
        guard let argu = getRequestArgument(command: command) else {
            return
        }
        guard  let clientId = argu["clientId"] as? String  else{
            reportErrorToJS("Wrong JSON  : \(argu)")
            return
        }
        guard mEnxRoom != nil else {
            reportErrorToJS("Object is not initialize : EnxRoom")
            return
        }
        mEnxRoom.hardUnmuteUserAudio(clientId)
    }
    /* Single Mute Video */
    @objc public func hardMuteUserVideo(_ command : CDVInvokedUrlCommand){
        updateEventList(command: command, forKey: "hardMuteUserVideo")
        guard let argu = getRequestArgument(command: command) else {
            return
        }
        guard  let clientId = argu["clientId"] as? String  else{
            reportErrorToJS("Wrong JSON  : \(argu)")
            return
        }
        guard mEnxRoom != nil else {
            reportErrorToJS("Object is not initialize : EnxRoom")
            return
        }
        mEnxRoom.hardMuteUserVideo(clientId)
    }
    
    /* Single UnMute Video */
    @objc public func hardUnmuteUserVideo(_ command : CDVInvokedUrlCommand){
        updateEventList(command: command, forKey: "hardUnmuteUserVideo")
        guard let argu = getRequestArgument(command: command) else {
            return
        }
        guard  let clientId = argu["clientId"] as? String  else{
            reportErrorToJS("Wrong JSON  : \(argu)")
            return
        }
        guard mEnxRoom != nil else {
            reportErrorToJS("Object is not initialize : EnxRoom")
            return
        }
        mEnxRoom.hardUnmuteUserVideo(clientId)
        
    }
    //Heighlite selected User Border color
    @objc public func highlightBorderForClient(_ command : CDVInvokedUrlCommand){
        updateEventList(command: command, forKey: "highlightBorderForClient")
        guard let argu = getRequestArgument(command: command) else {
            return
        }
        guard  let clientIds = argu["clientIds"] as? [String]  else{
            reportErrorToJS("Wrong JSON  : \(argu)")
            return
        }
        guard mEnxRoom != nil else {
            reportErrorToJS("Object is not initialize : EnxRoom")
            return
        }
        mEnxRoom.highlightBorderForClient(clientIds)
        trigger(succussJSEvent: "highlightBorderForClient", actionName: "highlightBorderForClient", requestData: "Success")
    }
    //Change BG color for selected Clients
    @objc public func changeBgColorForClients(_ command : CDVInvokedUrlCommand){
        updateEventList(command: command, forKey: "changeBgColorForClients")
        guard let argu = getRequestArgument(command: command) else {
            return
        }
        guard  let clientIds = argu["clientIds"] as? [String], let color = argu["color"] as? String else{
            reportErrorToJS("Wrong JSON  : \(argu)")
            return
        }
        guard mEnxRoom != nil else {
            reportErrorToJS("Object is not initialize : EnxRoom")
            return
        }
        if let finalColor = colorFromHexString(color){
            mEnxRoom.changeBgColorForClients(clientIds, withColor: finalColor)
            trigger(succussJSEvent: "changeBgColorForClients", actionName: "changeBgColorForClients", requestData: "Success")
        }
    }
    //Change BG color for selected Clients
    @objc public func captureScreenShot(_ command : CDVInvokedUrlCommand){
        updateEventList(command: command, forKey: "captureScreenShot")
        guard let argu = getRequestArgument(command: command) else {
            return
        }
        guard  let streamID = argu["streamId"] as? String else{
            reportErrorToJS("Wrong JSON  : \(argu)")
            return
        }
        guard mEnxRoom != nil else {
            reportErrorToJS("Object is not initialize : EnxRoom")
            return
        }
        if let stream = mEnxRoom.streamsByStreamId[streamID]{
            if let enxPlayer = stream.enxPlayerView{
                enxPlayer.captureScreenShot()
            }
        }
    }
    //MARK: - Live Transcription
    @objc public func subscribeForLiveTranscription(_ command : CDVInvokedUrlCommand){
        updateEventList(command: command, forKey: "subscribeForLiveTranscription")
        guard let argu = getRequestArgument(command: command) else {
            return
        }
        guard  let flag = argu["enable"] as? Bool else{
            reportErrorToJS("Wrong JSON  : \(argu)")
            return
        }
        guard mEnxRoom != nil else {
            reportErrorToJS("Object is not initialize : EnxRoom")
            return
        }
        mEnxRoom.subscribe(forLiveTranscription: flag)
    }
    
    @objc public func startLiveTranscription(_ command : CDVInvokedUrlCommand){
        updateEventList(command: command, forKey: "startLiveTranscription")
        guard mEnxRoom != nil else {
            reportErrorToJS("Object is not initialize : EnxRoom")
            return
        }
        mEnxRoom.startLiveTranscription(forRoom: "")
    }
    @objc public func stopLiveTranscription(_ command : CDVInvokedUrlCommand){
        updateEventList(command: command, forKey: "stopLiveTranscription")
        guard mEnxRoom != nil else {
            reportErrorToJS("Object is not initialize : EnxRoom")
            return
        }
        mEnxRoom.stopLiveTranscription()
    }
    
    //MARK: - Private /Internal Apis
    /*
      Check for Camera and mic premission.
    */
    private func getPrivacyAccess(){
        let vStatus = AVCaptureDevice.authorizationStatus(for: .video)
        if(vStatus == AVAuthorizationStatus.notDetermined){
            AVCaptureDevice.requestAccess(for: .video, completionHandler: { (granted: Bool) in
            })
        }
        let aStatus = AVCaptureDevice.authorizationStatus(for: .audio)
        if(aStatus == AVAuthorizationStatus.notDetermined){
            AVCaptureDevice.requestAccess(for: .audio, completionHandler: { (granted: Bool) in
            })
        }
    }
    private func checkForObjectRef(){
        if mEnxRtc == nil{
            mEnxRtc = EnxRtc()
            parentView = webView
        }
    }
    /* Add constant For loacal view */
    private func addConstant(forlocalView view :EnxPlayerView, withDetails details : [String : Any]){
        view.translatesAutoresizingMaskIntoConstraints = false
        var height : Int = 0
        var width : Int = 0
        var position : String = "right"
        var topMargin : Int = 20
        var leftMargin : Int = 20
        var rightMargin : Int = -20
        var bottomMargin : Int = -20
        if let rheight = details["height"] as? Int{
            rheight == 0 ? (height = 130) :  (height = rheight)
        }
        if let rwidth = details["width"] as? Int{
            rwidth == 0 ? (width = 100) :  (width = rwidth)
        }
        if let margin_top = details["margin_top"] as? Int{
            topMargin = margin_top
        }
        if let margin_left = details["margin_left"] as? Int{
            leftMargin = margin_left
        }
        if let margin_right = details["margin_right"] as? Int{
            rightMargin = margin_right
        }
        if let margin_bottom = details["margin_bottom"] as? Int{
            bottomMargin = margin_bottom
        }
        if let rposition = details["position"] as? String{
            position = rposition
        }
        view.heightAnchor.constraint(equalToConstant: CGFloat(height)).isActive = true
        view.widthAnchor.constraint(equalToConstant: CGFloat(width)).isActive = true
        (position.caseInsensitiveCompare("right") == .orderedSame) ? rightConstraint(view, topMargin: topMargin, rightMargin: rightMargin) : (position.caseInsensitiveCompare("left") == .orderedSame) ? leftConstraint(view, topMargin: topMargin, leftMargin: leftMargin) : (position.caseInsensitiveCompare("top") == .orderedSame) ? topConstraint(view, topMargin: topMargin, rightMargin: rightMargin) : (position.caseInsensitiveCompare("bottom") == .orderedSame) ? bottomConstraint(view, bottomMargin: bottomMargin, rightMargin: rightMargin) : centerConstraint(view)
    }
    //local View position = right add constant
    private func rightConstraint(_ view : EnxPlayerView , topMargin top : Int , rightMargin right : Int){
        view.topAnchor.constraint(equalTo: parentView.topAnchor, constant: CGFloat(top)).isActive = true
        view.trailingAnchor.constraint(equalTo: parentView.trailingAnchor, constant: -(CGFloat(right))).isActive = true
    }
    //local View position = Left add constant
    private func leftConstraint(_ view : EnxPlayerView , topMargin top : Int , leftMargin left : Int){
        view.topAnchor.constraint(equalTo: parentView.topAnchor, constant: CGFloat(top)).isActive = true
        view.leadingAnchor.constraint(equalTo: parentView.trailingAnchor, constant: CGFloat(left)).isActive = true
    }
    //local View position = top add constant
    private func topConstraint(_ view : EnxPlayerView , topMargin top : Int , rightMargin right : Int){
        view.topAnchor.constraint(equalTo: parentView.topAnchor, constant: CGFloat(top)).isActive = true
        view.trailingAnchor.constraint(equalTo: parentView.trailingAnchor, constant: -(CGFloat(right))).isActive = true
    }
    //local View position = bottom add constant
    private func bottomConstraint(_ view : EnxPlayerView , bottomMargin bottom : Int , rightMargin right : Int){
        view.bottomAnchor.constraint(equalTo: parentView.topAnchor, constant: -(CGFloat(bottom))).isActive = true
        view.trailingAnchor.constraint(equalTo: parentView.trailingAnchor, constant: -(CGFloat(right))).isActive = true
    }
    //local View position = center add constant
    private func centerConstraint(_ view : EnxPlayerView){
        view.centerXAnchor.constraint(equalTo: view.superview!.centerXAnchor).isActive = true
        view.centerYAnchor.constraint(equalTo: view.superview!.centerYAnchor).isActive = true
    }
    /*
       Add constant For Remote view
    */
    private func addConstant(forRemoteView details : [String : Any]){
        mRemoteView.translatesAutoresizingMaskIntoConstraints = false
        var height : Int = 0
        var width : Int = 0
        var position : String = "right"
        var topMargin : Int = 20
        var leftMargin : Int = 20
        var rightMargin : Int = -20
        var bottomMargin : Int = -20
        if let rheight = details["height"] as? Int{
            rheight == 0 ? (height = 130) :  (height = rheight)
        }
        if let rwidth = details["width"] as? Int{
            rwidth == 0 ? (width = 100) :  (width = rwidth)
        }
        if let margin_top = details["margin_top"] as? Int{
            topMargin = margin_top
        }
        if let margin_left = details["margin_left"] as? Int{
            leftMargin = margin_left
        }
        if let margin_right = details["margin_right"] as? Int{
            rightMargin = margin_right
        }
        if let margin_bottom = details["margin_bottom"] as? Int{
            bottomMargin = margin_bottom
        }
        if let rposition = details["position"] as? String{
            position = rposition
        }
        if height == 0 || CGFloat(height) >= parentView.bounds.size.height{
            height = Int(parentView.bounds.size.height)
            height -= topMargin+bottomMargin
        }
        if width == 0 || CGFloat(width) >= parentView.bounds.size.width{
            width = Int(parentView.bounds.size.width)
            width -= leftMargin+rightMargin
        }
        (position.caseInsensitiveCompare("right") == .orderedSame) ? remoteViewRightConstraint(mRemoteView, topMargin: topMargin, rightMargin: rightMargin, leftMargin: leftMargin, bottomMargin: bottomMargin, widthOfView: width, heightOfView: height) : (position.caseInsensitiveCompare("left") == .orderedSame) ? remoteViewLeftConstraint(mRemoteView,topMargin: topMargin, rightMargin: rightMargin, leftMargin: leftMargin, bottomMargin: bottomMargin, widthOfView: width, heightOfView: height) : (position.caseInsensitiveCompare("top") == .orderedSame) ? remoteViewTopConstraint(mRemoteView,topMargin: topMargin, rightMargin: rightMargin, leftMargin: leftMargin, bottomMargin: bottomMargin, widthOfView: width, heightOfView: height) : remoteViewBottomConstraint(mRemoteView,topMargin: topMargin, rightMargin: rightMargin, leftMargin: leftMargin, bottomMargin: bottomMargin, widthOfView: width, heightOfView: height)
    }
    //Remote View position = right add constant
    private func remoteViewRightConstraint(_ view : UIView, topMargin top : Int , rightMargin right : Int, leftMargin left : Int , bottomMargin bottom : Int, widthOfView width : Int, heightOfView height : Int){
        var leftMargin : Int = 0
        var bottomMargin : Int = 0
        view.topAnchor.constraint(equalTo: parentView.topAnchor, constant: CGFloat(top)).isActive = true
        view.trailingAnchor.constraint(equalTo: parentView.trailingAnchor, constant: -(CGFloat(right))).isActive = true
        leftMargin = (left == 0) ? (Int(parentView.bounds.size.width) - width) : left
        view.leadingAnchor.constraint(equalTo: parentView.leadingAnchor, constant: CGFloat(leftMargin)).isActive = true
        bottomMargin = (bottom == 0) ? (Int(parentView.bounds.size.height) - height) : bottom
        view.bottomAnchor.constraint(equalTo: parentView.bottomAnchor, constant: -(CGFloat(bottomMargin))).isActive = true
        
    }
    //Remote View position = Left add constant
    private func remoteViewLeftConstraint(_ view : UIView , topMargin top : Int , rightMargin right : Int, leftMargin left : Int , bottomMargin bottom : Int, widthOfView width : Int, heightOfView height : Int){
        var rightMargin : Int = 0
        var bottomMargin : Int = 0
        view.topAnchor.constraint(equalTo: parentView.topAnchor, constant: CGFloat(top)).isActive = true
        view.leadingAnchor.constraint(equalTo: parentView.leadingAnchor, constant: CGFloat(left)).isActive = true
        bottomMargin = (bottom == 0) ? Int(parentView.bounds.size.height) - height : bottom
        view.bottomAnchor.constraint(equalTo: parentView.bottomAnchor, constant: -(CGFloat(bottomMargin))).isActive = true
        rightMargin = (right == 0) ? Int(parentView.bounds.size.width) - width : right
        view.trailingAnchor.constraint(equalTo: parentView.trailingAnchor, constant: -(CGFloat(rightMargin))).isActive = true
    }
    //Remote View position = top add constant
    private func remoteViewTopConstraint(_ view : UIView ,topMargin top : Int , rightMargin right : Int, leftMargin left : Int , bottomMargin bottom : Int, widthOfView width : Int, heightOfView height : Int){
        var leftMargin : Int = 0
        var bottomMargin : Int = 0
        view.topAnchor.constraint(equalTo: parentView.topAnchor, constant: CGFloat(top)).isActive = true
        leftMargin = (left == 0) ? Int(parentView.bounds.size.width) - width : left
        view.leadingAnchor.constraint(equalTo: parentView.leadingAnchor, constant: -(CGFloat(leftMargin))).isActive = true
        
        bottomMargin = (bottom == 0) ? Int(parentView.bounds.size.height) - height : bottom
        
        view.bottomAnchor.constraint(equalTo: parentView.bottomAnchor, constant: -(CGFloat(bottomMargin))).isActive = true
        
        view.trailingAnchor.constraint(equalTo: parentView.trailingAnchor, constant: -(CGFloat(right))).isActive = true
    }
    //Remote View position = bottom add constant
    private func remoteViewBottomConstraint(_ view : UIView ,topMargin top : Int , rightMargin right : Int, leftMargin left : Int , bottomMargin bottom : Int, widthOfView width : Int, heightOfView height : Int){
        var leftMargin : Int = 0
        var topMargin : Int = 0
        view.bottomAnchor.constraint(equalTo: parentView.topAnchor, constant: -(CGFloat(bottom))).isActive = true
        view.trailingAnchor.constraint(equalTo: parentView.trailingAnchor, constant: -(CGFloat(right))).isActive = true
        topMargin = (top == 0) ? Int(parentView.bounds.size.height) - height : top
        view.topAnchor.constraint(equalTo: parentView.topAnchor, constant: CGFloat(topMargin)).isActive = true
        leftMargin = (left == 0) ? Int(parentView.bounds.size.width) - width : left
        view.leadingAnchor.constraint(equalTo: parentView.leadingAnchor, constant: CGFloat(leftMargin)).isActive = true
    }
    
    //MARK: - Common Methods for any events , This will notify for app users , Update Event and parse request argument
    /*Common method for All events*/
    private func trigger(succussJSEvent actionType : String, actionName name : String , requestData metaData : Any){
        let dict : [String : Any] = ["eventType" : name, "data" : metaData]
        var result = CDVPluginResult(status: CDVCommandStatus_OK, messageAs: dict)
        result?.setKeepCallbackAs(true)
        self.commandDelegate.send(result, callbackId:(eventListional[actionType] as! String))
    }
    //Update event list
   private func updateEventList(command : CDVInvokedUrlCommand , forKey key :String){
        eventListional.updateValue(command.callbackId, forKey: key)
    }
    //Get request argument
    private func getRequestArgument(command : CDVInvokedUrlCommand) -> [String : Any]?{
        if  let phrase = command.arguments[0] as? [String:Any]{
            return phrase
        }
        return nil
    }
    /* Common Error message for all event*/
    private func reportErrorToJS(_ str : String){
        //let dict :[String : Any] = ["msg" : "Cordova Plugin Error: \(str)", "errorCode" : 0]
        triggerErrorJSEvent("onEventError", actionName: "onEventError", requestData: ["msg" : "Cordova Plugin Error: \(str)", "errorCode" : 0])
    }
    /*Send Event Error to App*/
    private func triggerErrorJSEvent(_ actionType : String , actionName name : String , requestData metaData : Any){
        let dict : [String : Any] = ["eventType" : name, "data" : metaData]
        var result = CDVPluginResult(status: CDVCommandStatus_OK, messageAs: dict)
        //result?.setKeepCallbackAs(true)
        self.commandDelegate.send(result, callbackId:(eventListional[actionType] as! String))
    }
    /*Remove Existing Constance from LocalPlayer*/
    private func removeAllConstance(fromLocal value : [String : Any]){
        if let superview = mlocalView.superview {
            for constraint in superview.constraints {
                if let firstItem = constraint.firstItem as? UIView, let secondItem = constraint.secondItem as? UIView {
                    if firstItem == mlocalView || secondItem == mlocalView {
                        superview.removeConstraint(constraint)
                    }
                }
            }
        }
        mlocalView.removeAllConstraints()
        addConstant(forlocalView: mlocalView, withDetails: value)
        trigger(succussJSEvent: "resizeLocalView", actionName: "resizeLocalView", requestData: "Success")
    }
    /*Remove Existing Constance from RemoteView*/
    private func removeAllConstanceFromRemote(fromLocal value : [String : Any]){
        if let superview = mRemoteView.superview {
            for constraint in superview.constraints {
                if let firstItem = constraint.firstItem as? UIView, let secondItem = constraint.secondItem as? UIView {
                    if firstItem == mRemoteView || secondItem == mRemoteView {
                        superview.removeConstraint(constraint)
                    }
                }
            }
        }
        mRemoteView.removeAllConstraints()
        addConstant(forRemoteView: value)
        for view in mRemoteView.subviews{
            if view.tag ==  10100000112{
                view.removeFromSuperview()
                mRemoteView.addSubview(view)
                setLayoutConstant(view,toView: mRemoteView)
                break
            }
        }
        mEnxRoom.adjustLayout()
        trigger(succussJSEvent: "resizeRemoteView", actionName: "resizeRemoteView", requestData: "Success")
    }
    /*Add constant For AT View*/
    private func setLayoutConstant(_ view : UIView , toView pView : UIView){
        view.translatesAutoresizingMaskIntoConstraints = false
        view.leadingAnchor.constraint(equalTo: pView.leadingAnchor, constant: 1.0).isActive = true
        view.trailingAnchor.constraint(equalTo: pView.trailingAnchor, constant: 1.0).isActive = true
        view.bottomAnchor.constraint(equalTo: pView.bottomAnchor, constant: 1.0).isActive = true
        view.topAnchor.constraint(equalTo: pView.topAnchor, constant: 1.0).isActive = true
    }
    private func startLocalTouchListener(_ flag : Bool){
        if flag{
            let localPanGuster = UIPanGestureRecognizer(target: self, action: #selector(dragView(_ :)))
            mlocalView.addGestureRecognizer(localPanGuster)
            mlocalView.isUserInteractionEnabled = true
        }
        else{
            if let gestureRecognizers = mlocalView.gestureRecognizers {
                for gr in gestureRecognizers{
                    mlocalView.removeGestureRecognizer(gr)
                }
            }
        }
        mlocalView.isUserInteractionEnabled = flag
    }
    private func startRemoteTouchListener(_ flag : Bool){
        if flag{
            let localPanGuster = UIPanGestureRecognizer(target: self, action: #selector(dragView(_ :)))
            mRemoteView.addGestureRecognizer(localPanGuster)
            mRemoteView.isUserInteractionEnabled = true
        }
        else{
            if let gestureRecognizers = mRemoteView.gestureRecognizers {
                for gr in gestureRecognizers{
                    mRemoteView.removeGestureRecognizer(gr)
                }
            }
        }
        mRemoteView.isUserInteractionEnabled = flag
    }
    @objc
    func dragView(_ sender : UIPanGestureRecognizer){
        var xAxis : CGFloat = 0.0
        var yAxis : CGFloat = 0.0
        var translatedPoint = sender.translation(in: parentView)
        if sender.state == .began{
            firstX = (sender.view?.center.x)!
            firstY = (sender.view?.center.y)!
            xAxis = firstX+translatedPoint.x
            yAxis = firstY+translatedPoint.y
        }
        if sender.state == .ended{
            xAxis = translatedPoint.x + 0 * (sender.velocity(in: sender.view)).x
            yAxis = translatedPoint.y + 0 * (sender.velocity(in: sender.view)).y
        }
       sender.view?.center = CGPoint(x: xAxis, y: yAxis)
    }
    /*Create option View for Screen Share ,Canvas,whiteboard,annotation*/
    private func createOptionView(_ options : [String : Any]){
        if mOptionView == nil{
            mOptionView = UIView(frame: .zero)
            parentView.addSubview(mOptionView)
            mOptionView.backgroundColor = .black
            parentView.bringSubviewToFront(mOptionView)
            parentView.bringSubviewToFront(mlocalView)
            addConstant(forOptionsView: options)
            mOptionView.addSubview(mOptionPlayer)
            setLayoutConstant(mOptionPlayer, toView: mOptionView)
        }
    }
    private func addConstant(forOptionsView details : [String : Any]){
        mOptionView.translatesAutoresizingMaskIntoConstraints = false
        var height : Int = 0
        var width : Int = 0
        var position : String = "right"
        var topMargin : Int = 0
        var leftMargin : Int = 0
        var rightMargin : Int = 0
        var bottomMargin : Int = 0
        if let rheight = details["height"] as? Int{
            rheight == 0 ? (height = 130) :  (height = rheight)
        }
        if let rwidth = details["width"] as? Int{
            rwidth == 0 ? (width = 100) :  (width = rwidth)
        }
        if let margin_top = details["margin_top"] as? Int{
            topMargin = margin_top
        }
        if let margin_left = details["margin_left"] as? Int{
            leftMargin = margin_left
        }
        if let margin_right = details["margin_right"] as? Int{
            rightMargin = margin_right
        }
        if let margin_bottom = details["margin_bottom"] as? Int{
            bottomMargin = margin_bottom
        }
        if let rposition = details["position"] as? String{
            position = rposition
        }
        if height == 0 || CGFloat(height) >= parentView.bounds.size.height{
            height = Int(parentView.bounds.size.height)
            height -= topMargin+bottomMargin
        }
        if width == 0 || CGFloat(width) >= parentView.bounds.size.width{
            width = Int(parentView.bounds.size.width)
            width -= leftMargin+rightMargin
        }
        (position.caseInsensitiveCompare("right") == .orderedSame) ? remoteViewRightConstraint(mOptionView , topMargin: topMargin, rightMargin: rightMargin, leftMargin: leftMargin, bottomMargin: bottomMargin, widthOfView: width, heightOfView: height) : (position.caseInsensitiveCompare("left") == .orderedSame) ? remoteViewLeftConstraint(mOptionView , topMargin: topMargin, rightMargin: rightMargin, leftMargin: leftMargin, bottomMargin: bottomMargin, widthOfView: width, heightOfView: height) : (position.caseInsensitiveCompare("top") == .orderedSame) ? remoteViewTopConstraint(mOptionView , topMargin: topMargin, rightMargin: rightMargin, leftMargin: leftMargin, bottomMargin: bottomMargin, widthOfView: width, heightOfView: height) : remoteViewBottomConstraint(mOptionView , topMargin: topMargin, rightMargin: rightMargin, leftMargin: leftMargin, bottomMargin: bottomMargin, widthOfView: width, heightOfView: height)
    }
    private func cleanOptionView(){
        mOptionStream.detachRenderer()
        mOptionPlayer.reloadInputViews()
        mOptionView.removeFromSuperview()
        mOptionView = nil
        mOptionPlayer = nil
    }
    private func create(optionStream stream : EnxStream?){
        guard stream != nil else {
            return
        }
        mOptionStream = stream
        guard let optPlayer = mOptionStream.enxPlayerView else {
            return
        }
        mOptionPlayer = optPlayer
        mOptionPlayer.delegate = self
    }
   private func colorFromHexString(_ hexString: String) -> UIColor? {
        var rgbValue: UInt64 = 0
        let scanner = Scanner(string: hexString)
        scanner.scanLocation = 1 // bypass '#' character
        scanner.scanHexInt64(&rgbValue)

        let red = CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0
        let green = CGFloat((rgbValue & 0xFF00) >> 8) / 255.0
        let blue = CGFloat(rgbValue & 0xFF) / 255.0

        return UIColor(red: red, green: green, blue: blue, alpha: 1.0)
    }
    private func releaseAllResources(){
        
    }
}
extension EnxCordovaPlugin : EnxRoomDelegate, EnxStreamDelegate, EnxPlayerDelegate{
    /*
    * Below are the all callbacks which implemented in the plugin class
    */
    /*Room Join call back*/
    public func room(_ room: EnxRoom?, didConnect roomMetadata: [String : Any]?) {
        if room != nil{
            mEnxRoom = room
            roomMode = mEnxRoom.getRoomMode()
            mEnxRoom.publish(mLocalStream)
        }
        trigger(succussJSEvent: "onRoomConnected", actionName: "onRoomConnected", requestData: roomMetadata!)
    }
    //Publish Stream CallBack
    public func room(_ room: EnxRoom?, didPublishStream stream: EnxStream?) {
        trigger(succussJSEvent: "onPublishStream", actionName: "onPublishStream", requestData:"Success")
    }
    public func room(_ room: EnxRoom?, didSubscribeStream stream: EnxStream?) {
        trigger(succussJSEvent: "onSubscribeStream", actionName: "onSubscribeStream", requestData:stream!.streamId)
    }
    public func room(_ room: EnxRoom?, didActiveTalkerView view: UIView?) {
        guard view != nil else{
            return
        }
        view?.tag = 10100000112
        mRemoteView.addSubview(view!)
        setLayoutConstant(view!, toView: mRemoteView)
    }
    public func room(_ room: EnxRoom?, didActiveTalkerList Data: [EnxStream]?) {
        //Not in used
    }
    /*Self Audio Mute/Unmute callback*/
    public func didAudioEvents(_ responseData: [String : Any]?) {
        trigger(succussJSEvent: "onAudioEvent", actionName: "onAudioEvent", requestData:responseData!)
    }
    /*Self Video Mute/Unmute callback*/
    public func didVideoEvents(_ responseData: [String : Any]?) {
        trigger(succussJSEvent: "onVideoEvent", actionName: "onVideoEvent", requestData:responseData!)
    }
    //UnPublish Stream
    public func room(_ room: EnxRoom?, didUnpublishStream stream: EnxStream?) {
        //
    }
    //Room Disconnected
    public func didRoomDisconnect(_ response: [Any]?) {
        trigger(succussJSEvent: "onRoomDisConnected", actionName: "onRoomDisConnected", requestData:response![0])
        releaseAllResources()
    }
    //Notify device media change update
    public func didNotifyDeviceUpdate(_ updates: String) {
        trigger(succussJSEvent: "onNotifyDeviceUpdate", actionName: "onNotifyDeviceUpdate", requestData:updates)
    }
    /*
     This Delegate will notify to User Once he Getting error in joining room
     */
    public func room(_ room: EnxRoom?, didError reason: [Any]?) {
        trigger(succussJSEvent: "onRoomError", actionName: "onRoomError", requestData:reason![0])
    }
    //Stream Ready To Subscribe
    public func room(_ room: EnxRoom?, didAddedStream stream: EnxStream?) {
        // We subscribe to all streams added.
        if stream != nil{
           let _ = mEnxRoom.subscribe(stream!)
        }
        trigger(succussJSEvent: "onAddedStream", actionName: "onAddedStream", requestData:stream!.streamId)
    }
    /*
    This Delegate will notify when any user join the room.
    */
    public func room(_ room: EnxRoom?, userDidJoined Data: [Any]?) {
        trigger(succussJSEvent: "onUserConnected", actionName: "onUserConnected", requestData:Data![0])
    }
    /*
     This Delegate will notify when any user leave the room.
     */
    public func room(_ room: EnxRoom?, userDidDisconnected Data: [Any]?) {
        trigger(succussJSEvent: "onUserDisConnected", actionName: "onUserDisConnected", requestData:Data![0])
    }
    /**
    Get Max Talker Count In room
     */
    public func room(_ room: EnxRoom?, didGetMaxTalkers Data: [Any]?) {
        trigger(succussJSEvent: "onMaxTalkerCount", actionName: "onMaxTalkerCount", requestData:Data![0])
    }
    /**
     Get Current Talker Count In room
     */
    public func room(_ room: EnxRoom?, didGetTalkerCount Data: [Any]?) {
        trigger(succussJSEvent: "onGetTalkerCount", actionName: "onGetTalkerCount", requestData:Data![0])
    }
    public func room(_ room: EnxRoom?, didSetTalkerCount Data: [Any]?) {
        trigger(succussJSEvent: "onSetTalkerCount", actionName: "onSetTalkerCount", requestData:Data![0])
    }
    public func room(_ room: EnxRoom?, didAckLockRoom data: [Any]?) {
        trigger(succussJSEvent: "onAckLockRoom", actionName: "onAckLockRoom", requestData:data![0])
    }
    public func room(_ room: EnxRoom?, didAckUnlockRoom data: [Any]?) {
        trigger(succussJSEvent: "onAckUnLockRoom", actionName: "onAckUnLockRoom", requestData:data![0])
    }
    public func room(_ room: EnxRoom?, didLockRoom data: [Any]?) {
        trigger(succussJSEvent: "onLockedRoom", actionName: "onLockedRoom", requestData:data![0])
    }
    public func room(_ room: EnxRoom?, didUnlockRoom data: [Any]?) {
        trigger(succussJSEvent: "onUnLockedRoom", actionName: "onUnLockedRoom", requestData:data![0])
    }
    //Delegate for drop and destroy
    public func room(_ room: EnxRoom?, didAckDropUser data: [Any]?) {
        trigger(succussJSEvent: "onAckDropUser", actionName: "onAckDropUser", requestData:data![0])
    }
    public func room(_ room: EnxRoom?, didAckDestroy data: [Any]?) {
        trigger(succussJSEvent: "onAckDestroy", actionName: "onAckDestroy", requestData:data![0])
    }
    public func didLogUpload(_ data: [Any]?) {
        trigger(succussJSEvent: "onLogUploaded", actionName: "onLogUploaded", requestData:data![0])
    }
    public func didhardMute(_ Data: [Any]?) {
        trigger(succussJSEvent: "onHardMuted", actionName: "onHardMuted", requestData:Data![0])
    }
    public func didHardMuteRecived(_ Data: [Any]?) {
        trigger(succussJSEvent: "onReceivedHardMute", actionName: "onReceivedHardMute", requestData:Data![0])
    }
    public func didHardunMuteRecived(_ Data: [Any]?) {
        trigger(succussJSEvent: "onReceivedHardUnMute", actionName: "onReceivedHardUnMute", requestData:Data![0])
    }
    public func stream(_ stream: EnxStream?, didHardVideoMute responseData: [Any]?) {
        trigger(succussJSEvent: "onReceivedHardUnMute", actionName: "onReceivedHardUnMute", requestData:responseData![0])
    }
    public func stream(_ stream: EnxStream?, didHardVideoUnMute responseData: [Any]?) {
        trigger(succussJSEvent: "onHardUnMutedVideo", actionName: "onHardUnMutedVideo", requestData:responseData![0])
    }
    public func stream(_ stream: EnxStream?, didReceivehardMuteVideo responseData: [Any]?) {
        trigger(succussJSEvent: "onReceivedHardMuteVideo", actionName: "onReceivedHardMuteVideo", requestData:responseData![0])
    }
    public func stream(_ stream: EnxStream?, didRecivehardUnmuteVideo responseData: [Any]?) {
        trigger(succussJSEvent: "onReceivedHardUnMuteVideo", actionName: "onReceivedHardUnMuteVideo", requestData:responseData![0])
    }
    public func didhardMuteAudio(_ responseData: [Any]?) {
        trigger(succussJSEvent: "onHardMutedAudio", actionName: "onHardMutedAudio", requestData:responseData![0])
    }
    public func didhardUnMuteAudio(_ responseData: [Any]?) {
        trigger(succussJSEvent: "onHardUnMutedAudio", actionName: "onHardUnMutedAudio", requestData:responseData![0])
    }
    public func didRecievedHardMutedAudio(_ responseData: [Any]?) {
        trigger(succussJSEvent: "onReceivedHardMuteAudio", actionName: "onReceivedHardMuteAudio", requestData:responseData![0])
    }
    public func didRecievedHardUnmutedAudio(_ responseData: [Any]?) {
        trigger(succussJSEvent: "onReceivedHardUnMuteAudio", actionName: "onReceivedHardUnMuteAudio", requestData:responseData![0])
    }
    public func room(_ room: EnxRoom?, didAcknowledgSendData data: [Any]?) {
        trigger(succussJSEvent: "onAcknowledgedSendData", actionName: "onAcknowledgedSendData", requestData:data![0])
    }
    /*
     This delegate method called to receive message at room Level.
     */
    public func room(_ room: EnxRoom, didMessageReceived data: [Any]?) {
        trigger(succussJSEvent: "onMessageReceived", actionName: "onMessageReceived", requestData:data![0])
    }
    /*
     This delegate method called to receive custom signaling event message at room Level.
     */
    public func room(_ room: EnxRoom, didUserDataReceived data: [Any]?) {
        trigger(succussJSEvent: "onUserDataReceived", actionName: "onUserDataReceived", requestData:data![0])
    }
    public func room(_ room: EnxRoom?, didRoomBandwidthAlert data: [Any]?) {
        trigger(succussJSEvent: "onRoomBandwidthAlert", actionName: "onRoomBandwidthAlert", requestData:data![0])
    }
    public func room(_ room: EnxRoom?, didSwitchUserRole data: [Any]?) {
        trigger(succussJSEvent: "onSwitchedUserRole", actionName: "onSwitchedUserRole", requestData:data![0])
    }
    public func room(_ room: EnxRoom?, didUserRoleChanged data: [Any]?) {
        trigger(succussJSEvent: "onUserRoleChanged", actionName: "onUserRoleChanged", requestData:data![0])
    }
    /*
     Confrence Time Alert
     */
    public func room(_ room: EnxRoom?, didConferenceRemainingDuration data: [Any]?) {
        trigger(succussJSEvent: "onConferenceRemainingDuration", actionName: "onConferenceRemainingDuration", requestData:data![0])
    }
    /* Extend Confrence callback*/
    public func room(_ room: EnxRoom?, didConferencessExtended data: [Any]?) {
        trigger(succussJSEvent: "onConferencessExtended", actionName: "onConferencessExtended", requestData:data![0])
    }
    public func room(_ room: EnxRoom?, didReceiveData data: [Any]?, fromStream stream: EnxStream?) {
        trigger(succussJSEvent: "onReceivedData", actionName: "onReceivedData", requestData:data![0])
    }
    public func room(_ room: EnxRoom?, didAcknowledgementAdvanceOption data: [String : Any]?) {
        trigger(succussJSEvent: "onAdvancedOptionsUpdate", actionName: "onAdvancedOptionsUpdate", requestData:data!)
    }
    public func room(_ room: EnxRoom?, didBatteryUpdates data: [String : Any]?) {
        trigger(succussJSEvent: "onAdvancedOptionsUpdate", actionName: "onAdvancedOptionsUpdate", requestData:data!)
    }
    public func room(_ room: EnxRoom?, didAspectRatioUpdates data: [String : Any]?) {
        trigger(succussJSEvent: "onAdvancedOptionsUpdate", actionName: "onAdvancedOptionsUpdate", requestData:data!)
    }
    public func room(_ room: EnxRoom?, didVideoResolutionUpdates data: [Any]?) {
        trigger(succussJSEvent: "onAdvancedOptionsUpdate", actionName: "onAdvancedOptionsUpdate", requestData:data![0])
    }
    public func room(_ room: EnxRoom?, didGetAdvanceOptions data: [Any]?) {
        trigger(succussJSEvent: "onGetAdvancedOptions", actionName: "onGetAdvancedOptions", requestData:data![0])
    }
    public func room(_ room: EnxRoom?, didBandWidthUpdated data: [Any]?) {
        trigger(succussJSEvent: "onBandWidthUpdated", actionName: "onBandWidthUpdated", requestData:data![0])
    }
    public func room(_ room: EnxRoom?, didCanvasStreamEvent data: [Any]?) {
        trigger(succussJSEvent: "onCanvasStreamEvent", actionName: "onCanvasStreamEvent", requestData:data![0])
    }
    public func room(_ room: EnxRoom?, didShareStreamEvent data: [Any]?) {
        trigger(succussJSEvent: "onShareStreamEvent", actionName: "onShareStreamEvent", requestData:data![0])
    }
    public func room(_ room: EnxRoom?, didConnectionInterrupted data: [Any]?) {
        trigger(succussJSEvent: "onConnectionInterrupted", actionName: "onConnectionInterrupted", requestData:data![0])
    }
    public func room(_ room: EnxRoom?, didConnectionLost data: [Any]?) {
        trigger(succussJSEvent: "onConnectionLost", actionName: "onConnectionLost", requestData:data![0])
    }
    public func room(_ room: EnxRoom?, didOutBoundCallInitiated data: [Any]?) {
        trigger(succussJSEvent: "onOutBoundCallInitiated", actionName: "onOutBoundCallInitiated", requestData:data![0])
    }
    public func room(_ room: EnxRoom?, didDialStateEvents state: EnxOutBoundCallState) {
        var statusName : String = "Initiated"
        if state == .Initiated{ statusName = "Initiated"}
        else if state == .Ringing{ statusName = "Ringing"}
        else if state == .Connected{ statusName = "Connected"}
        else if state == .Failed{ statusName = "Failed"}
        else if state == .Disconnected{ statusName = "Disconnected"}
        else if state == .Timeout{ statusName = "Timeout"}
        trigger(succussJSEvent: "onDialStateEvents", actionName: "onDialStateEvents", requestData:statusName)
    }
    public func room(_ room: EnxRoom?, didDTMFCollected data: String?) {
        trigger(succussJSEvent: "onDialStateEvents", actionName: "onDialStateEvents", requestData:data!)
    }
    public func room(_ channel: EnxRoom?, didOutBoundCallCancel data: [Any]?) {
        trigger(succussJSEvent: "onOutBoundCallCancel", actionName: "onOutBoundCallCancel", requestData:data!)
    }
    public func didPlayerStats(_ statsData: [String : Any]) {
        trigger(succussJSEvent: "onOutBoundCallCancel", actionName: "onOutBoundCallCancel", requestData:statsData)
    }
    public func room(_ room: EnxRoom?, didReconnect reason: String?) {
        trigger(succussJSEvent: "onReconnect", actionName: "onReconnect", requestData:reason!)
    }
    public func room(_ room: EnxRoom?, didUserReconnectSuccess data: [String : Any]?) {
        trigger(succussJSEvent: "onUserReconnectSuccess", actionName: "onUserReconnectSuccess", requestData:data!)
    }
    public func startRecordingEvent(_ response: [Any]?) {
        trigger(succussJSEvent: "onStartRecordingEvent", actionName: "onStartRecordingEvent", requestData:response![0])
    }
    public func stopRecordingEvent(_ response: [Any]?) {
        trigger(succussJSEvent: "onStopRecordingEvent", actionName: "onStopRecordingEvent", requestData:response![0])
    }
    public func roomRecord(on Data: [Any]?) {
        trigger(succussJSEvent: "onRoomRecordingOn", actionName: "onRoomRecordingOn", requestData:Data![0])
    }
    public func roomRecordOff(_ Data: [Any]?) {
        trigger(succussJSEvent: "onRoomRecordingOff", actionName: "onRoomRecordingOff", requestData:Data![0])
    }
    /*
        This method will update once stats enable and update to app user for stats
        @param statsData has all stats information.
     */
    public func didReceiveStats(_ statsData: [Any]?) {
        trigger(succussJSEvent: "onReceivedStats", actionName: "onReceivedStats", requestData:statsData![0])
    }
    /*
     This method will update  stats Subscribe and UnSubscribe
     @param statsData has all stats information.
     */
    public func didAcknowledgeStats(_ subUnSubResponse: [Any]?) {
        trigger(succussJSEvent: "onAcknowledgeStats", actionName: "onAcknowledgeStats", requestData:subUnSubResponse![0])
    }
    public func stream(_ stream: EnxStream?, didRemoteStreamAudioMute responseData: [Any]?) {
        trigger(succussJSEvent: "onRemoteStreamAudioMute", actionName: "onRemoteStreamAudioMute", requestData:responseData![0])
    }
    public func stream(_ stream: EnxStream?, didRemoteStreamVideoMute responseData: [Any]?) {
        trigger(succussJSEvent: "onRemoteStreamVideoMute", actionName: "onRemoteStreamVideoMute", requestData:responseData![0])
    }
    public func stream(_ stream: EnxStream?, didRemoteStreamVideoUnMute responseData: [Any]?) {
        trigger(succussJSEvent: "onRemoteStreamVideoUnMute", actionName: "onRemoteStreamVideoUnMute", requestData:responseData![0])
    }
    public func stream(_ stream: EnxStream?, didRemoteStreamAudioUnMute responseData: [Any]?) {
        trigger(succussJSEvent: "onRemoteStreamAudioUnMute", actionName: "onRemoteStreamAudioUnMute", requestData:responseData![0])
    }
    //New
    /*This delegate method called When any of the user in same room will start sharing file.*/
    public func room(_ room: EnxRoom, didFileUploadStarted data: [Any]?) {
        trigger(succussJSEvent: "onFileUploadStarted", actionName: "onFileUploadStarted", requestData:data![0])
    }
    /*This delegate method called When self user will start sharing file.*/
    public func room(_ room: EnxRoom, didInitFileUpload data: [Any]?) {
        trigger(succussJSEvent: "onInitFileUpload", actionName: "onInitFileUpload", requestData:data![0])
    }
    /*This delegate method called When File available to download.*/
    public func room(_ room: EnxRoom, didFileAvailable data: [Any]?) {
        trigger(succussJSEvent: "onFileAvailable", actionName: "onFileAvailable", requestData:data![0])
    }
    /*This delegate method called upload file is success.*/
    public func room(_ room: EnxRoom, didFileUploaded data: [Any]?) {
        trigger(succussJSEvent: "onFileUploaded", actionName: "onFileUploaded", requestData:data![0])
    }
    /*This delegate method called upload file is failed.*/
    public func room(_ room: EnxRoom, didFileUploadFailed data: [Any]?) {
        trigger(succussJSEvent: "onFileUploadFailed", actionName: "onFileUploadFailed", requestData:data![0])
    }
    /*This delegate method called When download of file success.*/
    public func room(_ room: EnxRoom, didFileDownloaded data: String?) {
        trigger(succussJSEvent: "onFileDownloaded", actionName: "onFileDownloaded", requestData:data!)
    }
    /*This delegate method called When file download failed.*/
    public func room(_ room: EnxRoom, didFileDownloadFailed data: [Any]?) {
        trigger(succussJSEvent: "onFileDownloadFailed", actionName: "onFileDownloadFailed", requestData:data![0])
    }
    /*This delegate method called When file download initiated.*/
    public func room(_ room: EnxRoom, didInitFileDownload data: [Any]?) {
        trigger(succussJSEvent: "onInitFileDownload", actionName: "onInitFileDownload", requestData:data![0])
    }
    /*This delegate method called When file download Cancel.*/
    public func room(_ room: EnxRoom, didFileDownloadCancelled data: [Any]?) {
        trigger(succussJSEvent: "onFileDownloadCancelled", actionName: "onFileDownloadCancelled", requestData:data![0])
    }
    /*This delegate method called When file Upload Cancel.*/
    public func room(_ room: EnxRoom, didFileUploadCancelled data: [Any]?) {
        trigger(succussJSEvent: "onFileUploadCancelled", actionName: "onFileUploadCancelled", requestData:data![0])
    }
    public func room(_ room: EnxRoom?, didScreenShareStarted stream: EnxStream?) {
        trigger(succussJSEvent: "onScreenSharedStarted", actionName: "onScreenSharedStarted", requestData:["eventType" : "onScreenSharedStarted", "data" : "Screen shared started"])
        create(optionStream: stream!)
    }
    public func room(_ room: EnxRoom?, didScreenShareStopped stream: EnxStream?) {
        trigger(succussJSEvent: "onScreenSharedStopped", actionName: "onScreenSharedStopped", requestData:["eventType" : "onScreenSharedStopped", "data" : "Screen shared stopped"])
    }
    public func room(_ room: EnxRoom?, didCanvasStarted stream: EnxStream?) {
        trigger(succussJSEvent: "onCanvasStarted", actionName: "onCanvasStarted", requestData:["eventType" : "onCanvasStarted", "data" : "Canvas started"])
        create(optionStream: stream!)
    }
    public func room(_ room: EnxRoom?, didCanvasStopped stream: EnxStream?) {
        trigger(succussJSEvent: "onCanvasStopped", actionName: "onCanvasStopped", requestData:["eventType" : "onCanvasStopped", "data" : "Canvas stopprd"])
    }
    public func room(_ room: EnxRoom?, didAnnotationStarted stream: EnxStream?) {
        trigger(succussJSEvent: "onAnnotationStarted", actionName: "onAnnotationStarted", requestData:["eventType" : "onCanvasStopped", "data" : "Annotation Started"])
        create(optionStream: stream!)
    }
    public func room(_ room: EnxRoom?, didAnnotationStopped stream: EnxStream?) {
        trigger(succussJSEvent: "onAnnotationStopped", actionName: "onAnnotationStopped", requestData:["eventType" : "onAnnotationStopped", "data" : "Annotation stopprd"])
    }
    public func room(_ room: EnxRoom?, didStartAnnotationACK Data: [Any]?) {
        trigger(succussJSEvent: "onStartAnnotationAck", actionName: "onStartAnnotationAck", requestData:Data![0])
    }
    public func room(_ room: EnxRoom?, didStoppedAnnotationACK Data: [Any]?) {
        trigger(succussJSEvent: "onStoppedAnnotationAck", actionName: "onStoppedAnnotationAck", requestData:Data![0])
    }
    public func room(_ room: EnxRoom?, didStartCanvasACK data: [Any]?) {
        trigger(succussJSEvent: "onStartCanvasACK", actionName: "onStartCanvasACK", requestData:data![0])
    }
    public func room(_ room: EnxRoom?, didStoppedCanvasACK data: [Any]?) {
        trigger(succussJSEvent: "onStoppedCanvasACK", actionName: "onStoppedCanvasACK", requestData:data![0])
    }
    // called when error on event failure like publish, subscribe etc
    public func room(_ room: EnxRoom?, didEventError reason: [Any]?) {
        trigger(succussJSEvent: "onEventError", actionName: "onEventError", requestData:reason![0])
    }
    // called pass info related to any event if required.
    public func room(_ room: EnxRoom?, didEventInfo infoData: [AnyHashable : Any]?) {
        trigger(succussJSEvent: "onEventInfo", actionName: "onEventInfo", requestData:infoData!)
    }
    public func didCapturedView(_ snapShot: UIImage?) {
        if let image = snapShot{
            let imageData = image.pngData()
            if let strBase64 = imageData?.base64EncodedString(options: .lineLength64Characters){
                trigger(succussJSEvent: "OnCapturedView", actionName: "OnCapturedView", requestData:strBase64)
            }
        }
    }
    //MARK: - Callback Methods for Chair controler
    public func didFloorRequested(_ Data: [Any]?) {
        trigger(succussJSEvent: "onFloorRequested", actionName: "onFloorRequested", requestData:Data![0])
    }
    public func didFloorCancelled(_ Data: [Any]?) {
        trigger(succussJSEvent: "onFloorCancelled", actionName: "onFloorCancelled", requestData:Data![0])
    }
    public func didFloorFinished(_ Data: [Any]?) {
        trigger(succussJSEvent: "onFloorFinished", actionName: "onFloorFinished", requestData:Data![0])
    }
    public func didGrantedFloorRequest(_ Data: [Any]?) {
        trigger(succussJSEvent: "onGrantedFloorRequest", actionName: "onGrantedFloorRequest", requestData:Data![0])
    }
    public func didDeniedFloorRequest(_ Data: [Any]?) {
        trigger(succussJSEvent: "onDeniedFloorRequest", actionName: "onDeniedFloorRequest", requestData:Data![0])
    }
    public func didReleasedFloorRequest(_ Data: [Any]?) {
        trigger(succussJSEvent: "onReleasedFloorRequest", actionName: "onReleasedFloorRequest", requestData:Data![0])
    }
    public func didCancelledFloorRequest(_ Data: [Any]?) {
        trigger(succussJSEvent: "onCancelledFloorRequest", actionName: "onCancelledFloorRequest", requestData:Data![0])
    }
    public func didFinishedFloorRequest(_ Data: [Any]?) {
        trigger(succussJSEvent: "onFinishedFloorRequest", actionName: "onFinishedFloorRequest", requestData:Data![0])
    }
    public func didFloorRequestReceived(_ Data: [Any]?) {
        trigger(succussJSEvent: "onFloorRequestReceived", actionName: "onFloorRequestReceived", requestData:Data![0])
    }
    public func didProcessFloorRequested(_ Data: [Any]?) {
        trigger(succussJSEvent: "onProcessFloorRequested", actionName: "onProcessFloorRequested", requestData:Data![0])
    }
    public func didACKInvite(toFloorRequested Data: [Any]?) {
        trigger(succussJSEvent: "onACKInviteToFloorRequested", actionName: "onACKInviteToFloorRequested", requestData:Data![0])
    }
    public func didInvite(toFloorRequested Data: [Any]?) {
        trigger(succussJSEvent: "onInviteToFloorRequested", actionName: "onInviteToFloorRequested", requestData:Data![0])
    }
    public func didInvited(forFloorAccess Data: [Any]?) {
        trigger(succussJSEvent: "onInvitedForFloorAccess", actionName: "onInvitedForFloorAccess", requestData:Data![0])
    }
    public func didCanceledFloorInvite(_ Data: [Any]?) {
        trigger(succussJSEvent: "onCanceledFloorInvite", actionName: "onCanceledFloorInvite", requestData:Data![0])
    }
    public func didRejectedInviteFloor(_ Data: [Any]?) {
        trigger(succussJSEvent: "onRejectedInviteFloor", actionName: "onRejectedInviteFloor", requestData:Data![0])
    }
    public func didAcceptedFloorInvite(_ Data: [Any]?) {
        trigger(succussJSEvent: "onAcceptedFloorInvite", actionName: "onAcceptedFloorInvite", requestData:Data![0])
    }
    //MARK: - pin/unpin callback
    public func room(_ room: EnxRoom?, didAckPinUsers data: [Any]?) {
        trigger(succussJSEvent: "onAckPinUsers", actionName: "onAckPinUsers", requestData:data![0])
    }
    public func room(_ room: EnxRoom?, didAckUnpinUsers data: [Any]?) {
        trigger(succussJSEvent: "onAckUnpinUsers", actionName: "onAckUnpinUsers", requestData:data![0])
    }
    public func room(_ channel: EnxRoom?, didpinnedUsers data: [Any]?) {
        trigger(succussJSEvent: "onPinnedUsers", actionName: "onPinnedUsers", requestData:data![0])
    }
    //MARK: - spotlight callback
    public func room(_ channel: EnxRoom?, didAckAddSpotlightUsers data: [Any]?) {
        trigger(succussJSEvent: "onAckAddSpotlightUsers", actionName: "onAckAddSpotlightUsers", requestData:data![0])
    }
    public func room(_ channel: EnxRoom?, didAckRemoveSpotlightUsers data: [Any]?) {
        trigger(succussJSEvent: "onAckRemoveSpotlightUsers", actionName: "onAckRemoveSpotlightUsers", requestData:data![0])
    }
    public func room(_ channel: EnxRoom?, didUpdatedSpotlightUsers data: [Any]?) {
        trigger(succussJSEvent: "onUpdateSpotlightUsers", actionName: "onUpdateSpotlightUsers", requestData:data![0])
    }
    //MARK: - AudioEnergy /Talker Notification callback
    public func room(_ room: EnxRoom?, didAckSubscribeTalkerNotification data: [Any]?) {
        trigger(succussJSEvent: "onAckSubscribeTalkerNotification", actionName: "onAckSubscribeTalkerNotification", requestData:data![0])
    }
    public func room(_ room: EnxRoom?, didAckUnsubscribeTalkerNotification data: [Any]?) {
        trigger(succussJSEvent: "onAckUnsubscribeTalkerNotification", actionName: "onAckUnsubscribeTalkerNotification", requestData:data![0])
    }
    public func room(_ room: EnxRoom?, didTalkerNotification data: [Any]?) {
        trigger(succussJSEvent: "onTalkerNtification", actionName: "onTalkerNtification", requestData:data![0])
    }
    //MARK: - switched Room Callback
    public func room(_ channel: EnxRoom?, didAckSwitchedRoom data: [Any]?) {
        trigger(succussJSEvent: "onAckSwitchedRoom", actionName: "onAckSwitchedRoom", requestData:data![0])
    }
    public func room(_ channel: EnxRoom?, didRoomModeSwitched data: [Any]?) {
        trigger(succussJSEvent: "onRoomModeSwitched", actionName: "onRoomModeSwitched", requestData:data![0])
    }
    
    //MARK: - single mute user audio
    public func didAckHardMuteUserAudio(_ data: [Any]?) {
        trigger(succussJSEvent: "onAckHardMuteUserAudio", actionName: "onAckHardMuteUserAudio", requestData:data![0])
    }
    
    public func didAckHardMuteUserVideo(_ data: [Any]?) {
        trigger(succussJSEvent: "onAckHardMuteUserVideo", actionName: "onAckHardMuteUserVideo", requestData:data![0])
    }
    public func didAckHardunMuteUserAudio(_ data: [Any]?) {
        trigger(succussJSEvent: "onAckHardunMuteUserAudio", actionName: "onAckHardunMuteUserAudio", requestData:data![0])
    }
    public func didAckHardUnMuteUserVideo(_ data: [Any]?) {
        trigger(succussJSEvent: "onAckHardUnMuteUserVideo", actionName: "onAckHardUnMuteUserVideo", requestData:data![0])
    }
    //MARK: - Livetranscription(Speech to text) callbacks
    public func room(_ room: EnxRoom?, didACKStartLiveTranscription data: [Any]?) {
        trigger(succussJSEvent: "onACKStartLiveTranscription", actionName: "onACKStartLiveTranscription", requestData:data![0])
    }
    public func room(_ room: EnxRoom?, didACKStopLiveTranscription data: [Any]?) {
        trigger(succussJSEvent: "onACKStopLiveTranscription", actionName: "onACKStopLiveTranscription", requestData:data![0])
    }
    public func room(_ room: EnxRoom?, didTranscriptionEvents data: [Any]?) {
        trigger(succussJSEvent: "onTranscriptionEvents", actionName: "onTranscriptionEvents", requestData:data![0])
    }
    public func room(_ room: EnxRoom?, didRoomTranscriptionOn data: [Any]?) {
        trigger(succussJSEvent: "onRoomTranscriptionOn", actionName: "onRoomTranscriptionOn", requestData:data![0])
    }
    public func room(_ room: EnxRoom?, didRoomTranscriptionOff data: [Any]?) {
        trigger(succussJSEvent: "onRoomTranscriptionOff", actionName: "onRoomTranscriptionOff", requestData:data![0])
    }
    public func room(_ room: EnxRoom?, didSelfTranscriptionOn data: [Any]?) {
        trigger(succussJSEvent: "onSelfTranscriptionOn", actionName: "onSelfTranscriptionOn", requestData:data![0])
    }
    public func room(_ room: EnxRoom?, didSelfTranscriptionOff data: [Any]?) {
        trigger(succussJSEvent: "onSelfTranscriptionOff", actionName: "onSelfTranscriptionOff", requestData:data![0])
    }
}
