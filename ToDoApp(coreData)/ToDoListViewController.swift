//
//  ViewController.swift
//  ToDoApp(coreData)
//
//  Created by Dmitry Logachev on 04.04.2022.
//

import UIKit
import CoreData

protocol ToDoViewControllerDelegate {
    func reloadData()
}

class ToDoListViewController: UITableViewController {
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    private let cellID = "task"
    private var todoList: [Task] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellID)
        setupNavigationBar()
        fetchData()
    }
    
    private func setupNavigationBar() {
        title = "ToDo List"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.backgroundColor = UIColor(
            red: 21/255,
            green: 101/255,
            blue: 192/255,
            alpha: 194/255
        )
        
        navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        navBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .add,
            target: self,
            action: #selector(addNewTask)
        )
        
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.standardAppearance = navBarAppearance
        navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
    }
    
    @objc private func addNewTask() {
        let todoVC = ToDoViewController()
        todoVC.delegate = self
        present(todoVC, animated: true)
    }
    
    private func fetchData() {
        let fetchRequest = Task.fetchRequest()
        
        do {
            todoList = try context.fetch(fetchRequest)
        } catch let error {
            print("Failed to fetch data", error)
        }
    }
}

//MARK: - UITableViewDataSource
extension ToDoListViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        todoList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath)
        let task = todoList[indexPath.row]
        var content = cell.defaultContentConfiguration()
        content.text = task.taskTitle
        cell.contentConfiguration = content
        return cell
    }
}

//MARK: - ToDoViewControllerDelegate
extension ToDoListViewController: ToDoViewControllerDelegate {
    func reloadData() {
        fetchData()
        tableView.reloadData()
    }
}
