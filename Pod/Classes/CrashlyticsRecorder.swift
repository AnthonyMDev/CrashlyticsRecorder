//
//  CrashlyticsRecorder.swift
//  For use with Crashlytics version 3.7.0
//
//  Created by Anthony Miller on 2/17/16.
//

import Foundation

public protocol CrashlyticsProtocol: class {

    func log(_ msg: String)
    func log(format: String, arguments args: CVaListPointer)
    func setUserID(_ userID: String)
    func setCustomValue(_ value: Any, forKey key: String)
    func record(error: Error)
}

/// The delegate for a `CrashlyticsRecorder` instance.
public protocol CrashlyticsRecorderDelegate: class {

    /// Use this function to decide if an error should be recorded by `CrashlyticsRecorder`.
    /// The delegate can modify an error prior to it being recorded.
    ///
    /// - Note: If a `CrashlyticsRecorder` instance does not have a `delegate` then all errors will be recorded.
    ///
    /// - Parameter error: The error received by `CrashlyticsRecorder`
    /// - Returns: An optional error to be recorded. Return `nil` if you do not want an error to be recorded.
    func recorderShouldRecordError(_ error: Error) -> Error?

}

open class CrashlyticsRecorder {

    // MARK: - Instance Properties

    /// The `CrashlyticsRecorder` shared instance to be used for recording crashes and errors.
    public fileprivate(set) static var sharedInstance: CrashlyticsRecorder?

    /// The delegate for CrashlyticsRecorder
    weak public var delegate: CrashlyticsRecorderDelegate?

    fileprivate let crashlyticsInstance: CrashlyticsProtocol

    fileprivate init(crashlyticsInstance: CrashlyticsProtocol) {
        self.crashlyticsInstance = crashlyticsInstance
    }

    // MARK: - Create Shared Instance

    /// Creates the `sharedInstance` with the `Crashlytics` shared instance for the application. This method should
    /// be called in `application:didFinishLaunchingWithOptions:` after initializing `Crashlytics`.
    ///
    /// - Parameter crashlytics: The `sharedInstance` of `Crashlytics` for the application.
    ///
    /// - Returns: The created `CrashlyticsRecorder` shared instance
    open class func createSharedInstance(crashlytics crashlyticsInstance: CrashlyticsProtocol) -> CrashlyticsRecorder {
        let recorder = CrashlyticsRecorder(crashlyticsInstance: crashlyticsInstance)
        self.sharedInstance = recorder
        return recorder
    }

    /// Adds logging that is sent with your crash data. The logging does not appear  in the
    /// system.log and is only visible in the Crashlytics dashboard.
    ///
    ///  - Paramater msg Message to log
    open func log(_ msg: String) {
        crashlyticsInstance.log(msg)
    }

    /// Adds logging that is sent with your crash data. The logging does not appear  in the
    /// system.log and is only visible in the Crashlytics dashboard.
    ///
    /// - Parameter msg Message to log
    open func log(_ format: String, arguments: CVarArg...) {
        crashlyticsInstance.log(format: format, arguments: getVaList(arguments))
    }

    /// Records a user ID (identifier) that's associated with subsequent fatal and non-fatal reports.
    ///
    /// If you want to associate a crash with a specific user, we recommend specifying an arbitrary
    /// string (e.g., a database, ID, hash, or other value that you can index and query, but is
    /// meaningless to a third-party observer). This allows you to facilitate responses for support
    /// requests and reach out to users for more information.
    ///
    /// - Parameter userID An arbitrary user identifier string that associates a user to a record in your
    /// system.
    open func setUserID(_ userId: String) {
        crashlyticsInstance.setUserID(userId)
    }

    /// Sets a custom key and value to be associated with subsequent fatal and non-fatal reports.
    /// When setting an object value, the object is converted to a string. This is
    /// typically done by calling `-[NSObject description]`.
    ///
    /// - Parameter value The value to be associated with the key
    /// - Parameter key A unique key
    open func setCustomValue(_ value: Any, forKey key: String) {
        crashlyticsInstance.setCustomValue(value, forKey: key)
    }

    /// Records a non-fatal event described by an NSError object. The events are
    /// grouped and displayed similarly to crashes. Keep in mind that this method can be expensive.
    /// The total number of NSErrors that can be recorded during your app's life-cycle is limited by a
    /// fixed-size circular buffer. If the buffer is overrun, the oldest data is dropped. Errors are
    /// relayed to Crashlytics on a subsequent launch of your application.
    ///
    /// - Parameter error Non-fatal error to be recorded
    open func record(error: Error) {
        guard let error = confirmErrorWithDelegate(error) else { return }
        crashlyticsInstance.record(error: error)
    }

    func confirmErrorWithDelegate(_ error: Error) -> Error? {
        guard let delegate = delegate else { return error }
        return delegate.recorderShouldRecordError(error)
    }

    /// A convenience function that wraps the given closure in a do/catch block and reports any errors thrown to Crashlytics.
    ///
    /// - Parameter closure: The throwing closure to be performed
    ///
    /// - Returns: `true` if no error was caught. `false` if an error was caught
    open func doAndReportErrors(_ closure: () throws -> Void) -> Bool {
        do {
            try closure()

            return true

        } catch {
            record(error: error)
            return false
        }
    }

    // MARK: - Deprecated methods

    @available(*, deprecated, message: "Use log(format:arguments:)")
    public func log(_ format: String, args: CVarArg...) { fatalError() }

    @available(*, deprecated, message: "Use setUserID(:)")
    public func setUserIdentifier(_ identifier: String?) { fatalError() }

    @available(*, deprecated, message: "Obsolete. No replacement.")
    public func setUserName(_ name: String?) { fatalError() }

    @available(*, deprecated, message: "Obsolete. No replacement.")
    public func setUserEmail(_ email: String?) { fatalError() }

    @available(*, deprecated, message: "Use setCustomValue(_:forKey:)")
    public func setObjectValue(_ value: AnyObject?, forKey key: String) { fatalError() }

    @available(*, deprecated, message: "Use setCustomValue(_:forKey:)")
    public func setIntValue(_ value: Int32, forKey key: String) { fatalError() }

    @available(*, deprecated, message: "Use setCustomValue(_:forKey:)")
    public func setBoolValue(_ value: Bool, forKey key: String) { fatalError() }

    @available(*, deprecated, message: "Use setCustomValue(_:forKey:)")
    public func setFloatValue(_ value: Float, forKey key: String) { fatalError() }

    @available(*, deprecated, message: "Use recordError(error:). You'll have to add your own additional user info." )
    public func recordError(_ error: NSError, withAdditionalUserInfo userInfo: [String: Any]?) { fatalError() }

    @available(*, deprecated, message: "Use recordError(error:)." )
    public func recordError(_ error: Error) { fatalError() }
}
