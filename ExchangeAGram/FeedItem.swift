//
//  FeedItem.swift
//  ExchangeAGram
//
//  Created by Wale Anif on 12/22/14.
//  Copyright (c) 2014 Lavvo Group. All rights reserved.
//

import Foundation
import CoreData


@objc (FeedItem)

class FeedItem: NSManagedObject {

    @NSManaged var caption: String
    @NSManaged var image: NSData

}
