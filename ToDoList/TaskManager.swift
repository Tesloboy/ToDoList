import Foundation
import UIKit
import CoreData

class TaskManager {

    static let shared = TaskManager()
    
    weak var tableView: UITableView? 
    weak var taskListViewController: TaskListViewController?
    private var tasks: [Task] = []
    // MARK: - Core Data stack
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "ToDoList")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    
    // MARK: - Core Data Saving support
    
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
        // MARK: - save
    
    //Cоздадим метод save(передавая в него имя task(задачи) каоторую будем сохранять)
    //по сути мы перенесли его из NewTaskViewController
    func save(_ taskName: String, completion: ((_ cellIndex: IndexPath?) -> Void)?) {
        var tasks: [Task] = []
        let context = persistentContainer.viewContext
        //Получим некий объект для сущности в CoreData позволяющий её использовать для записи в контекст
        
        // Создаем новый экземпляр Task и устанавливаем его свойство name
        let task = Task(context: context)
        task.name = taskName
        tasks.append(task)
        
        //получим индекс ячейки которую мы собираемся вставить
        let cellIndex = IndexPath(row: tasks.count - 1, section: 0)
        tableView?.insertRows(at: [cellIndex], with: .automatic)
        
        //сохраняем контекст, проверив в начале на наличие изменений
        if context.hasChanges {
            do {
                try context.save()
                completion?(cellIndex)
                taskListViewController?.fetchData() // Обновляем данные в TaskListViewController
                        taskListViewController?.tableView.reloadData() // Обновляем таблицу
            } catch let error {
                print(error)
            }
            
//            dismiss(animated: true)
        }
    }
        
    //удаление от ГПТ
    // MARK: - delete
    
    func delete(_ task: Task) {
        let context = persistentContainer.viewContext
        context.delete(task)
        saveContext()
    }
    
}
