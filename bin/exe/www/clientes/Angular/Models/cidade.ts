  export interface CidadeReq {
    id_cidade?:number,
    codigo_ibge:number,
    nome:string,
    uf:string
  }
  export interface Cidade {
    id_cidade?:number,
    codigo_ibge:number,
    nome:string,
    uf:string
  }
  export interface Cidades {  
    content: Cidade[],     
    totalElements: number,   
    totalPages: number,      
    pageSize: number,        
    pageNumber: number       
 }                           
  export interface CidadeRes {
    content: {       
      id_cidade?:number,
      codigo_ibge:number,
      nome:string,
      uf:string
    },
    mensagem: string,
    sucesso: boolean 
  }
