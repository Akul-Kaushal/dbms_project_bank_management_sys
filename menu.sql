set serveroutput on

declare 
	
	invalid_entry exception;
	
	err_num number;
	err_msg char(100);


	procedure f_d_in is
		rec Fixed_deposit%rowtype;
	begin

	procedure sav_acc is
		rec Savings_account%rowtype;
	begin

	procedure loans is
		rec Loans%rowtype;
	begin

	procedure t_his is 
		rec T_history%rowtype;
	begin
		

	procedure menu is	
	choice_m char(1) := upper('a');
	begin     
		
		case choice_m
			when 'A' then 
				dbms_output.put_line('Fixed Deposit');
				f_d_in();
			
			when 'B' then
				dbms_output.put_line('Loans');

			when 'C' then
				dbms_output.put_line('Saving Account');
		
			when 'D' then
				dbms_output.put_line('Transaction History');
				t_his();
		
			when 'E' then 
				dbms_output.put_line('Money Transfer To Account');
		
			when 'F' then 
				dbms_output.put_line('UPI Transaction');
				
			else
				raise invalid_entry;
		end case;
	end; 		
		



begin

	menu();

exception
	
	when invalid_entry then
		dbms_output.put_line('Invalid Entry');
		dbms_output.put_line('Terminating Session');
		dbms_output.put_line('Refersh Session');

	when others then
		dbms_output.put_line('Out of Bound Error');
		dbms_output.put_line('Check Code once again');
		err_num:= sqlcode;
		err_msg:= substr(sqlerrm,1,100);
		insert into errors
		values(err_num,err_msg);
	


end;
/
