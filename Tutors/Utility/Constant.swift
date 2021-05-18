//
//  Constant.swift
//  Tutors
//
//  Created by Alan on 18.5.2021.
//

import Foundation
import SwiftUI


// color
let colorBackground: Color = Color("ColorBackground")
let colorGray: Color = Color(UIColor.systemGray4)

// layout
let radius: CGFloat = 8
let columnSpacing: CGFloat = 8
let rowSpacing: CGFloat = 8
var gridLayout: [GridItem] {
    return Array(repeating: GridItem(.flexible(), spacing: rowSpacing), count: 2)
}




