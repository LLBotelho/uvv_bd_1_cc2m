CREATE TABLE elmasri.funcionario (
                cpf CHAR(11) NOT NULL,
                primeiro_nome VARCHAR(15) NOT NULL,
                nome_meio CHAR(1),
                ultimo_nome VARCHAR(15) NOT NULL,
                data_nascimento DATE,
                endereco VARCHAR(30),
                sexo CHAR(1),
                salario NUMERIC(10,2),
                cpf_supervisor CHAR(11) NOT NULL,
                numero_departamento INTEGER NOT NULL,
                CONSTRAINT pk_cpf PRIMARY KEY (cpf)
);


CREATE TABLE elmasri.dependente (
                cpf_funcionario CHAR(11) NOT NULL,
                nome_dependente VARCHAR(15) NOT NULL,
                sexo CHAR(1),
                data_nascimento DATE,
                parentesco VARCHAR(15),
                CONSTRAINT pk_nome_dependente PRIMARY KEY (cpf_funcionario, nome_dependente)
);


CREATE TABLE elmasri.departamento (
                numero_departamento INTEGER NOT NULL,
                nome_departamento VARCHAR(15) NOT NULL,
                cpf_gerente CHAR(11) NOT NULL,
                data_inicio_gerente DATE,
                CONSTRAINT pk_numero_departamento PRIMARY KEY (numero_departamento)
);


CREATE UNIQUE INDEX nome_departameno
 ON elmasri.departamento
 ( nome_departamento );

CREATE TABLE elmasri.projeto (
                numero_projeto INTEGER NOT NULL,
                nome_projeto VARCHAR(15) NOT NULL,
                local_projeto VARCHAR(15),
                numero_departamento INTEGER NOT NULL,
                CONSTRAINT pk_numero_projeto PRIMARY KEY (numero_projeto)
);


CREATE UNIQUE INDEX nome_projeto
 ON elmasri.projeto
 ( nome_projeto );

CREATE TABLE elmasri.localizacoes_departamento (
                numero_departamento INTEGER NOT NULL,
                local VARCHAR(15) NOT NULL,
                CONSTRAINT pk_local PRIMARY KEY (numero_departamento, local)
);


CREATE TABLE elmasri.trabalha_em (
                cpf_funcionario CHAR(11) NOT NULL,
                numero_projeto INTEGER NOT NULL,
                horas NUMERIC(3,1) NOT NULL,
                CONSTRAINT pk_cpf_funcionario PRIMARY KEY (cpf_funcionario, numero_projeto)
);


ALTER TABLE elmasri.trabalha_em ADD CONSTRAINT funcionario_trabalha_em_fk
FOREIGN KEY (cpf_funcionario)
REFERENCES elmasri.funcionario (cpf)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE elmasri.departamento ADD CONSTRAINT funcionario_departamento_fk
FOREIGN KEY (cpf_gerente)
REFERENCES elmasri.funcionario (cpf)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE elmasri.funcionario ADD CONSTRAINT funcionario_funcionario_fk
FOREIGN KEY (cpf_supervisor)
REFERENCES elmasri.funcionario (cpf)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE elmasri.dependente ADD CONSTRAINT funcionario_dependente_fk
FOREIGN KEY (cpf_funcionario)
REFERENCES elmasri.funcionario (cpf)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE elmasri.localizacoes_departamento ADD CONSTRAINT departamento_localizacoes_departamento_fk
FOREIGN KEY (numero_departamento)
REFERENCES elmasri.departamento (numero_departamento)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE elmasri.projeto ADD CONSTRAINT departamento_projeto_fk
FOREIGN KEY (numero_departamento)
REFERENCES elmasri.departamento (numero_departamento)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE elmasri.trabalha_em ADD CONSTRAINT projeto_trabalha_em_fk
FOREIGN KEY (numero_projeto)
REFERENCES elmasri.projeto (numero_projeto)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

comment on table elmasri.funcionario 
is 'Tabela que armazena as informa????es dos funcion??rios.';
comment on column elmasri.funcionario.cpf 
is 'CPF do funcion??rio. Ser?? a PK da tabela.';
comment on column elmasri.funcionario.primeiro_nome 
is 'Primeiro nome do funcion??rio.';
comment on column elmasri.funcionario.nome_meio 
is 'Inicial do nome do meio.';
comment on column elmasri.funcionario.ultimo_nome  
is 'Sobrenome do funcion??rio.';
comment on column elmasri.funcionario.endereco  
is 'Endere??o do funcion??rio.';
comment on column elmasri.funcionario.sexo 
is 'Sexo do funcion??rio.';
comment on column elmasri.funcionario.salario 
is 'Sal??rio do funcion??rio.';
comment on column elmasri.funcionario.cpf_supervisor  
is 'CPF do supervisor. Ser?? uma FK para a pr??pria tabela (um auto-relacionamento).';
comment on column elmasri.funcionario.numero_departamento 
is 'N??mero do departamento do funcion??rio.';

comment on table elmasri.dependente
is 'Tabela que armazena as informa????es dos dependentes dos funcion??rios.';
comment on column elmasri.dependente.cpf_funcionario
is 'CPF do funcion??rio. Faz parte da PK desta tabela e ?? uma FK para a tabela funcion??rio.';
comment on column elmasri.dependente.nome_dependente 
is 'Nome do dependente. Faz parte da PK desta tabela.';
comment on column elmasri.dependente.sexo 
is 'Sexo do dependente.';
comment on column elmasri.dependente.data_nascimento 
is 'Data de nascimento do dependente.';
comment on column elmasri.dependente.parentesco 
is 'Descri????o do parentesco do dependente com o funcion??rio.';

comment on table elmasri.departamento 
is 'Tabela que armazena as informa??o???s dos departamentos.';
comment on column elmasri.departamento.numero_departamento 
is 'N??mero do departamento. ?? a PK desta tabela.';
comment on column elmasri.departamento.nome_departamento 
is 'Nome do departamento. Deve ser ??nico.';
comment on column elmasri.departamento.cpf_gerente 
is 'CPF do gerente do departamento. ?? uma FK para a tabela funcion??rios.';
comment on column elmasri.departamento.data_inicio_gerente 
is 'Data do in??cio do gerente no departamento.';

comment on table elmasri.projeto 
is 'Tabela que armazena as informa????es sobre os projetos dos departamentos.';
comment on column elmasri.projeto.numero_projeto
is 'N??mero do projeto. ?? a PK desta tabela.';
comment on column elmasri.projeto.nome_projeto 
is 'Nome do projeto. Deve ser ??nico.';
comment on column elmasri.projeto.local_projeto 
is 'Localiza????o do projeto.';
comment on column elmasri.projeto.numero_departamento 
is 'N??mero do departamento. ?? uma FK para a tabela departamento.';

comment on table elmasri.localizacoes_departamento 
is 'Tabela que armazena as poss??veis localiza????es dos departamentos.';
comment on column elmasri.localizacoes_departamento.numero_departamento
is 'N??mero do departamento. Faz parta da PK desta tabela e tamb??m ?? uma FK para a tabela departamento.';
comment on column elmasri.localizacoes_departamento."local" 
is 'Localiza????o do departamento. Faz parte da PK desta tabela.';

comment on table elmasri.trabalha_em 
is 'Tabela para armazenar quais funcion??rios trabalham em quais projetos.';
comment on column elmasri.trabalha_em.cpf_funcionario 
is 'CPF do funcion??rio. Faz parte da PK desta tabela e ?? uma FK para a tabela funcion??rio.';
comment on column elmasri.trabalha_em.numero_projeto 
is 'N??mero do projeto. Faz parte da PK desta tabela e ?? uma FK para a tabela projeto.';
comment on column elmasri.trabalha_em.horas 
is 'Horas trabalhadas pelo funcion??rio neste projeto.';

INSERT INTO elmasri.funcionario
(primeiro_nome, nome_meio, ultimo_nome, cpf, data_nascimento, endereco, sexo, salario, cpf_supervisor , numero_departamento)
values
('joao','B', 'silva', '12345678966', '09-01-1965', 'RuaDasFlores 751 S??o Paulo SP', 'M', 30.000, '33344555587', 5);
('Fernando','T', 'Wong', '33344555587', '08-12-1955', 'RuaDasLapa 34 S??o Paulo SP', 'M', 40.000, '88866555576', 5);
('Alice','J', 'Zelaya', '99988777767', '19-01-1968', 'RuaSouzaLima 35 Curitiba PR', 'F', 25.000, '98765432168', 4);
('Jeniffer','S', 'Souza', '98765432168', '20-06-1941', 'AvArthurDeLima 54 Santo Andre SP', 'F', 43.000, '88866555576', 4);
('Ronaldo','K', 'Lima', '66688444476', '15-09-1965', 'RuaRebou??as 65 Piracicaba SP', 'M', 38.000, '33344555587', 5);
('Joice','A', 'Leite', '45345345376', '31-07-1972', 'AvLucasObes 74 S??o Paulo SP', 'F', 25.000, '33344555587', 5);
('Andr??','V', 'Pereira', '98798798733', '29-03-1969', 'RuaTimbira 35 S??o Paulo SP', 'M', 25.000, '98765432168', 4);
('Jorge','E', 'Brito', '88866555576', '10-11-1937', 'RuaDoHorto 35 S??o Paulo SP', 'M', 55.000, 'null', 1);


INSERT INTO elmasri.dependente
(cpf_funcionario, nome_dependente, sexo, data_nascimento, parentesco)
values
('33344555587', 'Alicia', F, 05-04-1986, 'Filha');
('33344555587', 'Tiago', M, 05-04-1983, 'Filho');
('33344555587', 'Janaina', F, 05-04-1958, 'Esposa');
('98765432168', 'Antonio', M, 05-04-1942, 'Marido');
('12345678966', 'Michael', M, 05-04-1988, 'Filho');
('12345678966', 'Alicia', F, 05-04-1988, 'Filha');
('12345678966', 'Elizabeth', F, 05-05-1967, 'Esposa');


INSERT INTO elmasri.departamento
(nome_departamento, numero_departamento, cpf_gerente, data_inicio_gerente)
values
('Pesquisa', 5, '33344555587', 22-05-1988);
('Administra????o', 4, '98765432168', 01-01-1995);
('Matriz', 1, '88866555576', 19-06-1981);


INSERT INTO elmasri.localizacoes_departamento
(numero_departamtno, local)
values
(1, 'S??o Paulo');
(4, 'Mau??');
(5, 'Santo Andre');
(5, 'Itu');
(5, 'S??o Paulo');


INSERT INTO elmasri.projeto
(nome_projeto, numero_projeto, local_projeto, numero_projeto)
values
('ProdutoX', 1, 'Santo Andr??', 5);
('ProdutoY', 2, 'Itu', 5);
('ProdutoZ', 3, 'S??o Paulo', 5);
('Informatiza????o', 10, 'Mau??', 4);
('Reorganiza????o', 20, 'S??o Paulo', 1);
('Novosbenef??cios', 30, 'Mau??', 4);


INSERT INTO elmasri.trabalha_em
(cpf_funcionario, numero_projeto, horas)
values
('1234567866', 1, 32,5);
('1234567866', 2, 7,5);
('66688444476', 3, 40);
('45345345376', 1, 20);
('45345345376', 2, 20);
('33344555587', 2, 10);
('33344555587', 3, 10);
('33344555587', 10, 10);
('33344555587', 20, 10);
('99988777767', 30, 30);
('99988777767', 10, 10);
('98798798733', 10, 35);
('98798798733', 30, 5);
('98765432168', 30, 20);
('98765432168', 20, 15);
('88866555576', 20, null);
