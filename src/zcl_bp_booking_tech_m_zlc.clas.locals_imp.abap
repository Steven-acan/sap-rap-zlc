CLASS lhc_zi_booking_tech_m_zlc DEFINITION INHERITING FROM cl_abap_behavior_handler.

  PRIVATE SECTION.

    METHODS earlynumbering_cba_Bookingsupp FOR NUMBERING
      IMPORTING entities FOR CREATE ZI_BOOKING_TECH_M_ZLC\_Bookingsuppl.

ENDCLASS.

CLASS lhc_zi_booking_tech_m_zlc IMPLEMENTATION.

  METHOD earlynumbering_cba_Bookingsupp.


  ENDMETHOD.

ENDCLASS.

*"* use this source file for the definition and implementation of
*"* local helper classes, interface definitions and type
*"* declarations
