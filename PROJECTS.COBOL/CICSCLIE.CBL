      *************************************************                 
      *  PROGRAMA DE PRUEBA DE CICS-COBOL CON FICHEROS VSAM             
      *************************************************                 
       IDENTIFICATION DIVISION.                                         
       PROGRAM-ID. CLNT.                                                
       ENVIRONMENT DIVISION.                                            
       DATA DIVISION.                                                   
       WORKING-STORAGE SECTION.                                         
      *==============================================================   
      * LA COPY MAPA GENERADO                                           
      *==============================================================   
       COPY CLNTMP.                                                     
      *==============================================================   
      * FIN DE LA COPY DEL MAPA GENERADO                                
      *==============================================================   
       01 MSG-FIN-SESION  PIC X(13) VALUE 'FIN DE SESION'.              
       01 MI-COMMAREA.                                                  
       03 CAMPOINICIO                     PIC X(8).                     
       01  REGISTRO-CLIENTES.                                           
           05  C-DNI                      PIC X(9).                     
           05  C-NOMBRE                   PIC X(10).                    
           05  C-APELLIDO                 PIC X(21).                    
           05  C-TELEFONO                 PIC X(9).                     
           05  C-DIRECCION                PIC X(35).                    
       01  RESPUESTA                      PIC S9(8)  COMP.              
      *============================================================     
      * COPIAMOS AYUDAS DE BMS PARA HACER BONITO EL TERMINAL            
      *============================================================     
       COPY DFHAID.                                                     
       COPY DFHBMSCA.                                                   
      *                                                                 
       LINKAGE SECTION.                                                 
      *                                                                 
       PROCEDURE DIVISION.                                              
      *                                                                 
           IF EIBCALEN = 0                                              
              MOVE LOW-VALUES TO CLNTMPI                                
              PERFORM MANDAR-MAPONLY                                    
              PERFORM RETORNO-TRANS                                     
           END-IF.                                                      
      *============================================================     
      * RECOGIDA DEL MAPA DEL USUARIO                                   
      *============================================================     
           EXEC CICS RECEIVE MAP('CLNTMP')                              
                   INTO(CLNTMPI)                                        
                   NOHANDLE                                             
              END-EXEC.                                                 
      *============================================================     
      * EVALUAMOS LA RESPUESTA DEL USUARIO                              
      *============================================================     
           IF EIBAID = DFHPF3                                           
              PERFORM FIN-SESION                                        
              EXEC CICS RETURN                                          
              END-EXEC                                                  
           END-IF.                                                      
           EVALUATE EIBRESP                                             
                    WHEN DFHRESP(NORMAL)                                
           CONTINUE                                                     
                    WHEN DFHRESP(MAPFAIL)                               
                    PERFORM FALLO-MAPA                                  
                    PERFORM RETORNO-TRANS                               
           END-EVALUATE.                                                
      *============================================================     
      * TRATAMIENTO DEL FICHERO                                         
      *============================================================     
           EXEC CICS                                                    
               READ FILE('CLIENTES')                                    
                    INTO(REGISTRO-CLIENTES)                             
                    RIDFLD(DNII)                                        
                    RESP(RESPUESTA)                                     
           END-EXEC.                                                    
           IF RESPUESTA = DFHRESP(NORMAL)                               
               MOVE 'REGISTRO ENCONTRADO'  TO MSGO                      
               MOVE C-NOMBRE     TO NOMO                                
               MOVE C-APELLIDO   TO APEO                                
               MOVE C-TELEFONO   TO TLFO                                
               MOVE C-DIRECCION  TO DIRO                                
           ELSE                                                         
               PERFORM FALLO-FICHERO                                    
           END-IF.                                                      
      *============================================================     
      * RESPUESTA AL MAPA                                               
      *============================================================     
           EXEC CICS SEND MAP('CLNTMP')                                 
               DATAONLY                                                 
               FROM(CLNTMPO)                                            
           END-EXEC.                                                    
      *============================================================     
      * PROCEDIMIENTO DEL PSEUDO-CONVERSACIONAL                         
      *============================================================     
       RETORNO-TRANS.                                                   
               EXEC CICS RETURN                                         
                     TRANSID(EIBTRNID)                                  
                     COMMAREA(MI-COMMAREA)                              
                     LENGTH(8)                                          
               END-EXEC.                                                
               GOBACK.                                                  
      *============================================================     
      * RESTO DE PROCEDIMIENTOS                                         
      *============================================================     
       MANDAR-MAPONLY.                                                  
               EXEC CICS SEND MAP('CLNTMP')                             
                     MAPONLY                                            
                     ERASE                                              
                     NOHANDLE                                           
               END-EXEC.                                                
      *                                                                 
       FALLO-MAPA.                                                      
           MOVE DFHBLINK TO MSGH.                                       
           MOVE 'POR FAVOR, INTRODUZCA UN VALOR' TO MSGO.               
               EXEC CICS SEND MAP('CLNTMP')                             
                     ERASE                                              
                     FROM(CLNTMPO)                                      
                     NOHANDLE                                           
               END-EXEC.                                                
           PERFORM RETORNO-TRANS.                                       
      *                                                                 
       FIN-SESION.                                                      
           EXEC CICS                                                    
               SEND TEXT FROM(MSG-FIN-SESION)                           
                         ERASE                                          
                         FREEKB                                         
           END-EXEC.                                                    
      *                                                                 
       FALLO-FICHERO.                                                   
           IF RESPUESTA = DFHRESP(NOTFND)                               
               MOVE 'EL CLIENTE NO EXISTE.' TO MSGO                     
               MOVE SPACE TO NOMO                                       
                             APEO                                       
                             TLFO                                       
                             DIRO                                       
           ELSE                                                         
               EXEC CICS ABEND                                          
               END-EXEC                                                 
           END-IF.                                                      
      *                                                                 
       FIN-PGM.                                                         
               EXEC CICS RETURN                                         
               END-EXEC.                                                
               GOBACK.                                                  