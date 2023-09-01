//
//  SceneDelegate.swift
//  AppMovies
//
//  Created by Derian Aguilar on 30/08/23.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var listMovieRouter = ListMovieRouter()


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        window = UIWindow(windowScene: windowScene)
        listMovieRouter.showListMovies(window: window)
    }


}

