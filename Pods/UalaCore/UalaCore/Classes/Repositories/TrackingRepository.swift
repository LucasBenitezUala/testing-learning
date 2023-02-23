//
//  TrackingRepository.swift
//  UalaCore
//
//  Created by Mario A. Barragan on 26/01/22.
//

import PromiseKit

protocol TrackingRepositoryProtocol {
    func getdataTracking() -> Promise<Data>
}

public class TrackingRepository: BaseRepository, TrackingRepositoryProtocol {
    public func getdataTracking() -> Promise<Data> {
        let router: TrackingRouter = TrackingRouter()
        
        return requestAuth(router)
    }
}

protocol TrackingNumberRepositoryProtocol {
    func getTrackingNumber() -> Promise<String?>
}

public class TrackingNumberRepository: BaseRepository, TrackingNumberRepositoryProtocol {    
    public func getTrackingNumber() -> Promise<String?> {
        let router: TrackingNumberRouter = TrackingNumberRouter()
        
        return requestAuth(router)
    }
}
