  export interface PedidoitemReq {
    id_pedido_item?:number,
    id_pedido:number,
    id_produto:number,
    qtde:number,
    valor_unitario:number,
    valor_total:number,
    data_hora_emissao:Date,
    data_hora_status:Date,
    pedido_item_status:string,
    id_produto_precificacao:string,
    obs:string
  }
  export interface Pedidoitem {
    id_pedido_item?:number,
    id_pedido:number,
    id_produto:number,
    qtde:number,
    valor_unitario:number,
    valor_total:number,
    data_hora_emissao:Date,
    data_hora_status:Date,
    pedido_item_status:string,
    id_produto_precificacao:string,
    obs:string
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
      id_pedido_item?:number,
      id_pedido:number,
      id_produto:number,
      qtde:number,
      valor_unitario:number,
      valor_total:number,
      data_hora_emissao:Date,
      data_hora_status:Date,
      pedido_item_status:string,
      id_produto_precificacao:string,
      obs:string
    },
    mensagem: string,
    sucesso: boolean 
  }
