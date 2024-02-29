#INCLUDE 'Protheus.ch'
#INCLUDE 'totvs.ch'


/*/{Protheus.doc} RLNFENT
Funcao usada para chamar as funcoes de montagem da query, criacao da parambox e geracao do relatorio em planilha
@type user function
@author Tulio Bastos
@since 28/02/2024
@version 1.0
/*/
User Function RLNFENT()

  Public pDtInicio    := ""
  Public pDtFim       := ""

  xParambox()
  Processa({||MntQry() },,"Processando...")
  MsAguarde({||GeraExcel()},,"O arquivo está sendo gerado...")

  DbSelectArea("TR1")
  DbCloseArea()

Return NIL

/*/{Protheus.doc} Funcao usada para criar caixa de parametros
  @type  Static Function
  @author Tulio Bastos
  @since 28/02/2024
  @version 1.0
/*/
Static Function xParambox()

    Local aPergs       := {}

    // [1] - Tipo 1 - MsGet
    // [2] - Descricao
    // [3] - String contendo o inicializador do campo
    // [4] - String contendo o Picture do campo
    // [5] - String contendo a validacao
    // [6] - Consulta F3
    // [7] - String contendo a validacao When
    // [8] - Tamanho do MsGet
    // [9] - Flag .T./.F. definide se a pergunta eh obrigatoria
    aadd(aPergs, {1, "Dt. Digit Ini", SToD(""), "", "", "", ".T.", 50, .T.})
    aadd(aPergs, {1, "Dt. Digit Fim", SToD(""), "", "", "", ".T.", 50, .T.})

    if Parambox(aPergs, "Informe os Parametros")
    
    pDtInicio := DToS(MV_PAR01)
    pDtFim := DToS(MV_PAR02)

    
        if (Empty(pDtInicio) .OR. Empty(pDtFim))
            MsgAlert("Uma das datas não foi informada. Preencha os campos de data corretamente.")
        else
            MntQry()
        endif
    endif
  
Return 

/*/{Protheus.doc} MntQry
  Funcao criada para realizar a montagem da query
  @type  Static Function
  @author Tulio Bastos
  @since 28/02/2024
  @version 1.0
/*/
Static Function MntQry()

  Local cQuery := ''

  // Pega dados do banco
  cQuery += "SELECT DISTINCT "
  cQuery += " F1_DOC, "
  cQuery += " F1_SERIE, " 
  cQuery += " F1_TIPO, "
  cQuery += " F1_FORNECE, " 
  cQuery += " F1_LOJA, "
  cQuery += " CASE WHEN F1_TIPO = 'N' THEN A2_NOME ELSE A1_NOME END 'NOME', "
  cQuery += " F1_EMISSAO, " 
  cQuery += " F1_DTDIGIT, "
  cQuery += " F1_VALMERC, "
  cQuery += " F1_DUPL "
  cQuery += " E2_NATUREZ, "
  cQuery += " ED_DESCRIC, "
  cQuery += " F1.D_E_L_E_T_ "
  cQuery += "FROM"
  cQuery += " " + RetSQLName('SF1') + " AS F1"
  cQuery += " LEFT JOIN " + RetSQLName('SE2') + " AS E2 ON F1_DOC = E2_NUM AND F1_FORNECE = E2_FORNECE AND E2_FILIAL = '" + FWxFilial('SE2') + "'"
  cQuery += " LEFT JOIN " + RetSQLName('SA1') + " AS A1 ON F1_FORNECE = A1_COD AND F1_LOJA = A1_LOJA "
  cQuery += " LEFT JOIN " + RetSQLName('SA2') + " AS A2 ON F1_FORNECE = A2_COD AND F1_LOJA = A2_LOJA "
  cQuery += " LEFT JOIN " + RetSQLName('SED') + " AS ED ON E2_NATUREZ = ED_CODIGO "
  cQuery += "WHERE F1_DTDIGIT "
  cQuery += " BETWEEN " + "'" + pDtInicio + "'" + " AND " + "'" + pDtFim + "'" + " AND F1.D_E_L_E_T_ = ' '"

  cQuery := ChangeQuery(cQuery)

  If Select("TR1") <> 0
    DbSelectArea("TR1")
    DbCloseArea()
  EndIf  

  DbUseArea(.T., "TOPCONN", TCGenQry(,,cQuery),'TR1',.F.,.T.)


Return


/*/{Protheus.doc} GeraExcel
  Funcao usada para realizar a montagem do relatorio em planilha
  @type  Static Function
  @author Tulio Bastos
  @since 28/02/2024
  @version 1.0
/*/
Static Function GeraExcel()
  
  Local oExcel := FWMSEXCEL() :New()
  Local lOk := .F.
  Local cArq := ""
  Local cDirTmp := "C:\TOTVS\"

  DBSelectArea("TR1")
  TR1->(DbGoTop())
  
  // Criando Area de trabalho
  oExcel:AddworkSheet("NF")
  oExcel:AddTable("NF", "Notas Fiscais de Entrada")

  // Adicionando colunas
  oExcel:AddColumn("NF", "Notas Fiscais de Entrada", "Documento",1,1)
  oExcel:AddColumn("NF", "Notas Fiscais de Entrada", "Serie",2,1)
  oExcel:AddColumn("NF", "Notas Fiscais de Entrada", "Tipo",2,1)
  oExcel:AddColumn("NF", "Notas Fiscais de Entrada", "Cod. Fornecedor",1,1)
  oExcel:AddColumn("NF", "Notas Fiscais de Entrada", "Loja",1,1)
  oExcel:AddColumn("NF", "Notas Fiscais de Entrada", "Razao Social",2,1)
  oExcel:AddColumn("NF", "Notas Fiscais de Entrada", "Dt. Emissao",2,4)
  oExcel:AddColumn("NF", "Notas Fiscais de Entrada", "Dt. Digitacao",2,4)
  oExcel:AddColumn("NF", "Notas Fiscais de Entrada", "Valor Total",2,3)
  oExcel:AddColumn("NF", "Notas Fiscais de Entrada", "Cod. Natureza",1,1)
  oExcel:AddColumn("NF", "Notas Fiscais de Entrada", "Dsc. Natureza",2,1)

  While TR1->(!EoF())

    // Adicionando linhas
    oExcel:AddRow("NF","Notas Fiscais de Entrada",{TR1->(F1_DOC),TR1->(F1_SERIE),TR1->(F1_TIPO),TR1->(F1_FORNECE),TR1->(F1_LOJA),TR1->NOME,SToD(TR1->(F1_EMISSAO)),SToD(TR1->(F1_DTDIGIT)),TR1->(F1_VALMERC),TR1->(F1_DUPL),TR1->(E2_NATUREZ),TR1->(ED_DESCRIC)})

    lOk := .T.
    TR1->(DBSkip())
  EndDo

  oExcel:Activate()

  cArq := CriaTrab(NIL, .F.) + ".xls"
  oExcel:GetXMLFile(cArq)

  if __CopyFile(cArq,cDirTmp + cArq)

    if lOk
      oExcelApp := MSExcel():New()
      oExcelApp:WorkBooks:Open(cDirTmp + cArq)
      oExcelApp:SetVisible(.T.)
      oExcelApp:Destroy()

      MsgInfo("Aquivo gerado no diretorio " + cDirTmp + cArq + " com sucesso.")  
    endif
    
  else

      MsgAlert("Erro ao criar o arquivo Excel.")

  endif


Return
