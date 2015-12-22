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
    @IBOutlet var puaseButton: UIButton!
    @IBOutlet var playerView: UIView!
    @IBOutlet var playButton: UIButton!
    @IBOutlet var honorTimedMetadataTracksDuringPlayback: UISwitch!
    //var facesLayer: [CALayer]?
    var facesLayer: CALayer?
    var itemMetadataOutput: AVPlayerItemMetadataOutput?
    var seekToZeroBeforePlay: Bool?
    //AVPlayerItemMetadataOutput *itemMetadataOutput;
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        view.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
        self.playerView.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
        
        self.playButton.enabled = false
        self.puaseButton.enabled = false
        
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
            //[self removeAllSublayersFromLayer:self.facesLayer]
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
}


