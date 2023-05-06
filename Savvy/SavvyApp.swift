//
//  SavvyApp.swift
//  Savvy
//
//  Created by Vin Bui on 5/5/23.
//

import FirebaseCore
import FirebaseAuth
import GoogleSignIn
import SwiftUI

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        return GIDSignIn.sharedInstance.handle(url)
    }
}

@main
struct SavvyApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) private var delegate
    
    @StateObject var authViewModel = AuthenticationViewModel.shared
    @StateObject var user: User = User.shared
    
    init() {
        configureFirebase()
    }
    
    var body: some Scene {
        WindowGroup {
            Group {
                switch authViewModel.state {
                case .signedIn:
                    HomeView()
                case .signedOut:
                    LoginView()
                }
            }
            .environmentObject(user)
            .environmentObject(authViewModel)
            .onAppear {
                if let netid = UserDefaults.standard.value(forKey: "netid") as? String,
                   let imgUrl = UserDefaults.standard.value(forKey: "imageUrl") as? String,
                   let name = UserDefaults.standard.value(forKey: "name") as? String {
                    authenticateUserDefault(name: name, netid: netid, imgUrl: imgUrl)
                }
            }
            .onChange(of: authViewModel.state) { _ in
                authenticateUser()
            }
        }
    }
    
    private func configureFirebase() {
        FirebaseApp.configure()
    }
    
    private func authenticateUser() {
        guard let googleUser = Auth.auth().currentUser else { return }
        
        let netid = googleUser.email?.components(separatedBy: "@").first ?? ""
        let imgUrl = googleUser.photoURL?.absoluteString ?? ""
        let name = googleUser.displayName ?? ""
        
        authViewModel.createUser(name: name, netid: netid, imageUrl: imgUrl) { newUser in
            DispatchQueue.main.async {
                user.id = newUser.id
                user.imgUrl = newUser.imgUrl
                user.name = newUser.name
                user.netid = newUser.netid
                user.appliedPosts = newUser.appliedPosts
                user.savedPosts = newUser.savedPosts
            }
        }
    }
    
    private func authenticateUserDefault(name: String, netid: String, imgUrl: String) {
        authViewModel.createUser(name: name, netid: netid, imageUrl: imgUrl) { newUser in
            DispatchQueue.main.async {
                user.id = newUser.id
                user.imgUrl = newUser.imgUrl
                user.name = newUser.name
                user.netid = newUser.netid
                user.appliedPosts = newUser.appliedPosts
                user.savedPosts = newUser.savedPosts
                
                authViewModel.state = .signedIn
            }
        }
    }
}
