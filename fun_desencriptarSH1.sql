/* script_fun_desencriptarSH1.sql
-- 11-08-2019
-- Developer: Oscar Barrios Landa
-- Email: barrioslandaoscar@gmail.com
-- Description:
	this function decrypt string in code sha1 and return a varchar2
---------------------------------------------------------------------------------------*/

create or replace function fun_desencriptarSH1(
    d_encripter in varchar2,
    d_key_bytes_raw in varchar2
) return varchar2 authid current_user
as
    d_methodname              varchar2(64)    := ' ';
    d_titleblock              varchar2(128)   := ' ';
    d_notification            varchar2(256)   := ' ';      
    n_positionblock           number(8,0)     := 0;
    d_returnvalue             varchar2(4000);
    ex_exceptionuser          exception;   
    encripted_raw             RAW(2000);
    decrypted_raw             RAW (2000);             -- stores decrypted binary text
    num_key_bytes             NUMBER := 256/8;        -- key length 256 bits (32 bytes)
    key_bytes_raw             RAW (32);               -- stores 256-bit encryption key
    encryption_type           PLS_INTEGER :=          -- total encryption type
                                            DBMS_CRYPTO.HASH_SH1
                                            + DBMS_CRYPTO.CHAIN_CBC
                                            + DBMS_CRYPTO.PAD_PKCS5;
begin

    d_methodname := 'fun_encriptarSH1';
    d_titleblock := 'Valiting Parameters Empty and White Space Content';
    n_positionblock := 1;

    if fun_isempty(d_encripter) = 1
    then         
      d_returnvalue := null;  
      d_notification := 'The Parameter encrypted_raw is Empty';      
      raise ex_exceptionuser;  
    end if;

    d_titleblock := 'Decripted Rutines';
    n_positionblock := 2;
        

    key_bytes_raw := UTL_I18N.STRING_TO_RAW (d_key_bytes_raw,  'AL32UTF8');
    encripted_raw := UTL_I18N.STRING_TO_RAW (d_encripter,  'AL32UTF8');
    
    decrypted_raw := DBMS_CRYPTO.DECRYPT(
         src => encripted_raw,
         typ => encryption_type,
         key => key_bytes_raw
    );

    d_returnvalue := UTL_I18N.RAW_TO_CHAR (decrypted_raw, 'AL32UTF8');  

    return d_returnvalue;

exception       
    when ex_exceptionuser then  
         raise_application_error(-20001,
                              ' Excepcion -20001 ' ||
                              ' Rutina: ' || d_methodname ||
                              ' Bloque: ' || d_titleblock ||
                              ' Posicion: ' || cast(n_positionblock as varchar2) ||
                              ' Notificación: ' || d_notification ||
                              ' Fecha: ' || cast(systimestamp as varchar2));        
         return d_returnvalue;   
    when others then   
         raise_application_error(-20002,'Se encontro un Error - '||SQLCODE||' -ERROR- '||SQLERRM); 
         return d_returnvalue;
end;
/