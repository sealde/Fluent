//
//  SceneDelegate.swift
//  Fluent
//
//  Created by scalxrd on 11/06/2020.
//  Copyright © 2020 scalxrd. All rights reserved.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate
{

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession,
               options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }

        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene
        window?.rootViewController = createMainNC()
        window?.makeKeyAndVisible()
    }

    func createMainNC() -> UINavigationController {
        let controller = RootTableViewController()
        let MainNC = UINavigationController(
                rootViewController: controller)
        MainNC.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        MainNC.navigationBar.tintColor = .white
        MainNC.navigationBar.isTranslucent = false
        MainNC.navigationBar.barTintColor = .rgb(red: 60, green: 61, blue: 62)

        let button = FLButton()
        button.delegate = controller
        MainNC.view.addSubview(button)

        let safeArea = MainNC.view.safeAreaLayoutGuide
        button.rightAnchor.constraint(equalTo: safeArea.rightAnchor,
                                      constant: -15).isActive = true
        button.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor,
                                       constant: -20).isActive = true
        button.heightAnchor.constraint(equalToConstant: 60).isActive = true
        button.widthAnchor.constraint(equalToConstant: 60).isActive = true


        return MainNC

    }

}
