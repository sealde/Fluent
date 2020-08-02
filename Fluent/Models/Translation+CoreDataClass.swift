//  Translation+CoreDataClass.swift
//  Fluent
//
//  Created by scalxrd on 13/06/2020.
//  Copyright © 2020 scalxrd. All rights reserved.
//
//

import Foundation
import CoreData

@objc(Translation)
public class Translation: NSManagedObject, Decodable
{
    public override var description: String {
        return "text: \(text)"
    }

    required convenience public init(from decoder: Decoder) throws {
        guard let context = decoder.userInfo[.context] as? NSManagedObjectContext else {
            throw EntityDecodeError.contextNotFound
        }

        // Initialize but don't insert into the context yet.
        // Leave inserting until after decoding keys, in case we throw.
        guard let entity = NSEntityDescription.entity(forEntityName: "Translation",
                                                      in: context) else {
            throw EntityDecodeError.entityNotFound
        }

        self.init(entity: entity, insertInto: context)

        do {
            let values = try decoder.container(keyedBy: CodingKeys.self)
            text = try? values.decode(String.self, forKey: .text)
            note = try? values.decode(String.self, forKey: .note)

        } catch let error {
            throw error
        }

        // If we made it this far without throwing, insert self into the context.
        // Default is to insert. If deferInsertion is present and `true`, do not insert.
        guard let deferInsertion = decoder.userInfo[CodingUserInfoKey.deferInsertion] as? Bool,
              deferInsertion == false else { return }

        context.insert(self)

    }

    enum CodingKeys: String, CodingKey
    {
        case text, note, meaning
    }
}
