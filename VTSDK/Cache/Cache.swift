//
//  Cache.swift
//  TVTFramework
//
//  Created by Thanh Tran Van on 1/7/19.
//  Copyright © 2019 Thanh Tran Van. All rights reserved.
//

import CoreData

class Cache {
    let coreDataStack = CoreDataStack.shared
    
    func save(_ data: Data, for resource: Cacheable) {
        // Check for item in cache
        let request: NSFetchRequest<NSFetchRequestResult> = CachedEntity.fetchRequest()
        request.predicate = NSPredicate(format: "cacheKey == %@", resource.cacheKey)
        
        if let res = try! coreDataStack.managedObjectContext.fetch(request).first as? CachedEntity {
            // Update cached resource
            res.data = data
        } else {
            // Create new cached item
            let cacheItem = CachedEntity(context: coreDataStack.managedObjectContext)
            cacheItem.data = data
            cacheItem.cacheKey = resource.cacheKey
        }
        try! coreDataStack.managedObjectContext.save()
    }
    
    func loadData<T>(for resource: Resource<T>) -> T? {
        let request: NSFetchRequest<NSFetchRequestResult> = CachedEntity.fetchRequest()
        let predicate = NSPredicate(format: "cacheKey == %@", resource.cacheKey)
        request.predicate = predicate
        request.fetchLimit = 1
        guard let result = try? coreDataStack.managedObjectContext.fetch(request).first as? CachedEntity,
            let data = result?.data,
            let decodedData = try? JSONDecoder().decode(T.self, from: data) else { return nil }
        return decodedData
    }
    
    func loadArrayData<T>(for resource: ArrayResource<T>) -> [T]? {
        let request: NSFetchRequest<NSFetchRequestResult> = CachedEntity.fetchRequest()
        let predicate = NSPredicate(format: "cacheKey == %@", resource.cacheKey)
        request.predicate = predicate
        guard let result = try? coreDataStack.managedObjectContext.fetch(request) as? [CachedEntity],
            let data = result?.first?.data,
            let decodedData = try? JSONDecoder().decode([T].self, from: data) else { return nil }
        return decodedData
    }
}
