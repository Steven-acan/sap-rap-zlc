@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Travel Consumption'
@Metadata.ignorePropagatedAnnotations: true

@Metadata.allowExtensions: true
@Search.searchable: true
define root view entity ZC_TRAVEL_TECH_M_ZLC
  provider contract transactional_query
  as projection on ZI_TRAVEL_TECH_M_ZLC
{
  key TravelId,
  
      @ObjectModel.text:{
      element:['AgencyName']
      }
      AgencyId,
      
      _Agency.Name       as AgencyName,
      @ObjectModel.text.element:['CustomerName']
      CustomerId,
      _Customer.LastName as CustomerName,
      BeginDate,
      EndDate,
      @Semantics.amount.currencyCode: 'CurrencyCode'
      BookingFee,
      @Semantics.amount.currencyCode: 'CurrencyCode'
      TotalPrice,
      CurrencyCode,
      Description,
      @ObjectModel.text.element: [ 'OverallStatusText' ]
      OverallStatus,
      _Status._Text.Text as OverallStatusText: localized,
      CreatedBy,
      CreatedAt,
      LastChangedBy,
      LastChangedAt,
      /* Associations */
      _Agency,
      _Booking : redirected to composition child ZC_BOOKING_TECH_M_ZLC,
      _Currency,
      _Customer,
      _Status
}
