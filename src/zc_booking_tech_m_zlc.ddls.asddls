@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Booking Consumption'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
define view entity ZC_BOOKING_TECH_M_ZLC 
as projection on ZI_BOOKING_TECH_M_ZLC
{
    key TravelId,
    key BookingId,
    BookingDate,
    CustomerId,
    @ObjectModel.text.element: [ 'CarrierName' ]
    CarrierId,
    _Carrier.Name as CarrierName,
    ConnectionId,
    FlightDate,
    @Semantics.amount.currencyCode: 'CurrencyCode'
    FlightPrice,
    CurrencyCode,
    
    @ObjectModel.text.element:['BookingStatusText']
    BookingStatus,
    
    _Booking_Status._Text.Text as BookingStatusText: localized,
    
    LastChangedAt,
    /* Associations */
    _Bookingsuppl: redirected to composition child ZC_BOOKINGSUPPL_TECH_M_ZLC,
    _Booking_Status,
    _Carrier,
    _Connection,
    _Customer,
    _Travel: redirected to parent ZC_TRAVEL_TECH_M_ZLC
}
