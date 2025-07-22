//
//  ContentViewModel.swift
//  Sample
//
//  Created by Hendrik Nicolas Carlo on 21/07/25.
//  Copyright © 2025 Eric. All rights reserved.
//

// ContentViewModel.swift

import Foundation
import Combine
import TruSDK // Make sure to import this

@MainActor
final class ContentViewModel: ObservableObject {
    // MARK: - Published Properties for the UI
    @Published var phoneNumber: String = ""
    @Published var termsAccepted: Bool = false
    @Published var promotionsAccepted: Bool = false
    
    @Published var isLoading: Bool = false
    @Published var checkResult: Bool? = nil // nil=not run, true=success, false=fail
    
    // MARK: - Private Properties
    private let apiManager = APIManager()
    private let truSdk = TruSDK()
    
    // A computed property to enable/disable the 'Lanjut' button
    var isContinueButtonEnabled: Bool {
        // You can add phone number validation here if needed
        let phoneNumberTest = NSPredicate(format: "SELF MATCHES %@", "^[0-9+]{0,1}+[0-9]{5,16}$")
        return termsAccepted && phoneNumberTest.evaluate(with: phoneNumber)
    }
    
    // MARK: - Intentions
    func performPhoneCheck() {
        // Reset previous result and start loading
        checkResult = nil
        isLoading = true
        
        let cleanedPhoneNumber = phoneNumber.replacingOccurrences(of: "\\s*", with: "", options: [.regularExpression])
        print("phoneNumber \(cleanedPhoneNumber)")
        // Step 1: Post the check to your server
        apiManager.postCheck(withPhoneNumber: cleanedPhoneNumber) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let checkResponse):
                // Step 2: Open the check_url with the TruSDK
                self.openCheckURL(checkResponse)
            case .failure(_):
                // Handle API error
                self.isLoading = false
                self.checkResult = false
            }
        }
    }
    
    private func openCheckURL(_ check: APIManager.Check) {
        truSdk.checkUrlWithResponseBody(url: URL(string: check.url)!) { [weak self] _, _ in
            guard let self = self else { return }
            
            // Step 3: Get the final result from your server
            self.apiManager.getCheckStatus(withCheckId: check.id) { status in
                // Update state on the main thread
                DispatchQueue.main.async {
                    self.isLoading = false
                    self.checkResult = status.match
                }
            }
        }
    }
}
