//
//  FoozleApp.swift
//  Foozle
//
//  Created by Mike Conner on 5/25/21.
//

import SwiftUI

@main
struct FoozleApp: App {
    
    let coreDataManager = CoreDataManager.shared
    @Environment(\.scenePhase) var scenePhase
    
    var body: some Scene {
        WindowGroup {
            FoozleTabView(tabIndex: 1)
                .environment(\.managedObjectContext, coreDataManager.container.viewContext)
                .preferredColorScheme(.light)
        }
        .onChange(of: scenePhase) { _ in
            coreDataManager.save()
        }
    }
}
