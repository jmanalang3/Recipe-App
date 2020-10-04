//
//  CoreDataManager.swift
//  Recipe-App
//
//  Created by Jeffrey Manalang (HLB) on 03/10/2020.
//

import Foundation
import CoreData

final class CoreDataManager {
    
    // MARK: - Properties
    
    fileprivate static var dataModelName: String?
    fileprivate static var dataModelBundle: Bundle?
    fileprivate static var persistentStoreName: String?
    fileprivate static var persistentStoreType = PersistentStoreType.sqLite
    fileprivate static var folderDatabaseName = "Database"
    
    /// The value to use for `fetchBatchSize` when fetching objects.
    static var defaultFetchBatchSize = 30
    
    static var privateContext: NSManagedObjectContext = {
        let context = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
        context.persistentStoreCoordinator = CoreDataManager.persistentStoreCoordinator
        return context
    }()
    
    static var mainContext: NSManagedObjectContext = {
        let context = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        context.parent = CoreDataManager.privateContext
        return context
    }()
    
    
    // MARK: Setup
    
    /// This method must be called before CoreDataManager can be used.
    /// It provides CoreDataManager with the required information for setting up the Core Data stack. Call this in application(_:didFinishLaunchingWithOptions:)
    
    /// NOTE : When creating manageObject subclass you need to set Codegen `Manual/none` on your model `.xcdatamodeld`
    /// so that you can place your class file to your folder and organize it the way you want.
    
    ///
    /// - Parameters:
    ///   - dataModelName:       The name of the data model schema file.
    ///   - bundle:              The bundle in which the data model schema file resides.
    ///   - persistentStoreName: The name of the persistent store.
    ///   - persistentStoreType: The persistent store type. Defaults to SQLite.
    static func setUp(withDataModelName dataModelName: String, bundle: Bundle,
                      persistentStoreName: String, persistentStoreType: PersistentStoreType = .sqLite) {
        
        CoreDataManager.dataModelName = dataModelName
        CoreDataManager.dataModelBundle = bundle
        CoreDataManager.persistentStoreName = persistentStoreName
        CoreDataManager.persistentStoreType = persistentStoreType
        
    }
    
    
    // MARK: Saving
    
    /// Saves changes to the persistent store.
    ///
    /// - Parameters:
    ///   - synchronously: Main thread should block while writing to the persistent store or not.
    ///   - completion:    Called after the save on the private context completes.
    static func persist(synchronously: Bool = true, completion: ((NSError?) -> Void)? = nil) {
        
        var mainContextSaveError: NSError?
        
        if mainContext.hasChanges {
            mainContext.performAndWait {
                do {
                    try self.mainContext.save()
                }
                catch let error as NSError {
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
    
    // MARK: Fetching
    
    /// Convenience method for fetching request with a generic ManagedObject
    ///
    /// - Parameters:
    ///   - entity:          The NSManagedObject subclass to be fetched.
    ///   - predicate:       A predicate to use for the fetch if needed (defaults to nil).
    ///   - sortDescriptors: Sort descriptors to use for the fetch if needed (defaults to nil).
    ///   - context:         The NSManagedObjectContext to perform the fetch with.
    /// - Returns: A typed array containing the results.
    /// - Example predicate :       let predicate = NSPredicate(format: "\(#keyPath(T.value)) == %@", "[Value]")
    /// - Example sortDescriptors : let ascendingSortDescriptor = NSSortDescriptor(key: #keyPath(T.value), ascending: true)
    static func fetchObjects<T: NSManagedObject>(entity: T.Type, predicate: NSPredicate? = nil, sortDescriptors: [NSSortDescriptor]? = nil, context: NSManagedObjectContext) -> [T] {
        
        let request = NSFetchRequest<T>(entityName: String(describing: entity))
        request.predicate = predicate
        request.sortDescriptors = sortDescriptors
        request.fetchBatchSize = defaultFetchBatchSize
        
        do {
            return try context.fetch(request)
        }
        catch let error as NSError {
            CoreDataManagerError.log(error: error)
            return [T]()
        }
    }
    
    /// Convenience method for fetching request with a generic ManagedObject
    ///
    /// - Parameters:
    ///   - entity:          The NSManagedObject subclass to be fetched.
    ///   - predicate:       A predicate to use for the fetch if needed (defaults to nil).
    ///   - sortDescriptors: Sort descriptors to use for the fetch if needed (defaults to nil).
    ///   - context:         The NSManagedObjectContext to perform the fetch with.
    /// - Returns: A typed result if found.
    /// - Example predicate :       let predicate = NSPredicate(format: "\(#keyPath(T.value)) == %@", "[Value]")
    /// - Example sortDescriptors : let ascendingSortDescriptor = NSSortDescriptor(key: #keyPath(T.value), ascending: true)
    static func fetchObject<T: NSManagedObject>(entity: T.Type, predicate: NSPredicate? = nil, sortDescriptors: [NSSortDescriptor]? = nil, context: NSManagedObjectContext) -> T? {
        
        let request = NSFetchRequest<T>(entityName: String(describing: entity))
        request.predicate = predicate
        request.sortDescriptors = sortDescriptors
        request.fetchLimit = 1
        
        do {
            return try context.fetch(request).first
        }
        catch let error as NSError {
            CoreDataManagerError.log(error: error)
            return nil
        }
    }
    
    
    /// Convenience method for fetching request that can be use for FetchedResultsController.
    ///
    /// - Parameters:
    ///   - entity:             The NSManagedObject subclass to be fetched.
    ///   - predicate:          A predicate to use for the fetch if needed (defaults to nil).
    ///   - sortDescriptors:    Sort descriptors to use for the fetch if needed (defaults to nil).
    ///   - context:            The NSManagedObjectContext to perform the fetch with.
    /// - Returns:              A fetch request.
    static func fetchRequest<T: NSManagedObject>(entity: T.Type, predicate: NSPredicate? = nil, sortDescriptors: [NSSortDescriptor], context: NSManagedObjectContext) -> NSFetchRequest<T> {
        let request = NSFetchRequest<T>(entityName: String(describing: entity))
        request.predicate = predicate
        request.sortDescriptors = sortDescriptors
        request.fetchBatchSize = defaultFetchBatchSize
        return request
    }
    
    
    /// Convenience method for FetchedResultsController
    ///
    /// - Parameters:
    ///   - entity:             The NSManagedObject subclass to be fetched.
    ///   - request:            Fetching request with a generic ManagedObject.
    ///   - sectionNameKeyPath: The key path on the fetched objects used to determine the section they belong to (defaults to nil).
    ///   - name:               The name of the file used to cache section information.
    ///   - context:            The NSManagedObjectContext to perform the fetch with.
    /// - Returns:              A fetchedResultsController result.
    static func fetchedResultsControllert<T: NSManagedObject>(entity: T.Type, request: NSFetchRequest<T>,sectionNameKeyPath: String? = nil,
                                                              cacheName name: String? = nil, context: NSManagedObjectContext) -> NSFetchedResultsController<T> {
        let fetchedResultsController:NSFetchedResultsController<T> = NSFetchedResultsController(fetchRequest: request, managedObjectContext: context,
                                                                                                sectionNameKeyPath: sectionNameKeyPath, cacheName: name)
        return fetchedResultsController
        
    }
    
    // MARK: Deleting
    
    /// Iterates over the objects and deletes
    ///
    /// - Parameters:
    ///   - objects: The objects to delete.
    ///   - context: The context to perform the deletion with.
    static func delete(_ objects: [NSManagedObject], in context: NSManagedObjectContext) {
        for object in objects {
            context.delete(object)
        }
    }
    
    static func delete<T: NSManagedObject>(entity: T.Type) {
        let request = NSFetchRequest<T>(entityName: String(describing: entity))
        request.includesPropertyValues = false
        do {
            for object in try mainContext.fetch(request) {
                mainContext.delete(object)
            }
        }
        catch let error as NSError {
            CoreDataManagerError.log(error: error)
        }
    }
    
    
    /// Delete All Objects using mainContext
    static func deleteAllObjects() {
        for entityName in managedObjectModel.entitiesByName.keys {
            let request = NSFetchRequest<NSManagedObject>(entityName: entityName)
            request.includesPropertyValues = false
            
            do {
                for object in try mainContext.fetch(request) {
                    mainContext.delete(object)
                }
            }
            catch let error as NSError {
                CoreDataManagerError.log(error: error)
            }
        }
    }
}

fileprivate extension CoreDataManager {
    
    // MARK: Core Data Stack
    
    static var applicationDocumentsDirectory: URL = {
        let url = FileManager.default.urls(for: .libraryDirectory, in: .userDomainMask).first!
        return url
    }()
    
    static var managedObjectModel: NSManagedObjectModel = {
        
        guard let dataModelName = CoreDataManager.dataModelName else {
            fatalError("Attempting to use nil data model name. \(String(describing: CoreDataManagerError.errorSetUpMessage))")
        }
        
        guard let modelURL = CoreDataManager.dataModelBundle?.url(forResource: CoreDataManager.dataModelName, withExtension: "momd") else {
            fatalError("Failed to locate data model schema file.")
        }
        
        guard let managedObjectModel = NSManagedObjectModel(contentsOf: modelURL) else {
            fatalError("Failed to created managed object model")
        }
        
        return managedObjectModel
    }()
    
    static var persistentStoreCoordinator: NSPersistentStoreCoordinator = {
        
        guard let persistentStoreName = CoreDataManager.persistentStoreName else {
            fatalError("Attempting to use nil persistent store name. \(String(describing: CoreDataManagerError.errorSetUpMessage))")
        }
        
        let coordinator = NSPersistentStoreCoordinator(managedObjectModel: CoreDataManager.managedObjectModel)
        
        let fileManager = FileManager.default
        let filePath =  CoreDataManager.applicationDocumentsDirectory.appendingPathComponent(CoreDataManager.folderDatabaseName)
        if !fileManager.fileExists(atPath: filePath.path) {
            do {
                try fileManager.createDirectory(atPath: filePath.path, withIntermediateDirectories: true, attributes: nil)
            } catch {
                CoreDataManagerError.log(error: error)
            }
        }
        
        print("Document directory is \(filePath)")
        
        let url = filePath.appendingPathComponent("\(persistentStoreName).sqlite")
        
        let options = [
            NSMigratePersistentStoresAutomaticallyOption: true,
            NSInferMappingModelAutomaticallyOption: true
        ]
        
        do {
            try coordinator.addPersistentStore(ofType: CoreDataManager.persistentStoreType.stringValue, configurationName: nil, at: url, options: options)
        }
        catch let error as NSError {
            fatalError("Failed to initialize the application's persistent data: \(error.localizedDescription)")
        }
        catch {
            fatalError("Failed to initialize the application's persistent data")
        }
        
        return coordinator
    }()
    
}


