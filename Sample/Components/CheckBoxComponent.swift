//
//  CheckBoxComponent.swift
//  Sample
//
//  Created by Hendrik Nicolas Carlo on 21/07/25.
//  Copyright © 2025 Eric. All rights reserved.
//

import SwiftUI

struct CheckBoxComponent: View {
    @Binding var isSelected: Bool
    var body: some View {
        Button( action: {
            isSelected.toggle()
        }
        ){
        if isSelected {
            Image(systemName: "checkmark.square.fill")
                .resizable()
                .frame(width: 20, height: 20)
                .scaledToFit()
                .foregroundColor(Color("AppPrimaryColor"))
        } else {
            Image(systemName: "square")
                .resizable()
                .frame(width: 20, height: 20)
                .scaledToFit()
                .foregroundColor(Color("AppSecondaryColor"))
        }}
    }
}
