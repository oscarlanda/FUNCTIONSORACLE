/* script_fun_comparestrs.sql
-- 09-08-2019
-- Developer: Oscar Barrios Landa
-- Email: barrioslandaoscar@gmail.com
-- Description:
	This Function is used for compare two Strings, and return One if they`re true or Zero
	in other case
---------------------------------------------------------------------------------------*/

create or replace function fun_comparestrs(
    d_stroneIN  in   varchar2,
    d_strtwoIN  in   varchar2
) return number authid current_user
as 
  d_methodname              varchar2(64)    := ' ';
  d_titleblock              varchar2(128)   := ' ';
  d_notification            varchar2(256)   := ' ';  
  d_strauxone               varchar2(4000)  := ' ';
  d_strauxtwo               varchar2(4000)  := ' ';
  n_positionblock           number(8,0)     := 0;
  n_returnvalue             number(1,0)     := 0;
  ex_exceptionuser          exception;
begin 

    d_methodname := 'fun_comparestrs';         
    d_titleblock := 'Formate the Content';
    n_positionblock := 1;

    -- Remove white space
    d_strauxone := replace(d_stroneIN,' ','');
    d_strauxtwo := replace(d_strtwoIN,' ','');

    -- Convert to lower case
    d_strauxone := lower(d_strauxone);
    d_strauxtwo := lower(d_strauxtwo);

    d_titleblock := 'Comparing Variables';
    n_positionblock := 2;

    if d_strauxone = d_strauxtwo
    then
        n_returnvalue := 1;
        dbms_output.put_line('The Compared Strings is Equals');
        return n_returnvalue;    
    end if;

    dbms_output.put_line('The Compared Strings is Distincts');
    return n_returnvalue;

exception    
    when ex_exceptionuser then  
      raise_application_error(-20001,
                              ' Excepcion -20001 ' ||
                              ' Rutina: ' || d_methodname ||
                              ' Bloque: ' || d_titleblock ||
                              ' Posicion: ' || cast(n_positionblock as varchar2) ||
                              ' Notificación: ' || d_notification ||
                              ' Fecha: ' || cast(systimestamp as varchar2));    
       return n_returnvalue;
    when others then   
      raise_application_error(-20002,'Error Ocurred - '||SQLCODE||' -ERROR- '||SQLERRM); 
      return n_returnvalue;
end;