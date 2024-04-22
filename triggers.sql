
																-- (CENÁRIO COMPANY)

use company;

# 01
-- BEFORE UPDATE com new.Atributo
-- Antes de atualizar, será checado se o número do departamento (Dno) é 1 para atualizar o salário

delimiter \\
create trigger Atualizacao_salario before update on Company.Employee
for each row
	begin
		case new.Dno
			when 1 then set new.Salary = new.Salary * 1.20;
		end case;
    end \\
delimiter ;

update Employee set Dno= '1' where Ssn= '123454789'; 



# 02
--  BEFORE DELETE com old.Atributo / 
-- Antes de deletar tupla da tabela Employee, os dados do funcionário demitido serão salvos na tabela Funcionarios_Demitidos

delimiter \\
create trigger Funcionario_demitido before delete on Company.Employee
for each row
	begin
		insert into Tabela_Demitidos (Ssn)
		values (old.Ssn);
    end \\
delimiter ;

delete from Employee
where Ssn = '738172819' and Fname = 'Ana'; 

select * from Tabela_Demitidos;




-------------------------------------------------------------------------------------------------------------------------------------------------------


															-- (CENÁRIO ECOMMERCE)

use ecommerce;
show tables;


# 01
-- before insert statement
-- Antes de acrescentar um novo pedido na tabela Orders, confere se existe o tipo de pagamento (0 ou 1) para informar o frete.
delimiter \\
create trigger Checar_pagamento before insert on Ecommerce.Tabela_orders
for each row
	begin
		case new.paymentCash
			when 0 then set new.SendValue = 55;			-- set (setando) é como uma orientação, new indica uma nova informação que será recebida
            when 1 then set new.SendValue = 22;
		end case;
    end \\
delimiter ;

# 02
-- after insert statement
-- atualiza a coluna status com o valor 'Novo Cliente' sempre que um novo cliente é inserido na tabela tabela_clients

delimiter //

create trigger Novo_Cliente after insert on Tabela_clients
for each row
begin
    update Tabela_clients
    set status = 'Novo Cliente'
    where idClient = new.idClient;
end;
//

delimiter ;
;
