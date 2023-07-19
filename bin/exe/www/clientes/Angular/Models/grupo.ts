  export interface GrupoReq {
    id_grupo?:number,
    descricao:string
  }
  export interface Grupo {
    id_grupo?:number,
    descricao:string
  }
  export interface Grupos {  
    content: Grupo[],     
    totalElements: number,   
    totalPages: number,      
    pageSize: number,        
    pageNumber: number       
 }                           
  export interface GrupoRes {
    content: {       
      id_grupo?:number,
      descricao:string
    },
    mensagem: string,
    sucesso: boolean 
  }
