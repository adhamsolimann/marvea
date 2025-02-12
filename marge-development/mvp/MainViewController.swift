//  MainViewController.swift
//  mvp
//
//  Created by adham soliman on 13.01.23.
//

import ARCL
import UIKit
import CoreLocation
import SceneKit

class MainViewController: UIViewController {
    
    @IBOutlet weak var menuButton: UIButton!
    
    var sceneLocationView = SceneLocationView()
    
    private var currentLocation: CLLocation? {
          return sceneLocationView.sceneLocationManager.currentLocation
      }
       
    let locationManager = CLLocationManager()
       

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Register to receive notification
        NotificationCenter.default.addObserver(self, selector: #selector(filtersApplied), name: NSNotification.Name(rawValue: "FilterApplied"), object: nil)

        
        NotificationCenter.default.addObserver(self, selector: #selector(aggregationApplied), name: Notification.Name("AggregationApplied"), object: nil)


        // Do any additional setup after loading the view.
        
        menuButton.layer.cornerRadius = 10
        menuButton.translatesAutoresizingMaskIntoConstraints = true
        sceneLocationView.addSubview(menuButton)

        sceneLocationView.run()
        sceneLocationView.showsStatistics = true
        view.addSubview(sceneLocationView)
    }
    
     override func viewDidLayoutSubviews() {
     super.viewDidLayoutSubviews()
     sceneLocationView.frame = view.bounds
   }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
       
        // Register observers for FiltersAppliedNotification & AggregationAppliedNotification
        NotificationCenter.default.addObserver(self, selector: #selector(filtersAppliedNotification(_:)), name: Notification.Name("FiltersAppliedNotification"), object: nil)

        NotificationCenter.default.addObserver(self, selector: #selector(aggregationAppliedNotification(_:)), name: Notification.Name("AggregationAppliedNotification"), object: nil)

        addAllPoints()
        }

    // MARK: TOUCHES
    // touches are working
    // TO DO:
    // show pop with object properties when clicked.
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        
        if let touch = touches.first {
            if touch.view != nil {
                let sceneView = self.sceneLocationView
                let location = touch.location(in: sceneView)
                let hitTest = sceneView.hitTest(location)
                
                if (!hitTest.isEmpty) {
                    let results = hitTest.first!
                    let currentNode = results.node
                    if let locationNode = getLocationNode(node: currentNode) {
                        print("clicked on node \(String(describing: locationNode.tag))")
                        
                        if let currentLocation = currentLocation {
                            let distance = locationNode.location.distance(from: currentLocation)
                            print("distance: \(Float(distance)/1000) km")
                        }
                        // show pop up
                        if let popupVC = storyboard?.instantiateViewController(withIdentifier: "PopupViewController") as? PopupViewController {
                            let facilityNode = locationNode as! FacilityNode
                                                popupVC.titleText = facilityNode.title
                                                popupVC.addressText = facilityNode.address
                                                popupVC.performanceText = facilityNode.performance
                                                popupVC.launchText = facilityNode.launch
                                                popupVC.tagText = facilityNode.tag
                                present(popupVC, animated: true, completion: nil)
                            
                          //  performSegue(withIdentifier: "showPopup", sender: self)
                        }
                    }
                }
            }
        }
    }
    
    func addAllPoints() {
        sceneLocationView.removeAllNodes()
        let objects = FaciltityFactory.build()
        print(objects)

        for object in objects {
            addPoint(from: object)
            }
        }
    
    private func addPoint(from object: FacilityObject) {
        var distance_temp: Float = 0
        // add a tag to object depending on energy type to be able to filter later
        let imageNameDict: [UIImage: String] = [
            UIImage(named: "Wind")!: "Wind",
            UIImage(named: "Solar")!: "Solar",
            UIImage(named: "Biomasse")!: "Biomasse",
            UIImage(named: "Wind_agg")!: "Wind_agg",
            UIImage(named: "Solar_agg")!: "Solar_agg",
            UIImage(named: "Biomasse_agg")!: "Biomasse_agg"
        ]
        
        let coordinates = CLLocationCoordinate2D(latitude: object.latitude, longitude: object.longitude)
        let location = CLLocation(coordinate: coordinates, altitude: 250)
        
        var distanceText = ""
        if let currentLocation = currentLocation {
            let distance = location.distance(from: currentLocation)
            
            // round() to 2 decimals only
            let roundedKm = (Float(distance)/1000 * 100).rounded() / 100
            distance_temp = roundedKm
//            print(distance_temp)
            distanceText = "\(roundedKm) km"
        }
        
        // Create objects
        let facilityNode = FacilityNode(location: location, title: object.name, address: object.address, performance: object.performance, launch: object.launch, distance: distanceText, image: object.image)

        if let imageName = imageNameDict[object.image!] {
            facilityNode.tag = imageName
        }
        
        // apply the filter based on the selected buttons
        
        let isBiomasseSelected = UserDefaults.standard.bool(forKey: "isBiomasseSelected")
        let isWindSelected = UserDefaults.standard.bool(forKey: "isWindSelected")
        let isSolarSelected = UserDefaults.standard.bool(forKey: "isSolarSelected")
        
        // set the values of the radius to UserDefaults values respectively
        
        var radius: Float = 0
        
        let twoSelected = UserDefaults.standard.bool(forKey: "isTwoKmSelected")
        let fiveSelected = UserDefaults.standard.bool(forKey: "isFiveKmSelected")
        let tenSelected = UserDefaults.standard.bool(forKey: "isTenKmSelected")
        
        if twoSelected {
            radius = 2.0
        }
        if fiveSelected {
            radius = 5.0
        }
        if tenSelected {
            radius = 10.0
        }
        
        // Filteration of the objects based on selected types and radius in the FilterViewController

        if isBiomasseSelected && facilityNode.tag == "Biomasse" && distance_temp < radius {
            sceneLocationView.addLocationNodeWithConfirmedLocation(locationNode: facilityNode)
        } else if isWindSelected && facilityNode.tag == "Wind" && distance_temp < radius {
            sceneLocationView.addLocationNodeWithConfirmedLocation(locationNode: facilityNode)
        } else if isSolarSelected && facilityNode.tag == "Solar" && distance_temp < radius {
            sceneLocationView.addLocationNodeWithConfirmedLocation(locationNode: facilityNode)
        }
        
   //       sceneLocationView.addLocationNodeWithConfirmedLocation(locationNode: facilityNode)
    }
    
    func getLocationNode(node: SCNNode) -> LocationAnnotationNode? {
        if node.isKind(of: LocationNode.self) {
            return node as? LocationAnnotationNode
        } else if let parentNode = node.parent {
            return getLocationNode(node: parentNode)
        }
        return nil
    }   
    
    @objc func filtersApplied() {
        NotificationCenter.default.post(name: Notification.Name("FiltersAppliedNotification"), object: nil)

    }
    
    @objc func filtersAppliedNotification(_ notification: Notification) {
        // Call addAllPoints function here
        addAllPoints()
    }

//    Current aggregation logic:
//    In the MenuViewController will be an aggregation Checkbox.
//    When this checkbox is pressed on, it triggers a notification in the MainViewContrller.
//    When the corresponding function from the notification gets called, it first stores all
//    old FacilityNode objects in an array. Then, it checks the value of the button using the UserDefaults.
//    If the button has value 'false', it restores all the old objects from last filter.
//    Otherwise if 'true', it calls a function to aggregate objects from the sceneLocationView
//    based on the tags of the objects.
    
    @objc func aggregationApplied() {
        NotificationCenter.default.post(name: Notification.Name("AggregationAppliedNotification"), object: nil)
    }
    
    func collectOldNodes(sceneLocationView: SceneLocationView) -> [FacilityNode] {
        let slv = self.sceneLocationView
        var oldNodes = [FacilityNode]()
        for node in slv.sceneNode!.childNodes {
            if let facilityNode = node as? FacilityNode {
                oldNodes.append(facilityNode)
            }
        print("Collected nodes: \(oldNodes)")
        print("aggregationAppliedNotification() called!")
        }
        return oldNodes
    }
    
    // Delete aggregated Nodes from SceneLocationview (for when the checkbox is unselected)
    func deleteAggregatedNodes(sceneLocationView: SceneLocationView) {
        let slv = self.sceneLocationView
        for node in slv.sceneNode!.childNodes {
            if let facilityNode = node as? FacilityNode {
                if facilityNode.tag?.suffix(4) == "_agg" {
                    print("Hide function called: \(String(describing: facilityNode.title))")
                //node.isHidden = true
                slv.removeLocationNode(locationNode: facilityNode)
                }
            }
        }
    }

    // If aggregate is selected, sum all objects in sceneLocationView and hides the separate ones
    @objc func aggregationAppliedNotification(_ notification: Notification) {
        // Call addAllPoints function here
        let aggSelected = UserDefaults.standard.bool(forKey: "isAggregationSelected")
        let sceneView = self.sceneLocationView
        let separateNodes = collectOldNodes(sceneLocationView: sceneView)
        var aggNodes = [FacilityNode]()
        aggNodes = aggregateFacilities(sceneLocationView: sceneView)
        print(aggNodes)
        if aggSelected {
            for facility in separateNodes {
                facility.isHidden = true
            }
           
            for f in aggNodes {
                f.isHidden = false
                // sceneView.addLocationNodeWithConfirmedLocation(locationNode: f)
            }
        }
        else {
             deleteAggregatedNodes(sceneLocationView: sceneView)
            
            for i in separateNodes {
                i.isHidden = false
            }
            //            sceneView.addLocationNodesWithConfirmedLocation(locationNodes: oldNodes)
        }
    }
        
            // Sum all objects in sceneLocationView and hide the separate ones
        func aggregateFacilities(sceneLocationView: SceneLocationView) -> [FacilityNode] {
            
            // Create dictionaries to store facility nodes by tag and aggregated facilities by tag
            
            var facilityNodesByTag = [String: [FacilityNode]]()
            var aggregatedFacilityNodes = [FacilityNode]()
            
            // Loop through all nodes in the scene, group facility nodes by tag, and aggregate facilities by tag
            
            self.sceneLocationView.sceneNode!.childNodes.compactMap { $0 as? FacilityNode }.forEach { facilityNode in
                guard let tag = facilityNode.tag else { return }
                
                // If it is an aggregated object, skip aggregation to avoid double aggregation
                
                if tag.hasSuffix("_agg") { return }
                facilityNodesByTag[tag, default: []].append(facilityNode)
            }
            
            for (tag, facilityNodes) in facilityNodesByTag {
                let totalFacilities = facilityNodes.count
                let totalEnergyProduced = facilityNodes.compactMap { Double($0.performance ?? "") ?? 0.0 }.reduce(0, +)
                let coordinates = facilityNodes.first?.location.coordinate
                let image = UIImage(named: "\(tag)_agg")
                let facility = FacilityNode(location: CLLocation(latitude: coordinates?.latitude ?? 0.0, longitude: coordinates?.longitude ?? 0.0), title: "\(totalFacilities) \(tag)-Anlagen", address: "ungenau", performance: String(totalEnergyProduced), launch: "ungenau", distance: "ungenau", image: image)
                facility.tag = "\(tag)_agg"
                aggregatedFacilityNodes.append(facility)
            }
              sceneLocationView.addLocationNodesWithConfirmedLocation(locationNodes: aggregatedFacilityNodes)
            return aggregatedFacilityNodes
        }
    
    @IBAction func menuButtonPressed(_ sender: Any) {
        
        // Show Menu page
        let menuVC = storyboard?.instantiateViewController(withIdentifier: "MenuViewController")
        present(menuVC!, animated: true, completion: nil)
    }
}
