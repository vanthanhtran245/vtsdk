//
//  CoreDataStack.swift
//  TVTFramework
//
//  Created by Thanh Tran Van on 1/7/19.
//  Copyright © 2019 Thanh Tran Van. All rights reserved.
//

import CoreData

class CoreDataStack {
    
    static let shared = CoreDataStack()
    
    lazy var managedObjectContext: NSManagedObjectContext = {
        return persistentContainer.viewContext
    }()
    let persistentContainer: NSPersistentContainer
    let modelName = "CacheModel"
    
    private init() {
        persistentContainer = NSPersistentContainer(name: modelName)
        persistentContainer.loadPersistentStores { (_, error) in
            guard error == nil else {
                fatalError(error!.localizedDescription)
            }
        }
    }
    
    func flush() {
        let request: NSFetchRequest<CachedEntity> = CachedEntity.fetchRequest()
        let res = try! managedObjectContext.fetch(request)
        guard !res.isEmpty else {
            return
        }
        for i in 0..<res.count {
            managedObjectContext.delete(res[i])
        }
        try! managedObjectContext.save()
    }
}

