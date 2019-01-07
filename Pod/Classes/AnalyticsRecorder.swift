//
//  AnalyticsRecorder.swift
//  CrashlyticsRecorder
//
//  Created by David Whetstone on 1/7/19.
//

import Foundation

public protocol AnalyticsProtocol: class {

    static func logEvent(_ name: String, parameters: [String: Any]?)
    static func setUserProperty(_ value: String?, forName name: String)
    static func setUserID(_ userID: String?)
    static func setScreenName(_ screenName: String?, screenClass screenClassOverride: String?)
    static func appInstanceID() -> String
    static func resetAnalyticsData()
}

public class AnalyticsRecorder {

    /// The `AnalyticsRecorder` shared instance to be used for recording Analytics events
    public private(set) static var sharedInstance: AnalyticsRecorder?

    private var analyticsClass: AnalyticsProtocol.Type

    private init(analyticsClass: AnalyticsProtocol.Type) {
        self.analyticsClass = analyticsClass
    }

    /**
     Creates the `sharedInstance` with the `Analytics` class for the application. This method should be called in `application:didFinishLaunchingWithOptions:`.

     - parameter analytics: The `Analytics` class from the `FirebaseCore` framework.

     - returns: The created `FirebaseRecorder` shared instance
     */
    public class func createSharedInstance(analytics analyticsClass: AnalyticsProtocol.Type) -> AnalyticsRecorder {
        let recorder = AnalyticsRecorder(analyticsClass: analyticsClass)
        sharedInstance = recorder
        return recorder
    }

    public func logEvent(_ name: String, parameters: [String: Any]?) {
        analyticsClass.logEvent(name, parameters: parameters)
    }

    public func setUserProperty(_ value: String?, forName name: String) {
        analyticsClass.setUserProperty(value, forName: name)
    }

    public func setUserID(_ userID: String?) {
        analyticsClass.setUserID(userID)
    }

    public func setScreenName(_ screenName: String?, screenClass screenClassOverride: String?) {
        analyticsClass.setScreenName(screenName, screenClass: screenClassOverride)
    }

    public func appInstanceID() -> String {
        return analyticsClass.appInstanceID()
    }

    public func resetAnalyticsData() {
        analyticsClass.resetAnalyticsData()
    }
}

public extension AnalyticsRecorder {

    public func logEvent(_ name: AnalyticsEvent, parameters: [AnalyticsParameter: Any]? = nil) {
        let parameters = parameters?.reduce(into: [:]) { result, x in result[x.key.rawValue] = x.value }
        logEvent(name.rawValue, parameters: parameters)
    }

    public func setUserProperty(_ value: String?, forName name: AnalyticsUserProperty) {
        analyticsClass.setUserProperty(value, forName: name.rawValue)
    }
}

public enum AnalyticsEvent: String {

    case addPaymentInfo       = "add_payment_info"
    case addToCart            = "add_to_cart"
    case addToWishlist        = "add_to_wishlist"
    case appOpen              = "app_open"
    case beginCheckout        = "begin_checkout"
    case campaignDetails      = "campaign_details"
    case checkoutProgress     = "checkout_progress"
    case earnVirtualCurrency  = "earn_virtual_currency"
    case ecommercePurchase    = "ecommerce_purchase"
    case generateLead         = "generate_lead"
    case joinGroup            = "join_group"
    case levelUp              = "level_up"
    case login                = "login"
    case postScore            = "post_score"
    case presentOffer         = "present_offer"
    case purchaseRefund       = "purchase_refund"
    case removeFromCart       = "remove_from_cart"
    case search               = "search"
    case selectContent        = "select_content"
    case setCheckoutOption    = "set_checkout_option"
    case share                = "share"
    case signUp               = "sign_up"
    case spendVirtualCurrency = "spend_virtual_currency"
    case tutorialBegin        = "tutorial_begin"
    case tutorialComplete     = "tutorial_complete"
    case unlockAchievement    = "unlock_achievement"
    case viewItem             = "view_item"
    case viewItemList         = "view_item_list"
    case viewSearchResults    = "view_search_results"
    case levelStart           = "level_start"
    case levelEnd             = "level_end"
}

public enum AnalyticsParameter: String {

    case achievementID       = "achievement_id"
    case adNetworkClickID    = "aclid"
    case affiliation         = "affiliation"
    case campaign            = "campaign"
    case character           = "character"
    case checkoutStep        = "checkout_step"
    case checkoutOption      = "checkout_option"
    case content             = "content"
    case contentType         = "content_type"
    case coupon              = "coupon"
    case cP1                 = "cp1"
    case creativeName        = "creative_name"
    case creativeSlot        = "creative_slot"
    case currency            = "currency"
    case destination         = "destination"
    case endDate             = "end_date"
    case flightNumber        = "flight_number"
    case groupID             = "group_id"
    case index               = "index"
    case itemBrand           = "item_brand"
    case itemCategory        = "item_category"
    case itemID              = "item_id"
    case itemLocationID      = "item_location_id"
    case itemName            = "item_name"
    case itemList            = "item_list"
    case itemVariant         = "item_variant"
    case level               = "level"
    case location            = "location"
    case medium              = "medium"
    case numberOfNights      = "number_of_nights"
    case numberOfPassengers  = "number_of_passengers"
    case numberOfRooms       = "number_of_rooms"
    case origin              = "origin"
    case price               = "price"
    case quantity            = "quantity"
    case score               = "score"
    case searchTerm          = "search_term"
    case shipping            = "shipping"
    case signUpMethod        = "sign_up_method"
    case source              = "source"
    case startDate           = "start_date"
    case tax                 = "tax"
    case term                = "term"
    case transactionID       = "transaction_id"
    case travelClass         = "travel_class"
    case value               = "value"
    case virtualCurrencyName = "virtual_currency_name"
    case levelName           = "level_name"
    case success             = "success"
}

public enum AnalyticsUserProperty: String {

    case signUpMethod = "sign_up_method"
}

