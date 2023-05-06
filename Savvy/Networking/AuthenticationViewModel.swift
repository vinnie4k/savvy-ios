//
//  AuthenticationViewModel.swift
//  Savvy
//
//  Created by Vin Bui on 5/5/23.
//

import Firebase
import GoogleSignIn
import SwiftUI

class AuthenticationViewModel: ObservableObject {
    
    static let shared = AuthenticationViewModel()
    
    @Published var state: SignInState = .signedOut

    func signIn() {
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }
        
        let config = GIDConfiguration(clientID: clientID)
        GIDSignIn.sharedInstance.configuration = config
        
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else { return }
        guard let rootViewController = windowScene.windows.first?.rootViewController else { return }
        
        GIDSignIn.sharedInstance.signIn(withPresenting: rootViewController) { [unowned self] result, error in
            guard error == nil else {
                print(error!.localizedDescription)
                return
            }
            
            guard let user = result?.user,
                  let idToken = user.idToken?.tokenString else {
                return
            }
            
            let credential = GoogleAuthProvider.credential(
                withIDToken: idToken,
                accessToken: user.accessToken.tokenString
            )
            
            Auth.auth().signIn(with: credential) { [unowned self] user, error in
                if let error = error {
                    print(error.localizedDescription)
                } else {
                    self.state = .signedIn
                    
                    guard let googleUser = Auth.auth().currentUser else { return }
                    
                    let netid = googleUser.email?.components(separatedBy: "@").first ?? ""
                    let imgUrl = googleUser.photoURL?.absoluteString ?? ""
                    let name = googleUser.displayName ?? ""
                    
                    UserDefaults.standard.set(netid, forKey: "netid")
                    UserDefaults.standard.set(name, forKey: "name")
                    UserDefaults.standard.set(imgUrl, forKey: "imageUrl")
                }
            }
        }
    }
    
    func signOut() {
        state = .signedOut
        UserDefaults.standard.set("", forKey: "netid")
        UserDefaults.standard.set("", forKey: "name")
        UserDefaults.standard.set("", forKey: "imageUrl")
        do {
            try Auth.auth().signOut()
        } catch {
            print("Unable to sign out")
        }
    }
    
    func createUser(name: String, netid: String, imageUrl: String, completion: @escaping (User) -> Void) {
        guard let url = URL(string: "http://34.150.213.122/api/users/") else { return }

        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        
        let parameters = ["name": name, "netid": netid, "img_url": imageUrl]
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
        } catch let error {
            print(error.localizedDescription)
        }
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, let response = response as? HTTPURLResponse, error == nil else {
                print(URLError(.badServerResponse))
                return
            }
            
            guard (200 ... 299) ~= response.statusCode else {
                print("statusCode should be 2xx, but is \(response.statusCode)")
                print("response = \(response)")
                return
            }
            
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
                        
            do {
                let user = try decoder.decode(User.self, from: data)
                completion(user)
            } catch {
                print(error)
                
                if let responseString = String(data: data, encoding: .utf8) {
                    print("responseString = \(responseString)")
                } else {
                    print("unable to parse response as string")
                }
            }
        }
        
        task.resume()
    }
    
    func bookmarkPost(toSave: Bool, postID: Int, userID: Int, completion: @escaping ([Post]) -> Void) {
        var saveString = "save_post"
        if !toSave {
            saveString = "unsave_post"
        }
        guard let url = URL(string: "http://34.150.213.122/api/users/\(userID)/\(saveString)/\(postID)/") else { return }
        
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, let response = response as? HTTPURLResponse, error == nil else {
                print(URLError(.badServerResponse))
                return
            }
            
            guard (200 ... 299) ~= response.statusCode else {
                print("statusCode should be 2xx, but is \(response.statusCode)")
                print("response = \(response)")
                return
            }
            
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
                        
            do {
                let postList = try decoder.decode(PostList.self, from: data)
                completion(postList.posts)
            } catch {
                print(error)
                
                if let responseString = String(data: data, encoding: .utf8) {
                    print("responseString = \(responseString)")
                } else {
                    print("unable to parse response as string")
                }
            }
        }
        
        task.resume()
    }
    
}

extension AuthenticationViewModel {
    
    enum SignInState: Equatable {
        case signedIn
        case signedOut
    }
    
}
