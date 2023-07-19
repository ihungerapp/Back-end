  export interface MesaReq {
    id_mesa?:number,
    descricao:string,
    mesa_uuid:string
  }
  export interface Mesa {
    id_mesa?:number,
    descricao:string,
    mesa_uuid:string
  }
  export interface Mesas {  
    content: Mesa[],     
    totalElements: number,   
    totalPages: number,      
    pageSize: number,        
    pageNumber: number       
 }                           
  export interface MesaRes {
    content: {       
      id_mesa?:number,
      descricao:string,
      mesa_uuid:string
    },
    mensagem: string,
    sucesso: boolean 
  }
