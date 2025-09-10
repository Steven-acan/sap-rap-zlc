CLASS zcl_read_entity_practicing DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_read_entity_practicing IMPLEMENTATION.
  METHOD if_oo_adt_classrun~main.

    READ ENTITY zi_travel_tech_m_zlc

    FROM VALUE #( ( %key-TravelId = '00000003'
                    %control-TravelId = if_abap_behv=>mk-on
                    %control-AgencyId = if_abap_behv=>mk-on
                    %control-customerid = if_abap_behv=>mk-on ) )
    RESULT DATA(lt_result_short)
    FAILED DATA(lt_failed).

    IF lt_failed IS NOT INITIAL.
      out->write( 'Read failed' ).
    ELSE.
      out->write( lt_result_short ).

    ENDIF.

  ENDMETHOD.
ENDCLASS.
