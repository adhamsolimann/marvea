//
//  FacilityNode.swift
//  mvp
//
//  Created by adham soliman on 03.02.23.
//

import Foundation
import UIKit
import CoreLocation

class FacilityNode: LocationLayerNode {
    
    let title: String?
    let address: String
    let performance: String?
    let launch: String?
    
    public init(location: CLLocation, title: String, address: String, performance: String, launch: String?, distance: String, image: UIImage?) {
        
        self.title = title
        self.address = address
        self.performance = performance
        self.launch = launch

            
        // Background
        let bgrLayer = CAShapeLayer()
        
        bgrLayer.frame = CGRect(x: 0, y: 0, width: 270, height: 80)
        
        let cornerRadius = 35
        let bgrPath = CGPath(roundedRect: bgrLayer.frame, cornerWidth: CGFloat(cornerRadius), cornerHeight: CGFloat(cornerRadius), transform: nil)
        bgrLayer.path = bgrPath
        bgrLayer.fillColor = UIColor.white.cgColor
        
        bgrLayer.shadowColor = UIColor.darkGray.cgColor
        bgrLayer.shadowOffset = CGSize(width: 0, height: 0)
        bgrLayer.shadowRadius = 3
        bgrLayer.shadowOpacity = 0.5
        
        // Title text
        let titleLayer = CATextLayer()
        titleLayer.frame = CGRect(x: 86, y: 10, width: 160, height: 40)
        titleLayer.string = title
        titleLayer.fontSize = 16
        titleLayer.foregroundColor = UIColor.black.cgColor
        titleLayer.isWrapped = true
        titleLayer.alignmentMode = CATextLayerAlignmentMode.left
        titleLayer.contentsScale = UIScreen.main.scale
        
        bgrLayer.addSublayer(titleLayer)
        
        // Distance text
        let distanceText = CATextLayer()
        distanceText.frame = CGRect(x: 86, y: 40, width: 160, height: 20)
        distanceText.string = distance
        distanceText.fontSize = 15
        distanceText.foregroundColor = UIColor.darkGray.cgColor
        distanceText.isWrapped = true
        distanceText.alignmentMode = CATextLayerAlignmentMode.left
        distanceText.contentsScale = UIScreen.main.scale
        
        bgrLayer.addSublayer(distanceText)
        
        // Image
        if let image = image {
            let imageLayer = CALayer()
            imageLayer.contents = image.cgImage
            imageLayer.frame = CGRect(x: 12, y: 12, width: 60, height: 60)
        
            let imageMask = CAShapeLayer()
            let imageMaskPath = CGPath(ellipseIn: imageLayer.bounds, transform: nil)
            imageMask.path = imageMaskPath
            imageLayer.mask = imageMask
        
            bgrLayer.addSublayer(imageLayer)
        }
        
        // Line
        let lineLayer = CAShapeLayer()
        lineLayer.frame = CGRect.init(x: 0, y: 80, width: 270, height: 80)
        let linePath = UIBezierPath()
        linePath.move(to: CGPoint(x: lineLayer.bounds.midX, y: lineLayer.bounds.minY))
        linePath.addLine(to: CGPoint(x: lineLayer.bounds.midX, y: lineLayer.bounds.maxY))
        lineLayer.path = linePath.cgPath
        lineLayer.lineWidth = 1
        lineLayer.strokeColor = UIColor.white.cgColor
        
        // Dot
        let dotLayer = CAShapeLayer()
        dotLayer.frame = CGRect.init(x: 0, y: 0, width: 270, height: 80)
        let radius: CGFloat = 5
        let dotPath = CGPath.init(ellipseIn: CGRect(x: dotLayer.bounds.midX - radius, y: dotLayer.bounds.maxY - radius*2, width: radius*2, height: radius*2), transform: nil)
        dotLayer.path = dotPath
        dotLayer.fillColor = UIColor.white.cgColor
        
        lineLayer.addSublayer(dotLayer)
        
        // Group together
        let baseLayer = CALayer()
        baseLayer.frame = CGRect(x: 0, y: 0, width: 270, height: 160)
        baseLayer.addSublayer(bgrLayer)
        baseLayer.addSublayer(lineLayer)
        
        super.init(location: location, layer: baseLayer)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
