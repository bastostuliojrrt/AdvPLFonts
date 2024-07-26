#Include 'Protheus.ch'

User Function MTA110MNU()

//Customizações do cliente

aadd(aRotina,{'Consultar Estoque','U_zViewSB2()',0,3,0,NIL})
Return aRotina

Return

/*/{Protheus.doc} F4CONULT
scription)
  @type  Static Function
  @author user
  @since 26/07/2024
  @version version
  @param param_name, param_type, param_descr
  @return return_var, return_type, return_description
  @example
  (examples)
  @see (links_or_references)
/*/

User Function zViewSB2()
    Local aArea    := FWGetArea()
 
    DbSelectArea('SB1')
    SB1->(DbSetOrder(1)) // B1_FILIAL + B1_COD
 
    //Se conseguir posicionar no produto
    If SB1->(DbSeek(FWxFilial('SB1') + M->C1_COD))
        MaViewSB2(SB1->B1_COD)
    EndIf
 
    FWRestArea(aArea)
Return

