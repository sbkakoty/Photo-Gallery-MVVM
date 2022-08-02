//
//  SceneDelegate.swift
//  PhotoGalleryClean
//
//  Created by MacBook on 02/07/22.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    private var realmUserSessionViewModel : RealmUserSessionViewModel!
    var sessionCount: Int?
    var sessionDate: Date?
    var sessionExist: Bool?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        guard let _ = (scene as? UIWindowScene) else { return }
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
        
        //print("sceneDidDisconnect")
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
        //print("sceneDidBecomeActive")
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
        //print("sceneWillResignActive")
        
        self.realmUserSessionViewModel =  RealmUserSessionViewModel()
        self.sessionCount = self.realmUserSessionViewModel.sessionCount
        self.sessionDate = self.realmUserSessionViewModel.sessionDate
        self.sessionExist = self.realmUserSessionViewModel.sessionExist
        
        if self.sessionExist! {
            
            self.sessionCount = Int(self.sessionCount!) + 1
            
            let calendar = Calendar.current
            let savedComponents = calendar.dateComponents([.year, .month, .day], from: self.sessionDate!)
            let savedDate = calendar.date(from: savedComponents)
            
            let components = calendar.dateComponents([.year, .month, .day], from: Date())
            let currentDate = calendar.date(from: components)
            
            let elapsed = Calendar.current.dateComponents([.day], from: savedDate!, to: currentDate!).day ?? 0
            
            /*print("sessionDate Before Update: \(sessionDate)")
            print("sessionCount Before Update: \(sessionData.sessionCount)")
            print("elapsed Before Update: \(elapsed)")*/
            
            self.realmUserSessionViewModel.updateRealmUserSession(with: self.sessionCount!, with: elapsed)
        } else {
            
            self.realmUserSessionViewModel =  RealmUserSessionViewModel()
            self.realmUserSessionViewModel.saveRealmUserSession()
        }
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
        
        //print("sceneWillEnterForeground")
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
        //print("sceneDidEnterBackground")
    }
}

