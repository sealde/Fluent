//
// Created by scalxrd on 11/06/2020.
// Copyright (c) 2020 scalxrd. All rights reserved.
//

import UIKit
import CoreData

class RootTableViewController: FetchedResultsTableViewController
{
    var fetchedResultsController: NSFetchedResultsController<WordList>?

    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        updateUI()
    }

    // MARK: - Private Implementation

    private func updateUI() {
        let context: NSManagedObjectContext   = PersistenceManager.shared.viewContext
        let request: NSFetchRequest<WordList> = WordList.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key: "typeId", ascending: true),
                                   NSSortDescriptor(key: "create", ascending: true)]
        request.predicate = NSPredicate(value: true)
        fetchedResultsController = NSFetchedResultsController<WordList>(
                fetchRequest: request,
                managedObjectContext: context,
                sectionNameKeyPath: "typeId",
                cacheName: nil)
        fetchedResultsController?.delegate = self
        try? fetchedResultsController?.performFetch()
        tableView.reloadData()
    }

    private func configureTableView() {
        configureNavigationBar()
        tableView.separatorColor = .rgb(red: 238, green: 239, blue: 239)
//        tableView.backgroundColor = .rgb(red: 246, green: 247, blue: 248)
        tableView.tableFooterView = UIView()
        tableView.register(RootControllerHeaderCell.self,
                           forHeaderFooterViewReuseIdentifier: RootControllerHeaderCell.identifier)

        tableView.register(WordListCell.self,
                           forCellReuseIdentifier: WordListCell.identifier)
    }
}


