//
// Created by scalxrd on 12/06/2020.
// Copyright (c) 2020 scalxrd. All rights reserved.
//

import UIKit
import CoreData

extension RootTableViewController
{
    var sections: [NSFetchedResultsSectionInfo]? {
        return fetchedResultsController?.sections
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView,
                            cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: WordListCell.identifier,
                                                 for: indexPath) as? WordListCell else {
            fatalError("Unexpected indexPath = \(indexPath)")
        }

        guard let wordList = fetchedResultsController?.object(at: indexPath) else {
            fatalError("Not found object in core data by indexPath = \(indexPath)")
        }

        cell.wordList = wordList
        return cell
    }

    override func tableView(_ tableView: UITableView,
                            heightForHeaderInSection section: Int) -> CGFloat {
        return (section == 1) ? SizeRatio.cellHeight : 0
    }

    override func tableView(_ tableView: UITableView,
                            heightForRowAt indexPath: IndexPath) -> CGFloat {
        return SizeRatio.cellHeight
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return sections?.count ?? 0
    }

    override func tableView(_ tableView: UITableView,
                            titleForHeaderInSection section: Int) -> String? {
        guard let sectionName = sections?[section].name else { return nil }
        switch sectionName {
        case "0":
            // Section header is hidden by default, so that isn't matter which title is.
            return "Base Section"
        case "1":
            return "Glossaries"
        default:
            // That section doesn't exist, so if it appear in runtime it's mean something going wrong.
            return "Unrecognized section"
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections?[section].numberOfObjects ?? 0
    }

    // MARK: - Table view delegate

    override func tableView(_ tableView: UITableView,
                            viewForHeaderInSection section: Int) -> UIView? {
        let headerView = tableView.dequeueReusableHeaderFooterView(
                withIdentifier: RootControllerHeaderCell.identifier
        ) as! RootControllerHeaderCell
        headerView.delegate = self
        return headerView
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let wordList = fetchedResultsController?.object(at: indexPath) else {
            fatalError("Not found object in core data by indexPath = \(indexPath)")
        }

        if wordList.name == "Add More" {
            rootButtonPressed()
        } else {

            let controller = WordListTableViewController()
            controller.navigationItem.title = fetchedResultsController?.object(at: indexPath).name
            navigationController?.pushViewController(controller, animated: true)
        }
    }
}

extension RootTableViewController
{
    private struct SizeRatio
    {
        static let cellHeight: CGFloat = 48
    }
}

class WordListTableViewController: UITableViewController
{}




