//
//  HelperFunctions.swift
//  Tutors
//
//  Created by Alan on 21.6.2021.
//

import Foundation

func formatDate(date: Date) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "dd MMMM, yyyy"
    
    return dateFormatter.string(from: date)
}

func formatTime(date: Date) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "HH:mm"
    
    return dateFormatter.string(from: date)
}
