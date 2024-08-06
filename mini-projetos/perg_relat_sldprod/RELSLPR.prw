#INCLUDE "TOPCONN.CH"
#INCLUDE "PROTHEUS.CH"                                                      

//Protheus-Construindo um relat�rio ADVPL em 5 minutos
User Function RELSLPR(sCod1, sCod2)
Local cAlias := GetNextAlias() //Declarei meu ALIAS

Private aCabec := {} //ARRAY DO CABE�ALHO
Private aDados := {} //ARRAY QUE ARMAZENAR� OS DADOS

//COME�O A MINHA CONSULTA SQL
BeginSql Alias cAlias
		SELECT B1_COD, B1_XCODFOR,B1_DESC, B2_LOCAL, B2_QATU FROM  %table:SB1%  SB1
		INNER JOIN  %table:SB2%  SB2 ON SB2.B2_COD = SB1.B1_COD   
		WHERE SB1.%notdel% AND SB2.%notdel% AND SB1.B1_COD BETWEEN %exp:sCod1% AND %exp:sCod2%
		//SELECT B1_COD,B1_XCODFOR,B1_DESC FROM %table:SB1% SB1
		//WHERE SB1.%notdel% AND SB1.B1_COD BETWEEN %exp:sCod1% AND %exp:sCod2%
EndSql //FINALIZO A MINHA QUERY
	
//CABE�ALHO
aCabec := {"CODIGO","COD PROD FORNEC","DESCRICAO","LOCAL","QUANTIDADE ATUAL"}

While !(cAlias)->(Eof())

	aAdd(aDados,{B1_COD,B1_XCODFOR,B1_DESC,B2_LOCAL,B2_QATU})
	//aAdd(aDados,{B1_COD,B1_XCODFOR,B1_DESC})
	
	(cAlias)->(dbSkip()) //PASSAR PARA O PR�XIMO REGISTRO                                    
enddo

//JOGO TODO CONTE�DO DO ARRAY PARA O EXCEL
DlgtoExcel({{"ARRAY","Relat�rio saldo f�sico de produtos por armazem", aCabec, aDados}})

	                                          
(cAlias)->(dbClosearea())	

return


