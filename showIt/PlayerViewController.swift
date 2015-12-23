//
//  PlayerViewController.swift
//  showIt
//
//  Created by Riley Rodenburg on 12/17/15.
//  Copyright © 2015 Riley Rodenburg. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation
import ImageIO
import MobileCoreServices


class PlayerViewController: UIViewController, AVPlayerItemMetadataOutputPushDelegate {
    @IBOutlet var playerView: UIView!
    
    @IBOutlet var libraryButton: UIBarButtonItem!
    @IBOutlet var pauseButton: UIBarButtonItem!
    @IBOutlet var playButton: UIBarButtonItem!
    
    @IBOutlet var honorTimedMetadataTracksDuringPlayback: UISwitch!
    //var facesLayer: [CALayer]?
    var facesLayer: CALayer?
    var itemMetadataOutput: AVPlayerItemMetadataOutput?
    var seekToZeroBeforePlay: Bool?
    //AVPlayerItemMetadataOutput *itemMetadataOutput;
    var player: AVPlayer?
    //@interface AAPLImagePickerController : UIImagePickerController
    //var picker:UIImagePickerController?=UIImagePickerController() - See more at: http://www.theappguruz.com/blog/user-interaction-camera-using-uiimagepickercontroller-swift#sthash.mekLbXQD.dpuf
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        view.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
        self.playerView.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
        
        self.playButton.enabled = false
        self.pauseButton.enabled = false
        
        self.playerView.backgroundColor = UIColor.darkGrayColor()
        let metadataQueue: dispatch_queue_t = dispatch_queue_create("com.apple.metadataqueue", DISPATCH_QUEUE_SERIAL)
        
        
        self.itemMetadataOutput = AVPlayerItemMetadataOutput(identifiers: nil)
        self.itemMetadataOutput?.setDelegate(self, queue: metadataQueue)
        
    }
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(true)
        self.seekToZeroBeforePlay = true
    }
    @IBAction func toggleTMDSwitch(sender: AnyObject) {
        if self.honorTimedMetadataTracksDuringPlayback.on {
            self.honorTimedMetadataTracksDuringPlayback.setOn(true, animated: true)
        }
        else {
            self.honorTimedMetadataTracksDuringPlayback.setOn(false, animated: true)
            self.removeAllSublayersFromLayer(self.facesLayer!)
        }
    }
    func removeAllSublayersFromLayer(layer: CALayer) {
        CATransaction.begin()
        CATransaction.disableActions()
        let sublayers: [CALayer] = layer.sublayers!
        for layer: CALayer in sublayers {
            layer.removeFromSuperlayer()
        }
        CATransaction.commit()
    }
    @IBAction func playButtonTapped(sender: AnyObject) {
        if (self.seekToZeroBeforePlay != nil) {
            self.seekToZeroBeforePlay = false
            self.player?.seekToTime(kCMTimeZero)
        }
        self.player?.play()
        self.playButton.enabled = false
        self.pauseButton.enabled = true
    }
    
    @IBAction func loadMoviesFromCameraRoll(sender: AnyObject) {
        self.player?.pause()
        let videoPicker:  UIImagePickerController = UIImagePickerController()
        videoPicker.delegate = self
        videoPicker.modalPresentationStyle = UIModalPresentationStyle.Popover
        videoPicker.sourceType = .SavedPhotosAlbum
        videoPicker.mediaTypes = [kUTTypeMovie as String]
        videoPicker.allowsEditing = NO;
        if(UIDevice.currentDevice().userInterfaceIdiom == UIUserInterfaceIdiom.Pad)
        {
            videoPicker.popoverPresentationController?.barButtonItem = self.libraryButton;
        }
        self.presentViewController(videoPicker, animated: true, completion: nil)
    }
    

    
    @IBAction func loadMoviesFromCameraRoll(sender: AnyObject) {
        self.player.pause()
        // Initialize UIImagePickerController to select a movie from the camera roll
        var videoPicker: AAPLImagePickerController = AAPLImagePickerController()
        videoPicker.delegate = self
        videoPicker.modalPresentationStyle = UIModalPresentationPopover
        videoPicker.sourceType = .SavedPhotosAlbum
        videoPicker.mediaTypes = [kUTTypeMovie]
    }
    
    - (IBAction)loadMoviesFromCameraRoll:(id)sender
    {
    [self.player pause];
    
    // Initialize UIImagePickerController to select a movie from the camera roll
    AAPLImagePickerController *videoPicker = [[AAPLImagePickerController alloc] init];
    videoPicker.delegate = self;
    videoPicker.modalPresentationStyle = UIModalPresentationPopover;
    videoPicker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    videoPicker.mediaTypes = @[(NSString*)kUTTypeMovie];
    videoPicker.allowsEditing = NO;
    if ( UIDevice.currentDevice.userInterfaceIdiom == UIUserInterfaceIdiomPad )	{
    videoPicker.popoverPresentationController.barButtonItem = self.libraryButton;
    }
    [self presentViewController:videoPicker animated:YES completion:nil];
    }
}


