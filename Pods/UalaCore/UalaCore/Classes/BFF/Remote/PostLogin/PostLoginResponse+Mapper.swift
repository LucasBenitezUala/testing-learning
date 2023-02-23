//
//  PostLoginResponse+Mapper.swift
//  UalaCore
//
//  Created by Andrés Abraham Bonilla Gómex on 14/01/22.
//  Copyright © 2022 Ualá. All rights reserved.
//

import Foundation

extension PostLoginResponse {
   
    func mapToPostLoginInfo() -> Account {
        let account = Account(metadata: nil,
                              id: userInfo?.id ?? "",
                              username: userInfo?.username ?? "",
                              firstname: userInfo?.name ?? "",
                              lastname: userInfo?.lastName ?? "",
                              status: userInfo?.status ?? "",
                              picture: userInfo?.avatar ?? "",
                              hasPin: userInfo?.hasTransactionalPin ?? false,
                              email: userInfo?.email ?? "",
                              phone: userInfo?.phoneNumber ?? "",
                              displayName: userInfo?.displayName ?? "",
                              userType: UserType(rawValue: userInfo?.userType ?? "") ?? .unknown,
                              action: userAction?.mapToPostLoginAction() ?? PostLoginAction())
        account.isPPJJ = account.userType == .juridical
        return account
    }
}

extension PostLoginUserActionResponse {
    
    func mapToPostLoginAction() -> PostLoginAction {
        
        return PostLoginAction(type: PostLoginActionType(rawValue: type ?? "") ?? .unknown,
                               path: PostLoginPathType.getPath(url: link ?? ""),
                               pendingAction: PostLoginPendingActionType.getPendingAction(url: link ?? ""))
    }
}
