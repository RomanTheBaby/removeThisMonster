//
//  UsersRealmProvider.swift
//  MyProject
//
//  Created by Baby on 4/10/18.
//  Copyright © 2018 Alina. All rights reserved.
//

import Cocoa
import RealmSwift

protocol UsersRealmProviderProtocol {

}

final class UsersRealmProvider: UsersRealmProviderProtocol {

    private let fileManager = FileManager.default

    private func realm() -> Realm? {
        guard let documentsDirectory = try? fileManager.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
            else { return nil }

        let databaseFileUrl = documentsDirectory
            .appendingPathComponent("users")
            .appendingPathExtension("realm")

        let realmConfiguration = Realm.Configuration(fileURL: databaseFileUrl,
                                                     inMemoryIdentifier: nil,
                                                     syncConfiguration: nil,
                                                     encryptionKey: nil,
                                                     readOnly: false,
                                                     schemaVersion: 0,
                                                     migrationBlock: nil,
                                                     deleteRealmIfMigrationNeeded: true,
                                                     shouldCompactOnLaunch: nil,
                                                     objectTypes: [DBUser.self])

        guard let realm = try? Realm(configuration: realmConfiguration) else { return nil }
        return realm
    }
}
