//
//  AsyncOperationButton.swift
//  SwiftUIAsyncAlerts
//
//  Created by Paul Addy on 2020-01-15.
//  Copyright © 2020 Paul Addy. All rights reserved.
//

import SwiftUI

struct AsyncOperationButton: View {

    @Binding var result: Bool
    @Binding var resultTitle: String
    @Binding var resultMessage: String

    var body: some View {
        Button(action: {
            self.launchAsyncOperation()
        }){
            Text("Launch Async Operation")
                .foregroundColor(Color.white)
                .padding()
                .background(Color(UIColor.systemBlue))
        }.cornerRadius(4)
    }
}

extension AsyncOperationButton {

    func launchAsyncOperation() {

        asyncOperation { result, message in
            self.result = result
            self.resultTitle = "Success"
            self.resultMessage = message
        }
    }

    func asyncOperation(completion: @escaping(Bool, String) -> ()) {

        completion(true, "Async operation has completed")
    }
}
