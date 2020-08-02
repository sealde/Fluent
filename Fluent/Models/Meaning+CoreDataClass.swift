//  Meaning+CoreDataClass.swift
//  Fluent
//
//  Created by scalxrd on 13/06/2020.
//  Copyright © 2020 scalxrd. All rights reserved.
//

import Foundation
import CoreData

public class Meaning: NSManagedObject, Decodable
{
    public override var description: String {
        return """
               id: \(id)
               partOfSpeechCode: \(partOfSpeechCode)
               translation: \(translation)
               transcription": \(translation)
               soundUrl": \(soundURL) 
               """
    }

    required convenience public init(from decoder: Decoder) throws {
        guard let context = decoder.userInfo[.context] as? NSManagedObjectContext else {
            throw EntityDecodeError.contextNotFound
        }

        // Initialize but don't insert into the context yet.
        // Leave inserting until after decoding keys, in case we throw.
        guard let entity = NSEntityDescription.entity(forEntityName: "Meaning",
                                                      in: context) else {
            throw EntityDecodeError.entityNotFound
        }

        self.init(entity: entity, insertInto: context)

        do {
            let values = try decoder.container(keyedBy: CodingKeys.self)

            if let arrayOfExamples = try? values.decode([Definition].self, forKey: .examples) {
                examples = NSSet(array: arrayOfExamples)
            }

            translation = try? values.decode(Translation.self, forKey: .translation)
            id = try? values.decode(String.self, forKey: .id)
            partOfSpeechCode = try? values.decode(String.self, forKey: .partOfSpeechCode)
            text = try? values.decode(String.self, forKey: .text)
            transcription = try? values.decode(String.self, forKey: .transcription)
            definition = try? values.decode(Definition.self, forKey: .definition)
            wordID = try? values.decode(Int.self, forKey: .wordID) as? NSNumber
            soundURL = try? values.decode(String.self, forKey: .soundURL)

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
        case id, partOfSpeechCode, text, transcription, translation, definition, examples
        case wordID   = "wordId"
        case soundURL = "soundUrl"
    }
}
