//
//  AnswersRecorder.swift
//  For use with Crashlytics version 3.7.0
//
//  Created by Anthony Miller on 2/18/16.
//
//

import Foundation

public protocol AnswersProtocol: class {
    
    static func logSignUpWithMethod(signUpMethodOrNil: String?,
        success signUpSucceededOrNil: NSNumber?,
        customAttributes customAttributesOrNil: [String : AnyObject]?)
    
    static func logLoginWithMethod(loginMethodOrNil: String?,
        success loginSucceededOrNil: NSNumber?,
        customAttributes customAttributesOrNil: [String : AnyObject]?)
    
    static func logShareWithMethod(shareMethodOrNil: String?,
        contentName contentNameOrNil: String?,
        contentType contentTypeOrNil: String?,
        contentId contentIdOrNil: String?,
        customAttributes customAttributesOrNil: [String : AnyObject]?)
    
    static func logInviteWithMethod(inviteMethodOrNil: String?,
        customAttributes customAttributesOrNil: [String : AnyObject]?)
    
    static func logPurchaseWithPrice(itemPriceOrNil: NSDecimalNumber?,
        currency currencyOrNil: String?,
        success purchaseSucceededOrNil: NSNumber?,
        itemName itemNameOrNil: String?,
        itemType itemTypeOrNil: String?,
        itemId itemIdOrNil: String?,
        customAttributes customAttributesOrNil: [String : AnyObject]?)
    
    static func logLevelStart(levelNameOrNil: String?,
        customAttributes customAttributesOrNil: [String : AnyObject]?)
    
    static func logLevelEnd(levelNameOrNil: String?,
        score scoreOrNil: NSNumber?,
        success levelCompletedSuccesfullyOrNil: NSNumber?,
        customAttributes customAttributesOrNil: [String : AnyObject]?)
    
    static func logAddToCartWithPrice(itemPriceOrNil: NSDecimalNumber?,
        currency currencyOrNil: String?,
        itemName itemNameOrNil: String?,
        itemType itemTypeOrNil: String?,
        itemId itemIdOrNil: String?,
        customAttributes customAttributesOrNil: [String : AnyObject]?)
    
    static func logStartCheckoutWithPrice(totalPriceOrNil: NSDecimalNumber?,
        currency currencyOrNil: String?,
        itemCount itemCountOrNil: NSNumber?,
        customAttributes customAttributesOrNil: [String : AnyObject]?)
    
    static func logRating(ratingOrNil: NSNumber?,
        contentName contentNameOrNil: String?,
        contentType contentTypeOrNil: String?,
        contentId contentIdOrNil: String?,
        customAttributes customAttributesOrNil: [String : AnyObject]?)
    
    
    static func logContentViewWithName(contentNameOrNil: String?,
        contentType contentTypeOrNil: String?,
        contentId contentIdOrNil: String?,
        customAttributes customAttributesOrNil: [String : AnyObject]?)
    
    static func logSearchWithQuery(queryOrNil: String?,
        customAttributes customAttributesOrNil: [String : AnyObject]?)
    
    static func logCustomEventWithName(eventName: String,
        customAttributes customAttributesOrNil: [String : AnyObject]?)
    
}

public class AnswersRecorder {
    
    /// The `AnswersRecorder` shared instance to be used for recording Answers events
    public private(set) static var sharedInstance: AnswersRecorder?
    
    private var answersClass: AnswersProtocol.Type
    
    private init(answersClass: AnswersProtocol.Type) {
        self.answersClass = answersClass
    }
    
    /**
     Creates the `sharedInstance` with the `Answers` class for the application. This method should be called in `application:didFinishLaunchingWithOptions:` after initializing `Crashlytics`.
     
     - parameter answers: The `Answers` class from the `Crashlytics` framework.
     
     - returns: The created `CrashlyticsRecorder` shared instance
     */
    public class func createSharedInstance(answers answersClass: AnswersProtocol.Type) -> AnswersRecorder {
        let recorder = AnswersRecorder(answersClass: answersClass)
        sharedInstance = recorder
        return recorder
    }
    
    /**
     *  Log a Sign Up event to see users signing up for your app in real-time, understand how
     *  many users are signing up with different methods and their success rate signing up.
     *
     *  @param signUpMethod     The method by which a user logged in, e.g. Twitter or Digits.
     *  @param signUpSucceeded  The ultimate success or failure of the login
     *  @param customAttributes A dictionary of custom attributes to associate with this event.
     */
    public func logSignUp(signUpMethod signUpMethod: String?, success: NSNumber?, customAttributes: [String : AnyObject]?) {
        answersClass.logSignUpWithMethod(signUpMethod, success: success, customAttributes: customAttributes)
    }
    
    /**
     *  Log an Log In event to see users logging into your app in real-time, understand how many
     *  users are logging in with different methods and their success rate logging into your app.
     *
     *  @param loginMethod      The method by which a user logged in, e.g. email, Twitter or Digits.
     *  @param loginSucceeded   The ultimate success or failure of the login
     *  @param customAttributes A dictionary of custom attributes to associate with this event.
     */
    public func logLogin(loginMethod loginMethod: String?, success: NSNumber?, customAttributes: [String : AnyObject]?) {
        answersClass.logLoginWithMethod(loginMethod, success: success, customAttributes: customAttributes)
    }
    
    /**
     *  Log a Share event to see users sharing from your app in real-time, letting you
     *  understand what content they're sharing from the type or genre down to the specific id.
     *
     *  @param shareMethod      The method by which a user shared, e.g. email, Twitter, SMS.
     *  @param contentName      The human readable name for this piece of content.
     *  @param contentType      The type of content shared.
     *  @param contentId        The unique identifier for this piece of content. Useful for finding the top shared item.
     *  @param customAttributes A dictionary of custom attributes to associate with this event.
     */
    public func logShare(shareMethod shareMethod: String?,
        contentName: String?,
        contentType: String?,
        contentId: String?,
        customAttributes: [String : AnyObject]?) {
            answersClass.logShareWithMethod(shareMethod,
                contentName: contentName,
                contentType: contentType,
                contentId: contentId,
                customAttributes: customAttributes)
    }
    
    /**
     *  Log an Invite Event to track how users are inviting other users into
     *  your application.
     *
     *  @param inviteMethod     The method of invitation, e.g. GameCenter, Twitter, email.
     *  @param customAttributes A dictionary of custom attributes to associate with this event.
     */
    public func logInvite(inviteMethod inviteMethod: String?, customAttributes: [String : AnyObject]?) {
        answersClass.logInviteWithMethod(inviteMethod, customAttributes: customAttributes)
    }
    
    /**
     *  Log a Purchase event to see your revenue in real-time, understand how many users are making purchases, see which
     *  items are most popular, and track plenty of other important purchase-related metrics.
     *
     *  @param itemPrice         The purchased item's price.
     *  @param currency          The ISO4217 currency code. Example: USD
     *  @param purchaseSucceeded Was the purchase succesful or unsuccesful
     *  @param itemName          The human-readable form of the item's name. Example:
     *  @param itemType          The type, or genre of the item. Example: Song
     *  @param itemId            The machine-readable, unique item identifier Example: SKU
     *  @param customAttributes  A dictionary of custom attributes to associate with this purchase.
     */
    public func logPurchase(itemPrice itemPrice: NSDecimalNumber?,
        currency: String?,
        success: NSNumber?,
        itemName: String?,
        itemType: String?,
        itemId: String?,
        customAttributes: [String : AnyObject]?) {
            answersClass.logPurchaseWithPrice(itemPrice,
                currency: currency,
                success: success,
                itemName: itemName,
                itemType: itemType,
                itemId: itemId,
                customAttributes: customAttributes)
    }
    
    /**
     *  Log a Level Start Event to track where users are in your game.
     *
     *  @param levelName        The level name
     *  @param customAttributes A dictionary of custom attributes to associate with this level start event.
     */
    public func logLevelStart(levelName levelName: String?, customAttributes: [String : AnyObject]?) {
        answersClass.logLevelStart(levelName, customAttributes: customAttributes)
    }
    
    /**
     *  Log a Level End event to track how users are completing levels in your game.
     *
     *  @param levelName                 The name of the level completed, E.G. "1" or "Training"
     *  @param score                     The score the user completed the level with.
     *  @param levelCompletedSuccesfully A boolean representing whether or not the level was completed succesfully.
     *  @param customAttributes          A dictionary of custom attributes to associate with this event.
     */
    public func logLevelEnd(levelName levelName: String?,
        score: NSNumber?,
        success: NSNumber?,
        customAttributes: [String : AnyObject]?) {
            answersClass.logLevelEnd(levelName, score: score, success: success, customAttributes: customAttributes)
    }
    
    /**
     *  Log an Add to Cart event to see users adding items to a shopping cart in real-time, understand how
     *  many users start the purchase flow, see which items are most popular, and track plenty of other important
     *  purchase-related metrics.
     *
     *  @param itemPrice         The purchased item's price.
     *  @param currency          The ISO4217 currency code. Example: USD
     *  @param itemName          The human-readable form of the item's name. Example:
     *  @param itemType          The type, or genre of the item. Example: Song
     *  @param itemId            The machine-readable, unique item identifier Example: SKU
     *  @param customAttributes  A dictionary of custom attributes to associate with this event.
     */
    public func logAddToCart(itemPrice itemPrice: NSDecimalNumber?,
        currency: String?,
        itemName: String?,
        itemType: String?,
        itemId: String?,
        customAttributes: [String : AnyObject]?) {
            answersClass.logAddToCartWithPrice(itemPrice,
                currency: currency,
                itemName: itemName,
                itemType: itemType,
                itemId: itemId,
                customAttributes: customAttributes)
    }
    
    /**
     *  Log a Start Checkout event to see users moving through the purchase funnel in real-time, understand how many
     *  users are doing this and how much they're spending per checkout, and see how it related to other important
     *  purchase-related metrics.
     *
     *  @param totalPrice        The total price of the cart.
     *  @param currency          The ISO4217 currency code. Example: USD
     *  @param itemCount         The number of items in the cart.
     *  @param customAttributes  A dictionary of custom attributes to associate with this event.
     */
    public func logStartCheckout(totalPrice totalPrice: NSDecimalNumber?,
        currency: String?,
        itemCount: NSNumber?,
        customAttributes: [String : AnyObject]?) {
            answersClass.logStartCheckoutWithPrice(totalPrice,
                currency: currency,
                itemCount: itemCount,
                customAttributes: customAttributes)
    }
    
    /**
     *  Log a Rating event to see users rating content within your app in real-time and understand what
     *  content is most engaging, from the type or genre down to the specific id.
     *
     *  @param rating               The integer rating given by the user.
     *  @param contentName          The human readable name for this piece of content.
     *  @param contentType          The type of content shared.
     *  @param contentId            The unique identifier for this piece of content. Useful for finding the top shared item.
     *  @param customAttributes     A dictionary of custom attributes to associate with this event.
     */
    public func logRating(rating: NSNumber?,
        contentName: String?,
        contentType: String?, contentId: String?,
        customAttributes: [String : AnyObject]?) {
            answersClass.logRating(rating,
                contentName: contentName,
                contentType: contentType,
                contentId: contentId,
                customAttributes: customAttributes)
    }
    
    /**
     *  Log a Content View event to see users viewing content within your app in real-time and
     *  understand what content is most engaging, from the type or genre down to the specific id.
     *
     *  @param contentName          The human readable name for this piece of content.
     *  @param contentType          The type of content shared.
     *  @param contentId            The unique identifier for this piece of content. Useful for finding the top shared item.
     *  @param customAttributes     A dictionary of custom attributes to associate with this event.
     */
    public func logContentView(contentName contentName: String?,
        contentType: String?,
        contentId: String?,
        customAttributes: [String : AnyObject]?) {
            answersClass.logContentViewWithName(contentName,
                contentType: contentType,
                contentId: contentId,
                customAttributes: customAttributes)
    }
    
    /**
     *  Log a Search event allows you to see users searching within your app in real-time and understand
     *  exactly what they're searching for.
     *
     *  @param query            The user's query.
     *  @param customAttributes A dictionary of custom attributes to associate with this event.
     */
    public func logSearch(query query: String?, customAttributes: [String : AnyObject]?) {
        answersClass.logSearchWithQuery(query, customAttributes: customAttributes)
    }
    
    /**
     *  Log a Custom Event to see user actions that are uniquely important for your app in real-time, to see how often
     *  they're performing these actions with breakdowns by different categories you add. Use a human-readable name for
     *  the name of the event, since this is how the event will appear in Answers.
     *
     *  @param eventName             The human-readable name for the event.
     *  @param customAttributes      A dictionary of custom attributes to associate with this event. Attribute keys
     *                               must be <code>NSString</code> and and values must be <code>NSNumber</code> or <code>NSString</code>.
     *  @discussion                  How we treat <code>NSNumbers</code>:
     *                               We will provide information about the distribution of values over time.
     *
     *                               How we treat <code>NSStrings</code>:
     *                               NSStrings are used as categorical data, allowing comparison across different category values.
     *                               Strings are limited to a maximum length of 100 characters, attributes over this length will be
     *                               truncated.
     *
     *                               When tracking the Tweet views to better understand user engagement, sending the tweet's length
     *                               and the type of media present in the tweet allows you to track how tweet length and the type of media influence
     *                               engagement.
     */
    public func logCustomEvent(eventName eventName: String, customAttributes: [String : AnyObject]?) {
        answersClass.logCustomEventWithName(eventName, customAttributes: customAttributes)
    }
    
}