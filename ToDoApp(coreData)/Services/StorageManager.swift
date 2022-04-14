//
//  StorageManager.swift
//  ToDoApp(coreData)
//
//  Created by Dmitry Logachev on 10.04.2022.
//

import CoreData

class StorageManager {
    static let shared = StorageManager()
    
    // MARK: - Core Data stack
    private let persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "ToDoApp_coreData_")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    private let viewContext: NSManagedObjectContext
    private init() {
        viewContext = persistentContainer.viewContext
    }
    
    //MARK: - Public Methods
    func fetchData(completion: (Result<[Task], Error>) -> Void) {
        let fetchRequest = Task.fetchRequest()
        
        do {
            let tasks = try viewContext.fetch(fetchRequest)
            completion(.success(tasks))
        } catch let error {
            completion(.failure(error))
        }
    }
    
    //MARK: - Save/edit/delete data methods
    func save(_ taskName: String, completion: (Task) -> Void) {
        let task = Task(context: viewContext)
        task.taskTitle = taskName
        completion(task)
        saveContext()
    }
    
    func edit(_ task: Task, newName: String) {
        task.taskTitle = newName
        saveContext()
    }
    
    func delete(_ task: Task) {
        viewContext.delete(task)
        saveContext()
    }
    
    //MARK: - CoreData saving Support
    func saveContext() {
        if viewContext.hasChanges {
            do {
                try viewContext.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}
