-- for authorization
set serveroutput on

declare 
	s_l_choice char(1);

	sign_up exception;
	invalid_entry exception;
	try_again exception;

	err_num number;
	err_msg char(100);

	login_ssid SSID.customer_id%type;
	verify_ssid SSID.customer_id%type;
	cus_id SSID.customer_id%type;
	key_ varchar(50);

    
	cursor data (d number) is 
	select customer_id 
	from SSID 
	where customer_id = d;
    
	function sign_up_(cust in number, key in varchar2) return char is
	begin
		insert into SSID(customer_id, password_)
		values(cust, key);
		return 'Y';
	end sign_up_;

	s_var 	Saving_account%rowtype;
	fd_var  Fixed_deposit%rowtype;
	l_var Loans%rowtype;
	l2_var ;
	m_choice char(1);


begin
	s_l_choice := lower('&s_l_choice');

	if (s_l_choice = 'y') then
		login_ssid := 100001;

		open data(login_ssid);

		if data%found then
			dbms_output.put_line('Proceed');
			m_choice := upper('a');    --give input 
			menu(m_choice);

		elsif data%notfound then 
			raise try_again;
		else
			raise sign_up;
		end if;
	
		close data;

	elsif (s_l_choice = 'n') then
		cus_id := 100004;
		key_ := 'randomssh';
		if sign_up_(cus_id, key_) = 'Y' then
			dbms_output.put_line('Sign up successful.');
			m_choice := upper('a');    --give input 
			menu(m_choice);
		end if;
	
	else
		raise invalid_entry;

	end if;

exception
	when sign_up then
		dbms_output.put_line('Please Proceed To Signup');
	when invalid_entry then
		dbms_output.put_line('Invalid Entry');
	when try_again then
		dbms_output.put_line('Try Again');
	when others then
		dbms_output.put_line('Check Code once again');
		err_num:= sqlcode;
		err_msg:= substr(sqlerrm,1,100);
		insert into errors
		values(err_num,err_msg);
end;
/
