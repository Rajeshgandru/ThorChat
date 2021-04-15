//
//  commntedKeyFile.swift
//  FlowerBazaaarCustomer
//
//  Created by admin on 12/24/20.
//  Copyright © 2020 Thorsignia. All rights reserved.
//

import Foundation
//https://stackoverflow.com/questions/50175266/implementation-of-agora-signalling-to-communicate-when-app-is-closed



//MARK:-  Domain Links 

//Link-1 : applinks:flowerbazaaarbuyer.page.link
//Link-2 : applinks:flowerbazaaarbuyerandroid.page.link
//MARK:-  Notification 
/*
 ["google.c.a.e": 1, "aps": {
 alert =     {
 body = "Order Request Accepted From Seller! Syed, Adeeb";
 title = "Order Request Accepted From Seller!";
 };
 sound = "egyptianNotification1.wav";
 }, "gcm.message_id": 1608702053695194]
 
 
 
 //REJECTING THE Order
 
 
 [AnyHashable("gcm.message_id"): 1606227472518964, AnyHashable("aps"): {
 alert =     {
 subtitle = "Order Request Rejected From Seller! Syed, Adeeb";
 title = "Order Request Rejected From Seller!";
 };
 sound = 1;
 }, AnyHashable("gcm.notification.visibility"): 1, AnyHashable("google.c.sender.id"): 202426927307, AnyHashable("gcm.notification.tickerText"): Ticker text here...Ticker text here...Ticker text here, AnyHashable("gcm.notification.force-start"): 1, AnyHashable("google.c.a.e"): 1, AnyHashable("gcm.notification.message"): Order Request Rejected From Seller! Syed, Adeeb, AnyHashable("gcm.notification.no-cache"): 1, AnyHashable("gcm.notification.vibrate"): 1, AnyHashable("gcm.notification.foreground"): true, AnyHashable("gcm.notification.priority"): 1]
 
 */

//Call Notification
/*
["customer_id": 17, "appID": dcafa5a70371491992a9f6e96685e5ae, "seller_id": 170, "notification_type": Call, "google.c.a.e": 1, "aps": {
    alert =     {
        title = "Audio Call From Seller Praveen, pprStore";
    };
    sound = "HiTechLogo.wav";
}, "tokenForBuyer": 006dcafa5a70371491992a9f6e96685e5aeIABKTyfddQzBBxV3EnWM731BHsxHHP2ZAZ6ORD6lTKHEofYR/G0AAAAAEABbjAAAka32XwEA6AMhavVf, "channelName": 17_170, "gcm.message_id": 1609915409704920]
*/
//applinks:flowerbazaaarbuyer.page.link

//Here Is Live Build Bundile ID : "com.Thorsignia.FlowerBazaaarBuyer"
