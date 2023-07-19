  export interface ProdutoReq {
    id_produto?:number,
    descricao:string,
    complemento:string,
    valor_inicial:number,
    valor_promocao:number,
    promocao_do_dia:boolean,
    id_grupo:number,
    imagem:byte,
    exibir_app:boolean
  }
  export interface Produto {
    id_produto?:number,
    descricao:string,
    complemento:string,
    valor_inicial:number,
    valor_promocao:number,
    promocao_do_dia:boolean,
    id_grupo:number,
    imagem:byte,
    exibir_app:boolean
  }
  export interface Produtos {  
    content: Produto[],     
    totalElements: number,   
    totalPages: number,      
    pageSize: number,        
    pageNumber: number       
 }                           
  export interface ProdutoRes {
    content: {       
      id_produto?:number,
      descricao:string,
      complemento:string,
      valor_inicial:number,
      valor_promocao:number,
      promocao_do_dia:boolean,
      id_grupo:number,
      imagem:byte,
      exibir_app:boolean
    },
    mensagem: string,
    sucesso: boolean 
  }
