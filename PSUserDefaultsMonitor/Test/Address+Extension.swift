//
//  Address+Extension.swift
//  PSUserDefaultsMonitor
//
//  Created by Muronaka Hiroaki on 2015/06/21.
//  Copyright (c) 2015年 plusadd. All rights reserved.
//

import Foundation

extension Address: Comparable {
}

func <(lhs:Address, rhs:Address) -> Bool {
    return lhs.address < rhs.address
}

func ==(lhs:Address, rhs:Address) -> Bool {
    return lhs.address == rhs.address
}