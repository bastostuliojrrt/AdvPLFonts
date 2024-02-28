#INCLUDE 'Protheus.ch'
#INCLUDE 'totvs.ch'

User Function RLNFENT()

  Public pDtInicio    := ""
  Public pDtFim       := ""

  xParambox()
  Processa({||MntQry() },,"Processando...")
  MsAguarde({||GeraExcel()},,"O arquivo está sendo gerado...")

  DbSelectArea("TR1")
  DbCloseArea()

Return NIL

/*/{Protheus.doc} Pergs
  (long_description)
  @type  Static Function
  @author user
  @since 28/02/2024
  @version version
  @param param_name, param_type, param_descr
  @return return_var, return_type, return_description
  @example
  (examples)
  @see (links_or_references)
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

Static Function MntQry()

  Local cQuery := ''

  // Pega dados do banco
  cQuery += "SELECT "
  cQuery += " F1_DOC, "
  cQuery += " F1_SERIE, " 
  cQuery += " F1_FORNECE, " 
  cQuery += " F1_LOJA, "
  cQuery += " E2_NOMFOR, "
  cQuery += " F1_EMISSAO, " 
  cQuery += " F1_DTDIGIT, "
  cQuery += " F1_VALMERC, "
  cQuery += " E2_NATUREZ, "
  cQuery += " ED_DESCRIC "
  cQuery += "FROM"
  cQuery += " " + RetSQLName('SF1') + " "
  cQuery += " INNER JOIN " + RetSQLName('SE2') + " ON F1_DOC = E2_NUM AND E2_FILIAL = '" + FWxFilial('SE2') + "'"
  cQuery += " INNER JOIN " + RetSQLName('SED') + " ON E2_NATUREZ = ED_CODIGO "
  cQuery += "WHERE F1_DTDIGIT "
  cQuery += " BETWEEN " + "'" + pDtInicio + "'" + " AND " + "'" + pDtFim + "'"

  cQuery := ChangeQuery(cQuery)

  If Select("TR1") <> 0
    DbSelectArea("TR1")
    DbCloseArea()
  EndIf  

  DbUseArea(.T., "TOPCONN", TCGenQry(,,cQuery),'TR1',.F.,.T.)


Return


/*/{Protheus.doc} nomeStaticFunction
  (long_description)
  @type  Static Function
  @author user
  @since 28/02/2024
  @version version
  @param param_name, param_type, param_descr
  @return return_var, return_type, return_description
  @example
  (examples)
  @see (links_or_references)
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
  oExcel:AddColumn("NF", "Notas Fiscais de Entrada", "Documento",2,1)
  oExcel:AddColumn("NF", "Notas Fiscais de Entrada", "Serie",2,1)
  oExcel:AddColumn("NF", "Notas Fiscais de Entrada", "Cod. Fornecedor",2,1)
  oExcel:AddColumn("NF", "Notas Fiscais de Entrada", "Loja",2,1)
  oExcel:AddColumn("NF", "Notas Fiscais de Entrada", "Razao Social",2,1)
  oExcel:AddColumn("NF", "Notas Fiscais de Entrada", "Dt. Emissao",2,4)
  oExcel:AddColumn("NF", "Notas Fiscais de Entrada", "Dt. Digitacao",2,4)
  oExcel:AddColumn("NF", "Notas Fiscais de Entrada", "Valor Total",2,3)
  oExcel:AddColumn("NF", "Notas Fiscais de Entrada", "Cod. Natureza",2,1)
  oExcel:AddColumn("NF", "Notas Fiscais de Entrada", "Dsc. Natureza",2,1)

  While TR1->(!EoF())

    // Adicionando linhas
    oExcel:AddRow("NF","Notas Fiscais de Entrada",{TR1->(F1_DOC),TR1->(F1_SERIE),TR1->(F1_FORNECE),TR1->(F1_LOJA),TR1->(E2_NOMFOR),SToD(TR1->(F1_EMISSAO)),SToD(TR1->(F1_DTDIGIT)),TR1->(F1_VALMERC),TR1->(E2_NATUREZ),TR1->(ED_DESCRIC)})

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
