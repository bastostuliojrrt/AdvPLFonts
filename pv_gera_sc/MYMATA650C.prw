#INCLUDE 'TOTVS.CH'
#INCLUDE 'PROTHEUS.CH'
#INCLUDE 'PARMTYPE.CH'
#INCLUDE "RWMAKE.CH"
 
/*/{Protheus.doc} MYMATA650C
   @type User Function
   @author Túlio Bastos
   @since 25/05/2023
   @version 1.0
   @see (https://tdn.totvs.com.br/pages/releaseview.action?pageId=612546305)
/*/

/*--------------------------------------------------------------------------------------------------------------*
 | P.E.:  M410MNU                                                                                               |
 | Desc:  Este fonte irá gerar uma solicitação de compra através do ExecAuto da rotina MATA650                  |
 |        (Ordem de Produção). Ele chama a tela de perguntas através do grupo de perguntas MTA651               |
 | Link:  http://tdn.totvs.com/pages/releaseview.action?pageId=6787737                                          |
 *--------------------------------------------------------------------------------------------------------------*/

User Function MYMATA650C()

// Chama o grupo de perguntas MTA651
If Pergunte("MTA651", .T., "Gera Solicitação")
   // Passa as perguntas como parametros para a funcao GERASC
   GERASC(MV_PAR01,MV_PAR02,MV_PAR03,MV_PAR04,MV_PAR05,MV_PAR06,MV_PAR07,MV_PAR08,MV_PAR09,MV_PAR10,MV_PAR11,MV_PAR12,MV_PAR13,MV_PAR14,MV_PAR15,MV_PAR16,MV_PAR17,MV_PAR18,MV_PAR19,MV_PAR20,MV_PAR21,MV_PAR22,MV_PAR23,MV_PAR24,MV_PAR25,MV_PAR26)

endif

Return .T.

// 

Static Function GERASC(MV_PAR01,MV_PAR02,MV_PAR03,MV_PAR04,MV_PAR05,MV_PAR06,MV_PAR07,MV_PAR08,MV_PAR09,MV_PAR10,MV_PAR11,MV_PAR12,MV_PAR13,MV_PAR14,MV_PAR15,MV_PAR16,MV_PAR17,MV_PAR18,MV_PAR19,MV_PAR20,MV_PAR21,MV_PAR22,MV_PAR23,MV_PAR24,MV_PAR25,MV_PAR26)

Local lAuto       := .T.
Local aParams     := {}
Local lMsErroAuto := .F.
Local aArea       := GetArea()

// Adiciona ao aParams os valores de cada pergunta
aadd(aParams,{"MV_PAR01",              MV_PAR01})//Mostra Pedido com OP ? 1- Sim 2- Nao
aadd(aParams,{"MV_PAR02",              MV_PAR02})//Produto Sem Estrutura Gera ? 1- Ordem de Prod. 2- Solic. Compra 3- Nenhum
aadd(aParams,{"MV_PAR03",              MV_PAR03})//Do Cliente?
aadd(aParams,{"MV_PAR04",              MV_PAR04})//Ate o Cliente?
aadd(aParams,{"MV_PAR05",              MV_PAR05})//Do Produto?
aadd(aParams,{"MV_PAR06",              MV_PAR06})//Ate o Produto?
aadd(aParams,{"MV_PAR07",              MV_PAR07})//Da Data de Entrega? 
aadd(aParams,{"MV_PAR08",              MV_PAR08})//Ate a Data de Entrega?
aadd(aParams,{"MV_PAR09",              MV_PAR09})//Da TES?
aadd(aParams,{"MV_PAR10",              MV_PAR10})//Ate a TES?
aadd(aParams,{"MV_PAR11",              MV_PAR11})//Considerar Armazem Padrao? 1- Sim 2- Nao
aadd(aParams,{"MV_PAR12",              MV_PAR12})//Liberar Bloqueio de Credito? 1- Sim 2- Nao
aadd(aParams,{"MV_PAR13",              MV_PAR13})//Numero Inicial OP?
aadd(aParams,{"MV_PAR14",              MV_PAR14})//Do Pedido?
aadd(aParams,{"MV_PAR15",              MV_PAR15})//Ate o Pedido?
aadd(aParams,{"MV_PAR16",              MV_PAR16})//Do Armazem?
aadd(aParams,{"MV_PAR17",              MV_PAR17})//Ate o Armazem?
aadd(aParams,{"MV_PAR18",              MV_PAR18})//Avalia o Pedido de Venda? 1- Individualmente 2- Agrupadamente
aadd(aParams,{"MV_PAR19",              MV_PAR19})//Qtd da Geracao OPs e SCs? 1- LE Padrao 2- Sem LE 3- LE Somados
aadd(aParams,{"MV_PAR20",              MV_PAR20})//Mostra apenas PV liber. cred? 1- Sim 2- Nao
aadd(aParams,{"MV_PAR21",              MV_PAR21})//Cons. Saldos de Armazens? 1- Sim 2- Nao
aadd(aParams,{"MV_PAR22",              MV_PAR22})//Exibe PV c/ Fat. Parcial? 1- Sim 2- Nao
aadd(aParams,{"MV_PAR23",              MV_PAR23})//Avaliar os PVs Priorizando? 1- Num. Pedido 2- Data de Entrega
aadd(aParams,{"MV_PAR24",              MV_PAR24})//Considera Est. Seguranca? 1- Sim 2- Nao
aadd(aParams,{"MV_PAR25",              MV_PAR25})//Considera Qtd Liberada PV? 1- Sim 2- Nao
aadd(aParams,{"MV_PAR26",              MV_PAR26})//Considera Est Seguranca PI? 1- Sim 2- Nao

MSExecAuto({|x,y,z,b,c| MATA650C(x,y,z,b,c)},,,,lAuto,aParams) //

If lMsErroAuto
    Alert("Erro")
    MostraErro()
else
   ApMsgInfo("Solicitações geradas.")
endif

RestArea(aArea) 

Return lAuto
