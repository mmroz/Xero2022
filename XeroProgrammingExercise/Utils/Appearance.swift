//
//  Appearance.swift
//  XeroProgrammingExercise
//
//  Created by Mark Mroz on 2022-09-14.
//

import UIKit

enum Appearance {
    /// Configure the UIAppearance of the App
    static func configure() {
        navbar()
        tableView()
        tableViewCell()
    }
    
    private static func navbar() {
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = .lightGray
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
    }
    
    private static func tableView() {
        UITableView.appearance().backgroundColor = .gray
        UITableView.appearance().separatorColor = .lightGray
    }
    
    private static func tableViewCell() {
        UITableView.appearance().separatorInset = .zero
        UITableViewCell.appearance().backgroundColor = .darkGray
    }
}
