//
//  HapticHelper.swift
//  BinaryBoardPuzzle
//
//  Created by Harry Pantaleon on 4/2/23.
//

import Foundation
import CoreHaptics




func myHapticPrepareHaptics() -> CHHapticEngine? {
    guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else { return nil }

    var engine: CHHapticEngine?
    
    do {
        engine = try CHHapticEngine()
        try engine?.start()
    } catch {
        print("There was an error creating the engine: \(error.localizedDescription)")
    }
    return engine
}


func myHaptic(engine: CHHapticEngine?, style: MyHapticStyle) {
    // make sure that the device supports haptics
    guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else { return }
    var events = [CHHapticEvent]()
    
    if style == .common {
        // CommontTap
        let intensity = CHHapticEventParameter(parameterID: .hapticIntensity, value: 1)
        let sharpness = CHHapticEventParameter(parameterID: .hapticSharpness, value: 1)
        let event = CHHapticEvent(eventType: .hapticTransient, parameters: [intensity, sharpness], relativeTime: 0)
        events.append(event)
    } else if style == .wrong {
        // ErrorStyle Haptic
        for i in stride(from: 0, to: 0.3, by: 0.075) {
            let intensity = CHHapticEventParameter(parameterID: .hapticIntensity, value: Float(1))
            let sharpness = CHHapticEventParameter(parameterID: .hapticSharpness, value: Float(1))
            let event = CHHapticEvent(eventType: .hapticTransient, parameters: [intensity, sharpness], relativeTime: i)
            events.append(event)
        }
    }
    
    // convert those events into a pattern and play it immediately
    do {
        let pattern = try CHHapticPattern(events: events, parameters: [])
        let player = try engine?.makePlayer(with: pattern)
        try player?.start(atTime: 0)
    } catch {
        print("Failed to play pattern: \(error.localizedDescription).")
    }
}

enum MyHapticStyle {
    case common, wrong
}
