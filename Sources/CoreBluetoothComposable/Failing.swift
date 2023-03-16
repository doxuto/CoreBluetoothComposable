//
//  Failing.swift
//  
//
//  Created by doxuto on 20/03/2023.
//

import ComposableArchitecture
import Foundation
import XCTestDynamicOverlay

extension CoreBluetoothManager {
  public var failing: Self {
    Self {
      XCTFail("A failing endpoint was accessed: 'CoreBluetoothManager.delegate'")
    } authorization: {
      XCTFail("A failing endpoint was accessed: 'CoreBluetoothManager.authorization'")
    } connect: { _, _ in
      XCTFail("A failing endpoint was accessed: 'CoreBluetoothManager.connect'")
    } cancelPeripheralConnection: { _ in
      XCTFail("A failing endpoint was accessed: 'CoreBluetoothManager.cancelPeripheralConnection'")
    } retrieveConnectedPeripherals: { _ in
      XCTFail("A failing endpoint was accessed: 'CoreBluetoothManager.retrieveConnectedPeripherals'")
    } retrievePeripherals: { _ in
      XCTFail("A failing endpoint was accessed: 'CoreBluetoothManager.retrievePeripherals'")
    } scanForPeripherals: { _, _  in
      XCTFail("A failing endpoint was accessed: 'CoreBluetoothManager.scanForPeripherals'")
    } stopScan: {
      XCTFail("A failing endpoint was accessed: 'CoreBluetoothManager.stopScan'")
    } isScanning: {
      XCTFail("A failing endpoint was accessed: 'CoreBluetoothManager.isScanning'")
    } supports: { _ in
      XCTFail("A failing endpoint was accessed: 'CoreBluetoothManager.supports'")
    } add: { _ in
      XCTFail("A failing endpoint was accessed: 'CoreBluetoothManager.add'")
    } remove: { _ in
      XCTFail("A failing endpoint was accessed: 'CoreBluetoothManager.remove'")
    } removeAllServices: {
      XCTFail("A failing endpoint was accessed: 'CoreBluetoothManager.removeAllServices'")
    } startAdvertising: { _ in
      XCTFail("A failing endpoint was accessed: 'CoreBluetoothManager.startAdvertising'")
    } stopAdvertising: {
      XCTFail("A failing endpoint was accessed: 'CoreBluetoothManager.stopAdvertising'")
    } isAdvertising: {
      XCTFail("A failing endpoint was accessed: 'CoreBluetoothManager.isAdvertising'")
    } updateValue: { _, _, _ in
      XCTFail("A failing endpoint was accessed: 'CoreBluetoothManager.updateValue'")
    } respond: { _, _ in
      XCTFail("A failing endpoint was accessed: 'CoreBluetoothManager.respond'")
    } setDesiredConnectionLatency: { _, _ in
      XCTFail("A failing endpoint was accessed: 'CoreBluetoothManager.setDesiredConnectionLatency'")
    } publishL2CAPChannel: { _ in
      XCTFail("A failing endpoint was accessed: 'CoreBluetoothManager.publishL2CAPChannel'")
    } unpublishL2CAPChannel: { _ in
      XCTFail("A failing endpoint was accessed: 'CoreBluetoothManager.unpublishL2CAPChannel'")
    }
  }
}
