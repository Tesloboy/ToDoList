//
//  AppDelegate.swift
//  CoreDataDemo
//
//  Created by Viktor Teslenko on 02.06.2023.
//

import UIKit
import CoreData

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    //создадим окно
var window: UIWindow?

    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        
        //передаем во frame границы нашего экрана(т.е создали окно и растянули в весь экран)
        window = UIWindow(frame: UIScreen.main.bounds)
        //Зададим параметр для видимости взаимодействия
        window?.makeKeyAndVisible()
        //подсовываем нашему окну корневой ViewController через navigation т.к делаем To Do list
       window?.rootViewController = UINavigationController(rootViewController: TaskListViewController())

        return true
    }
    
    //сделаем небольшую обертку, для сохранения контекста независимо от происходящих событий/ошибок с приложением
    func applicationWillTerminate(_ application: UIApplication) {
    }

}


