/* script_fun_isempty.sql
-- 09-08-2019
-- Developer: Oscar Barrios Landa
-- Email: barrioslandaoscar@gmail.com
-- Description:
	this function is for validate if it`s value empty o whit space white
---------------------------------------------------------------------------------------*/

create or replace function fun_isempty(
  d_valueIN in varchar2
) return number authid current_user 
as 
  n_sequentialblockIN       number(8,0) := 0;
  d_titleblockIN            varchar2(128):= ' ';  
  d_value                   varchar2(4000) := ' ';
begin  

  n_sequentialblockIN := 1;
  d_titleblockIN := 'Validate NULL value';
  
  if d_valueIN is null then 
    return 1; 
  end if;
        
  n_sequentialblockIN := 2;
  d_titleblockIN := 'Validate Empty Value or White Space';
  
  d_value := replace(d_valueIN,' ',''); 
  
  if d_value is null then 
    return 1; 
  end if;

  return 0;  
  
  exception    
    when others then        
      raise_application_error(-20001,'Error Ocurred - '||SQLCODE||' -ERROR- '||SQLERRM);
      return 1;
       
end fun_isempty;