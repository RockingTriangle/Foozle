//
//  CoreDataManager.swift
//  Foozle
//
//  Created by Mike Conner on 5/25/21.
//

import SwiftUI
import CoreData

struct CoreDataManager {
    
    // MARK: - Properties
    static let shared = CoreDataManager()
    let container: NSPersistentContainer

    // MARK: - Initializer
    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "Foozle")
        if inMemory {
            container.persistentStoreDescriptions.first?.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores { description, error in
            if let error = error {
                
                print("Error in \(#function) : \(error.localizedDescription) \n---\n\(error)")
            }
        }
    }
    
    // MARK: - CRUD Functions
    func save() {
        let context = container.viewContext

        if context.hasChanges {
            do {
                try context.save()
            } catch {
                print("Error in \(#function) : \(error.localizedDescription) \n---\n\(error)")
            }
        }
    }
    
    func addGameToCollection(from viewModel: FoozleViewModel) {
        
        let newGame = CollectionGame(context: container.viewContext)
        
        newGame.uniqueID = UUID()
        newGame.name = viewModel.selectedGame?.name ?? "no name"
        newGame.slug = viewModel.selectedGame?.slug ?? "no-slug"
        newGame.backgroundImage = viewModel.selectedGame?.backgroundImage ?? "https://www.rockingtriangle.co/wp-content/uploads/2021/05/noImage.png"
        newGame.descripitionRaw = viewModel.additionalGameDetail?.descriptionRaw ?? "no description"
        newGame.developers = viewModel.additionalGameDetail?.displayDeveloperData() ?? "no developers"
        newGame.esrbRating = viewModel.selectedGame?.displayESRBData() ?? "no rating"
        newGame.genres = viewModel.selectedGame?.displayGenreData() ?? "no genres"
        newGame.platforms = viewModel.selectedGame?.displayPlatformData() ?? "no platforms"
        newGame.publishers = viewModel.additionalGameDetail?.displayPublisherData() ?? "no publishers"
        newGame.released = viewModel.selectedGame?.displayReleasedData() ?? "no release date"
        newGame.stores = viewModel.selectedGame?.displayStoreData() ?? "no stores"
        newGame.website = viewModel.additionalGameDetail?.website ?? "no website"
        
        do {
            try self.container.viewContext.save()
        } catch {
            print("Could not save to context\n-----------\n\(error.localizedDescription)\n-----------")
        }
        
        save()
    }
    
    func addGameToWishList(from viewModel: FoozleViewModel) {
        
        let newGame = WishListGame(context: container.viewContext)
        
        newGame.uniqueID = UUID()
        newGame.name = viewModel.selectedGame?.name ?? "no name"
        newGame.slug = viewModel.selectedGame?.slug ?? "noslug"
        newGame.backgroundImage = viewModel.selectedGame?.backgroundImage ?? "https://www.rockingtriangle.co/wp-content/uploads/2021/05/noImage.png"
        newGame.descripitionRaw = viewModel.additionalGameDetail?.descriptionRaw ?? "no description"
        newGame.developers = viewModel.additionalGameDetail?.displayDeveloperData() ?? "no developers"
        newGame.esrbRating = viewModel.selectedGame?.displayESRBData() ?? "no rating"
        newGame.genres = viewModel.selectedGame?.displayGenreData() ?? "no genres"
        newGame.platforms = viewModel.selectedGame?.displayPlatformData() ?? "no platforms"
        newGame.publishers = viewModel.additionalGameDetail?.displayPublisherData() ?? "no publishers"
        newGame.released = viewModel.selectedGame?.displayReleasedData() ?? "no release date"
        newGame.stores = viewModel.selectedGame?.displayStoreData() ?? "no stores"
        newGame.website = viewModel.additionalGameDetail?.website ?? "no website"
        
        do {
            try self.container.viewContext.save()
        } catch {
            print("Could not save to context\n-----------\n\(error.localizedDescription)\n-----------")
        }
        
        save()
    }
    
    func delete(game: GameResponse, from collection: FetchedResults<CollectionGame>) {
        
        for index in (0 ..< collection.count) {
            if collection[index].name == game.name {
                container.viewContext.delete(collection[index])
            }
        }
        
        do {
            try self.container.viewContext.save()
        } catch {
            print("Could not save to context\n-----------\n\(error.localizedDescription)\n-----------")
        }
        
        save()
    }
    
    func delete(game: GameResponse, from collection: FetchedResults<WishListGame>) {
        
        for index in (0 ..< collection.count) {
            if collection[index].name == game.name {
                container.viewContext.delete(collection[index])
            }
        }
        
        do {
            try self.container.viewContext.save()
        } catch {
            print("Could not save to context\n-----------\n\(error.localizedDescription)\n-----------")
        }
        
        save()
    }
    
}// End of struct
