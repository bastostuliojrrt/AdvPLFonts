#Include "TOTVS.CH"

/*/{Protheus.doc} MA410MNU

Ponto de entrada disparado antes da abertura do Browse, caso Browse inicial da rotina esteja habilitado, ou antes da apresenta��o do Menu de op��es, caso Browse inicial esteja desabilitado.

@type function
@author T�lio Bastos
@since 25/05/2023

@history 
/*/
User Function MA410MNU()
	  If !IsBlind() 
               aAdd(aRotina,{'Gerar Solicitacoes','U_MYMATA650C',0,3,0,NIL})               
     EndIf 

Return Nil 
