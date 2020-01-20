//
//  ContentView.swift
//  SwiftUIAsyncAlerts
//
//  Created by Paul Addy on 2020-01-15.
//  Copyright © 2020 Paul Addy. All rights reserved.
//

import SwiftUI

struct ContentView: View {

    @State private var showAlert = false
    @State private var alertTitle = ""
    @State private var alertMessage = ""

    var alert: Alert {
        Alert(title: Text("\(alertTitle)"),
              message: Text("\(alertMessage)"),
              dismissButton: .default(Text("OK")))
    }

    var body: some View {

        AsyncOperationButton(result: $showAlert,
                            resultTitle: $alertTitle,
                            resultMessage: $alertMessage)

        .alert(isPresented: $showAlert,
               content: { self.alert })
    }
}
