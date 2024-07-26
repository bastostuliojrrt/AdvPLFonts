#Include 'Protheus.ch'
#Include "rwmake.ch"
#Include "topconn.ch"

/*/{Protheus.doc} MTA110MNU

Adicionando a função F4 para consulta de estoque na rotina MATA110 - Solicitações de Compras

@type user function
@Tulio Bastos
@since 26/07/2024
@version v2.0
@example
(examples)
@see (links_or_references)
/*/

User Function MTA110MNU()

  SetKey(VK_F4, { || MTA110F4() })
    
Return 

Static Function MTA110F4()

IF ALLTRIM(FUNNAME()) == "MATA110"           
	MaViewSB2(M->C1_PRODUTO)     
Else
	SetKey(VK_F4, { || })	
EndIf

Return
