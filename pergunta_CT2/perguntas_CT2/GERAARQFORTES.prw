#Include "Protheus.ch"

/*/{Protheus.doc} ARQFORTES
escription)
   @type  User Function
   @author Túlio Bastos
   @since 29/05/2023
   @version 1.0
/*/

/*--------------------------------------------------------------------------------------------------------------*
 | P.E.:  Fonte PERGARQFORTES.prw                                                                               |
 | Desc:  Este fonte irá criar um arquivo e escrever nele as linhas de acordo com o select realiado dos campos  |
 |        específicos                                                                                           |
 *--------------------------------------------------------------------------------------------------------------*/

User Function GERAARQFORTES (dData1, dData2)

Local dData   := dtos(ddatabase)
Local cAlias  := GetNextAlias() //Declarei meu ALIAS
Local cDir    := "C:\TOTVS12\Protheus\Protheus\my projects\pancristal\TXT\"
Local cArq    := dData + ".txt"
//FCreate - É o comando responsavel pela criação do arquivo.
Local nHandle := FCreate(cDir+cArq)

//nHandle - A função FCreate retorna o handle, que indica se foi possível ou não criar o arquivo. Se o valor for
//menor que zero, não foi possível criar o arquivo.
If nHandle < 0
	MsgAlert("Erro durante criação do arquivo.")
Else

  //COMEÇO A MINHA CONSULTA SQL
  BeginSql Alias cAlias
      SELECT CT2_FILIAL,CT2_DATA,CT2_DEBITO,CT2_CREDIT,CT2_VALOR,CT2_HIST,CT2_CCD,CT2_CCC FROM %table:CT2% CT2
      WHERE CT2.%notdel% AND CT2.CT2_DATA BETWEEN %exp:dData1% AND %exp:dData2%
  EndSql //FINALIZO A MINHA QUERY
	
  //FWrite - Comando reponsavel pela gravação do texto.
  While !(cAlias)->(Eof())

    Do Case
      Case CT2_FILIAL == '01'
        FWrite(nHandle, "1"+";"+CT2_DATA+";"+AllTrim(CT2_DEBITO)+";"+AllTrim(CT2_CREDIT)+";"+cValToChar(CT2_VALOR)+";"+AllTrim(CT2_HIST)+";"+"0001"+";"+AllTrim(CT2_CCD)+";"+"0001"+";"+AllTrim(CT2_CCC) + CRLF)
      
      Case CT2_FILIAL == '02'
        FWrite(nHandle, "1"+";"+CT2_DATA+";"+AllTrim(CT2_DEBITO)+";"+AllTrim(CT2_CREDIT)+";"+cValToChar(CT2_VALOR)+";"+AllTrim(CT2_HIST)+";"+"0002"+";"+AllTrim(CT2_CCD)+";"+"0002"+";"+AllTrim(CT2_CCC) + CRLF)
      
      Case CT2_FILIAL == '03'
        FWrite(nHandle, "1"+";"+CT2_DATA+";"+AllTrim(CT2_DEBITO)+";"+AllTrim(CT2_CREDIT)+";"+cValToChar(CT2_VALOR)+";"+AllTrim(CT2_HIST)+";"+"0004"+";"+AllTrim(CT2_CCD)+";"+"0004"+";"+AllTrim(CT2_CCC) + CRLF)
      
      Case CT2_FILIAL == '04'
        FWrite(nHandle, "1"+";"+CT2_DATA+";"+AllTrim(CT2_DEBITO)+";"+AllTrim(CT2_CREDIT)+";"+cValToChar(CT2_VALOR)+";"+AllTrim(CT2_HIST)+";"+"0007"+";"+AllTrim(CT2_CCD)+";"+"0007"+";"+AllTrim(CT2_CCC) + CRLF)
      
      Case CT2_FILIAL == '05'
        FWrite(nHandle, "1"+";"+CT2_DATA+";"+AllTrim(CT2_DEBITO)+";"+AllTrim(CT2_CREDIT)+";"+cValToChar(CT2_VALOR)+";"+AllTrim(CT2_HIST)+";"+"0009"+";"+AllTrim(CT2_CCD)+";"+"0009"+";"+AllTrim(CT2_CCC) + CRLF)
      
      Case CT2_FILIAL == '06'
        FWrite(nHandle, "1"+";"+CT2_DATA+";"+AllTrim(CT2_DEBITO)+";"+AllTrim(CT2_CREDIT)+";"+cValToChar(CT2_VALOR)+";"+AllTrim(CT2_HIST)+";"+"0008"+";"+AllTrim(CT2_CCD)+";"+"0008"+";"+AllTrim(CT2_CCC) + CRLF)

      Case CT2_FILIAL == '07'
        FWrite(nHandle, "1"+";"+CT2_DATA+";"+AllTrim(CT2_DEBITO)+";"+AllTrim(CT2_CREDIT)+";"+cValToChar(CT2_VALOR)+";"+AllTrim(CT2_HIST)+";"+"0010"+";"+AllTrim(CT2_CCD)+";"+"0010"+";"+AllTrim(CT2_CCC) + CRLF)

      Otherwise
      
    EndCase    
	
	  (cAlias)->(dbSkip()) //PASSAR PARA O PRÓXIMO REGISTRO                                    
  enddo

	//FClose - Comando que fecha o arquivo, liberando o uso para outros programas.
	FClose(nHandle)

  MsgInfo("Arquivo gerado na pasta " + cDir,"Processo finalizado.")

EndIf

Return
