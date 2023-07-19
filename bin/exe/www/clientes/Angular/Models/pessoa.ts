  export interface PessoaReq {
    id_pessoa?:number,
    nome:string,
    cpf_cnpj:string,
    logradouro:string,
    numero:string,
    complemento:string,
    bairro:string,
    cep:string,
    id_cidade:number,
    cidade_codigo_ibge:number,
    id_usuario:number
  }
  export interface Pessoa {
    id_pessoa?:number,
    nome:string,
    cpf_cnpj:string,
    logradouro:string,
    numero:string,
    complemento:string,
    bairro:string,
    cep:string,
    id_cidade:number,
    cidade_codigo_ibge:number,
    id_usuario:number
  }
  export interface Pessoas {  
    content: Pessoa[],     
    totalElements: number,   
    totalPages: number,      
    pageSize: number,        
    pageNumber: number       
 }                           
  export interface PessoaRes {
    content: {       
      id_pessoa?:number,
      nome:string,
      cpf_cnpj:string,
      logradouro:string,
      numero:string,
      complemento:string,
      bairro:string,
      cep:string,
      id_cidade:number,
      cidade_codigo_ibge:number,
      id_usuario:number
    },
    mensagem: string,
    sucesso: boolean 
  }
