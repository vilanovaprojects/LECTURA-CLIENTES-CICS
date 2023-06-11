       01  CLNTMPI.                                                     
           02  FILLER PIC X(12).                                        
           02  DNIL    COMP  PIC  S9(4).                                
           02  DNIF    PICTURE X.                                       
           02  FILLER REDEFINES DNIF.                                   
             03 DNIA    PICTURE X.                                      
           02  FILLER   PICTURE X(1).                                   
           02  DNII  PIC X(9).                                          
           02  NOML    COMP  PIC  S9(4).                                
           02  NOMF    PICTURE X.                                       
           02  FILLER REDEFINES NOMF.                                   
             03 NOMA    PICTURE X.                                      
           02  FILLER   PICTURE X(1).                                   
           02  NOMI  PIC X(10).                                         
           02  APEL    COMP  PIC  S9(4).                                
           02  APEF    PICTURE X.                                       
           02  FILLER REDEFINES APEF.                                   
             03 APEA    PICTURE X.                                      
           02  FILLER   PICTURE X(1).                                   
           02  APEI  PIC X(21).                                         
           02  TLFL    COMP  PIC  S9(4).                                
           02  TLFF    PICTURE X.                                       
           02  FILLER REDEFINES TLFF.                                   
             03 TLFA    PICTURE X.                                      
           02  FILLER   PICTURE X(1).                                   
           02  TLFI  PIC X(9).                                          
           02  DIRL    COMP  PIC  S9(4).                                
           02  DIRF    PICTURE X.                                       
           02  FILLER REDEFINES DIRF.                                   
             03 DIRA    PICTURE X.                                      
           02  FILLER   PICTURE X(1).                                   
           02  DIRI  PIC X(35).                                         
           02  MSGL    COMP  PIC  S9(4).                                
           02  MSGF    PICTURE X.                                       
           02  FILLER REDEFINES MSGF.                                   
             03 MSGA    PICTURE X.                                      
           02  FILLER   PICTURE X(1).                                   
           02  MSGI  PIC X(60).                                         
       01  CLNTMPO REDEFINES CLNTMPI.                                   
           02  FILLER PIC X(12).                                        
           02  FILLER PICTURE X(3).                                     
           02  DNIH    PICTURE X.                                       
           02  DNIO  PIC X(9).                                          
           02  FILLER PICTURE X(3).                                     
           02  NOMH    PICTURE X.                                       
           02  NOMO  PIC X(10).                                         
           02  FILLER PICTURE X(3).                                     
           02  APEH    PICTURE X.                                       
           02  APEO  PIC X(21).                                         
           02  FILLER PICTURE X(3).                                     
           02  TLFH    PICTURE X.                                       
           02  TLFO  PIC X(9).                                          
           02  FILLER PICTURE X(3).                                     
           02  DIRH    PICTURE X.                                       
           02  DIRO  PIC X(35).                                         
           02  FILLER PICTURE X(3).                                     
           02  MSGH    PICTURE X.                                       
           02  MSGO  PIC X(60).                                         