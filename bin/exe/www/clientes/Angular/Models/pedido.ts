  export interface PedidoReq {
    codrecepcao?:number,
    codcli:number,
    vlrtotal:number,
    nome_cliente:string,
    numero_celular:string,
    e_mail:string,
    codap:number,
    qtdepagante:number,
    n_comanda:number,
    data_entrada:Date,
    data_saida:Date,
    situacao:string,
    fechar_conta:boolean
  }
  export interface Pedido {
    codrecepcao?:number,
    codcli:number,
    vlrtotal:number,
    nome_cliente:string,
    numero_celular:string,
    e_mail:string,
    codap:number,
    qtdepagante:number,
    n_comanda:number,
    data_entrada:Date,
    data_saida:Date,
    situacao:string,
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
      codrecepcao?:number,
      codcli:number,
      vlrtotal:number,
      nome_cliente:string,
      numero_celular:string,
      e_mail:string,
      codap:number,
      qtdepagante:number,
      n_comanda:number,
      data_entrada:Date,
      data_saida:Date,
      situacao:string,
      fechar_conta:boolean
    },
    mensagem: string,
    sucesso: boolean 
  }
