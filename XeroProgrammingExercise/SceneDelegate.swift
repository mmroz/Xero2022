//
//  SceneDelegate.swift
//  XeroProgrammingExercise
//
//  Created by Francesco P on 5/05/20.
//  Copyright © 2020 Xero Ltd. All rights reserved.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        self.window = (scene as? UIWindowScene).map { UIWindow(windowScene: $0) }
        let viewModel = InvoicesListViewModel(dataSource: [])
        let controller = InvoicesListViewController(viewModel: viewModel, dateFormatter: Formatters.dateFormatter(), currencyFormatter: Formatters.currencyFormatter())
        let navigationController = UINavigationController(rootViewController: controller)
        controller.title = "Invoices"
        self.window?.rootViewController = navigationController
        self.window?.makeKeyAndVisible()
    }
}

