//
//  TutorsApp+Injection.swift
//  Tutors
//
//  Created by Alan on 28.5.2021.
//

import Foundation
import Resolver

extension Resolver: ResolverRegistering {
  public static func registerAllServices() {
    // register application components
    register { AuthenticationService() }.scope(.application)
    register { FirestoreTutorRepo() as TutorRepo }.scope(.application)
    register { FirestoreTutorsRepo() as TutorsRepo }.scope(.application)
    register { FirestoreChatRepo() as ChatRepo }.scope(.application)
    register { FirestoreUserRepo() as UserRepo }.scope(.application)
  }
}
