//
//  AppDelegate.swift
//  MoviesStoreApp
//
//  Created by Александр Андреевич Щепелин on 24.10.2022.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    func application(
        _: UIApplication,
        didFinishLaunchingWithOptions _: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)

        let viewController = MoviesListViewController()
        window?.rootViewController = viewController
        window?.makeKeyAndVisible()
        return true
    }
}
