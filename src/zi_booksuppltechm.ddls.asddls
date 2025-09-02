@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Booking Supply'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZI_BOOKSUPPLTECHM
  as select from zbooksuppltechlc
  association        to parent ZI_BOOKING_TECH_M_ZLC as _Booking        on  $projection.TravelId  = _Booking.TravelId
                                                                        and $projection.BookingId = _Booking.BookingId
  association [1..1] to ZI_TRAVEL_TECH_M_ZLC         as _Travel         on  $projection.TravelId = _Travel.TravelId
  association [1..1] to /DMO/I_Supplement            as _Supplement     on  $projection.SupplementId = _Supplement.SupplementID
  association [1..*] to /DMO/I_SupplementText        as _SupplementText on  $projection.SupplementId = _SupplementText.SupplementID

{
  key travel_id             as TravelId,
  key booking_id            as BookingId,
  key booking_supplement_id as BookingSupplementId,
      supplement_id         as SupplementId,
      @Semantics.amount.currencyCode: 'CurrencyCode'
      price                 as Price,
      currency_code         as CurrencyCode,
      @Semantics.systemDateTime: { lastChangedAt: true, 
                                   localInstanceLastChangedAt: true }
      last_changed_at       as LastChangedAt,

      _Supplement,
      _SupplementText,
      _Booking,
      _Travel
}
