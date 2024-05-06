set serveroutput on;
declare 

	choice varchar(1);
	validate_var varchar(1);
	err_num number;
	err_msg char(100);

	config_id Customer.customer_id%type;
	aconfig_id User_account.account_id%type;


	invalid_entry exception;
	negative_balance exception;
	
	




	cursor c1(a number) is select * from Customer where customer_id = a;
	cursor c2(a varchar,b number) is select * from SSID where password_ = a and exists (select * from Customer where customer_id = b);
	cursor c3 is select customer_id from Customer;
	cursor c4(a number) is select * from User_account where Customer_id = a;
	cursor c5 is select transaction_id from T_history;
	cursor c6 is select * from T_history;
	cursor c7(d number) is select balance from Saving_account where account_id = d;


	function roulette return number is
	begin
		return 1;
	end;
		

	procedure m_trans is
		pa_r Money_account.payer%type;
		py_r Money_account.payee%type;
		amt Money_account.amount%type;

		t_id T_history.transaction_id%type;
		a_t T_history.amount%type;
		t_y T_history.type_%type;
		c_d T_history.cap_date%type;

		rec_t T_history.transaction_id%type;
		rec_m Saving_account.balance%type;


	begin
		pa_r := aconfig_id;
		py_r := 1002;
		amt := 100;
		
		insert into Money_account
		values (
			pa_r,
			py_r,
			amt
		);
		
		
		open c7(pa_r);
		loop 
			fetch c7 into rec_m;
			exit when c7%found;
		end loop;
		
		rec_m := rec_m - amt;

		if (rec_m < 0) then
			dbms_output.put_line('no negative balance');
			raise negative_balance;

		else
			update Saving_account 
			set balance = balance - amt
			where account_id = pa_r;
		
			update Saving_account 
			set balance = balance + amt 
			where account_id = py_r;
		end if;
		close c7;

		open c5;
		loop
			fetch c5 into rec_t;
			-- dbms_output.put_line(rec_t);
			exit when c5%notfound;
		end loop;
		close c5;
		
		t_id := rec_t + 1;
		pa_r := aconfig_id;
		py_r := 1001;
		amt := 10000;
		

		t_y := 'Account';
			insert into T_history
			values
			(
				t_id,
				pa_r,
				py_r,
				amt,
				t_y,
				current_timestamp
			);
	end;

	procedure t_his(decide in number) is 

		rec_t T_history%rowtype;
	begin
		
		open c6;
		loop
			fetch c6 into rec_t;
			-- dbms_output.put_line(rec_t);
			dbms_output.put_line('Send By :: ' || rec_t.payer || ' to ' || rec_t.payee || ' reference :: ' || rec_t.transaction_id); 
			exit when c5%notfound;
		end loop;
		close c5;
		
	end;

	
	
	procedure f_d_in is 
		fd_id Fixed_deposit.deposit_id%type;
		s_d Fixed_deposit.start_date%type;
		amt Fixed_deposit.amount%type;
		i_r Fixed_deposit.interest_rate%type;
		tenure Fixed_deposit.tenure%type;
		m_d Fixed_deposit.maturity_date%type;
		acc_id Fixed_deposit.account_id%type;
		status Fixed_deposit.status_%type;

		rec Fixed_deposit%rowtype;
	begin
		
		
		acc_id := aconfig_id;
		fd_id := 1004;
		amt := 100000.00;
		i_r := 7.20;
		

		insert into Fixed_deposit (deposit_id, amount, interest_rate)
		values
		(
				fd_id,
				amt,
				i_r	
			);
	end;


	procedure password_check(login_arg in number) is
    		password_var SSID.password_%type;
		rec2 SSID%rowtype;
	begin
		password_var := 'Password123';
        	open c2(password_var,login_arg);

		loop
            		fetch c2 into rec2;
			exit when c2%found;
		end loop;
		

		-- if c2%found then
				-- dbms_output.put_line('found');		
		-- else
				-- dbms_output.put_line('not found');
		--end if;
		
		dbms_output.put_line(' ');
		close c2;
		
	end;

	procedure login_check is
    		login_id number;
		rec Customer%rowtype;
		password SSID%rowtype;
	begin
		login_id := 100001;
		config_id :=  login_id;
        	open c1(login_id);

		loop
            		fetch c1 into rec;
			exit when c1%found;
		end loop;
		

		if c1%found then
				-- dbms_output.put_line('found');
				dbms_output.put_line('Enter the Password :: ');
				password_check(login_id);
				dbms_output.put_line('Welcome ,'||rec.first_name||' '||rec.last_name );
				
				

		else
				dbms_output.put_line('not found');
		end if;
		close c1;
	end;


	procedure sign_up is
    		rec3 Customer.customer_id%type;
    		n_cust Customer.customer_id%type; 
    		f_name Customer.first_name%type;
    		l_name Customer.last_name%type;
    		d_o_b Customer.date_of_birth%type;
    		gen Customer.gender%type;
    		h_n Customer.house_no%type;
    		st Customer.street%type;
    		ct Customer.city%type;
    		p_c Customer.postal_code%type;
    		sta Customer.state_%type;
    		e Customer.email%type;
    		p_n Customer.phone_no%type;
    		i_p_t Customer.id_proof_type%type;
    		i_p_n Customer.id_proof_number%type;
    
    		pass_ SSID.password_%type;

    		acc_id User_account.account_id%type;
    		acc_type User_account.account_type%type;
    		acc_status User_account.status_%type;
    		rec4 User_account.account_id%type;
	begin
    		open c3;
    
		loop
			fetch c3 into rec3;
			dbms_output.put_line(rec3);
			exit when c3%notfound;
		end loop;
    		close c3;

    		n_cust := rec3 + 1;
		config_id := n_cust;
    		f_name := 'hunt';
    		l_name := '3r';
    		d_o_b  :=  TO_DATE('1990-09-15', 'YYYY-MM-DD') ;
    		gen := 'Female';
    		h_n := 110;
    		st := 'Rosmary Street';
    		ct := 'Virginia';
    		p_c := 145002;
    		sta := 'West Virginia';
    		e := 'dove@icloud.com';
    		p_n := '987-654-3210';
    		i_p_t := 'passport';
    		i_p_n := 'alok19990';

    		insert into Customer 
    		values
    		(   
		n_cust ,
        	f_name,
        	l_name ,
        	d_o_b,
        	gen ,
        	h_n ,
        	st,
        	ct ,
        	p_c ,
        	sta ,
        	e ,
        	p_n ,
        	i_p_t ,
        	i_p_n
    		);

    		pass_ := 'Abcdefg001';
    		insert into SSID
    		values
    		(   
        	n_cust,
        	pass_
    		);

    		acc_id := 1004;
    		acc_type := 'Retirement Account';
    		acc_status := 'open';
    		insert into User_account
    		values
    		(
        	acc_id,
        	n_cust,
        	acc_type,
        	acc_status
    		);
	end;

		
	

	procedure menu is	
		choice_m char(1) := upper('e');
		demo number;
	begin     
		
		case choice_m
			when 'A' then 
				dbms_output.put_line('Fixed Deposit');
				-- f_d_in();
			
			when 'B' then
				dbms_output.put_line('Loans');

			when 'C' then
				dbms_output.put_line('Saving Account');
		
			when 'D' then
				dbms_output.put_line('Transaction History');
				-- t_his();
				demo := roulette();
				t_his(demo);
		
			when 'E' then 
				dbms_output.put_line('Money Transfer To Account');
				m_trans();
				
				
			when 'F' then 
				dbms_output.put_line('UPI Transaction');
				
			else
				raise invalid_entry;
		end case;
	end; 		

	procedure linking_cust_acc_id  is
		rec User_account%rowtype;
	begin
		open c4(config_id);
		loop 
			fetch c4 into rec;
			exit when c4%found;
		end loop;
			
		aconfig_id := rec.account_id;
		-- dbms_output.put_line(aconfig_id);
		close c4;
	end;
	





		

begin

	choice := '&choice';

	case choice
		when 'y' then
        		login_check();
			-- dbms_output.put_line('yes');

		when 'n' then
			sign_up();
			dbms_output.put_line('no');


		else
			dbms_output.put_line('infinity');
	end case;

	linking_cust_acc_id();

	dbms_output.put_line(' ');
	dbms_output.put_line('Welcome to Bank Management system');

	-- dbms_output.put_line(config_id);
	-- dbms_output.put_line(aconfig_id);

	

	menu();
	


exception
	
	when invalid_entry then
		dbms_output.put_line('Invalid Entry');
		dbms_output.put_line('Terminating Session');
		dbms_output.put_line('Refersh Session');

	when negative_balance then 
		dbms_output.put_line('Cannot Proceed');
		dbms_output.put_line('Refresh Session');

	when others then
		dbms_output.put_line('Out of Bound Error');
		dbms_output.put_line('Check Code once again');
		err_num:= sqlcode;
		err_msg:= substr(sqlerrm,1,100);
		insert into errors
		values(err_num,err_msg);
		
end;
/
