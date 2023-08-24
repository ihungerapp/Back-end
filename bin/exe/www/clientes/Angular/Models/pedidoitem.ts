  export interface PedidoitemReq {
    id_consumo_ap?:number,
    codrecepcao:number,
    codprod:number,
    n_comanda_recepcao:number,
    qtde:number,
    vlrunitario:number,
    vlrtotalitem:number,
    data_consumo:Date,
    pedido_item_status:string,
    id_produto_precificacao:string,
    complemento:string
  }
  export interface Pedidoitem {
    id_consumo_ap?:number,
    codrecepcao:number,
    codprod:number,
    n_comanda_recepcao:number,
    qtde:number,
    vlrunitario:number,
    vlrtotalitem:number,
    data_consumo:Date,
    pedido_item_status:string,
    id_produto_precificacao:string,
    complemento:string
  }
  export interface Pedidoitems {  
    content: Pedidoitem[],     
    totalElements: number,   
    totalPages: number,      
    pageSize: number,        
    pageNumber: number       
 }                           
  export interface PedidoitemRes {
    content: {       
      id_consumo_ap?:number,
      codrecepcao:number,
      codprod:number,
      n_comanda_recepcao:number,
      qtde:number,
      vlrunitario:number,
      vlrtotalitem:number,
      data_consumo:Date,
      pedido_item_status:string,
      id_produto_precificacao:string,
      complemento:string
    },
    mensagem: string,
    sucesso: boolean 
  }
