//
//  Failing.swift
//  
//
//  Created by doxuto on 20/03/2023.
//

import ComposableArchitecture
import Foundation

extension CoreBluetoothManager {
  public var failing: Self {
    Self {
      XCTFail("A failing endpoint was accessed: 'CoreBluetoothManager.delegate'")
      return .none
    } authorization: {
      XCTFail("A failing endpoint was accessed: 'CoreBluetoothManager.authorization'")
      return .allowedAlways
    } connect: { _, _ in
      XCTFail("A failing endpoint was accessed: 'CoreBluetoothManager.connect'")
      return .none
    } cancelPeripheralConnection: { _ in
      XCTFail("A failing endpoint was accessed: 'CoreBluetoothManager.cancelPeripheralConnection'")
      return .none
    } retrieveConnectedPeripherals: { _ in
      XCTFail("A failing endpoint was accessed: 'CoreBluetoothManager.retrieveConnectedPeripherals'")
      return .init()
    } retrievePeripherals: { _ in
      XCTFail("A failing endpoint was accessed: 'CoreBluetoothManager.retrievePeripherals'")
      return .init()
    } scanForPeripherals: { _, _  in
      XCTFail("A failing endpoint was accessed: 'CoreBluetoothManager.scanForPeripherals'")
      return .none
    } stopScan: {
      XCTFail("A failing endpoint was accessed: 'CoreBluetoothManager.stopScan'")
      return .none
    } isScanning: {
      XCTFail("A failing endpoint was accessed: 'CoreBluetoothManager.isScanning'")
      return false
    } supports: { _ in
      XCTFail("A failing endpoint was accessed: 'CoreBluetoothManager.supports'")
      return false
    } add: { _ in
      XCTFail("A failing endpoint was accessed: 'CoreBluetoothManager.add'")
      return .none
    } remove: { _ in
      XCTFail("A failing endpoint was accessed: 'CoreBluetoothManager.remove'")
      return .none
    } removeAllServices: {
      XCTFail("A failing endpoint was accessed: 'CoreBluetoothManager.removeAllServices'")
      return .none
    } startAdvertising: { _ in
      XCTFail("A failing endpoint was accessed: 'CoreBluetoothManager.startAdvertising'")
      return .none
    } stopAdvertising: {
      XCTFail("A failing endpoint was accessed: 'CoreBluetoothManager.stopAdvertising'")
      return .none
    } isAdvertising: {
      XCTFail("A failing endpoint was accessed: 'CoreBluetoothManager.isAdvertising'")
      return false
    } updateValue: { _, _, _ in
      XCTFail("A failing endpoint was accessed: 'CoreBluetoothManager.updateValue'")
      return false
    } respond: { _, _ in
      XCTFail("A failing endpoint was accessed: 'CoreBluetoothManager.respond'")
      return .none
    } setDesiredConnectionLatency: { _, _ in
      XCTFail("A failing endpoint was accessed: 'CoreBluetoothManager.setDesiredConnectionLatency'")
      return .none
    } publishL2CAPChannel: { _ in
      XCTFail("A failing endpoint was accessed: 'CoreBluetoothManager.publishL2CAPChannel'")
      return .none
    } unpublishL2CAPChannel: { _ in
      XCTFail("A failing endpoint was accessed: 'CoreBluetoothManager.unpublishL2CAPChannel'")
      return .none
    }
  }
}
