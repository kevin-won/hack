//
//  Recipe.swift
//  A4
//
//  Created by Kevin Won on 4/19/24.
//

import Foundation

struct Task: Codable, Equatable {
    let title: String
    let category: String
    var isFinished: Bool = false 
    
    static var dummyData = [
        Task(title: "Do Laundry", category: "Household"),
        Task(title: "Do CS 4780 HW", category: "Education"),
        Task(title: "Grocery Shopping", category: "Errands"),
        Task(title: "Clean the Kitchen", category: "Household"),
        Task(title: "Schedule Doctor's Appointment", category: "Health"),
        Task(title: "Pay Electricity Bill", category: "Finance"),
        Task(title: "Complete Project Report", category: "Work"),
        Task(title: "Read Chapter 4 of Textbook", category: "Education"),
        Task(title: "Call Mom", category: "Personal"),
        Task(title: "Prepare Presentation Slides", category: "Work")
    ]
}

