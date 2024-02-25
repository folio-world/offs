//
//  OnboardingSignUpView.swift
//  ToffFeature
//
//  Created by 송영모 on 1/27/24.
//

import Foundation
import SwiftUI
import AuthenticationServices

import ComposableArchitecture
import Supabase

import OffShared

public struct OnboardingSignInView: View {
    let store: StoreOf<OnboardingSignInStore>
    let client = SupabaseClient(supabaseURL: URL(string: OffShared.Environment.supabaseProjectURL)!, supabaseKey: OffShared.Environment.supabaseAPIpublicKey)
    
    public init(store: StoreOf<OnboardingSignInStore>) {
        self.store = store
    }
    
    @State private var rotateIn3D = false
    
    public var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            SignInWithAppleButton(onRequest: {_ in }, onCompletion: { result in
                switch result {
                case let .success(result):
                    switch result.credential {
                    case let appleIDCredential as ASAuthorizationAppleIDCredential:
                        let idToken = String(data: appleIDCredential.identityToken!, encoding: .utf8) ?? ""
                        viewStore.send(.signIn(idToken: idToken))
                    default:
                        break
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                }
            })
            .frame(height: 50, alignment: .center)
        }
    }
}
