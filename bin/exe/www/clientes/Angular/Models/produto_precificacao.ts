  export interface Produto_precificacaoReq {
    id_produto_precificacao?:number,
    id_precificacao:number,
    id_produto:number,
    valor:number
  }
  export interface Produto_precificacao {
    id_produto_precificacao?:number,
    id_precificacao:number,
    id_produto:number,
    valor:number
  }
  export interface Produto_precificacaos {  
    content: Produto_precificacao[],     
    totalElements: number,   
    totalPages: number,      
    pageSize: number,        
    pageNumber: number       
 }                           
  export interface Produto_precificacaoRes {
    content: {       
      id_produto_precificacao?:number,
      id_precificacao:number,
      id_produto:number,
      valor:number
    },
    mensagem: string,
    sucesso: boolean 
  }
