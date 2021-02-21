*&---------------------------------------------------------------------*
*& Report zalv_example_2_layout
*&---------------------------------------------------------------------*
*& Objetivo: Ejemplos para entender como utilizar la clase ZCL_CA_ALV
*& Descripción: Ejemplo cambiando el layout del ALV
*&---------------------------------------------------------------------*
report zalv_example_2_layout.

start-of-selection.

  select bname, gltgv, gltgb, uflag
         from usr02
         into table @data(mt_datos).

end-of-selection.

  data(mo_alv) = new zcl_ca_alv(  ).

  MO_ALV->CREATE_ALV(
    EXPORTING
      IV_PROGRAM        = SY-REPID
    CHANGING
      CT_DATA           = MT_DATOS
    EXCEPTIONS
      ERROR_CREATE_ALV  = 1
      OTHERS            = 2 ).

  if sy-subrc <> 0.
    write:/ 'Error crear ALV'.
  else.
    "Opciones de layout
    "Columnas optimizadas
    mo_alv->set_optimized_cols( abap_true ).

    "Todas las funciones ALV por defecto
    mo_alv->set_alv_functions( abap_true ).

    "Permitir la grabación de variantes
    mo_alv->set_manag_layout( ).

    "Título del programa
    mo_alv->set_title( |{  sy-title }| ).

    "Método seleccion de filas
    mo_alv->set_selection_mode( if_salv_c_selection_mode=>multiple ).

    mo_alv->show_alv( ).
  endif.
