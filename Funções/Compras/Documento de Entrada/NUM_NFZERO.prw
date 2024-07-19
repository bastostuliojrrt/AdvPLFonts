#include "rwmake.ch"       
/*/{Protheus.doc} NUM_NFZERO

Funcao utilizada para colocar zeros a esquerda na entrada da NF

@type user function
@Tulio Bastos
@since 19/07/2024
@version 1.0
@param param_name, param_type, param_descr
@return return_var, return_type, return_description
@example
(examples)
@see (links_or_references)
/*/


//Colocar no X3_VLDUSER do campo F1_DOC --> U_NUM_NFZERO(9)

User Function NUM_NFZERO(ntam)     
   CNFISCAL := STRZERO(VAL(CNFISCAL),ntam)           
Return(.T.)
