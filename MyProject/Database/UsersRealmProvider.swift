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
    func deleteAllCards()
    func fetchAllUsers() -> [User]
    func cards(for project: Project) -> [Card]
    func retriveUser(with authInfo: AuthInfo) -> User?
    func saveUser(_ user: User, update: Bool, completion: @escaping () -> Void, error: @escaping (Error) -> Void)
    func saveCard(_ card: Card, completion: @escaping () -> Void, error: @escaping (Error) -> Void)
}

extension UsersRealmProviderProtocol {
    func saveUser(_ user: User, update: Bool = false, completion: @escaping () -> Void, error: @escaping (Error) -> Void) {
        saveUser(user, update: update, completion: completion, error: error)
    }
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

//        print("Users DB path: ", databaseFileUrl)

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

    func fetchAllUsers() -> [User] {
        guard let realm = realm() else { return [] }
        return Array(realm.objects(DBUser.self).map { $0.asDomain })
    }

    func cards(for project: Project) -> [Card] {
        guard let realm = realm() else { return [] }
        let allObjects = realm.objects(DBCard.self)
            .filter { $0.projectID == project.created.asKey }
            .map { $0.asDomain }

        return Array(allObjects)
    }

    func retriveUser(with authInfo: AuthInfo) -> User? {
        guard let realm = realm() else { return nil }
        guard
            let dbUser = realm.object(ofType: DBUser.self, forPrimaryKey: authInfo.username),
            dbUser.password == authInfo.password
            else { return nil }

        return dbUser.asDomain
    }

    func saveUser(_ user: User, update: Bool, completion: @escaping () -> Void, error: @escaping (Error) -> Void) {
        guard let realm = realm() else { return }

        let realmUser: DBUser

        if !update {
            // then login
            guard realm.object(ofType: DBUser.self, forPrimaryKey: user.username) == nil else {
                let err = NSError(domain: "com.alinka",
                                  code: 404,
                                  userInfo: [NSLocalizedDescriptionKey: "Користувач з таким імя вже існує!"])
                error(err)
                return
            }

            realmUser = DBUser()
            realm.beginWrite()

            realmUser.sync(domain: user)
        } else {
            realm.beginWrite()

            realmUser = realm.object(ofType: DBUser.self, forPrimaryKey: user.username)!

            realmUser.cards.append(contentsOf: user.cards)
        }

        realm.add(realmUser, update: true)

        do {
            try realm.commitWrite()
            completion()
        } catch let err {
            error(err)
            print("Error writing Down: ", err.localizedDescription)
        }
    }

    func saveCard(_ card: Card, completion: @escaping () -> Void, error: @escaping (Error) -> Void) {
        guard let realm = realm() else { return }

        let dbCard = realm.object(ofType: DBCard.self, forPrimaryKey: card.created) ?? DBCard()

        realm.beginWrite()
        dbCard.sync(domain: card)
        realm.create(DBCard.self, value: dbCard, update: true)

        do {
            try realm.commitWrite()
            completion()
        } catch let err {
            error(err)
        }
    }

    func deleteAllCards() {
        guard let realm = realm() else { return }
        realm.beginWrite()
        realm.deleteAll()

        do {
            try realm.commitWrite()
        } catch let err {
            print(err)
        }
    }
}
