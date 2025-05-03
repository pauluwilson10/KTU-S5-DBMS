set serveroutput on;


create or replace procedure max_vote_party as
	max_vote number;
	party_id number;
begin
	select votes,party into max_vote,party_id from result where votes=(select max(votes) from result);
	dbms_output.put_line('max vote :'||max_vote);
	dbms_output.put_line('max vote party is :'||party_id);
end max_vote_party;
/
	
	
create or replace trigger vote_count after insert on votes for each row
begin
	if :new.validity='valid' then
		update result set votes=votes+1 where party=:new.vchoice;
	end if;
end vote_count;
/

set serveroutput on;

accept usern prompt'enter the username: ';
accept passw prompt'enter the password: ';
accept choice prompt'enter the part number: ';

		
declare
	usern varchar(20):='&usern';
	passw varchar(20):='&passw';
	choice number(20):=&choice;
	avail_p varchar(20);
	valid number(20):=0;
	validchoice number(20):=0;
	party_number number;
begin
	begin
		select password into avail_p from voters where voterid=usern;
		if avail_p=passw then
			valid:=1;
			dbms_output.put_line('valid user');
		else
			dbms_output.put_line('INVALID user');
		end if;
	end;

	if valid=1 then
		begin
			select party into party_number from candidate where party=choice;
			validchoice:=1;
			dbms_output.put_line('Valid party: ');
		exception
			when no_data_found then
				dbms_output.put_line('invalid party ');
		end;
	end if;
	
	if validchoice=1 then
		insert into votes(voterid,vchoice,validity) values(usern,choice,'VALID');
		dbms_output.put_line('valid user ');
		
	else
		insert into votes(voterid,vchoice,validity) values(usern,choice,'INVALID');
		dbms_output.put_line('invalid user ');
	end if;
	
	dbms_output.put_line('transaction completed sucessfuly.....');
	
	max_vote_party;


end;
/