//
//  DescriptionView.swift
//  Tutors
//
//  Created by Alan on 18.6.2021.
//

import SwiftUI

struct DescriptionView: View {
    var description: String = "Bacon ipsum dolor amet frankfurter pastrami drumstick tongue prosciutto doner sirloin ground round shank corned beef pork loin kevin."
    var body: some View {
        Text(description)
            .font(.footnote)
    }
}

struct DescriptionView_Previews: PreviewProvider {
    static var previews: some View {
        DescriptionView()
    }
}
