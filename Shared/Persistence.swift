//
//  Persistence.swift
//  Shared
//
//  Created by Andrew Li on 19/8/2022.
//

import CoreData
import Combine
import CloudKit

class PersistenceController {
    static let shared = PersistenceController() // Singleton class
    
    // For preview purpose
    static var preview: PersistenceController = {
        let result = PersistenceController(inMemory: true)
        let viewContext = result.container.viewContext
        
        // Init items for preview
        let previewHelper = PreviewHelper(viewContext: viewContext)
        previewHelper.initForNewUser()
        
        return result
    }()

    let container: NSPersistentCloudKitContainer
    
    @Published private(set) var cloudEvent: NSPersistentCloudKitContainer.Event? = nil
    private var cancellables = Set<AnyCancellable>()

    init(inMemory: Bool = false) {
        container = NSPersistentCloudKitContainer(name: "Kiwi")
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        container.viewContext.automaticallyMergesChangesFromParent = true
        container.viewContext.mergePolicy = NSMergeByPropertyStoreTrumpMergePolicy
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        
        setCloudKitEventChangedNotification()
    }
    
    private func setCloudKitEventChangedNotification() {
        NotificationCenter.default.publisher(for: NSPersistentCloudKitContainer.eventChangedNotification)
            .sink(receiveValue: { notification in
                if let cloudEvent = notification.userInfo?[NSPersistentCloudKitContainer.eventNotificationUserInfoKey]
                    as? NSPersistentCloudKitContainer.Event {
                    DispatchQueue.main.async {
                        self.cloudEvent = cloudEvent
                    }
                }
            })
            .store(in: &cancellables)
        
    }
}
