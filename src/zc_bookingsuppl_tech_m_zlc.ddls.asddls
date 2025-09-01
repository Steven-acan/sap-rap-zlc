@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'booking supply consumption'
@Metadata.ignorePropagatedAnnotations: true
@Search.searchable: true
@Metadata.allowExtensions: true
define view entity ZC_BOOKINGSUPPL_TECH_M_ZLC as projection on ZI_BOOKSUPPLTECHM
{
    key TravelId,
    key BookingId,
    @Search.defaultSearchElement: true
    key BookingSupplementId,
    
    @ObjectModel.text.element:['SupplemenDesc']
    SupplementId,
    _SupplementText.Description as SupplemenDesc: localized,
    @Semantics.amount.currencyCode: 'CurrencyCode'
    Price,
    CurrencyCode,
    LastChangedAt,
    /* Associations */
    _Booking: redirected to parent ZC_BOOKING_TECH_M_ZLC,
    _Supplement,
    _SupplementText,
    _Travel: redirected to ZC_TRAVEL_TECH_M_ZLC
}
