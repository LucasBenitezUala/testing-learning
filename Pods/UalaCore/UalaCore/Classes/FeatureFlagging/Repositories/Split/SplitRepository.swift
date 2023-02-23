//
//  SplitRepository.swift
//  Uala
//
//  Created by Josefina Perez on 13/02/2020.
//  Copyright © 2020 Ualá. All rights reserved.
//

import Split
import PromiseKit

public enum SplitRepositoryStatus {
    case ready, timedOut, notInicialized
}

public enum TreatmentResponse: String {
    case on, off
    
    var asBool: Bool {
        
        switch self {
        case .on: return true
        case.off: return false
        }
    }
}

public class SplitRepository {
    
    public static let shared = SplitRepository()

    public var client: SplitClient?
    public var status: SplitRepositoryStatus = .notInicialized
    public var clientId: String?
}

extension SplitRepository: SplitRepositoryProtocol {
    public func initializeFor(user: String?) -> Promise<Void> {
        
        return Promise<Void> { seal in
            let uuid = UIDevice.current.identifierForVendor?.uuidString ?? ""
            
            let identifier = user ?? uuid
            
            guard identifier != clientId else { seal.fulfill_(); return }
            
            if status == .ready {
                finish()
            }
            
            clientId = identifier
            let configuration = SplitConfiguration()
            let userKey = Key(matchingKey: identifier)
            let factory = DefaultSplitFactoryBuilder().setApiKey(configuration.apiKey).setKey(userKey).setConfig(SplitClientConfig()).build()
            self.client = factory?.client
            
            client?.on(event: SplitEvent.sdkReady) { [weak self ] in
                self?.status = .ready
                seal.fulfill_()
            }
            
            client?.on(event: SplitEvent.sdkReadyTimedOut) { [weak self ] in
                self?.status = .timedOut
                seal.fulfill_()
            }
        }
    }
    
    /// Only use this initializer from demo
    /// - Parameters:
    ///   - user: `String` value
    ///   - scheme: `Scheme` object
    /// - Returns: `Void`
    public func demoInitializationFor(user: String?, scheme: Scheme) -> Promise<Void> {
        
        return Promise<Void> { seal in
            let uuid = UIDevice.current.identifierForVendor?.uuidString ?? ""
            
            let identifier = user ?? uuid
            
            guard identifier != clientId else { seal.fulfill_(); return }
            
            if status == .ready {
                finish()
            }
            
            clientId = identifier
            
            let configuration = SplitConfiguration()
            let userKey = Key(matchingKey: identifier)
            let factory = DefaultSplitFactoryBuilder().setApiKey(configuration.demoApiKey(from: scheme)).setKey(userKey).setConfig(SplitClientConfig()).build()
            self.client = factory?.client
            
            client?.on(event: SplitEvent.sdkReady) { [weak self ] in
                self?.status = .ready
                seal.fulfill_()
            }
            
            client?.on(event: SplitEvent.sdkReadyTimedOut) { [weak self ] in
                self?.status = .timedOut
                seal.fulfill_()
            }
        }
    }
    
    public func finish() {
        status = .notInicialized
        client?.destroy()
        clientId = nil
    }

    public func getTreatmentFor(_ feature: Feature) -> Promise<Bool> {
        getTreatmentFor(feature, attributes: nil)
    }

    public func getTreatmentFor(_ feature: Feature, attributes: [String: Any]?) -> Promise<Bool> {
        return Promise<Bool> { seal in
            guard let client = self.client else {
                seal.fulfill(false)
                return
            }

            let fullAttributtes = buildAttributes(attributes: attributes)
            let treatment = TreatmentResponse(rawValue: client.getTreatment(feature.rawValue, attributes: fullAttributtes))
            
            seal.fulfill(treatment?.asBool ?? false)
        }
    }

    public func getStringTreatmentFor(_ feature: Feature) -> Promise<String?> {
        return Promise<String?> { seal in
            guard let client = self.client else {
                seal.fulfill(nil)
                return
            }

            let treatment =  client.getTreatment(feature.rawValue, attributes: buildAttributes())
            
            seal.fulfill(treatment)
        }
    }

    public func getStringTreatmentFor(_ split: SplitFeatureType) -> String? {
        guard let client = self.client else {
            return nil
        }
        
        let treatment = client.getTreatment(split.id, attributes: buildAttributes())
        return treatment
    }

    public func getTreatmentsFor(_ features: [Feature]) -> Promise<[Feature: Bool]> {
        return Promise<[Feature: Bool]> { seal in
            guard let client = self.client else {
                seal.fulfill([:])
                return
            }

            var treatments: [Feature: Bool] = [:]
            for feature in features {
                let treatment = TreatmentResponse(rawValue: client.getTreatment(feature.rawValue, attributes: buildAttributes()))
                treatments[feature] = treatment?.asBool ?? false
            }

            seal.fulfill(treatments)
        }
    }

    public func getEnvironmentTreatmentFor(_ feature: Feature) -> Promise<Bool> {
        getTreatmentFor(feature)
    }

    public func getSplitTreatment(split: SplitFeatureType) -> Guarantee<Bool> {
        getSplitTreatment(split: split, attributes: nil)
    }

    public func getEnvironmentTreatmentFor(split: SplitFeatureType) -> Guarantee<Bool> {
        getSplitTreatment(split: split)
    }

    public func getSplitTreatment(split: SplitFeatureType, attributes: [String: Any]? = nil) -> Guarantee<Bool> {
        return Guarantee { guarantee in
            guard let client = self.client,
                  let treatment = TreatmentResponse(rawValue: client.getTreatment(split.id, attributes: buildAttributes(attributes: attributes)))
            else {
                guarantee(false)
                return
            }
            guarantee(treatment.asBool)
        }
    }

    public func getSplitTreatments(splits: [SplitFeatureType]) -> Guarantee<[SplitFeature: Bool]> {
        return Guarantee { guarantee in
            guard let client = self.client else {
                guarantee([:])
                return
            }
            
            let result = splits.reduce(into: [SplitFeature: Bool]()) { result, splitFeature in
                let treatment = TreatmentResponse(rawValue: client.getTreatment(splitFeature.id, attributes: buildAttributes()))
                result[SplitFeature(id: splitFeature.id)] = treatment?.asBool
            }
            guarantee(result)
        }
    }
}

extension SplitRepository {
    fileprivate func buildAttributes(attributes: [String: Any]? = nil) -> [String: Any] {
        guard let buildVersionNumber = Bundle.main.buildVersionNumber else { return [:] }
        let environment: Environment = CoreEnvironment.shared.environment
        var fullAttributtes: [String: Any] = ["environment": environment.name, "iosBuildNumber": Int(buildVersionNumber)]

        if let attributes = attributes {
            fullAttributtes.merging(attributes) { $1 }
        }

        return fullAttributtes
    }
}
