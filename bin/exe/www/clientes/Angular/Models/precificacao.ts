  export interface PrecificacaoReq {
    id_precificacao?:number,
    tipo:string,
    grupo:string,
    qtde_max_selecao:number
  }
  export interface Precificacao {
    id_precificacao?:number,
    tipo:string,
    grupo:string,
    qtde_max_selecao:number
  }
  export interface Precificacaos {  
    content: Precificacao[],     
    totalElements: number,   
    totalPages: number,      
    pageSize: number,        
    pageNumber: number       
 }                           
  export interface PrecificacaoRes {
    content: {       
      id_precificacao?:number,
      tipo:string,
      grupo:string,
      qtde_max_selecao:number
    },
    mensagem: string,
    sucesso: boolean 
  }
