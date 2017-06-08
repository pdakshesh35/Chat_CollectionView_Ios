//
//  ChatBubbleData.swift
//  tableView
//
//  Created by Dakshesh patel on 6/7/17.
//  Copyright © 2017 Dakshesh patel. All rights reserved.
//

import Foundation
import UIKit // For using UIImage
// 1. Type Enum
/**
 Enum specifing the type
 - Mine:     Chat message is outgoing
 - Opponent: Chat message is incoming
 */
enum BubbleDataType: Int{
    case Mine = 0
    case Opponent
}

/// DataModel for maintaining the message data for a single chat bubble
class ChatBubbleData {
    // 2.Properties
    var text: String?
    var image: UIImage?
    var date: NSDate?
    var type: BubbleDataType
    
    // 3. Initialization
    init(text: String?,image: UIImage?,date: NSDate? , type:BubbleDataType = .Mine) {
        // Default type is Mine
        self.text = text
        self.image = image
        self.date = date
        self.type = type
    }
}
