  export interface PedidoReq {
    id_pedido?:number,
    id_pessoa:number,
    valor_total:number,
    nome_cliente:string,
    numero_celular:string,
    e_mail:string,
    id_mesa:number,
    numero_comanda:number,
    data_hora_abertura:Date,
    data_hora_finalizacao:Date,
    pedido_status:string,
    fechar_conta:boolean
  }
  export interface Pedido {
    id_pedido?:number,
    id_pessoa:number,
    valor_total:number,
    nome_cliente:string,
    numero_celular:string,
    e_mail:string,
    id_mesa:number,
    numero_comanda:number,
    data_hora_abertura:Date,
    data_hora_finalizacao:Date,
    pedido_status:string,
    fechar_conta:boolean
  }
  export interface Pedidos {  
    content: Pedido[],     
    totalElements: number,   
    totalPages: number,      
    pageSize: number,        
    pageNumber: number       
 }                           
  export interface PedidoRes {
    content: {       
      id_pedido?:number,
      id_pessoa:number,
      valor_total:number,
      nome_cliente:string,
      numero_celular:string,
      e_mail:string,
      id_mesa:number,
      numero_comanda:number,
      data_hora_abertura:Date,
      data_hora_finalizacao:Date,
      pedido_status:string,
      fechar_conta:boolean
    },
    mensagem: string,
    sucesso: boolean 
  }
