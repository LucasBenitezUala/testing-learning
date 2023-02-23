//
//  PasswordCollectorRouterProtocols.swift
//  UalaUI
//
//  Created by Agustina Ardisana on 31/10/2022.
//

public protocol PasswordCollectorRouterType: AnyObject {
    var view: PasswordCollectorViewType? { get set }
    
    func executePrimaryAction()
}
