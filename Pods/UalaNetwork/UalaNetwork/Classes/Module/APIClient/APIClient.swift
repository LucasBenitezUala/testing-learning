//
//  APIClient.swift
//  UalaNetwork
//
//  Created by Luis Perez on 29/03/22.
//

public protocol APIClient {
    func processRequest(_ request: APIRequest, retries: Int) async -> Result<Data, APIClientErrorWrapper>
}
