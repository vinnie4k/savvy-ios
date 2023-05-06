//
//  LoginView.swift
//  Savvy
//
//  Created by Vin Bui on 5/5/23.
//

import FirebaseAuth
import SwiftUI

struct LoginView: View {
    
    @EnvironmentObject var user: User
    @StateObject private var authViewModel = AuthenticationViewModel()
    
    var body: some View {
        VStack {
            Text("savvy")
                .foregroundColor(Color.savvy.baseText)
                .font(.sfPro(size: 56, weight: .medium))
            
            loginButton
                .onTapGesture {
                    authViewModel.signIn()
                }
        }
        .onChange(of: authViewModel.state) { state in
            switch state {
            case .signedIn:
                guard let googleUser = Auth.auth().currentUser else { return }
                
                let netid = googleUser.email?.components(separatedBy: "@").first
                
                user.id = googleUser.uid
                user.imgUrl = googleUser.photoURL!
                user.name = googleUser.displayName ?? ""
                user.netid = netid ?? ""
                user.savedPosts = []
                
                UserDefaults.standard.set(true, forKey: "isLoggedIn")
            case .signedOut:
                break
            }
        }
    }
    
    private var loginButton: some View {
        HStack {
            Image.savvy.googleLogo
                .resizable()
                .frame(width: 24, height: 24)
                .padding(.trailing, 16)
            
            Text("Continue with Google")
                .font(.sfPro(size: 16, weight: .semibold))
        }
        .padding(.vertical, 12)
        .padding(.horizontal, 32)
        .overlay(
            RoundedRectangle(cornerRadius: 32)
                .stroke(Color.savvy.gray, lineWidth: 2)
        )
    }
    
}

//struct LoginView_Previews: PreviewProvider {
//    static var previews: some View {
//        LoginView()
//    }
//}
