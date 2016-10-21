//
//  CrashlyticsRecorder.swift
//  For use with Crashlytics version 3.7.0
//
//  Created by Anthony Miller on 2/17/16.
//

import Foundation

public protocol CrashlyticsProtocol: class {
    
    func log(_ format: String, args: CVaListPointer)
    
    func setUserIdentifier(_ identifier: String?)
    func setUserName(_ name: String?)
    func setUserEmail(_ email: String?)
    func setObjectValue(_ value: Any?, forKey key: String)
    func setIntValue(_ value: Int32, forKey key: String)
    func setBoolValue(_ value: Bool, forKey key: String)
    func setFloatValue(_ value: Float, forKey key: String)
    
    func recordError(_ error: Error, withAdditionalUserInfo userInfo: [String : Any]?)
    
}

/**
 *  An `Error` can conform to this protocol to provide information to be included in an error report to the Crashlytics UI.
 */
public protocol ErrorReportable: Error {
    
    /**
     The error's title to be displayed in the "Title" field in the Crashlytics UI.
     
     - returns: The title of the error.
     */
    func errorReportTitle() -> String?

    /**
     A dictionary of keys and values to be displayed for the error in the Crashlytics UI.
     
     - returns: The user info for the error.
     */
    func errorReportUserInfo() -> [String: Any]?
    
}

private extension ErrorReportable {
    
    func userInfo() -> [String: Any]? {
        var userInfo = errorReportUserInfo() ?? [:]
        if let title = errorReportTitle() { userInfo["Error Title"] = NSString(string: title) }
        
        return userInfo.isEmpty ? nil : userInfo
    }
    
}

open class CrashlyticsRecorder {
    
    /// The `CrashlyticsRecorder` shared instance to be used for recording crashes and errors.
    open fileprivate(set) static var sharedInstance: CrashlyticsRecorder?
    
    fileprivate let crashlyticsInstance: CrashlyticsProtocol
    
    fileprivate init(crashlyticsInstance: CrashlyticsProtocol) {
        self.crashlyticsInstance = crashlyticsInstance
    }
    
    /**
     Creates the `sharedInstance` with the `Crashlytics` shared instance for the application. This method should be called in `application:didFinishLaunchingWithOptions:` after initializing `Crashlytics`.
     
     - parameter crashlytics: The `sharedInstance` of `Crashlytics` for the application.
     
     - returns: The created `CrashlyticsRecorder` shared instance
     */
    open class func createSharedInstance(crashlytics crashlyticsInstance: CrashlyticsProtocol) -> CrashlyticsRecorder {
        let recorder = CrashlyticsRecorder(crashlyticsInstance: crashlyticsInstance)
        self.sharedInstance = recorder
        return recorder
    }
    
    /**
     *
     * Add logging that will be sent with your crash data. This logging will be visible in the Crashlytics UI.
     *
     **/
    open func log(_ format: String, args: CVarArg...) {
        crashlyticsInstance.log(format, args: getVaList(args))
    }
    
    /**
     *  Specify a user identifier which will be visible in the Crashlytics UI.
     *
     *  Many of our customers have requested the ability to tie crashes to specific end-users of their
     *  application in order to facilitate responses to support requests or permit the ability to reach
     *  out for more information. We allow you to specify up to three separate values for display within
     *  the Crashlytics UI - but please be mindful of your end-user's privacy.
     *
     *  We recommend specifying a user identifier - an arbitrary string that ties an end-user to a record
     *  in your system. This could be a database id, hash, or other value that is meaningless to a
     *  third-party observer but can be indexed and queried by you.
     *
     *  Optionally, you may also specify the end-user's name or username, as well as email address if you
     *  do not have a system that works well with obscured identifiers.
     *
     *  Pursuant to our EULA, this data is transferred securely throughout our system and we will not
     *  disseminate end-user data unless required to by law. That said, if you choose to provide end-user
     *  contact information, we strongly recommend that you disclose this in your application's privacy
     *  policy. Data privacy is of our utmost concern.
     *
     *  @param identifier An arbitrary user identifier string which ties an end-user to a record in your system.
     */
    open func setUserIdentifier(_ identifier: String?) {
        crashlyticsInstance.setUserIdentifier(identifier)
    }
    
    /**
     *  Specify a user name which will be visible in the Crashlytics UI.
     *  Please be mindful of your end-user's privacy and see if setUserIdentifier: can fulfil your needs.
     *  @see setUserIdentifier:
     *
     *  @param name An end user's name.
     */
    open func setUserName(_ name: String?) {
        crashlyticsInstance.setUserName(name)
    }
    
    /**
     *  Specify a user email which will be visible in the Crashlytics UI.
     *  Please be mindful of your end-user's privacy and see if setUserIdentifier: can fulfil your needs.
     *
     *  @see setUserIdentifier:
     *
     *  @param email An end user's email address.
     */
    open func setUserEmail(_ email: String?) {
        crashlyticsInstance.setUserEmail(email)
    }
    
    /**
     *  Set a value for a for a key to be associated with your crash data which will be visible in the Crashlytics UI.
     *  When setting an object value, the object is converted to a string. This is typically done by calling
     *  -[NSObject description].
     *
     *  @param value The object to be associated with the key
     *  @param key   The key with which to associate the value
     */
    open func setObjectValue(_ value: AnyObject?, forKey key: String) {
        crashlyticsInstance.setObjectValue(value, forKey: key)
    }
    
    /**
     *  Set an int value for a key to be associated with your crash data which will be visible in the Crashlytics UI.
     *
     *  @param value The integer value to be set
     *  @param key   The key with which to associate the value
     */
    open func setIntValue(_ value: Int32, forKey key: String) {
        crashlyticsInstance.setIntValue(value, forKey: key)
    }
    
    /**
     *  Set a BOOL value for a key to be associated with your crash data which will be visible in the Crashlytics UI.
     *
     *  @param value The BOOL value to be set
     *  @param key   The key with which to associate the value
     */
    open func setBoolValue(_ value: Bool, forKey key: String) {
        crashlyticsInstance.setBoolValue(value, forKey: key)
    }
    
    /**
     *  Set a float value for a key to be associated with your crash data which will be visible in the Crashlytics UI.
     *
     *  @param value The float value to be set
     *  @param key   The key with which to associate the value
     */
    open func setFloatValue(_ value: Float, forKey key: String) {
        crashlyticsInstance.setFloatValue(value, forKey: key)
    }
    
    /**
     *
     * This allows you to record a non-fatal event, described by an NSError object. These events will be grouped and
     * displayed similarly to crashes. Keep in mind that this method can be expensive. Also, the total number of
     * NSErrors that can be recorded during your app's life-cycle is limited by a fixed-size circular buffer. If the
     * buffer is overrun, the oldest data is dropped. Errors are relayed to Crashlytics on a subsequent launch
     * of your application.
     *
     */
    open func recordError(_ error: NSError, withAdditionalUserInfo userInfo: [String: Any]? = nil) {
        crashlyticsInstance.recordError(error, withAdditionalUserInfo: userInfo)
    }
    
    /**
     *
     * This allows you to record a non-fatal event, described by a Swift `ErrorType` object that conforms to the
     * `ErrorReportable` protocol. These events will be grouped and displayed similarly to crashes. Keep in mind
     * that this method can be expensive. Also, the total number of NSErrors that can be recorded during your 
     * app's life-cycle is limited by a fixed-size circular buffer. If the buffer is overrun, the oldest data is
     * dropped. Errors are relayed to Crashlytics on a subsequent launch of your application.
     *
     */
    open func recordError(_ error: ErrorReportable) {
        crashlyticsInstance.recordError(error as NSError, withAdditionalUserInfo: error.userInfo())
    }
    
    /**
     *
     * This allows you to record a non-fatal event, described by a Swift `ErrorType` object.
     * These events will be grouped and displayed similarly to crashes. Keep in mind
     * that this method can be expensive. Also, the total number of NSErrors that can be recorded during your 
     * app's life-cycle is limited by a fixed-size circular buffer. If the buffer is overrun, the oldest data is
     * dropped. Errors are relayed to Crashlytics on a subsequent launch of your application.
     *
     */
    open func recordError(_ error: Error) {
        if let error = error as? ErrorReportable {
            recordError(error)
            
        } else {
            crashlyticsInstance.recordError(error, withAdditionalUserInfo: nil)
        }
    }
    
    /**
     A convenience function that wraps the given closure in a do/catch block and reports any errors thrown to Crashlytics.
     
     - parameter closure: The throwing closure to be performed
     
     - returns: `true` if no error was caught. `false` if an error was caught
     */
    open func doAndReportErrors(_ closure: () throws -> Void) -> Bool {
        do {
            try closure()
            
            return true
            
        } catch {
            if let error = error as? ErrorReportable {
                recordError(error)
                
            } else {
                recordError(error as NSError)
            }
            
            return false
        }
    }
}
