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
    func retriveUser(with authInfo: AuthInfo) -> User?
    func saveUser(_ user: User, completion: @escaping () -> Void, error: @escaping (Error) -> Void)
}

final class UsersRealmProvider: UsersRealmProviderProtocol {

    static let SharedInstance: UsersRealmProviderProtocol = UsersRealmProvider()

    private let fileManager = FileManager.default

    private func realm() -> Realm? {
        guard let documentsDirectory = try? fileManager.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
            else { return nil }

        let databaseFileUrl = documentsDirectory
            .appendingPathComponent("users")
            .appendingPathExtension("realm")

        print("Users DB path: ", databaseFileUrl)

        let realmConfiguration = Realm.Configuration(fileURL: databaseFileUrl,
                                                     inMemoryIdentifier: nil,
                                                     syncConfiguration: nil,
                                                     encryptionKey: nil,
                                                     readOnly: false,
                                                     schemaVersion: 0,
                                                     migrationBlock: nil,
                                                     deleteRealmIfMigrationNeeded: true,
                                                     shouldCompactOnLaunch: nil,
                                                     objectTypes: [DBUser.self, DBCard.self])

        guard let realm = try? Realm(configuration: realmConfiguration) else { return nil }
        return realm
    }

    func retriveUser(with authInfo: AuthInfo) -> User? {
        guard let realm = realm() else { return nil }
        guard
            let dbUser = realm.object(ofType: DBUser.self, forPrimaryKey: authInfo.username),
            dbUser.password == authInfo.password
            else { return nil }

        return dbUser.asDomain
    }

    func saveUser(_ user: User, completion: @escaping () -> Void, error: @escaping (Error) -> Void) {
        guard let realm = realm() else { return }

        guard realm.object(ofType: DBUser.self, forPrimaryKey: user.username) == nil else {
            let err = NSError(domain: "com.alinka",
                                code: 404,
                                userInfo: [NSLocalizedDescriptionKey: "Користувач з таким імя вже існує!"])
            error(err)
            return
        }

        realm.beginWrite()

        let realmUser = DBUser()
        realmUser.sync(domain: user)

        realm.add(realmUser)

        do {
            try realm.commitWrite()
            completion()
        } catch let err {
            error(err)
            print("Error writing Down: ", err.localizedDescription)
        }
    }
}
