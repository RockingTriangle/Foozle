//
//  FoozleAlert.swift
//  Foozle
//
//  Created by Mike Conner on 5/25/21.
//

import SwiftUI

struct FoozleAlertItem: Identifiable {
    let id = UUID()
    let title: Text
    let message: Text
    let dismissButton: Alert.Button

} // End of struct

struct FoozleAlertContext {
    
    //MARK: - NETWORK ALERTS
    static let invalidData = FoozleAlertItem(title: Text("Server Error"),
                                                message: Text("The data received from the server was invalid. Please contact support."),
                                                dismissButton: .default(Text("OK")))
    
    static let invalidResponse = FoozleAlertItem(title: Text("Server Error"),
                                                message: Text("Invalid response from server. Please try again later or contact support."),
                                                dismissButton: .default(Text("OK")))
    static let invalidURL = FoozleAlertItem(title: Text("Server Error"),
                                                message: Text("There was an issue connecting to the server. If this persists, please contact support."),
                                                dismissButton: .default(Text("OK")))
    
    static let unableToComplete = FoozleAlertItem(title: Text("Server Error"),
                                                message: Text("Unable to complete your request at this time. Please check your internet connection."),
                                                dismissButton: .default(Text("OK")))
    
} // End of struct

