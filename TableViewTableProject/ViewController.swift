//
//  ViewController.swift
//  TableViewTableProject
//
//  Created by Семён Кривцов on 18.01.2022.
//

import UIKit

class ViewController: UITableViewController {

    private var data = ["🍎", "🍏", "🍑", "🍇", "🍌", "🍋"]
    override func viewDidLoad() {
        super.viewDidLoad()
        createEditingButton()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: UITableViewCell
        if let reuseCell = tableView.dequeueReusableCell(withIdentifier: "MyCell") {
            cell = reuseCell
        } else {
            cell = UITableViewCell(style: .default, reuseIdentifier: "MyCell")
        }
            configure(cell: &cell, for: indexPath)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive,
                                              title: "Delete",
                                              handler: {
                                                (_, _, _) in
                                                self.data.remove(at: indexPath.row)
                                                tableView.reloadData()
                                              }
        )
        
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
    
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .none
    }

    
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let movedObject = self.data[sourceIndexPath.row]
        data.remove(at: sourceIndexPath.row)
        data.insert(movedObject, at: destinationIndexPath.row)
    }
    
    private func configure(cell: inout UITableViewCell, for indexPath: IndexPath) {
        var configuration = cell.defaultContentConfiguration()
        configuration.text = data[indexPath.row]
        configuration.textProperties.alignment = .center
        cell.contentConfiguration = configuration
    }
    
    private func createEditingButton() {
        let edit = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(beginEditing))
        navigationItem.rightBarButtonItem = edit
    }
    
    @objc private func beginEditing() {
        tableView.isEditing = true
        let end = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(endEditing))
        navigationItem.rightBarButtonItem = end
    }
    
    @objc private func endEditing() {
        tableView.isEditing = false
        createEditingButton()
    }
}
