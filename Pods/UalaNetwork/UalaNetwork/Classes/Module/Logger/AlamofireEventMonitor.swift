//
//  AlamofireEventMonitor.swift
//  UalaNetwork
//
//  Created by Luis Perez on 29/03/22.
//

import Alamofire

final class AlamofireEventLogger: EventMonitor {
    
    let queue = DispatchQueue(label: "com.ua.la.networklogger")
    
    func requestDidResume(_ request: Request) {
        let body = request.request.flatMap { $0.httpBody.map { String(decoding: $0, as: UTF8.self) } } ?? "None"
        let message = """
        ⚡️ Request Started: \(request)
        ⚡️ Body Data: \(body)
        """
        NSLog(message)
    }
    
    func request<Value>(_ request: DataRequest, didParseResponse response: DataResponse<Value, AFError>) {
        NSLog("⚡️ Response Received: \(response.debugDescription)")
    }
}
