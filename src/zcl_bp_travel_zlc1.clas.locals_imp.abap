CLASS lhc_ZI_TRAVEL_TECH_M_ZLC DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      IMPORTING keys REQUEST requested_authorizations FOR zi_travel_tech_m_zlc RESULT result.
    METHODS earlynumbering_cba_booking FOR NUMBERING
      IMPORTING entities FOR CREATE zi_travel_tech_m_zlc\_booking.

    METHODS earlynumbering_create FOR NUMBERING
      IMPORTING entities FOR CREATE zi_travel_tech_m_zlc.

ENDCLASS.

CLASS lhc_ZI_TRAVEL_TECH_M_ZLC IMPLEMENTATION.

  METHOD get_instance_authorizations.
  ENDMETHOD.

  METHOD earlynumbering_create.

    DATA(lt_entities) = entities.
    DATA: lt_travel_tech_m TYPE TABLE FOR MAPPED EARLY zi_travel_tech_m_zlc.
    DATA: ls_travel_tech_m LIKE LINE OF lt_travel_tech_m.


    DELETE lt_entities WHERE TravelId IS NOT INITIAL.

    TRY.
        cl_numberrange_runtime=>number_get(
          EXPORTING
*      ignore_buffer     =
            nr_range_nr       = '01'
            object            =  '/DMO/TRV_M'
            quantity          = CONV #( lines( lt_entities ) )
*      subobject         =
*      toyear            =
          IMPORTING
            number            =  DATA(lv_latest_num)
            returncode        =  DATA(lv_code)
            returned_quantity =  DATA(lv_quantity) ).

        DATA(lv_curr_num) = lv_latest_num - lv_quantity.


      CATCH cx_nr_object_not_found.
      CATCH cx_number_ranges INTO DATA(lo_error).

        LOOP AT lt_entities INTO DATA(ls_entity).

          lv_curr_num += 1.

          APPEND VALUE #( %cid = ls_entity-%cid
                                      %key = ls_entity-%key )

      TO failed-zi_travel_tech_m_zlc.

          APPEND VALUE #( %cid = ls_entity-%cid
                                     %key = ls_entity-%key
                                 %msg = lo_error ) TO reported-zi_travel_tech_m_zlc.


        ENDLOOP.

    ENDTRY.

    ASSERT lv_quantity = lines( lt_entities ).



    LOOP AT lt_entities INTO ls_entity.

      lv_curr_num += 1.

      ls_travel_tech_m = VALUE #( %cid = ls_entity-%cid
                                  TravelId = lv_curr_num ) .

      APPEND ls_travel_tech_m TO mapped-zi_travel_tech_m_zlc.


    ENDLOOP.


  ENDMETHOD.

  METHOD earlynumbering_cba_Booking.

    DATA: lv_max_booking TYPE /dmo/booking_id.

    READ ENTITIES OF zi_travel_tech_m_zlc
    IN LOCAL MODE
    ENTITY zi_travel_tech_m_zlc BY \_Booking
    FROM CORRESPONDING #(  entities  )
    LINK DATA(lt_link_data).

    LOOP AT entities ASSIGNING FIELD-SYMBOL(<ls_group_entity>)
    GROUP BY <ls_group_entity>-TravelId.

      lv_max_booking = REDUCE #( INIT lv_max = CONV /dmo/booking_id(  '0' )
                                FOR ls_link IN lt_link_data USING KEY entity
                                WHERE (  source-TravelId = <ls_group_entity>-TravelId )
                                NEXT lv_max = COND /dmo/booking_id(  WHEN lv_max < ls_link-target-BookingId THEN ls_link-target-BookingId
                                ELSE lv_max ) ).

      lv_max_booking = REDUCE #( INIT lv_max = lv_max_booking
                                FOR ls_entity IN entities USING KEY entity
                                WHERE (  TravelId = <ls_group_entity>-TravelId )
                                 FOR ls_booking IN ls_entity-%target
                                NEXT lv_max = COND /dmo/booking_id(  WHEN lv_max < ls_booking-BookingId THEN ls_booking-BookingId
                                ELSE lv_max ) ).

      LOOP AT entities ASSIGNING FIELD-SYMBOL(<ls_entities>) USING KEY entity WHERE TravelId = <ls_group_entity>-TravelId.

        LOOP AT <ls_entities>-%target ASSIGNING FIELD-SYMBOL(<ls_booking>).

          IF <ls_booking>-BookingId IS INITIAL.

            lv_max_booking += 10.

            APPEND CORRESPONDING #( <ls_booking> ) TO mapped-zi_booking_tech_m_zlc ASSIGNING FIELD-SYMBOL(<ls_new_map_book>).

            <ls_new_map_book>-BookingId = lv_max_booking.


          ENDIF.

        ENDLOOP.


      ENDLOOP.

    ENDLOOP.

  ENDMETHOD.

ENDCLASS.
