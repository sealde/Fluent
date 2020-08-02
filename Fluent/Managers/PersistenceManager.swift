//
//  PersistenceManager.swift
//  Minne
//
//  Created by scalxrd on 07/06/2020.
//  Copyright © 2020 scalxrd. All rights reserved.
//

import CoreData
import UIKit

class PersistenceManager
{
    // MARK: - Public API

    static let shared: PersistenceManager = PersistenceManager()

    let persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Fluent")
        container.loadPersistentStores {
            (storeDescription, error) in
            if let error = error {
                fatalError("Loading of store failed: \(error)")
            }
        }
        return container
    }()

    var viewContext: NSManagedObjectContext {
        get {
            return persistentContainer.viewContext
        }
    }

    var backgroundContext: NSManagedObjectContext {
        get {
            return persistentContainer.newBackgroundContext()
        }
    }

    func createAndSaveWordList(ofType type: WordListType, withName name: String,
                               andImageData imageData: Data) throws {
        let context  = viewContext
        let wordList = WordList(context: context)

        wordList.type = type
        wordList.name = name
        wordList.create = name == "Add More" ? Date() : Date(timeIntervalSinceNow: -10000000) 
        wordList.imageData = imageData

        do {
            try context.save()
            print(wordList, "saved!")
        } catch let saveError {
            throw saveError
        }
    }

    // MARK: - Private Implementation

    private init() { configureCoreData() }

    private func configureCoreData() {
        let launchedBefore = UserDefaults.standard.bool(forKey: "launchedBefore")
        guard !launchedBefore,
              let pathToFile = Bundle.main.path(forResource: "data", ofType: "plist"),
              let data = NSArray(contentsOfFile: pathToFile) else { return }
        data.forEach {
            guard let dictItem = $0 as? [String: AnyObject],
                  let name = dictItem["name"] as? String,
                  let typeId = dictItem["typeId"] as? Int16,
                  let imageName = dictItem["image"] as? String else { return }
            let image = ImageAsset(rawValue: imageName)?.image.pngData()
            if let imageData = image, let type = WordListType(rawValue: typeId) {
                _ = try? createAndSaveWordList(ofType: type,
                                               withName: name,
                                               andImageData: imageData)


            }
        }
        UserDefaults.standard.set(true, forKey: "launchedBefore")
    }

}
