#include "totvs.ch"
#include "protheus.ch"

/*/{Protheus.doc} TstXlsx
    Função de teste da classe FWMsExcelXlsx - u_TstXlsx()
@link
    Link para download os requisitos
    AppServer Build 19.3.1.1    : https://suporte.totvs.com/portal/p/10098/download?e=947528
    SmartClient Build 19.3.1.1  : https://suporte.totvs.com/portal/p/10098/download?e=947510
    LIB Label 20201009          : https://suporte.totvs.com/portal/p/10098/download?e=989259
    INCLUDES 20201007           : https://suporte.totvs.com/portal/p/10098/download?e=491499
    TOTVS Printer 2.1.0 Win_x64 : https://suporte.totvs.com/portal/p/10098/download?e=693168
/*/

User Function TESTE(dData1,dData2)
    Local cData     := dtos(ddatabase)
    Local cAlias    := GetNextAlias() //Declarei meu ALIAS
    Local oExlXlsx  := Nil
    Local lRet      := .T.
    Local cPasta    := GetSrvProfString("RootPath","") + "\print\"
    Local oOpnXlsx  := Nil

    oExlXlsx := FwMsExcelXlsx():New()
    lRet := oExlXlsx:IsWorkSheet("Planilha_01")

//  FwMsExcelXlsx():AddWorkSheet(< cWorkSheet >)
    oExlXlsx:AddworkSheet("Planilha_01")
    lRet := oExlXlsx:IsWorkSheet("Planilha_01")

//  FwMsExcelXlsx():AddTable(< cWorkSheet >, < cTable >)
    oExlXlsx:AddTable ("Planilha_01","Tabela01")
//  FwMsExcelXlsx():AddColumn(< cWorkSheet >, < cTable >, < cColumn >, [< nAlign >], [< nFormat >], [< lTotal >], [ < cPicture >]) 
    oExlXlsx:AddColumn("Planilha_01","Tabela01","Tipo Registro",1,1)
    oExlXlsx:AddColumn("Planilha_01","Tabela01","Data Registro",1,4)
    oExlXlsx:AddColumn("Planilha_01","Tabela01","Cod. Conta Deb.",1,1)
    oExlXlsx:AddColumn("Planilha_01","Tabela01","Cod. Conta Cred.",1,1)
    oExlXlsx:AddColumn("Planilha_01","Tabela01","Valor",1,3,.F.,"999999999.99")
    oExlXlsx:AddColumn("Planilha_01","Tabela01","Historico",1,1)
    oExlXlsx:AddColumn("Planilha_01","Tabela01","Cod. Estab. Deb.",1,1)
    oExlXlsx:AddColumn("Planilha_01","Tabela01","Cod. Cent. Result. Deb",1,1)
    oExlXlsx:AddColumn("Planilha_01","Tabela01","Cod. Estab. Cred.",1,1)
    oExlXlsx:AddColumn("Planilha_01","Tabela01","Cod. Cent. Result. Cred",1,1)

    oExlXlsx:SetFont("Calibri")
    oExlXlsx:SetFontSize(16)
    oExlXlsx:SetItalic(.F.)
    oExlXlsx:SetBold(.F.)
    oExlXlsx:SetUnderline(.F.)

    //COMEÇO A MINHA CONSULTA SQL
    BeginSql Alias cAlias
		SELECT CT2_FILIAL,CT2_DATA,CT2_DEBITO,CT2_CREDIT,CT2_VALOR,CT2_HIST,CT2_CCD,CT2_CCC FROM %table:CT2% CT2
		WHERE CT2.%notdel% AND CT2.CT2_DATA BETWEEN %exp:dData1% AND %exp:dData2%
    EndSql //FINALIZO A MINHA QUERY

//  FwMsExcelXlsx():AddRow(< cWorkSheet >, < cTable >, < aRow >)
    While !(cAlias)->(Eof()) 
	    If CT2_FILIAL == '01'
            oExlXlsx:AddRow("Planilha_01","Tabela_01",{"1",stod(CT2_DATA),StrTran(CT2_DEBITO, " ",""),StrTran(CT2_CREDIT," ",""),CT2_VALOR,StrTran(CT2_HIST," ",""),"0001",StrTran(CT2_CCD," ",""),"0001",StrTran(CT2_CCC," ","")})
	        (cAlias)->(dbSkip()) //PASSAR PARA O PRÓXIMO REGISTRO
        elseif CT2_FILIAL == '02'
            oExlXlsx:AddRow("Planilha_01","Tabela_01",{"1",stod(CT2_DATA),StrTran(CT2_DEBITO, " ",""),StrTran(CT2_CREDIT," ",""),CT2_VALOR,StrTran(CT2_HIST," ",""),"0002",StrTran(CT2_CCD," ",""),"0002",StrTran(CT2_CCC," ","")})
	        (cAlias)->(dbSkip()) //PASSAR PARA O PRÓXIMO REGISTRO
        elseif CT2_FILIAL == '03'
            oExlXlsx:AddRow("Planilha_01","Tabela_01",{"1",stod(CT2_DATA),StrTran(CT2_DEBITO, " ",""),StrTran(CT2_CREDIT," ",""),CT2_VALOR,StrTran(CT2_HIST," ",""),"0004",StrTran(CT2_CCD," ",""),"0004",StrTran(CT2_CCC," ","")})
	        (cAlias)->(dbSkip()) //PASSAR PARA O PRÓXIMO REGISTRO
        elseif CT2_FILIAL == '04'
            oExlXlsx:AddRow("Planilha_01","Tabela_01",{"1",stod(CT2_DATA),StrTran(CT2_DEBITO, " ",""),StrTran(CT2_CREDIT," ",""),CT2_VALOR,StrTran(CT2_HIST," ",""),"0007",StrTran(CT2_CCD," ",""),"0007",StrTran(CT2_CCC," ","")})
	        (cAlias)->(dbSkip()) //PASSAR PARA O PRÓXIMO REGISTRO
        elseif CT2_FILIAL == '05'
            oExlXlsx:AddRow("Planilha_01","Tabela_01",{"1",stod(CT2_DATA),StrTran(CT2_DEBITO, " ",""),StrTran(CT2_CREDIT," ",""),CT2_VALOR,StrTran(CT2_HIST," ",""),"0009",StrTran(CT2_CCD," ",""),"0009",StrTran(CT2_CCC," ","")})
	        (cAlias)->(dbSkip()) //PASSAR PARA O PRÓXIMO REGISTRO
        elseif CT2_FILIAL == '06'
            oExlXlsx:AddRow("Planilha_01","Tabela_01",{"1",stod(CT2_DATA),StrTran(CT2_DEBITO, " ",""),StrTran(CT2_CREDIT," ",""),CT2_VALOR,StrTran(CT2_HIST," ",""),"0008",StrTran(CT2_CCD," ",""),"0008",StrTran(CT2_CCC," ","")})
	        (cAlias)->(dbSkip()) //PASSAR PARA O PRÓXIMO REGISTRO
        elseif CT2_FILIAL == '07'
            oExlXlsx:AddRow("Planilha_01","Tabela_01",{"1",stod(CT2_DATA),StrTran(CT2_DEBITO, " ",""),StrTran(CT2_CREDIT," ",""),StrTran(CT2_VALOR," ",""),StrTran(CT2_HIST," ",""),"0010",StrTran(CT2_CCD," ",""),"0010",StrTran(CT2_CCC," ","")})
	        (cAlias)->(dbSkip()) //PASSAR PARA O PRÓXIMO REGISTRO            
        EndIf
                                           
    enddo

    cPasta += cData + ".csv"

    oExlXlsx:Activate()

    oExlXlsx:GetXMLFile( cPasta )

        oOpnXlsx:= MsExcel():New()
        oOpnXlsx:WorkBooks:Open( cPasta )
        oOpnXlsx:SetVisible(.T.)
        oOpnXlsx:Destroy()

    oExlXlsx:DeActivate()

Return
