//
//  API_List.swift
//  Flower Bazaaar Seller
//
//  Created by Thorsignia on 10/08/20.
//  Copyright © 2020 Thorsignia. All rights reserved.
//


let kAppTitle = "Flower Bazaaar!"
class Constants {
    struct URLs {    
        
        //MARK:- Base URl
       static let BASE_URL =  "https://flowerbazaaar.app/"
       // static let BASE_URL =  "http://192.168.0.181/FlowerBazaaar/"
     //  static let BASE_URL =  "http://192.168.1.11/FlowerBazaaar/"
        
        //
        static let CITY_API                                         = BASE_URL + "get/business/types/of/customer/and/cities/list"
        
        //MARK:- Home Apis
        static let Get_Home_data_API                                = BASE_URL + "get/customer/home/page/details"
        static let Get_Home_data_API_1                                = BASE_URL + "get/customer/home/page/details1"
        static let Get_SubCategory_Home_data_API                    = BASE_URL + "get/subcategory/details/by/category/for/customers/"
        static let Get_All_SubCategory_Home_data_API                = BASE_URL + "get/all/subcategory/details/for/customers"
        static let Get_All_SubCategory_Colour_data_API              = BASE_URL + "get/subcategory/colors/variety/list/by/subcategory/for/customers/"
        
        
        static let Search_Suggestion_API      = BASE_URL + "customer/product/search/suggestion/keywords/"
        
        static let Search_SellerShop_Suggestion_API      = BASE_URL + "get/this/seller/shop/products/search/suggestion"
        
        
        //MARK:- Filter Apis
        static let Get_Filter_data_API                              = BASE_URL + "get/categories/and/subcategories/list"
        static let Search_Product_data_API                          = BASE_URL + "customer/product/search/list/"
        static let Search_Product_WithSearchScreen_API              = BASE_URL + "customer/product/search/suggestion/list/"
        
        static let SellersFromCities_API                            = BASE_URL + "get/this/cities/active/sellers/list"
        
       //MARK:- Auth Part
        static let LogIN_API                                        = BASE_URL + "customer/register/or/login"
        static let LogOUT_API                                       = BASE_URL + "customer/logout"
        static let OtpVerification                                  = BASE_URL + "customer/login/otp/verification"
        static let ResendOtp                                        = BASE_URL + "customer/login/otp/resend/"
        static let CustomerPersonalAddressDetailsCapturing_API      = BASE_URL + "customer/personal/and/address/details/capturing"
        
        //MARK:- Product Preview
        
        static let ProductPreview                                   =  BASE_URL + "customer/get/product/details?"
        static let Addfevorateseller                                =  BASE_URL + "mark/this/seller/as/favourite/to/this/customer?customer_id="
        static let AddfevoratesellerProduct                         =  BASE_URL + "mark/this/seller/product/as/favourite/to/this/customer?customer_id="
        
        static let AddProductToCart                                 =  BASE_URL + "add/this/product/to/this/customer/cart"
        static let AddAgainSameProductToCart                        =  BASE_URL + "add/this/product/one/more/time/to/this/customer/cart"
        
        //MARK:- MyAccount
        static let SavedAddress                                     = BASE_URL + "get/customer/address/list?customer_id="
        static let SavedAddressDetails                              = BASE_URL + "get/this/customer/address/details?customer_id="
        static let EditAddressDetails                               = BASE_URL + "update/customer/address/details"
        static let AddNewAddressDetails                             = BASE_URL + "add/new/customer/address/details"
        static let MarkAsDefaultAddress                             = BASE_URL + "mark/this/customer/address/as/default/address?customer_id="
        static let DeleteAddress                                    = BASE_URL + "delete/customer/address/details?customer_id="
        
        static let FevarateProducts                                 = BASE_URL + "get/this/customer/favorite/products/list?customer_id="
        static let FevarateSellers                                  = BASE_URL + "get/this/customer/favorite/sellers/list?customer_id="
        
        
        //MARK:- Seller Shop :-
        
        static let SellerShopDetailsgetApi                           = BASE_URL + "get/seller/shop/details/for/customer?"
        static let SellerShopAllCategorysDetailsgetApi               = BASE_URL + "get/seller/all/active/subcategories/list/for/customer?"
        static let SellerShopSelectedProductList                     = BASE_URL + "get/this/seller/products/list"
        static let SellerShopSelectedProductListBySearchword         = BASE_URL + "get/this/seller/shop/products/search/suggestion/result"
        static let CartCountAPI                                      = BASE_URL + "get/customer/order/and/cart/counts"
        static let SellerRatingAndReviews                            = BASE_URL + "get/this/seller/reviews/list/for/this/customer"
        
        //MARK:- My Cart :-
        static let GetCartDetailsApi                                 = BASE_URL + "get/this/customer/cart/details"
        static let RemoveAllProductsFromCartApi                      = BASE_URL + "remove/all/items/from/customer/cart"
        static let EditCartDetailsApi                                = BASE_URL + "get/this/cart/details/of/this/customer"
        
        static let GetProductSummaryApi                              = BASE_URL + "customer/confirm/order/placement"
        static let GetBackFromProductSummaryApi                      = BASE_URL + "back/from/order/summary"

        static let GetRedeemApi                                      = BASE_URL + "get/this/cart/details/of/this/customer"
        static let GetCurrentUserOffers                              = BASE_URL + "current/running/flower/bazaaar/buyers/offers"
        
        static let GetCurrentRewardsTransList                  = BASE_URL + "get/this/buyer/referral/details/summary"
        
        static let PlaceOrderApi                                      = BASE_URL + "get/this/cart/details/of/this/customer"
        
        static let PlaceOrderDetailsSaveInSeverApi                   = BASE_URL + "customer/final/order/placement"
        static let SelectPaymentMethodApi                            = BASE_URL + "customer/final/order/placement"

       
        static let QwickViewApi                                      = BASE_URL + "customer/quick/view/cart/confirmation/from/seller"
        
        static let RemoveSingleProductsFromCartApi                   = BASE_URL + "remove/item/from/this/cart/this/customer"
        static let EditSingleProductsFromCartApi                     = BASE_URL + "edit/item/this/cart/this/customer"
        
        
        static let RemoveProductFromCartApi                          = BASE_URL + "get/this/seller/products/list"
        static let GetConformationForProductINCartApi                = BASE_URL + "order/request/from/customer/to/seller"
        static let GetConformationForMultiPuleProductINCartApi       = BASE_URL + "get/this/seller/products/list"
        static let PlaceOrderForSingleProductINCartApi               = BASE_URL + "get/this/seller/products/list"
        static let PlaceOrderForMultiPuleProductINCartApi            = BASE_URL + "get/this/seller/products/list"
        static let ModeOfTransportationCartApi                       = BASE_URL + "mode/of/transport/of/this/cart/customer"
        static let SaveModeOftransportationCartApi                   = BASE_URL + "save/mode/of/transport/of/this/cart/customer"

        
        
        //MARK:- My Account
        static let GetProfileFullDetails                             = BASE_URL +  "get/customer/profile/page/data"
        static let UpdateProfileFullDetails                          = BASE_URL +  "update/customer/profile/details"
        static let DeleteProfilePic                                  = BASE_URL +  "delete/customer/profile/photo"
        static let GetChatDetails                                    = BASE_URL +  "get/this/customer/seller/chat/details"
        static let GetAudioVideoCallToken                            = BASE_URL +  "generate/token/from/agora"
        static let EndAudioVideoCall                                 = BASE_URL +  "end/agora/call"
        static let AcceptingAudioVideoCall                           = BASE_URL +  "call/accepted"
        static let UplaodFilesToServer                               = BASE_URL +  "chat/buyer/file/upload"
        
        //MARK:- My Orders List
        
        static let MyorderListAPI                                       = BASE_URL +  "get/this/customer/orders/list"
        static let CancelMyorderAPI                                     = BASE_URL +  "buyer/cancel/order/by/buyer"
       
        static let MyorderDetailsAPI                                    = BASE_URL +  "get/this/order/details/this/customer"
        static let MyorderStatusChangeAPI                               = BASE_URL +  "mark/this/order/has/delivered/by/buyer"
        
        
        //MARK:- My Bills List
        static let MyBillsListAPI                                       = BASE_URL +  "get/this/customer/bills/details/list/data"
        
        //MARK:- Get Feedback And Sellers List
        static let getFeedBackSellersList                                       = BASE_URL +  "rate/and/feedback/sellers/details/customer"
        static let getFeedBackSellersRatingSubmit                               = BASE_URL +  "add/customer/ratings/and/feedback/to/this/sellers"
        static let RatingsAndReviewsList                                 = BASE_URL + "get/this/seller/buyer/orders/ratings/reviews/list"
        
        
        //MARK:- Get FAQ List
        
        static let getFAQListApi                                           = BASE_URL +  "get/faqs/questions/list"
        static let getFAQListDetailsApi                                    = BASE_URL +  "get/faqs/question/answer/details"
        
        //MARK:- Buyer Support And policies
        
    static let getsupportandPoliciesDetailsApi                          = BASE_URL + "get/buyer/tickets/data"
        static let RaiseTicketApi                                       = BASE_URL + "raise/ticket/from/customer"
        static let RaiseTicketListApi                                   = BASE_URL + "get/customer/tickets/list/by/ticketstate"
        static let GiveFeedBackToExistingTicketApi                                   = BASE_URL + "get/ratings/and/feedback/closed/ticket/buyer"
        static let ReOpenTicketApi                                   = BASE_URL + "reopen/buyer/ticket"
        
        
        //MARK:- Get Referral Code
        static let GetReferrelCodeApi                                 = BASE_URL + "get/this/buyer/referral/code"

    }
}


