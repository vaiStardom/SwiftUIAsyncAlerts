# SwiftUI and Async Alerts

Hello,

Using SwiftUI, I wanted to present the results of an async operation, similar to a network operation. I needed to do this via a SwiftUI `Alert` declared in a SwiftUI `View`. But, the async operation was performed outside the view.

I managed to piece together the solution by finding what I needed in the `Data Flow Through SwiftUI` WWDC presentation that you can find at the following link.

Link:
 https://developer.apple.com/videos/play/wwdc2019/226/


## Example Solution ##
Here's an example of how to present the results of an async operation, using a SwiftUI User Interface.

1. Create a new Swift UI project.
    1. Open Xcode 11 or above.
    2. Open the project creation window by pressing keys `command + shift + n`.
    3. Choose `Single View App` from the iOS templates.
    4. Click `Next`.
    5. Set the Product Name to anything you like, for example `SwiftUIAsyncAlerts`.
    6. Team, Organization Name, Organization Identifier, and Bundle Identifier default values should suffice.
    7. Set the Language field to `Swift`.
    8. Set the User Interface field to `SwiftUI`.
    9. Leave unchecked the remaining options.
    10. Click `Next`.
    11. Choose a location to save your project.
    12. Click `Create`.


2. Next, create an `AsyncOperationButton` that will be responsible for executing the async operation. We will later use this button in the default `ContentView` file.
    1. Open the Project Navigator by pressing keys `command + 1`.
    2. Select the top orange folder.
    3. Create a new file by pressing keys `command + n`.
    4. Select `Swift file`.
    5. Click `Next`.
    5. Name it `AsyncOperationButton`.
    6. Click `Create`.
    7. Copy-paste the following code in the file.

Note: The button is stylized blue, with rounded corder, and white text.

```
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
```

3. Next, use the `AsyncOperationButton` button in the default SwiftUI `ContentView` file.
    1. Open the Project Navigator by pressing keys `command + 1`.
    2. Click on `ContentView.swift`.
    3. Replace its entire contents with the following code.

```
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
```

That's it! You can now build and run the project by pressing keys `command + r`. After the simulator or device has launched the app, you should see a blue button in the middle. Press it to launch the async operation and view the result alert invoked by the async operation's result.

## Description of how this works ##
The magic happens between ContentView's property wrapper `@State`, and AsyncOperationButton  property wrapper `@Binding`.

Apple describes `@State` as "A persistent value of a given type, through which a view reads and monitors the value. [...] SwiftUI manages the storage of any property you declare as a state. When the state value changes, the view invalidates its appearance and recomputes the body. Use the state as the single source of truth for a given view."

Apple describes `@Binding` as "A manager for a value that provides a way to mutate it. [...] Use a binding to create a two-way connection between a view and its underlying model."

In the example above, the two-way connection is set when we use the $ prefix operator in order to bind the ContentView's state properties with the button's binding properties. We set the two-way communication by passing the ContentView's properties as parameters of the button:

```
AsyncOperationButton(result: $showAlert,
                    resultTitle: $alertTitle,
                    resultMessage: $alertMessage)
```

When the button changes the values of `result`, `resultTitle`, and `resultMessage`, the ContentView's properties react to these changes. For example, since `showAlert` is binded to `result`, the alert will present itself thanks to its property `isPresented`.

You can see the complete project here:
https://github.com/vaiStardom/AlertFromOutsideOfView/tree/develop

Hope this can help anybody.

Cheers!
