import UIKit
import CoreData

class TaskListViewController: UITableViewController {
    
    //добавим контекст
    //Правильнее будет вынести работу с "persistentContainer" из AppDelegate в отдельный менеджер, но сейчас мы это сократили
    private let context = TaskManager.shared.persistentContainer.viewContext
//    var taskManager: TaskManager!
    let taskManager = TaskManager.shared
    
    
    //Укажем cellID
    private let cellID = "cell"
    //Добавим список тасков
    private var tasks: [Task] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        taskManager.taskListViewController = self
        //зарегистрируем ячейку,чтобы делегат её точно обрабатывал (т.к мы делаем без сториборда этого может не произойти)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellID)
        view.backgroundColor = .white
        setupNavigationBar()
        
        taskManager.taskListViewController = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchData()
    }
    
    private func setupNavigationBar() {
        title = "Список дел"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        //Отредактируем NavigationBar
        let navBarAppearance = UINavigationBarAppearance()
        //сделаем прозрачным
        navBarAppearance.configureWithOpaqueBackground()
        //изменим вид маленького заголовка
        navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        //изменим вид большого заголовка
        navBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        //зададим  цвет бекграунда
        navBarAppearance.backgroundColor = UIColor(
            red: 205/225,
            green: 25/255,
            blue: 15/255,
            alpha: 194/255
        )
        
        //Присвоим "navBarAppearance" нашему NavigationBar'y
        navigationController?.navigationBar.standardAppearance = navBarAppearance
        navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
        
        //Добавим кнопку(справа) в Бар которая позволит добавлять задачи
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .add,
            target: self, //ставим self т.к мы будем реализовывать метод в том же VC и соответственно при отработке "Responder Chain" НЕ словим краш. Т.е в какой view метод описан ту и подставляем(в нашем случчае в самой себе = > self)
            action: #selector(addNewTask)
        )
        //и покрасим кнопку в белый
        navigationController?.navigationBar.tintColor = .white
    }
    
    @objc private func addNewTask() {
        //        let newTaskViewController = NewTaskViewController()
        //        newTaskViewController.modalPresentationStyle = .fullScreen
        //        //Воспользуемся методом "present" он позволяет открывать другие экраны (аналог segue)
        //        present(newTaskViewController, animated: true)
        shhowAlert(withTitle: "Новое напоминание", andMessage: "Добавьте напоминание")
    }
    
    //добавим "Task" через "alert" таким образом, чтобы не перезагружать всю страницу
    private func shhowAlert(withTitle title: String, andMessage message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        // создадим Алерт сонтроллер(экшн сохранения и его интерфейс)
        let saveAction = UIAlertAction(title: "Сохранить", style: .default) { _ in
            guard let task = alert.textFields?.first?.text, !task.isEmpty else { return }
//            self.taskManager.save(task, completion: nil)
            let taskManager = self.taskManager
                taskManager.save(task, completion: nil)

        }
        
        let cancelAction = UIAlertAction(title: "Отменить", style: .destructive)
        
        alert.addTextField()
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        present(alert, animated: true)
    }


        private func saveTask(_ taskName: String) {
        taskManager.save(taskName) { [weak self] cellIndex in
            self?.fetchData()
            if let cellIndex = cellIndex{
                
                self?.tableView.insertRows(at: [cellIndex], with: .automatic)
                // Закрытие модального представления
                self?.dismiss(animated: true)
            }
        }
    }
    
    //Получим данные
    internal func fetchData() {
        //создадим request(запрос)для получения данных (будто стучимся в сеть, ном ы стучимся в базу)
        let fetchRequest: NSFetchRequest<Task> = Task.fetchRequest()
        //Получим данные по нашему реквесту в контекст и сохраним в "tasks"
        do {
            tasks = try context.fetch(fetchRequest)
        } catch let error {
            print(error)
        }
    }

        // MARK: - delete metod
    //удаление
    func deleteTask(at indexPath: IndexPath) {
        let task = tasks[indexPath.row]
        taskManager.delete(task)
        fetchData()
        tableView.deleteRows(at: [indexPath], with: .automatic)
    }
    
}

extension TaskListViewController {
    //Прираняем кол-во строк количеству задач(task)
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        tasks.count
    }
    //зададим ячейки
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath)
        //достанем задачку для индекса
        let task = tasks[indexPath.row]
        //присвоим cell тейблвью 1 вариант:
        //        cell.textLabel?.text = task.name
        //2 вариант:
        var content = cell.defaultContentConfiguration()
        content.text = task.name
        cell.contentConfiguration = content
        
        return cell
    }
    
//снятие выбора с ячейки
   override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    //удаление
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            deleteTask(at: indexPath)
        }
    }
    
}

