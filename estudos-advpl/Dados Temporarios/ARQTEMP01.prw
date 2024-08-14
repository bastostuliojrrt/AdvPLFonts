#INCLUDE 'protheus.ch'

User Function ARQTEMP01()

          rpcSetEnv('01','010101')

          // Estrutura dos campos do aCampos
          Local aCampos := {{"ENTIDADE","C",3,0},{"CODIGO","C",6,0},{"LOJA","C",2,0},{"NOME","C",30,0}}

          // A fun��o criatrab precisa de um array de campos e um boolean pra indicar se a area deve ser criada
          cArqTrab := criatrab(aCampos,.T.)

          // Disponibilizando o cArqTrab como �rea de trabalho
          dbUseArea(.T.,,cArqTrab,cArqTrab,.T.,.F.)

          // Criando um index para a �rea de trabalho tempor�ria
          (cArqTrab)->(dbCreateIndex(cArqTrab +'1',"CODIGO+LOJA+ENTIDADE",{|| CODIGO+LOJA+ENTIDADE},.T.))

          // Setando o index da �rea de trabalho tempor�ria
          dbSetIndex(cArqTrab+'1')

          // Populando o arquivo tempor�rio com a SA1
          SA1->(dbSetOrder(1))

          while .not. SA1->(EOF())

              reclock(cArqTrab,.T.)

                CODIGO    := SA1->A1_COD
                LOJA      := SA1->A1_LOJA
                NOME      := SA1->A1_NOME
                ENTIDADE  := SA1->(alias())

              msUnlock()

              SA1->(dbSkip())

          Enddo

          // Populando a tabela atrav�s de outra maneira
          dbSelectArea('SA2')
          dbSetOrder(1)

          // Como foi feito um dbSelectArea('SA2') antes, ent�o o EOF() j� se refere a SA2 fazendo com que eu n�o precise especificar, como o exemplo anterior.
          while .not. EOF()

            (cArqTrab)->(reclock(cArqTrab,.T.))
              
              (cArqTrab)->CODIGO    := A2_COD
              (cArqTrab)->LOJA      := A2_LOJA
              (cArqTrab)->NOME      := A2_NOME
              (cArqTrab)->ENTIDADE  := alias() // A fun��o Alias() retorna o alias da tabela que est� sendo usada como principal

            (cArqTrab)->(msunlock())

            dbSkip()

          Enddo

          // Excluindo o arquivo da �rea de trabalho tempor�ria

          (cArqTrab)->(dbCloseArea())

          // A fun��o File() verifica se um arquivo existe 
          if File('\system\' + cArqTrab + '.dtc')

            // FErase() deleta o arquivo
            FErase('\system\' + cArqTrab + '.dtc')

          Endif

          // Realizando a exclus�o tamb�m do arquivo de �ndice 
          if File('\system\' + cArqTrab + '1.cdx')

            FErase('\system\' + cArqTrab + '1.cdx')

          Endif
          
          rpcClearEnv()

Return
