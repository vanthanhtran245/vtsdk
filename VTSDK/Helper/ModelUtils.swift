//
//  ModelUtils.swift
//  TVTFramework
//
//  Created by Thanh Tran Van on 1/10/19.
//  Copyright © 2019 Thanh Tran Van. All rights reserved.
//

import Foundation
import CoreData

public enum PersistentStoreType {
    
    /// Represents the value for NSSQLiteStoreType.
    case sqLite
    
    /// Represents the value for NSBinaryStoreType.
    case binary
    
    /// Represents the value for NSInMemoryStoreType.
    case inMemory
    
    /// Value of the Core Data string constants corresponding to each case.
    var stringValue: String {
        switch self {
        case .sqLite:
            return NSSQLiteStoreType
        case .binary:
            return NSBinaryStoreType
        case .inMemory:
            return NSInMemoryStoreType
        }
    }
}

public protocol ModelUtilsErrorLogger {
    
    func log(error: NSError, file: StaticString, function: StaticString, line: UInt)
}


private class DefaultLogger: ModelUtilsErrorLogger {
    
    func log(error: NSError, file: StaticString, function: StaticString, line: UInt) {
        print("[ModelUtils - \(function) line \(line)] Error: \(error.localizedDescription)")
    }
}



// MARK: - Constants
private struct Constants {
    static fileprivate let mustCallSetupMethodErrorMessage = "ModelUtils must be set up using setUp(withDataModelName:bundle:persistentStoreType:) before it can be used."
}


public final class ModelUtils {
    
    private static var dataModelName: String?
    private static var persistentStoreName: String?
    private static var dataModelBundle: Bundle?
    private static var persistentStoreType = PersistentStoreType.sqLite
    
    /// The logger to use for logging errors caught internally. A default logger is used if a custom one isn't provided. Assigning nil to this property prevents ModelUtils from emitting any logs to the console.
    public static var errorLogger: ModelUtilsErrorLogger? = DefaultLogger()
    
    /// The value to use for `fetchBatchSize` when fetching objects.
    public static var defaultFetchBatchSize = 50
    
    
    // MARK: Setup
    
    /**
     This method must be called before ModelUtils can be used. It provides ModelUtils with the required information for setting up the Core Data stack. Call this in application(_:didFinishLaunchingWithOptions:).
     
     - parameter dataModelName:       The name of the data model schema file.
     - parameter bundle:              The bundle in which the data model schema file resides.
     - parameter persistentStoreName: The name of the persistent store.
     - parameter persistentStoreType: The persistent store type. Defaults to SQLite.
     */
    public static func setUp(withBundle bundle: Bundle, modelName: String, storeName: String, persistentStoreType: PersistentStoreType = .sqLite) {
        ModelUtils.dataModelBundle = bundle
        ModelUtils.dataModelName = modelName
        ModelUtils.persistentStoreName = storeName
        ModelUtils.persistentStoreType = persistentStoreType
        
    }
    
    
    
    // MARK: Core Data Stack
    
    private static var applicationDocumentsDirectory: URL = {
        
        let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return urls[urls.lastIndex]
    }()
    
    
    
    private static var managedObjectModel: NSManagedObjectModel = {
        guard let modelURL = ModelUtils.dataModelBundle?.url(forResource: ModelUtils.dataModelName, withExtension: "momd") else {
            fatalError("Failed to locate data model schema file.")
        }
        guard let managedObjectModel = NSManagedObjectModel(contentsOf: modelURL) else {
            fatalError("Failed to created managed object model")
        }
        return managedObjectModel
    }()
    
    
    
    private static var persistentStoreCoordinator: NSPersistentStoreCoordinator = {
        guard let persistentStoreName = ModelUtils.persistentStoreName else {
            fatalError("Attempting to use nil persistent store name. \(Constants.mustCallSetupMethodErrorMessage)")
        }
        let coordinator = NSPersistentStoreCoordinator(managedObjectModel: ModelUtils.managedObjectModel)
        let url = ModelUtils.applicationDocumentsDirectory.appendingPathComponent("\(persistentStoreName).sqlite")
        let options = [
            NSMigratePersistentStoresAutomaticallyOption: true,
            NSInferMappingModelAutomaticallyOption: true
        ]
        do {
            try coordinator.addPersistentStore(ofType: ModelUtils.persistentStoreType.stringValue, configurationName: nil, at: url, options: options)
        }
        catch let error as NSError {
            fatalError("Failed to initialize the application's persistent data: \(error.localizedDescription)")
        }
        catch {
            fatalError("Failed to initialize the application's persistent data")
        }
        
        return coordinator
    }()
    
    
    
    static var privateContext: NSManagedObjectContext = {
        let context = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
        context.persistentStoreCoordinator = ModelUtils.persistentStoreCoordinator
        return context
    }()
    
    
    
    /// A MainQueueConcurrencyType context whose parent is a PrivateQueueConcurrencyType context. The PrivateQueueConcurrencyType context is the root context.
    public static var mainContext: NSManagedObjectContext = {
        let context = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        context.parent = ModelUtils.privateContext
        return context
    }()
    
    
    // MARK: Fetching
    
    /**
     This is a convenience method for performing a fetch request. Note: Errors thrown by executeFetchRequest are suppressed and logged in order to make usage less verbose. If detecting thrown errors is needed in your use case, you will need to use Core Data directly.
     
     - parameter entity:          The NSManagedObject subclass to be fetched.
     - parameter predicate:       A predicate to use for the fetch if needed (defaults to nil).
     - parameter sortDescriptors: Sort descriptors to use for the fetch if needed (defaults to nil).
     - parameter context:         The NSManagedObjectContext to perform the fetch with.
     
     - returns: A typed array containing the results. If executeFetchRequest throws an error, an empty array is returned.
     */
    public static func fetchObjects<T: NSManagedObject>(entity: T.Type, predicate: NSPredicate? = nil, sortDescriptors: [NSSortDescriptor]? = nil, context: NSManagedObjectContext) -> [T] {
        let request = NSFetchRequest<T>(entityName: String(describing: entity))
        request.predicate = predicate
        request.sortDescriptors = sortDescriptors
        request.fetchBatchSize = defaultFetchBatchSize
        request.returnsObjectsAsFaults = false
        do {
            return try context.fetch(request)
        }
        catch let error as NSError {
            log(error: error)
            return [T]()
        }
    }
    
    /**
     This is a convenience method for performing a fetch request that fetches a single object. Note: Errors thrown by executeFetchRequest are suppressed and logged in order to make usage less verbose. If detecting thrown errors is needed in your use case, you will need to use Core Data directly.
     
     - parameter entity:          The NSManagedObject subclass to be fetched.
     - parameter predicate:       A predicate to use for the fetch if needed (defaults to nil).
     - parameter sortDescriptors: Sort descriptors to use for the fetch if needed (defaults to nil).
     - parameter context:         The NSManagedObjectContext to perform the fetch with.
     
     - returns: A typed result if found. If executeFetchRequest throws an error, nil is returned.
     */
    public static func fetchObject<T: NSManagedObject>(entity: T.Type, predicate: NSPredicate? = nil, sortDescriptors: [NSSortDescriptor]? = nil, context: NSManagedObjectContext) -> T? {
        let request = NSFetchRequest<T>(entityName: String(describing: entity))
        request.predicate = predicate
        request.sortDescriptors = sortDescriptors
        request.fetchLimit = 1
        do {
            return try context.fetch(request).first
        }
        catch let error as NSError {
            log(error: error)
            return nil
        }
    }
    
    // MARK: Deleting
    
    /**
     Iterates over the objects and deletes them using the supplied context.
     
     - parameter objects: The objects to delete.
     - parameter context: The context to perform the deletion with.
     */
    public static func delete(_ objects: [NSManagedObject], in context: NSManagedObjectContext) {
        objects.forEach({ context.delete($0) })
    }
    
    /**
     For each entity in the model, fetches all objects into memory, iterates over each object and deletes them using the main context. Note: Errors thrown by executeFetchRequest are suppressed and logged in order to make usage less verbose. If detecting thrown errors is needed in your use case, you will need to use Core Data directly.
     */
    public static func deleteAllObjects() {
        managedObjectModel.entitiesByName.keys.forEach {
            let request = NSFetchRequest<NSManagedObject>(entityName: $0)
            request.includesPropertyValues = false
            do {
                try mainContext.fetch(request).forEach({ mainContext.delete($0) })
            }
            catch let error as NSError {
                log(error: error)
            }
        }
    }
    
    // MARK: Saving
    
    /**
     Saves changes to the persistent store.
     
     - parameter synchronously: Whether the main thread should block while writing to the persistent store or not.
     - parameter completion:    Called after the save on the private context completes. If there is an error, it is called immediately and the error parameter is populated.
     */
    public static func persist(synchronously: Bool, completion: ((NSError?) -> Void)? = nil) {
        var mainContextSaveError: NSError?
        if mainContext.hasChanges {
            mainContext.performAndWait {
                do {
                    try self.mainContext.save()
                }
                catch var error as NSError {
                    mainContextSaveError = error
                }
            }
        }
        
        guard mainContextSaveError == nil else {
            completion?(mainContextSaveError)
            return
        }
        
        func savePrivateContext() {
            do {
                try privateContext.save()
                completion?(nil)
            }
            catch let error as NSError {
                completion?(error)
            }
        }
        
        if privateContext.hasChanges {
            if synchronously {
                privateContext.performAndWait(savePrivateContext)
            }
            else {
                privateContext.perform(savePrivateContext)
            }
        }
    }
    
    
    private static func log(error: NSError, file: StaticString = #file, function: StaticString = #function, line: UInt = #line) {
        errorLogger?.log(error: error, file: file, function: function, line: line)
    }
}


