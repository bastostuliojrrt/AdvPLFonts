/*/{Protheus.doc} PERGARQFORTES
escription)
   @type  User Function
   @author T�lio Bastos
   @since 29/05/2023
   @version 1.0
/*/

/*--------------------------------------------------------------------------------------------------------------*
 | P.E.:  Rotina Customizada                                                                                    |
 | Desc:  Este fonte ir� executar as perguntas criadas no configurador                                          |
 | Link:  Perguntas do Usu�rio: https://tdn.totvs.com/pages/releaseview.action?pageId=22479548                  |
 *--------------------------------------------------------------------------------------------------------------*/
User Function PERGARQFORTES()
  If Pergunte("XFORTES",.T.,"Ger��o Arquivo FORTES RH")
    U_GERAARQFORTES(MV_PAR01,MV_PAR02)
  EndIf
  
Return .T.
