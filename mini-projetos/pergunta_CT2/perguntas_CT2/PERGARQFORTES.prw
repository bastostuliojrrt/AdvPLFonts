/*/{Protheus.doc} PERGARQFORTES
escription)
   @type  User Function
   @author Túlio Bastos
   @since 29/05/2023
   @version 1.0
/*/

/*--------------------------------------------------------------------------------------------------------------*
 | P.E.:  Rotina Customizada                                                                                    |
 | Desc:  Este fonte irá executar as perguntas criadas no configurador                                          |
 | Link:  Perguntas do Usuário: https://tdn.totvs.com/pages/releaseview.action?pageId=22479548                  |
 *--------------------------------------------------------------------------------------------------------------*/
User Function PERGARQFORTES()
  If Pergunte("XFORTES",.T.,"Gerção Arquivo FORTES RH")
    U_GERAARQFORTES(MV_PAR01,MV_PAR02)
  EndIf
  
Return .T.
