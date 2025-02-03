//
//  DataManager.swift
//  PitLap
//
//  Created by Tinashe MAKUTI on 18/01/2025.
//

import Foundation
import SwiftData

public final class PersistenceDataManager<T: PersistentModel> {
    private let modelContainer: ModelContainer?
    private let modelContext: ModelContext?
    
    @MainActor
    public static func shared() -> PersistenceDataManager<T> {
        PersistenceDataManager<T>()
    }
    
    @MainActor
    init() {
        do {
            self.modelContainer = try ModelContainer(for: T.self, configurations: ModelConfiguration())
            self.modelContext = modelContainer?.mainContext
        } catch {
            print("Failed to initialize ModelContainer: \(error)")
            self.modelContainer = nil
            self.modelContext = nil
        }
    }
    
    public func loadAll() -> [T] {
        guard let context = modelContext else {
            print("ModelContext is not available")
            return []
        }
        
        do {
            let descriptor = FetchDescriptor<T>()
            let items = try context.fetch(descriptor)
            return items
        } catch {
            print("Failed to fetch items: \(error.localizedDescription)")
            return []
        }
    }
    
    public func fetchItems(
        predicate: Predicate<T>? = nil,
        sortDescriptors: [SortDescriptor<T>] = []
    ) -> [T] {
        var fetchDescriptor = FetchDescriptor<T>()
        fetchDescriptor.predicate = predicate
        fetchDescriptor.sortBy = sortDescriptors
        
        do {
            let items = try modelContext?.fetch(fetchDescriptor)
            return items ?? []
        } catch {
            print("Failed to fetch items: \(error)")
            return []
        }
    }
    
    public func fetchItem(
        predicate: Predicate<T>? = nil,
        sortDescriptors: [SortDescriptor<T>] = []
    ) -> T? {
        var fetchDescriptor = FetchDescriptor<T>()
        fetchDescriptor.predicate = predicate
        fetchDescriptor.sortBy = sortDescriptors
        
        do {
            let items = try modelContext?.fetch(fetchDescriptor)
            return items?.first
        } catch {
            print("Failed to fetch items: \(error)")
            return nil
        }
    }
    
    public func saveItem(_ item: T, completion: ( (Bool) -> Void)? = nil) {
        do {
            if let modelContext = modelContext {
                modelContext.insert(item)
                try modelContext.save()
            }
            completion?(true)
        } catch {
            completion?(false)
            print("Failed to insert race weekend: \(error.localizedDescription)")
        }
    }
    
    public func saveItems(_ items: [T], completion: @escaping (Bool) -> Void) {
        for item in items {
            saveItem(item, completion: completion)
        }
    }
    
    public func deleteItem(_ item: T, completion: @escaping (Bool) -> Void) async {
        if let modelContext = modelContext {
            modelContext.delete(item)
            do {
                try modelContext.save()
                completion(true)
            } catch {
                completion(false)
                print("Failed to delete item: \(error.localizedDescription)")
                
            }
        }
    }
    
    public func saveIfNotExist(_ item: T, predicate: Predicate<T>? = nil) {
        if modelContext != nil {
            if fetchItem(predicate: predicate) == nil {
                saveItem(item)
            }
        }
    }
}
