//
// Created by scalxrd on 25/06/2020.
// Copyright (c) 2020 scalxrd. All rights reserved.
//

import UIKit

extension RootTableViewController
{
    func configureNavigationBar() {
        let searchBarItem = UIBarButtonItem(
                image: UIImage(named: SFSymbols.search),
                style: .plain,
                target: self,
                action: #selector(handleSearch))

        let settingsBarItem = UIBarButtonItem(
                image: UIImage(named: SFSymbols.setting),
                style: .plain,
                target: self,
                action: #selector(handleSettings))

        let notificationsBarItem = UIBarButtonItem(
                image: UIImage(named: SFSymbols.notifications),
                style: .plain,
                target: self,
                action: #selector(handleNotifications))

        let achievementsBarItem = UIBarButtonItem(
                image: UIImage(named: SFSymbols.achievements),
                style: .plain,
                target: self,
                action: #selector(handleAchievements))

        self.navigationItem.rightBarButtonItems = [
            settingsBarItem, notificationsBarItem, searchBarItem]
        self.navigationItem.leftBarButtonItems = [achievementsBarItem]
    }

    @objc func handleSearch() {
        let searchNC = UINavigationController(rootViewController: SearchItemController())
        searchNC.navigationBar.topItem?.title = "Search"
        present(searchNC, animated: true)
    }

    @objc func handleAchievements() {
        let achievementsNC
                = UINavigationController(rootViewController: AchievementsItemController())
        achievementsNC.navigationBar.topItem?.title = "Achievements"
        present(achievementsNC, animated: true)
    }

    @objc func handleNotifications() {
        let notificationsNC
                = UINavigationController(rootViewController: NotificationsItemController())
        notificationsNC.navigationBar.topItem?.title = "Notifications"
        present(notificationsNC, animated: true)
    }

    @objc func handleSettings() {
        let settingsNC = UINavigationController(rootViewController: SettingsItemController())
        settingsNC.navigationBar.topItem?.title = "Settings"
        present(settingsNC, animated: true)
    }
}