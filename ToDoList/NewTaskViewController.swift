import UIKit
import CoreData

class NewTaskViewController: UIViewController {
//
//    //Получим наш Context
////    private let context = (UIApplication.shared.delegate as! TaskManager).persistentContainer.viewContext
//    private let context = TaskManager.shared.persistentContainer.viewContext
//
//    //добавим объекты с помощью кода
//    //мы не должны иметь к элементам внешнего управления => private
//    //инициализация должна происходить лишь тогда когда мы его показываем => lazy var
//    private lazy var taskTextField: UITextField = {
//        let textField = UITextField()
//        //добавим плейсхолдер
//        textField.placeholder = "New Task"
//        //Закруглим углы
//        textField.layer.cornerRadius = 10
//        //после инициализации можем вернуть textField
//        return textField
//    }()
//
//    private lazy var saveButton: UIButton = {
//        let button = UIButton()
//        //цвет кнопки
//        button.backgroundColor = .blue
//        //название кнопки
//        button.setTitle("Save Task", for: .normal)
//        //Закруглим углы
//        button.layer.cornerRadius = 10
//        //Добавим таргеты т.к мы будем нажимать на кнопки
//        button.addTarget(self, action: #selector(save), for: .touchUpInside)
//        return button
//    }()
//
//    private lazy var cancelButton: UIButton = {
//       let button = UIButton()
//        //цвет кнопки
//        button.backgroundColor = .red
//        //название кнопки
//        button.setTitle("Cancel Task", for: .normal)
//        //Закруглим углы
//        button.layer.cornerRadius = 10
//        //Добавим таргеты т.к мы будем нажимать на кнопки
//        button.addTarget(self, action: #selector(cancel), for: .touchUpInside)
//        return button
//    }()
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        //с помощью кода заверстаем дизайн:
//        view.backgroundColor = .white
//        setupSubViews()
//        setupConstraints()
//    }
//
//    //методы которым будем устанавливать наши view:
//    private func setupSubViews() {
//        view.addSubview(taskTextField)
//        view.addSubview(saveButton)
//        view.addSubview(cancelButton)
//    }
//
//    //метод чтобы сетапить констреинты:
//    private func setupConstraints() {
//        //для начала отключим параметр отвечающий за ранний способ верстки у нашего текст филда, чтобы можно было заверстать с помощью автолейаута
//        taskTextField.translatesAutoresizingMaskIntoConstraints = false
//        //Расставим анкера констреинтов
//        NSLayoutConstraint.activate([
//            //верхняя точка taskTextField относительно верхней части экрана отстает на 80
//            taskTextField.topAnchor.constraint(equalTo: view.topAnchor, constant: 80),
//            //левая относительно родительской view отстает на 40
//            taskTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
//            //правая относительно родительской view отстает на -40(чтобы уйти влев а не в право т.к мы двигаемся по оси x)
//            taskTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40)
//        ])
//
//        //по аналогии добавим констреинты для saveButton и cancelButton
//
//        saveButton.translatesAutoresizingMaskIntoConstraints = false
//        NSLayoutConstraint.activate([
//            //в этот раз отступим от taskTextField
//            saveButton.topAnchor.constraint(equalTo: taskTextField.bottomAnchor, constant: 20),
//            saveButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
//            saveButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40)
//        ])
//
//        cancelButton.translatesAutoresizingMaskIntoConstraints = false
//        NSLayoutConstraint.activate([
//            //в этот раз отступим от saveButton
//            cancelButton.topAnchor.constraint(equalTo: saveButton.bottomAnchor, constant: 20),
//            cancelButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
//            cancelButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40)
//        ])
//    }
//
//    @objc private func save() {
//        //Получим некий объект для сущности в CoreData позволяющий её использовать для записи в контекст
//        guard let entityDescription = NSEntityDescription.entity(forEntityName: "Task", in: context) else { return }
//        //Формируем объект для записи в context, скастив его в тип "Task"
//        guard let task = NSManagedObject(entity: entityDescription, insertInto: context) as? Task else { return }
//        //Присваиваем имени текст который находится в textField
//        task.name = taskTextField.text
//        //сохраняем контекст, проверив в начале на наличие изменений
//        if context.hasChanges {
//            do {
//                try context.save()
//            } catch let error {
//                print(error)
//            }
//
//            dismiss(animated: true)
//        }
//    }
//
//    @objc private func cancel() {
//        dismiss(animated: true)
//    }
}
