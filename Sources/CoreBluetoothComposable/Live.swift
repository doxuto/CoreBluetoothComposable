//
//  Live.swift
//  
//
//  Created by doxuto on 20/03/2023.
//

import Combine
import ComposableArchitecture
import CoreBluetooth
import Foundation

extension CoreBluetoothManager {
  public static var live: Self {
    let centralManager = CBCentralManager()
    let peripheralManager = CBPeripheralManager()

    let delegate = EffectTask<Action>.run { subscriber in
      let delegate = CoreBluetoothDelegate(subscriber: subscriber)
      centralManager.delegate = delegate
      peripheralManager.delegate = delegate

      return AnyCancellable {
        _ = delegate
      }
    }
      .share()
      .eraseToEffect()

    return Self {
      delegate
    } authorization: {
      if #available(iOS 13.1, *) {
        return CBCentralManager.authorization
      } else if #available(iOS 13.0, *) {
        return CBCentralManager().authorization
      }
    } connect: { peripheral, options in
        .fireAndForget {
          centralManager.connect(peripheral, options: options)
        }
    } cancelPeripheralConnection: { peripheral in
        .fireAndForget {
          centralManager.cancelPeripheralConnection(peripheral)
        }
    } retrieveConnectedPeripherals: { uuids in
      centralManager.retrieveConnectedPeripherals(withServices: uuids)
    } retrievePeripherals: { uuids in
      centralManager.retrievePeripherals(withIdentifiers: uuids)
    } scanForPeripherals: { uuids, options in
        .fireAndForget {
          centralManager.scanForPeripherals(withServices: uuids, options: options)
        }
    } stopScan: {
      .fireAndForget {
        centralManager.stopScan()
      }
    } isScanning: {
      centralManager.isScanning
    } supports: { feature in
      CBCentralManager.supports(feature)
    } add: { service in
        .fireAndForget {
          peripheralManager.add(service)
        }
    } remove: { service in
        .fireAndForget {
          peripheralManager.remove(service)
        }
    } removeAllServices: {
      .fireAndForget {
        peripheralManager.removeAllServices()
      }
    } startAdvertising: { advertisementData in
        .fireAndForget {
          peripheralManager.startAdvertising(advertisementData)
        }
    } stopAdvertising: {
      .fireAndForget {
        peripheralManager.stopAdvertising()
      }
    } isAdvertising: {
      peripheralManager.isAdvertising
    } updateValue: { value, characteristics, centrals in
      peripheralManager.updateValue(value, for: characteristics, onSubscribedCentrals: centrals)
    } respond: { request, code in
        .fireAndForget {
          peripheralManager.respond(to: request, withResult: code)
        }
    } setDesiredConnectionLatency: { latency, central in
        .fireAndForget {
          peripheralManager.setDesiredConnectionLatency(latency, for: central)
        }
    } publishL2CAPChannel: { encryptionRequired in
        .fireAndForget {
          peripheralManager.publishL2CAPChannel(withEncryption: encryptionRequired)
        }
    } unpublishL2CAPChannel: { PSM in
        .fireAndForget {
          peripheralManager.unpublishL2CAPChannel(PSM)
        }
    }
  }
}


private class CoreBluetoothDelegate: NSObject, CBCentralManagerDelegate, CBPeripheralManagerDelegate {

  let subscriber: EffectPublisher<CoreBluetoothManager.Action, Never>.Subscriber

  init(subscriber: EffectPublisher<CoreBluetoothManager.Action, Never>.Subscriber) {
    self.subscriber = subscriber
  }

  func centralManagerDidUpdateState(
    _ central: CBCentralManager
  ) {
    self.subscriber.send(.centralManagerDidUpdateState(central))
  }

  func centralManager(
    _ central: CBCentralManager,
    didConnect peripheral: CBPeripheral
  ) {
    self.subscriber.send(.centralManagerDidConnect(central, peripheral: peripheral))
  }

  func centralManager(
    _ central: CBCentralManager,
    didDisconnectPeripheral peripheral: CBPeripheral,
    error: Error?) {
      if let error {
        self.subscriber.send(.centralManagerDidDisconnectPeripheral(central, TaskResult.failure(error)))
      } else {
        self.subscriber.send(.centralManagerDidDisconnectPeripheral(central, .success(peripheral)))
      }
    }

  func centralManager(
    _ central: CBCentralManager,
    didFailToConnect peripheral: CBPeripheral,
    error: Error?
  ) {
    if let error {
      self.subscriber.send(.centralManagerDidFailToConnect(central, .failure(error)))
    } else {
      self.subscriber.send(.centralManagerDidFailToConnect(central, TaskResult.success(peripheral)))
    }
  }

  func centralManager(
    _ central: CBCentralManager,
    connectionEventDidOccur event: CBConnectionEvent,
    for peripheral: CBPeripheral
  ) {
    self.subscriber.send(.centralManagerConnectionEventDidOccur(central, event: event, peripheral: peripheral))
  }

  func centralManager(
    _ central: CBCentralManager,
    didDiscover peripheral: CBPeripheral,
    advertisementData: [String : Any],
    rssi RSSI: NSNumber
  ) {
    let advertisementData = advertisementData as? [String : AnyHashable]
    self.subscriber.send(.centralManagerDidDiscover(central, peripheral: peripheral, advertisementData: advertisementData ?? [:], rssi: RSSI))
  }

  func centralManager(
    _ central: CBCentralManager,
    willRestoreState dict: [String : Any]
  ) {
    let dict = dict as? [String : AnyHashable]
    self.subscriber.send(.centralManagerWillRestoreState(central, dict: dict ?? [:]))
  }

  func centralManager(
    _ central: CBCentralManager,
    didUpdateANCSAuthorizationFor peripheral: CBPeripheral
  ) {
    self.subscriber.send(.centralManagerDidUpdateANCSAuthorizationFor(central, peripheral: peripheral))
  }

  func peripheralManagerDidUpdateState(_ peripheral: CBPeripheralManager) {
    self.subscriber.send(.peripheralManagerDidUpdateState(peripheral))
  }

  func peripheralManager(
    _ peripheral: CBPeripheralManager,
    willRestoreState dict: [String : Any]
  ) {
    let dict = dict as? [String : AnyHashable]
    self.subscriber.send(.peripheralManagerWillRestoreState(peripheral, dict: dict ?? [:]))
  }

  func peripheralManager(
    _ peripheral: CBPeripheralManager,
    didAdd service: CBService,
    error: Error?
  ) {
    if let error {
      self.subscriber.send(.peripheralManagerDidAdd(peripheral, .failure(error)))
    } else {
      self.subscriber.send(.peripheralManagerDidAdd(peripheral, .success(service)))
    }
  }

  func peripheralManagerDidStartAdvertising(
    _ peripheral: CBPeripheralManager,
    error: Error?
  ) {
    if let error {
      self.subscriber.send(.peripheralManagerDidStartAdvertising(.failure(error)))
    } else {
      self.subscriber.send(.peripheralManagerDidStartAdvertising(.success(peripheral)))
    }
  }

  func peripheralManager(
    _ peripheral: CBPeripheralManager,
    central: CBCentral,
    didSubscribeTo characteristic: CBCharacteristic
  ) {
    self.subscriber.send(.peripheralManagerDidSubscribeTo(peripheral, central: central, characteristic: characteristic))
  }

  func peripheralManager(
    _ peripheral: CBPeripheralManager,
    central: CBCentral,
    didUnsubscribeFrom characteristic: CBCharacteristic
  ) {
    self.subscriber.send(.peripheralManagerDidUnsubscribeTo(peripheral, central: central, characteristic: characteristic))
  }

  func peripheralManagerIsReady(toUpdateSubscribers peripheral: CBPeripheralManager) {
    self.subscriber.send(.peripheralManagerIsReadyToUpdateSubscribers(peripheral))
  }

  func peripheralManager(
    _ peripheral: CBPeripheralManager,
    didReceiveRead request: CBATTRequest
  ) {
    self.subscriber.send(.peripheralManagerDidReceiveRead(peripheral, request: request))
  }

  func peripheralManager(
    _ peripheral: CBPeripheralManager,
    didReceiveWrite requests: [CBATTRequest]
  ) {
    self.subscriber.send(.peripheralManagerDidReceiveWrite(peripheral, requests: requests))
  }

  func peripheralManager(
    _ peripheral: CBPeripheralManager,
    didPublishL2CAPChannel PSM: CBL2CAPPSM,
    error: Error?
  ) {
    if let error {
      self.subscriber.send(.peripheralManagerDidPublishL2CAPChannel(peripheral, .failure(error)))
    } else {
      self.subscriber.send(.peripheralManagerDidPublishL2CAPChannel(peripheral, .success(PSM)))
    }
  }

  func peripheralManager(
    _ peripheral: CBPeripheralManager,
    didUnpublishL2CAPChannel PSM: CBL2CAPPSM,
    error: Error?
  ) {
    if let error {
      self.subscriber.send(.peripheralManagerDidUnpublishL2CAPChannel(peripheral, .failure(error)))
    } else {
      self.subscriber.send(.peripheralManagerDidUnpublishL2CAPChannel(peripheral, .success(PSM)))
    }
  }

  func peripheralManager(
    _ peripheral: CBPeripheralManager,
    didOpen channel: CBL2CAPChannel?,
    error: Error?
  ) {
    if let error {
      self.subscriber.send(.peripheralManagerDidOpen(peripheral, .failure(error)))
    } else {
      self.subscriber.send(.peripheralManagerDidOpen(peripheral, .success(channel)))
    }
  }

}

public func ==<K, L: Hashable, R: Hashable>(lhs: [K: L], rhs: [K: R] ) -> Bool {
  (lhs as NSDictionary).isEqual(to: rhs)
}
