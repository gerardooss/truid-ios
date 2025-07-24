//
//  CelularModalView.swift
//  Sample
//
//  Created by Hendrik Nicolas Carlo on 24/07/25.
//  Copyright © 2025 Eric. All rights reserved.
//

import SwiftUI

struct CelularModalView: View {
    // Environment property to dismiss the sheet
    @Environment(\.dismiss) var dismiss
    
    // Properties to receive data from the parent view
    let phoneNumber: String
    let onContinue: () -> Void
    
    var body: some View {
        VStack (spacing: 20){
            Image("SNA_CellData")
                .resizable()
                .scaledToFit()
                .frame(width: 200, height: 180)
                .foregroundColor(Color("AppPrimaryColor"))
            
            VStack (alignment: .leading, spacing: 15) {
                Text("Kami akan memverifikasi nomor kamu melalui operator jaringan seluler.")
                    .font(.system(size: 18, weight: .semibold))
                    .multilineTextAlignment(.leading)

                Text("Pastikan:")
                    .font(.system(size: 15, weight: .semibold))
                
                VStack(alignment: .leading, spacing: 5) {
                    BulletPointView(text: "Data seluler dalam keadaan aktif.")
                    BulletPointView(text: "SIM dengan nomor \(phoneNumber) dipilih untuk data seluler di pengaturan.")
                }
            }
            
            Button(action: {
                // First, dismiss the sheet
                dismiss()
                // Then, execute the action passed from ContentView
                onContinue()
            }) {
                Text("Lanjut")
                    .font(.system(size: 16, weight: .bold))
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .frame(height: 56)
                    .background(Color("AppPrimaryColor", bundle: nil))
                    .cornerRadius(10)
            }
        }
        .padding(.all, 25)
    }
}

#Preview {
    // Example for previewing the modal
    CelularModalView(
        phoneNumber: "0878 345 6788",
        onContinue: {
            print("Continue button tapped in preview.")
        }
    )
}
