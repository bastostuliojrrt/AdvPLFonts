#INCLUDE 'TOTVS.CH'
#INCLUDE 'PROTHEUS.CH'
#INCLUDE 'PARMTYPE.CH'
#INCLUDE "RWMAKE.CH"
 
 /*/{Protheus.doc} GERASC
escription)
   @type  User Function
   @author Túlio Bastos
   @since 25/05/2023
   @version 2.0
   @see (https://tdn.totvs.com.br/pages/releaseview.action?pageId=612546305)
/*/

/*--------------------------------------------------------------------------------------------------------------*
 | P.E.:  M410MNU                                                                                               |
 | Desc:  Este fonte irá gerar uma solicitação de compra através do ExecAuto da rotina MATA650                  |
 |        (Ordem de Produção). Ele chama a tela de perguntas através do grupo de perguntas MTA651               |
 | Link:  http://tdn.totvs.com/pages/releaseview.action?pageId=6787737                                          |
 *--------------------------------------------------------------------------------------------------------------*/

User Function MYMATA650C()
Local aArea       := GetArea()
Local lAuto       := .T.
Local aParams     := {} //Array para armazenar os valores das perguntas
Local lMsErroAuto := .F.
Local nY 


// Chama as perguntas do grupo MTA651
If Pergunte("MTA651", .T., "Gera Solicitação")
	
	// For utilizado para adicionar no aParams o valor de cada pergunta
	For nY := 1 To 26 // do 1 ao 26 pois existem 26 perguntas no grupo
		If nY < 10
			aAdd(aParams, {"MV_PAR0"+cValtoChar(nY), MV_PAR0&(+cValtoChar(nY))} )
		Else 
			aAdd(aParams, {"MV_PAR"+cValtoChar(nY), MV_PAR&(+cValtoChar(nY))} )
		EndIf 
	Next nY
	
	// ExecAuto passando o aParams
   MSExecAuto({|x,y,z,b,c| MATA650C(x,y,z,b,c)},,,,lAuto,aParams) //

	If lMsErroAuto
		Alert("Erro")
		MostraErro()
		lAuto := .F.
	else
	   ApMsgInfo("Solicitações geradas.")
	endif

endif

RestArea(aArea)

Return lAuto
