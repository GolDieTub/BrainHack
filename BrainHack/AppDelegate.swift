//
//  AppDelegate.swift
//  BrainHack
//
//  Created by Uladzimir on 04.04.2022.
//

import UIKit
import UserNotifications
import FirebaseCore
import Firebase

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    let notificationCenter = UNUserNotificationCenter.current()
    var window: UIWindow?
    var sudoku: sudokuClass = sudokuClass()
    var load: sudokuData?
    private var splashPresenter: SplashPresenterDescription? = SplashPresenter()
    
    // ---------[ getPuzzles ]---------------------
    func getPuzzles(_ name : String) -> [String] {
        guard let url = Bundle.main.url(forResource: "simple", withExtension: "plist") else { return [] }
        guard let data = try? Data(contentsOf: url) else { return [] }
        guard let array = try? PropertyListDecoder().decode([String].self, from: data) else { return [] }
        return array
    }


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        splashPresenter?.present()
        FirebaseApp.configure()
        
        let delay: TimeInterval = 0.5
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
            self.splashPresenter?.dismiss { [weak self] in
                self?.splashPresenter = nil
            }
        }
        
        Auth.auth().addStateDidChangeListener {(auth, user) in
            if user == nil{
                self.showModalAuth()
            }
        }
        notificationCenter.requestAuthorization(options:[.alert, .sound, .badge]) { (granted, error) in
            guard granted else {return}
            self.notificationCenter.getNotificationSettings { (settings) in
                guard settings.authorizationStatus == .authorized else {return}
            }
        }
        notificationCenter.delegate = self
        sendNotifications()
        return true
    }
    
    func sendNotifications(){
        let content = UNMutableNotificationContent()
        content.title = "BrainHack"
        content.body = "Настало время для тренировки"
        content.sound = UNNotificationSound.default
        
        let calendar = Calendar.current
        let components = DateComponents(hour: 8, minute: 30)
        let date = calendar.date(from: components)
        let comp2 = calendar.dateComponents([.hour,.minute], from: date!)
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: comp2, repeats: true)
        
        let request = UNNotificationRequest(identifier: "Notification", content: content, trigger: trigger)
        notificationCenter.add(request) { (error) in
            print(error?.localizedDescription)
        }
    }

    func showModalAuth(){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let authVC = storyboard.instantiateViewController(withIdentifier: "AuthViewController") as! AuthViewController
        //self.window?.rootViewController?.present(newvc, animated: true, completion: nil)
        //navigationController?.pushViewController(newvc, animated: true)
        self.window?.rootViewController?.show(authVC, sender: self)
    }
    // MARK: UISceneSession Lifecycle

//    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
//        // Called when a new scene session is being created.
//        // Use this method to select a configuration to create the new scene with.
//        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
//    }
//
//    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
//        // Called when the user discards a scene session.
//        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
//        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
//    }

    func saveLocalStorage(save: sudokuData) {
        // Use Filemanager to store Local files
        let documentsDirectory =
            FileManager.default.urls(for: .documentDirectory,
                                     in: .userDomainMask).first!
        let saveURL = documentsDirectory.appendingPathComponent("sudoku_save")
                                        .appendingPathExtension("plist")
        // Encode and save to Local Storage
        //let propertyListEncoder = PropertyListEncoder()
        let saveGame = try? PropertyListEncoder().encode(save) // TODO: error here -- notes
        try? saveGame?.write(to: saveURL)
    } // end saveLocalStorage()
    
    // ---------------------[ Load Files ]-----------------------------
    func loadLocalStorage() -> sudokuData {
        let documentsDirectory =
            FileManager.default.urls(for: .documentDirectory,
                                     in: .userDomainMask).first!
        let loadURL = documentsDirectory.appendingPathComponent("sudoku_save").appendingPathExtension("plist")
        // Decode and Load from Local Storage
        if let data = try? Data(contentsOf: loadURL) {
            let decoder = PropertyListDecoder()
            load = try? decoder.decode(sudokuData.self, from: data)
            // once loaded, delete save
            try? FileManager.default.removeItem(at: loadURL)
        }
        
        return load!
    }
}
extension AppDelegate: UNUserNotificationCenterDelegate{
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.alert, .sound])
    }
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        print(#function)
    }
}

