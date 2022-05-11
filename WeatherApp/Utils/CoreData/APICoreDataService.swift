//
//  APICoreDataService.swift
//  WeatherApp
//
//  Created by Anthony merida on 5/9/22.
//

import Foundation
import UIKit
import CoreData

/// This protocol is called in the models (structs) to set these values required for the operation of the APICoreDataService
protocol ModelCoreData {
    static func getEntity() -> String
    func getCoreDataDictionary() -> [String:Any?]
    func getIdentifier() -> Int
    init(object: NSManagedObject)
}

class APICoreDataService {
    static let shared = APICoreDataService()
    
    func create<T:ModelCoreData>(_ model: T, save: Bool = false) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: type(of: model).getEntity(), in: managedContext)!
        let dic = model.getCoreDataDictionary()
        let keys = Array.init(dic.keys)
        let model = NSManagedObject(entity: entity, insertInto: managedContext)
        
        for k in keys {
            if dic[k]! != nil {
                model.setValue(dic[k]!, forKey: k)
            }
        }
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    func create<T:ModelCoreData>(_ models: [T]) {
        for (i,m) in models.enumerated() {
            if !checkIfExist(m) {
                if i == (models.count - 1) {
                    create(m, save: true)
                    return
                }
                create(m, save: false)
            } else {
                if i == (models.count - 1) {
                    update(m, save: true)
                    return
                }
                update(m, save: false)
            }
        }
    }
    
    func deleteAllObjects<T:ModelCoreData>(_ clase: T.Type) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest:NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: clase.getEntity())
        do {
            let results = try managedContext.fetch(fetchRequest)
            for managedObject in results
            {
                let managedObjectData:NSManagedObject = managedObject as! NSManagedObject
                managedContext.delete(managedObjectData)
            }
            do {
                try managedContext.save()
            } catch {
                print(error)
            }
        } catch let error as NSError {
            debugPrint(error)
        }
    }
    
    func deleteObject<T:ModelCoreData>(_ model: T) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest:NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: type(of: model).getEntity())
        fetchRequest.predicate = NSPredicate(format: "woeid = %d", model.getIdentifier())
        do {
            let test = try managedContext.fetch(fetchRequest)
            if test.count == 0 {
                return
            }
            let objectUpdate = test[0] as! NSManagedObject
            managedContext.delete(objectUpdate)
            do {
                try managedContext.save()
            } catch {
                print(error)
            }
        } catch {
            print(error)
        }
    }
    
    func retrieve<T:ModelCoreData>(_ clase: T.Type, order: NSSortDescriptor? = nil, predicate: NSPredicate? = nil) -> [T] {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return [] }
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: clase.getEntity())
        if let order = order{
            fetchRequest.sortDescriptors = [order]
        }
        if let predicate = predicate {
            fetchRequest.predicate = predicate
        }
        do {
            let result = try managedContext.fetch(fetchRequest)
            var list:[T] = []
            for data in result as! [NSManagedObject] {
                list.append(clase.init(object: data))
            }
            return list
        } catch {
            print("Failed")
        }
        return []
    }
    
    func checkIfExist<T:ModelCoreData>(_ model: T) -> Bool {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return false }
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: type(of: model).getEntity())
        fetchRequest.predicate = NSPredicate(format: "woeid = %d", model.getIdentifier())
        do {
            let result = try managedContext.count(for: fetchRequest)
            if result > 0 {
                return true
            }
        } catch {
            print("Failed")
        }
        return false
    }
    
    func update<T: ModelCoreData>(_ model: T, save: Bool = false) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest:NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: type(of: model).getEntity())
        fetchRequest.predicate = NSPredicate(format: "woeid = %d", model.getIdentifier())
        do {
            let test = try managedContext.fetch(fetchRequest)
            if test.count == 0 {
                return
            }
            let objectUpdate = test[0] as! NSManagedObject
            let dic = model.getCoreDataDictionary()
            let keys = Array.init(dic.keys)
            for k in keys {
                if dic[k]! != nil {
                    objectUpdate.setValue(dic[k]!, forKey: k)
                }
            }
            if !save{
                return
            }
            do {
                try managedContext.save()
            } catch {
                print(error)
            }
        } catch {
            print(error)
        }
    }
}
