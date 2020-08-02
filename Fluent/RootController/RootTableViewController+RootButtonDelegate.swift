//
// Created by scalxrd on 25/06/2020.
// Copyright (c) 2020 scalxrd. All rights reserved.
//

import UIKit

extension RootTableViewController: RootButtonDelegate
{
    func rootButtonPressed() {
        let rootController = CreateWordListTableViewController()
        rootController.isModalInPresentation = true
        let navigationController
                = UINavigationController(rootViewController: rootController)
        navigationController.navigationBar.tintColor = .rgb(red: 23, green: 24, blue: 28)
        navigationController.navigationBar.topItem?.title = "New Glossary"
        present(navigationController, animated: true)
    }
}
