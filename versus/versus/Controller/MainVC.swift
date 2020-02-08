//
//  ViewController.swift
//  versus
//
//  Created by TAEWON KONG on 2/8/20.
//  Copyright © 2020 TAEWON KONG. All rights reserved.
//

import UIKit

class MainVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var addCategoryButton: UIBarButtonItem!
    
    var categories: [String] = ["Computer", "Phone", "Tablet"]

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "CategoryCell", bundle: nil), forCellReuseIdentifier: "productCell")
    }
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "Add categoty", message: nil, preferredStyle: .alert)
        alert.addTextField { (categoryTF) in
            categoryTF.placeholder = "Enter Category"
        }
        let action = UIAlertAction(title: "Add", style: .default) { (UIAlertAction) in
            guard let category = alert.textFields?.first?.text else { return }
            self.addFront(category)
        }
        alert.addAction(action)
        present(alert, animated: true)
    }
    
    func addFront(_ category: String) {
        categories.insert(category, at: 0)
        let indexPath = IndexPath(row: 0, section: 0)
        tableView.insertRows(at: [indexPath], with: .left)
    }
    
}

extension MainVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let categoryCell = tableView.dequeueReusableCell(withIdentifier: "productCell", for: indexPath) as! CategoryCell
        categoryCell.categoryName.text = categories[indexPath.row]
        return categoryCell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard editingStyle == .delete else { return }
        categories.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .automatic)
    }
    
}
