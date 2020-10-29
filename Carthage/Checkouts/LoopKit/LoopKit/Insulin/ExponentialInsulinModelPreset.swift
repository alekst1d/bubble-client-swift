//
//  ExponentialInsulinModelPreset.swift
//  Loop
//
//  Copyright © 2017 LoopKit Authors. All rights reserved.
//

public enum ExponentialInsulinModelPreset: String, Codable {
    case humalogNovologAdult
    case humalogNovologChild
    case fiasp
}


// MARK: - Model generation
extension ExponentialInsulinModelPreset {
    public var actionDuration: TimeInterval {
        switch self {
        case .humalogNovologAdult:
            return .minutes(360)
        case .humalogNovologChild:
            return .minutes(360)
        case .fiasp:
            return .minutes(360)
        }
    }

    public var peakActivity: TimeInterval {
        switch self {
        case .humalogNovologAdult:
            return .minutes(75)
        case .humalogNovologChild:
            return .minutes(65)
        case .fiasp:
            return .minutes(55)
        }
    }

    var model: InsulinModel {
        return ExponentialInsulinModel(actionDuration: actionDuration, peakActivityTime: peakActivity)
    }
}


extension ExponentialInsulinModelPreset: InsulinModel {
    public var effectDuration: TimeInterval {
        return model.effectDuration
    }
    
    public var delay: TimeInterval {
        return model.delay
    }

    public func percentEffectRemaining(at time: TimeInterval) -> Double {
        return model.percentEffectRemaining(at: time)
    }
}


extension ExponentialInsulinModelPreset: CustomDebugStringConvertible {
    public var debugDescription: String {
        return "\(self.rawValue)(\(String(reflecting: model))"
    }
}
