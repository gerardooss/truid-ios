//
//  ResultView.swift
//  Sample
//
//  Created by Hendrik Nicolas Carlo on 21/07/25.
//  Copyright © 2025 Eric. All rights reserved.
//

import SwiftUI

struct ResultView: View {
    let isSuccess: Bool
    
    var body: some View {
        VStack(spacing:20){
            Image(isSuccess ? "SNA_Success": "SNA_Failed")
                .resizable()
                .frame(width: 158, height: 179)
                .scaledToFit()
            
            VStack (spacing: 10){
                Text(isSuccess ? "Nomor HP berhasil terverifikasi!" : "Verifikasi tidak berhasil")
                    .font(.system(size: 20, weight: .bold, design: .default))
                Text(isSuccess ? "Sekarang, lanjut ke verifikasi data diri (KYC)." : "Butuh bantuan? Hubungi call center untuk verifikasi dan atur ulang kata sandi.")
                    .font(.system(size: 16, weight: .regular, design: .default))
                    .multilineTextAlignment(.center)
                
            }.padding(.horizontal, 30)
        }
    }
}
