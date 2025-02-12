//
//  StartingVisualisationViewController.swift
//  mvp
//
//  Created by adham soliman on 05.01.23.
//

import UIKit
import AVFoundation
import CoreLocation

class StartingVisualisationViewController: UIViewController {
    
    @IBOutlet weak var startingVisualisationLabel: UILabel!
    @IBOutlet weak var loadingImage: UIImageView!
    
    func requestLocationServicesAuthorization() {
        let locationManager = CLLocationManager()
        locationManager.requestWhenInUseAuthorization()
        print("Location access granted.")
    }
    
    func requestCameraAccess() {
        switch AVCaptureDevice.authorizationStatus(for: .video) {
        case .authorized:
            print("Camera access granted.")
        case .denied, .restricted:
            print("Camera access denied.")
        case .notDetermined:
            AVCaptureDevice.requestAccess(for: .video) { granted in
                if granted {
                    print("Camera access granted.")
                } else {
                    print("Camera access denied.")
                }
            }
        @unknown default:
            fatalError()
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        requestCameraAccess()
        requestLocationServicesAuthorization()
        makeServerRequest()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        UIView.animate(withDuration: 1.5, delay: 0, options: .repeat, animations: {
            self.loadingImage.transform = CGAffineTransform(rotationAngle: .pi)}, completion: nil)
        
        let mainVC = storyboard?.instantiateViewController(withIdentifier: "MainViewController")
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.present(mainVC!, animated: true, completion: nil)
        }
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
}

