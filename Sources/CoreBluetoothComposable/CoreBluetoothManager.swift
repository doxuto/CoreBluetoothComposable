//
//  CoreBluetoothManager.swift
//  
//
//  Created by doxuto on 16/03/2023.
//

import Combine
import ComposableArchitecture
import CoreBluetooth
import Foundation

public struct CoreBluetoothManager: ReducerProtocol {

  public var delegate: () -> EffectTask<Action>

  // MARK: - CBCentralManager
  public var authorization: () -> CBManagerAuthorization
  public var connect: (CBPeripheral, [String : Any]) -> EffectTask<Never>
  public var cancelPeripheralConnection: (CBPeripheral) -> EffectTask<Never>
  public var retrieveConnectedPeripherals: ([CBUUID]) -> [CBPeripheral]
  public var retrievePeripherals: ([UUID]) -> [CBPeripheral]
  public var scanForPeripherals: ([CBUUID]?, [String : Any]?) -> EffectTask<Never>
  public var stopScan: () -> EffectTask<Never>
  public var isScanning: () -> Bool
  public var supports: (CBCentralManager.Feature) -> Bool
  public var registerForConnectionEvents: ([CBConnectionEventMatchingOption : Any]?)

  // MARK: - CBPeripheralManager
  public var add: (CBMutableService) -> EffectTask<Never>
  public var remove: (CBMutableService) -> EffectTask<Never>
  public var removeAllServices: () -> EffectTask<Never>
  public var startAdvertising: ([String : Any]?) -> EffectTask<Never>
  public var stopAdvertising: () -> EffectTask<Never>
  public var isAdvertising: () -> Bool
  public var updateValue: (Data, CBMutableCharacteristic, [CBCentral]?) -> Bool
  public var respond: (CBATTRequest, CBATTError.Code) -> EffectTask<Never>
  public var setDesiredConnectionLatency: (CBPeripheralManagerConnectionLatency, CBCentral) -> EffectTask<Never>
  public var publishL2CAPChannel: (Bool) -> EffectTask<Never>
  public var unpublishL2CAPChannel: (CBL2CAPPSM) -> EffectTask<Never>

  public enum Action: Equatable {
    case centralManagerDidUpdateState(_ central: CBCentralManager)
    case centralManagerDidDisconnectPeripheral(_ central: CBCentralManager, TaskResult<CBPeripheral>)
    case centralManagerDidConnect(_ central: CBCentralManager, peripheral: CBPeripheral)
    case centralManagerDidFailToConnect(_ central: CBCentralManager, TaskResult<CBPeripheral>)
    case centralManagerConnectionEventDidOccur(
      _ central: CBCentralManager, event: CBConnectionEvent, peripheral: CBPeripheral)
    case centralManagerDidDiscover(
      _ central: CBCentralManager, peripheral: CBPeripheral,
      advertisementData: [String: AnyHashable], rssi: NSNumber)
    case centralManagerWillRestoreState(
      _ central: CBCentralManager, dict: [String : AnyHashable])
    case centralManagerDidUpdateANCSAuthorizationFor(
      _ central: CBCentralManager, peripheral: CBPeripheral)

    case peripheralManagerDidUpdateState(_ peripheral: CBPeripheralManager)
    case peripheralManagerWillRestoreState(_ peripheral: CBPeripheralManager,  dict: [String : AnyHashable])
    case peripheralManagerDidAdd(_ peripheral: CBPeripheralManager, TaskResult<CBService>)
    case peripheralManagerDidStartAdvertising(TaskResult<CBPeripheralManager>)
    case peripheralManagerDidSubscribeTo(_ peripheral: CBPeripheralManager, central: CBCentral, characteristic: CBCharacteristic)
    case peripheralManagerDidUnsubscribeTo(_ peripheral: CBPeripheralManager, central: CBCentral, characteristic: CBCharacteristic)
    case peripheralManagerIsReadyToUpdateSubscribers(_ peripheral: CBPeripheralManager)
    case peripheralManagerDidReceiveRead(_ peripheral: CBPeripheralManager, request: CBATTRequest)
    case peripheralManagerDidReceiveWrite(_ peripheral: CBPeripheralManager, requests: [CBATTRequest])
    case peripheralManagerDidPublishL2CAPChannel(_ peripheral: CBPeripheralManager, TaskResult<CBL2CAPPSM>)
    case peripheralManagerDidUnpublishL2CAPChannel(_ peripheral: CBPeripheralManager, TaskResult<CBL2CAPPSM>)
    case peripheralManagerDidOpen(_ peripheral: CBPeripheralManager, TaskResult<CBL2CAPChannel?>)
  }

  public func reduce(into state: inout Void, action: Action) -> EffectTask<Action> {
    return .none
  }
}
