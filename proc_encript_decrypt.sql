/* script_proc_encript_decrypt.sql
-- 11-08-2019
-- Developer: Oscar Barrios Landa
-- Email: barrioslandaoscar@gmail.com
-- Description:
	The procedure is for use demostration the  functions  fun_encryptSH1 and fun_decryptSH1 
---------------------------------------------------------------------------------------*/

create or replace procedure proc_encrypt_decrypt(
    d_cadena in varchar2
) authid current_user
is
    d_cadenaEncrypt varchar2(4000);
    d_cadenaDecrypt varchar2(4000);
    d_key_bytes_rawP varchar2(4000);
begin

    d_cadenaEncrypt := fun_encriptarSH1(d_cadena,d_key_bytes_raw => d_key_bytes_rawP);
    d_cadenaDecrypt := fun_desencriptarSH1(d_cadenaEncrypt, d_key_bytes_rawP);
    
    if d_cadena = d_cadenaDecrypt
    then
        dbms_output.put_line('Exito');
    else 
        dbms_output.put_line('Fracaso');
    end if;
    
end;
/