*&---------------------------------------------------------------------*
*& Report zalv_example_basic
*&---------------------------------------------------------------------*
*& Objetivo: Ejemplos para entender de como utilizar la clase ZCL_CA_ALV
*& Descripción: Ejemplo básico de un ALV sencillo sin opciones
*&---------------------------------------------------------------------*
REPORT zalv_example_basic.

TYPES: BEGIN OF ts_user,
         bname TYPE usr02-bname,
         gltgv TYPE usr02-gltgv,
         gltgb TYPE usr02-gltgb,
         uflag TYPE usr02-uflag,
       END OF ts_user.
TYPES: tt_user TYPE STANDARD TABLE OF ts_user.

START-OF-SELECTION.

  SELECT bname, gltgv, gltgb, uflag
         FROM usr02
         INTO TABLE @DATA(mt_datos).

END-OF-SELECTION.

  DATA(mo_alv) = NEW zcl_ca_alv(  ).

  mo_alv->create_alv(
    EXPORTING
      iv_program        = sy-repid
    CHANGING
      ct_data           = mt_datos
    EXCEPTIONS
      error_create_alv  = 1
      OTHERS            = 2
  ).

  IF sy-subrc <> 0.
    WRITE:/ 'Error crear ALV'.
  ELSE.
    mo_alv->show_alv( ).
  ENDIF.
