* not working
* try 2 classes
CLASS zcl_fill_bank_table_jp DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_FILL_BANK_TABLE_JP IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

    CONSTANTS:
      spc             TYPE string VALUE `&nbsp;&nbsp;`,
      carriage_return TYPE string VALUE cl_abap_char_utilities=>newline.

    DATA: lt_accounts TYPE TABLE OF zaccounts_jp3.

    "read current timestamp
    GET TIME STAMP FIELD DATA(zv_tsl).

    "fill internal table
    lt_accounts = VALUE #(
        ( client ='100' account_number ='00000001' bank_customer_id ='100001' bank_name ='Volksbank' city = 'Gaertringen' balance ='200.00 ' currency ='EUR' account_category ='01' lastchangedat = zv_tsl )
        ( client ='100' account_number ='00000002' bank_customer_id ='200002' bank_name ='Sparkasse' city ='Schwetzingen' balance ='500.00 ' currency ='EUR' account_category ='02' lastchangedat = zv_tsl )
        ( client ='100' account_number ='00000003' bank_customer_id ='200003' bank_name ='Commerzbank' city ='Nuernberg' balance ='150.00 ' currency ='EUR' account_category ='02' lastchangedat = zv_tsl )
     ).

    "Delete possible entries; insert new entries
    DELETE FROM zaccounts_jp3.


    INSERT zaccounts_JP3 FROM TABLE @lt_accounts.

    out->write( sy-dbcnt ).
    out->write(  'DONE!' ).

    " Select 3 fields and display in console - WORKS
*    SELECT FROM zaccounts_jp3
*      FIELDS  account_number AS account,
*              bank_name AS bank,
*              bank_customer_id AS customer
*      ORDER BY
*              bank_name,
*              bank_customer_id,
*              account_number
*      INTO TABLE @DATA(result).
*
*      out->write( EXPORTING
*                      name = 'Accounts'
*                      data = result ).


    " Inner join - doesn't work
*    SELECT FROM zaccounts_jp3
*      INNER JOIN /dmo/customer
*         ON zaccounts_jp3~bank_customer_id = /dmo/customer~customer_id
*         FIELDS   zaccounts_jp3~bank_customer_id AS CustomerID,
*                  zaccounts_jp3~bank_name AS bank
**                  , /dmo/customer~city AS city
*          ORDER BY CustomerID, bank
**          , city
*          INTO TABLE @DATA(result_join).

* COMMENT OUT AT END
*    out->write(
*        EXPORTING
*            name = 'Banks'
*            data = result_join ).

    "Check result in console


  ENDMETHOD.
ENDCLASS.
