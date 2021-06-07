//
//  FoozleAlert.swift
//  Foozle
//
//  Created by Mike Conner on 5/25/21.
//

import SwiftUI

struct AlertItem: Identifiable {
    
    let id = UUID()
    let title: Text
    let message: Text
    let dismissButton: Alert.Button
    
} // End of struct

struct AlertContext {
    
    //MARK: - ALERTS
    static let invalidData = AlertItem(title: Text("Hmmm..."),
                                                message: Text("We're sorry but the data received from the server was invalid. Please contact the developer with the request details to investigate why this occurred."),
                                                dismissButton: .default(Text("OK")))
    
    static let invalidResponse = AlertItem(title: Text("Something isn't right..."),
                                                message: Text("We were unable to connect to the RAWG database at this time. Please try again later."),
                                                dismissButton: .default(Text("OK")))
    static let invalidURL = AlertItem(title: Text("That's not good..."),
                                                message: Text("We were unable to make your request. Please try again later."),
                                                dismissButton: .default(Text("OK")))
    
    static let unableToComplete = AlertItem(title: Text("That's strange..."),
                                                message: Text("We were unable to complete your request. Please check your wireless connectivity and try again."),
                                                dismissButton: .default(Text("OK")))
    
    static let noResultsFromSearch = AlertItem(title: Text("Bummer..."),
                                                     message: Text("There were no results for your search parameters. Please make some changes and try again."),
                                                     dismissButton: .default(Text("OK")))
    
    static let errorLoadingPersistentStore = AlertItem(title: Text("This isn't good..."),
                                                       message: Text("There was an issue loading the persistent stores, close and reopen the app."),
                                                       dismissButton: .default(Text("OK")))
    
    static let unableToSaveContext = AlertItem(title: Text("Please forgive me..."),
                                                       message: Text("We were unable to save your data, please try again."),
                                                       dismissButton: .default(Text("OK")))
    
} // End of struct

