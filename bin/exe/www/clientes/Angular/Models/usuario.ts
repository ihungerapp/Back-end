  export interface UsuarioReq {
    id_usuario?:number,
    nome_usuario:string,
    senha:string
  }
  export interface Usuario {
    id_usuario?:number,
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
      id_usuario?:number,
      nome_usuario:string,
      senha:string
    },
    mensagem: string,
    sucesso: boolean 
  }
