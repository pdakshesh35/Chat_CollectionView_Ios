//
//  chatModel.swift
//  tableView
//
//  Created by Dakshesh patel on 6/2/17.
//  Copyright © 2017 Dakshesh patel. All rights reserved.
//

import Foundation
import UIKit

enum BubbleDataType: Int{
    case Mine = 0
    case Opponent
}

class chatModel {
    
    var message : String;
    var image : UIImage;
    var time : NSDate
    
    var type:BubbleDataType
    
    func getMessage() -> String {
        return self.message
    }
    func getImage() -> UIImage {
        return self.image
    }
    func getTime() -> NSDate {
        return self.time
    }
    
    
    init(message : String, image : UIImage, time : NSDate, type : BubbleDataType = .Mine) {
        self.message = message;
        self.image = image;
        self.time = time;
        self.type = type;
        
    }
    
    
}
