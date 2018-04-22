//
//  ProdjectsRealmProvider.swift
//  MyProject
//
//  Created by Baby on 4/14/18.
//  Copyright © 2018 Alina. All rights reserved.
//

import Cocoa
import RealmSwift

protocol ProdjectsRealmProviderProtocol {
    func removeAllProjects()
    func fetchAllProdjects() -> [Project]
    func saveProdject(_ prodject: Project, completion: @escaping () -> Void, error: @escaping (Error) -> Void)
}

final class ProdjectsRealmProvider: ProdjectsRealmProviderProtocol {

    static let SharedInstance: ProdjectsRealmProviderProtocol = ProdjectsRealmProvider()

    private let fileManager = FileManager.default

    private func realm() -> Realm? {
        guard let documentsDirectory = try? fileManager.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
            else { return nil }

        let databaseFileUrl = documentsDirectory
            .appendingPathComponent("prodjects")
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
                                                     objectTypes: [DBProject.self])

        guard let realm = try? Realm(configuration: realmConfiguration) else { return nil }
        return realm
    }

    func removeAllProjects() {
        guard let realm = realm() else { return }
        realm.beginWrite()
        realm.deleteAll()

        do {
            try realm.commitWrite()
        } catch {
            print("Error removing all Projects")
        }
    }

    func fetchAllProdjects() -> [Project] {
        guard let realm = realm() else { return [] }
        let objects = Array(realm.objects(DBProject.self))
        return objects.map { $0.asDomain }
    }

    func saveProdject(_ prodject: Project, completion: @escaping () -> Void, error: @escaping (Error) -> Void) {
        guard let realm = realm() else { return }

        let dbProdject = realm.object(ofType: DBProject.self, forPrimaryKey: prodject.created.asKey) ?? DBProject()

        guard prodject.name != dbProdject.name else {
            realm.cancelWrite();
            let err = NSError(domain: "com.domain", code: 404, userInfo: [NSLocalizedDescriptionKey: "Проект з таким ім'ям уже існує!"])
            error(err)
            return
        }

        realm.beginWrite()

        dbProdject.sync(domain: prodject)

        realm.add(dbProdject, update: true)

        do {
            try realm.commitWrite()
            completion()
        } catch let err {
            error(err)
        }
    }
}
