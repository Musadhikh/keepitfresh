//
//  DIContainer.swift
//  keepitfresh
//
//  Created by Musadhikh Muhammed on 14/1/26.
//

import Factory

extension Container {
    var appMetadataProvider: Factory<AppMetadataProviding> {
        self { AppMetadataService() }
    }
    
    var versionCheckProvider: Factory<VersionCheckProvider> {
        self { VersionCheckProvider() }
    }
    
    var userProvider: Factory<UserProviding> {
        self { UserFirebaseService() }
    }
    
    var profileProvider: Factory<ProfileProviding> {
        self { ProfileFirebaseService() }
    }
}
