//
//  FeatureFlaggingManager.swift
//  Uala
//
//  Created by Josefina Perez on 17/02/2020.
//  Copyright © 2020 Ualá. All rights reserved.
//

import Foundation
import PromiseKit

public protocol SplitRepositoryProtocol {
    func initializeFor(user: String?) -> Promise<Void>
    func finish()
    
    @available(*, deprecated, message: "Use getSplitTreatment() instead")
    func getTreatmentFor(_ split: Feature) -> Promise<Bool>
    
    @available(*, deprecated, message: "Use getSplitTreatment() instead")
    func getTreatmentFor(_ split: Feature, attributes: [String: Any]?) -> Promise<Bool>
    
    @available(*, deprecated, message: "Use getSplitTreatments() instead")
    func getTreatmentsFor(_ split: [Feature]) -> Promise<[Feature: Bool]>
    
    @available(*, deprecated, message: "Post process of the result should be handled by the object calling the function, do not use this")
    func getStringTreatmentFor(_ feature: Feature) -> Promise<String?>
    
    func getStringTreatmentFor(_ split: SplitFeatureType) -> String?
    func getSplitTreatment(split: SplitFeatureType) -> Guarantee<Bool>
    func getSplitTreatment(split: SplitFeatureType, attributes: [String: Any]?) -> Guarantee<Bool>
    func getSplitTreatments(splits: [SplitFeatureType]) -> Guarantee<[SplitFeature: Bool]>
}

public class FeatureFlaggingManager {
    
    public static let shared = FeatureFlaggingManager()
    
    var repository: SplitRepositoryProtocol = SplitRepository.shared
    
    var flags: [Feature: Bool] = [:]
    
    public func getFlagsFor(user: String) -> Promise<Void> {
        
        return Promise<Void> { seal in
            firstly {
                repository.initializeFor(user: user)
            }.then {
                self.getTreatments()
            }.done {
                seal.fulfill_()
            }.catch { error in
                seal.reject(error)
            }
        }
    }
    
    public func featureEnabled(_ feature: Feature) -> Bool {
        return flags[feature] ?? false
    }
    
    public func finish() {
        repository.finish()
    }
    
    private var index = 0
    private func getTreatments() -> Promise<Void> {
    
        let features: [Feature] = Feature.allCases
        
        return Promise<Void> { seal in
            
            repository.getTreatmentsFor(features).done { treatments in
                
                self.flags = treatments
                seal.fulfill_()
            }.catch { error in
                seal.reject(error)
            }
        }
    }
}
