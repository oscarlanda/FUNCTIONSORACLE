/* script_fun_encriptarSH1.sql
-- 11-08-2019
-- Developer: Oscar Barrios Landa
-- Email: barrioslandaoscar@gmail.com
-- Description:
	this function encrypt string in code sha1 and return a varchar2
---------------------------------------------------------------------------------------*/
create or replace function fun_encriptarSH1(
    d_cadenaIN in varchar2,
    d_key_bytes_raw out varchar2
) return varchar2 authid current_user
as
    d_methodname              varchar2(64)    := ' ';
    d_titleblock              varchar2(128)   := ' ';
    d_notification            varchar2(256)   := ' ';      
    n_positionblock           number(8,0)     := 0;  
    d_returnvalue             varchar2(4000)  := ' ';
    ex_exceptionuser          exception;
    encrypted_raw             RAW (2000);             -- stores encrypted binary text  
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

    if fun_isempty(d_cadenaIN) = 1 
    then         
      d_returnvalue := null;  
      d_notification := 'The Parameter d_cadenaIn is Empty';      
      raise ex_exceptionuser;  
    end if;

    d_titleblock := 'Encripted Rutines';
    n_positionblock := 2;

    key_bytes_raw := DBMS_CRYPTO.RANDOMBYTES (num_key_bytes);
    encrypted_raw := DBMS_CRYPTO.ENCRYPT(
         src => UTL_I18N.STRING_TO_RAW (d_cadenaIN,  'AL32UTF8'),
         typ => encryption_type,
         key => key_bytes_raw
    );

    d_returnvalue := UTL_I18N.RAW_TO_CHAR (encrypted_raw, 'AL32UTF8');
    d_key_bytes_raw := UTL_I18N.RAW_TO_CHAR (key_bytes_raw, 'AL32UTF8');

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