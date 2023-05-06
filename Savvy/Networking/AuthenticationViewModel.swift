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
            
            Auth.auth().signIn(with: credential) { [unowned self] _, error in
                if let error = error {
                    print(error.localizedDescription)
                } else {
                    self.state = .signedIn
                }
            }
        }
    }
    
}

extension AuthenticationViewModel {
    
    enum SignInState {
        case signedIn
        case signedOut
    }
    
}
