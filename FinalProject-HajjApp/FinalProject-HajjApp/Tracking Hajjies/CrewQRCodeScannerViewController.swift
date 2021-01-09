//
//  CrewQRCodeScannerViewController.swift
//  FinalProject-HajjApp
//
//  Created by Noura Althenayan on 05/01/2021.
//

import UIKit
import AVFoundation
import AudioToolbox

protocol QRScanViewDelegate: class {
    func didScanQR(_ result: String)
}

class CrewQRCodeScannerViewController: UIViewController, AVCaptureMetadataOutputObjectsDelegate {
    
    var captureSession: AVCaptureSession!
    var previewLayer: AVCaptureVideoPreviewLayer!
    static var uidFromQRCode = ""
    
    weak var delegate: QRScanViewDelegate?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.black

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        captureQRCode()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
//        if (captureSession?.isRunning == true) {
//            captureSession.stopRunning()
//        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        if (captureSession?.isRunning == true) {
            captureSession.stopRunning()
        }
    }

func captureQRCode() {
    guard let videoCaptureDevice = AVCaptureDevice.default(for: AVMediaType.video)else{
        
        showAlert(message: NSLocalizedString("Cannot open camera", comment: "")) {
            self.dismiss(animated: true, completion: nil)
        }
        return
    }

    captureSession = AVCaptureSession()
    let videoInput: AVCaptureDeviceInput
    
    do {
        videoInput = try AVCaptureDeviceInput(device: videoCaptureDevice)
    } catch {
        return
    }
    
    if (captureSession.canAddInput(videoInput)) {
        captureSession.addInput(videoInput)
    } else {
        failed()
        return
    }
    
    let metadataOutput = AVCaptureMetadataOutput()
    
    if (captureSession.canAddOutput(metadataOutput)) {
        captureSession.addOutput(metadataOutput)
        
        metadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
        metadataOutput.metadataObjectTypes = [AVMetadataObject.ObjectType.qr]
    } else {
        failed()
        return
    }
    
    previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
    previewLayer.frame = view.layer.bounds
    previewLayer.videoGravity = AVLayerVideoGravity.resizeAspectFill
    view.layer.addSublayer(previewLayer)
    captureSession.startRunning()
        
}
    func failed() {
        showAlert(message: NSLocalizedString("Scanning QR not supported", comment: "")) {
            self.dismiss(animated: true, completion: nil)
        }
        
        captureSession = nil
    }

    
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        captureSession.stopRunning()
        
        if let metadataObject = metadataObjects.first,
            let readableObject = metadataObject as? AVMetadataMachineReadableCodeObject,
            let stringValue = readableObject.stringValue {
            
            AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))
            CrewQRCodeScannerViewController.uidFromQRCode = stringValue

            let storyboard = UIStoryboard(name: "CrewTabBar", bundle: nil)
            let controller = storyboard.instantiateViewController(identifier: "hajjDetailsVC")
            controller.modalTransitionStyle = .coverVertical
            controller.modalPresentationStyle = .overFullScreen
            self.present(controller, animated: true)
            
            return
        }
        
        if (captureSession?.isRunning == true) {
            captureSession.stopRunning()
        }
//        self.dismiss(animated: true, completion: nil)
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }

}

extension CrewQRCodeScannerViewController {
    
    func showAlert(_ title: String = NSLocalizedString("Alert", comment: ""),
                   message: String,
                   cancel: String = NSLocalizedString("OK", comment: ""),
                   handler: (() -> Void)? = nil)
    {
        //Message
        let alert = UIAlertController(title: title, message: message,
                                      preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: cancel, style: .cancel, handler: { (alert) in
            handler?()
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
}

