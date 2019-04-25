//
//  CrashlyticsAdapter.swift
//  CrashlyticsRecorder
//
//  Created by Anthony Miller on 2/17/16.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import Foundation
import Crashlytics
import CrashlyticsRecorder
import Firebase

extension Crashlytics: CrashlyticsProtocol {

    public func log(_ format: String, args: CVaListPointer) {
        #if DEBUG
            CLSNSLogv(format, args)
        #else
            CLSLogv(format, args)
        #endif
    }
}

extension Answers: AnswersProtocol { }

extension Analytics: AnalyticsProtocol { }