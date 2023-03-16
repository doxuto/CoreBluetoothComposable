# CoreBluetoothComposable

Core Bluetooth Composable is library that bridges the Composable Architecture and Core Bluetooth.



## Basic Usage

To use ComposableCoreLocation in your application, you can add an action to your domain that represents all of the actions the manager can emit via the `CBCentralManagerDelegate` and `CBPeripheralManagerDelegate` methods:

```swift
import CoreBluetoothComposable

enum AppAction {
  case coreBluetoothManager(CoreBluetoothManager.Action)

  // Your domain's other actions:
  ...
}
```


```swift
struct AppEnvironment {
  var coreBluetoothManager: CoreBluetoothManager

  // Your domain's other dependencies:
  ...
}
```

```swift
let appReducer = Reducer<AppState, AppAction, AppEnvironment> {
  state, action, environment in

  switch action {
  case .onAppear:
    return .merge(
      environment.coreBluetoothManager
        .delegate()
        .map(AppAction.coreBluetoothManager),

      environment.locationManager
        .startAdvertising([CBAdvertisementDataLocalNameKey : "CoreBluetoothApp", CBAdvertisementDataServiceUUIDsKey : [service]])
        .fireAndForget()
    )

  ...
  }
}
```
