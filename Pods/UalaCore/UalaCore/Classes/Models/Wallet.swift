//
//  Wallet.swift
//  Uala
//
//  Created by Rodrigo Ferretty on 20/05/2019.
//  Copyright © 2019 Ualá. All rights reserved.
//

import Foundation

class Wallet: CustomStringConvertible, Equatable, Codable {
    
    let code, name: String
    
    init(code: String, name: String) {
        self.code = code
        self.name = name
    }
    
    var description: String {
        return name
    }
    
    static func == (lhs: Wallet, rhs: Wallet) -> Bool {
        return lhs.code == rhs.code
    }
}

extension Wallet {
    
    private static func fromLocalBundle() -> [Wallet] {
        let bundle = BundleUtils.getBundle(from: .Core)
        guard let path = bundle.path(forResource: "walletCodes",
                                     ofType: "json"),
              let data = try? Data(contentsOf: URL(fileURLWithPath: path),
                             options: .alwaysMapped),
              let result = try? JSONDecoder().decode([Wallet].self,
                                                     from: data) else {
                  return []
              }
        return result
    }
    
    static func walletName(for walletCVU: String) -> String? {
        guard walletCVU.count >= 7 else { return nil }        
        let cvuWalletCode = walletCVU.substring(toIndex: 8)
        let wallets = fromLocalBundle()
        return wallets.first(where: { $0.code == cvuWalletCode })?.name ?? translate("VIRTUAL_WALLET")
    }
}
