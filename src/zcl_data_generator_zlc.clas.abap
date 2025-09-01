CLASS zcl_DATA_GENERATOR_zlc DEFINITION

  PUBLIC

  FINAL

  CREATE PUBLIC .


  PUBLIC SECTION.

    INTERFACES:

      if_oo_adt_classrun.

  PROTECTED SECTION.

  PRIVATE SECTION.

ENDCLASS.



CLASS zcl_DATA_GENERATOR_zlc IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

    " delete existing entries in the database table

    DELETE FROM ztravel_techmzlc.

    DELETE FROM zBOOKING_techmlc.

    DELETE FROM zbooksuppltechlc.

    COMMIT WORK.

    " insert travel demo data

    INSERT ztravel_techmzlc FROM (

        SELECT *

          FROM /dmo/travel_m

      ).

    COMMIT WORK.



    " insert booking demo data

    INSERT zbooking_techmlc FROM (

        SELECT *

          FROM   /dmo/booking_m

*            JOIN ztravel_tech_m AS z

*            ON   booking~travel_id = z~travel_id



      ).

    COMMIT WORK.

    INSERT zbooksuppltechlc FROM (

        SELECT *

          FROM   /dmo/booksuppl_m

*            JOIN ztravel_tech_m AS z

*            ON   booking~travel_id = z~travel_id



      ).

    COMMIT WORK.



    out->write( 'Travel and booking demo data inserted.').





  ENDMETHOD.

ENDCLASS.
