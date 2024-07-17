#INCLUDE 'totvs.ch'

/*/{Protheus.doc} User Function nomeFunction
  @type  Function
  @author Tulio Bastos
  @since 26/10/2023
  @version 1.0
  /*/
User Function variaveis()
  
  Local cTexto := 'Mensagem 1' //-- Escopo local determina que a variavel podera ser manipulada apenas na funcao em que foi declarada

  Private cTexto2 := 'Mensagem 2' //-- Escopo Private determina que a variavel podera ser manipulada no programa em que foi declarada e por todas as funcoes acionas a partir dele

  TESTE()

  FWAlertWarning(cTexto)

Return 

Static Function TESTE()
  
  fwAlertInfo(cTexto) //-- Note que a variavel na function 'variaveis' continua mostrando que ela nao esta sendo utilizada devido ao escopo Local
  fwAlertInfo(cTexto2) //-- Note que a variavel cTexto2 esta sendo utilizada nesta funcao devido ao seu escopo Private

Return 
