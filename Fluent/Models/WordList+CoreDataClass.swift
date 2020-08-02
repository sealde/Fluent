//  WordList+CoreDataClass.swift
//  Fluent
//
//  Created by scalxrd on 13/06/2020.
//  Copyright © 2020 scalxrd. All rights reserved.
//
//

import Foundation
import CoreData


public class WordList: NSManagedObject {
    var type: WordListType {
        get {
            let type = WordListType(rawValue: typeId)
            assert(type != nil, "Got unexpect typeId: \(typeId)")
            return type ?? WordListType.Custom
        }
        set {
            typeId = newValue.rawValue
        }
    }
}

enum WordListType: Int16 {
    case Base
    case Custom
}
