  export interface UsuarioReq {
    coduser?:number,
    nome_usuario:string,
    senha:string
  }
  export interface Usuario {
    coduser?:number,
    nome_usuario:string,
    senha:string
  }
  export interface Usuarios {  
    content: Usuario[],     
    totalElements: number,   
    totalPages: number,      
    pageSize: number,        
    pageNumber: number       
 }                           
  export interface UsuarioRes {
    content: {       
      coduser?:number,
      nome_usuario:string,
      senha:string
    },
    mensagem: string,
    sucesso: boolean 
  }
