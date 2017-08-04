//
//  borderDraw.swift
//  OrionHealth
//
//  Created by Liguo Jiao on 25/07/17.
//  Copyright © 2017 Liguo Jiao. All rights reserved.
//

import Foundation
import UIKit

class BorderDraw: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.clear
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func draw(_ rect: CGRect) {
        let pathRect = self.bounds.insetBy(dx: 1, dy: 1)
        let path = UIBezierPath(roundedRect: pathRect, cornerRadius: 0)
        path.lineWidth = 3
        UIColor.clear.setFill()
        UIColor.black.setStroke()
        path.fill()
        path.stroke()
    }
}
