//
//  CoreLocalDataSource.swift
//  Uala
//
//  Created by Andrés Abraham Bonilla Gómex on 17/02/22.
//  Copyright © 2022 Ualá. All rights reserved.
//

public protocol CoreLocalDataSourceType {
    static var postLogin: PostLoginLocalDataSourceType { get }
}

public enum CoreLocalDataSource: CoreLocalDataSourceType {
    
    public static var postLogin: PostLoginLocalDataSourceType {
        return PostLoginLocalAPI.shared
    }
}
