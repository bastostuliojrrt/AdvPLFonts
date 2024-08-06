/*/{Protheus.doc} nomeFunction
  (long_description)
  @type  Function
  @author user
  @since 23/05/2023
  @version version
  @param param_name, param_type, param_descr
  @return return_var, return_type, return_description
  @example
  (examples)
  @see (links_or_references)
  /*/
User Function PERGPROD()
  If Pergunte("XPROD",.T.,"Relatório de Produtos")
    U_RELSLPR(MV_PAR01,MV_PAR02)
  EndIf
  
Return .T.
