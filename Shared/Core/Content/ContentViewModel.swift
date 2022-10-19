//
//  ContentViewModel.swift
//  Kiwi
//
//  Created by Andrew Li on 20/8/2022.
//

import CoreData
import Combine

class ContentViewModel: ObservableObject {
    private var setting: SettingEntity? = nil
    private let viewContext:NSManagedObjectContext
    private var cancellables = Set<AnyCancellable>()
    
    /*
     * Temporary util function to reset user
     * Should be commented when commit
     */
    
//    init(viewContext: NSManagedObjectContext = PersistenceController.shared.container.viewContext) {
//        self.viewContext = viewContext
//        NSUbiquitousKeyValueStore().removeObject(forKey: CustomUserDefaultsKey.isFirstLaunch.rawValue)
//    }
    
    init(viewContext: NSManagedObjectContext = PersistenceController.shared.container.viewContext) {
        self.viewContext = viewContext

        // Init logic not working on WatchOS. Only allow initialization on iOS first
#if os(iOS)
        initForNewUser()
#endif

        // Retrieve setting instance from Core Data + CloudKit
        fetchSetting()

        PersistenceController.shared.$cloudEvent
            .sink{ newValue in
                print("PersistenceController cloudEvent property changed")
            }
            .store(in: &cancellables)
    }
    
    private func initForNewUser() {
        // Logic to check if it is a new user
        if #available(watchOS 9.0, *) {
            // Continue initialization only if iCloud user haven't open the app yet
            guard (NSUbiquitousKeyValueStore().object(forKey: CustomUserDefaultsKey.isFirstLaunch.rawValue) == nil) else { return }
            
            // Logic that only did once for new user
            initSetting()
            initDefaultCategories()
            
            // Mark user as he has launched the app
            NSUbiquitousKeyValueStore().set(false, forKey: CustomUserDefaultsKey.isFirstLaunch.rawValue)
            NSUbiquitousKeyValueStore().synchronize()
        } else {
            // Fallback on earlier versions
            print("DEBUGLOG: Platform not support NSUbiquitousKeyValueStore")
        }
    }
    
    private func fetchSetting() {
        do {
            let settingRequest: NSFetchRequest<SettingEntity> = SettingEntity.fetchRequest()
            setting = try viewContext.fetch(settingRequest).first
        } catch {
            NSLog("Handle fetchSetting() error!")
        }
    }
    
    private func initSetting() {
        _ = SettingEntity(context: viewContext)
        
        do {
            try viewContext.save()
        } catch {
            NSLog("Error initilizing Setting")
        }
    }
    
    private func initDefaultCategories() {
        for category in DefaultValues.categories {
            let newCategory = CategoryEntity(context: viewContext)
            newCategory.name = category.0
            newCategory.icon = category.1
        }
        
        do {
            try viewContext.save()
        } catch {
            // Replace this implementation with code to handle the error appropriately.
            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }

}
