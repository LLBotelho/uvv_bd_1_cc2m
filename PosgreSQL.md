# PostgreSQL

# ***Tabelas***

**Criação das tabelas e colunas**

```
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
```
---
# ***Alterações***

**Criando as constraints e os relacionamentos necessários**

```
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
```
---
# ***Comentários***

**Comentando todas as tabelas e colunas com uma breve descrição do que é cada uma**

```
comment on table elmasri.funcionario 
is 'Tabela que armazena as informações dos funcionários.';
comment on column elmasri.funcionario.cpf 
is 'CPF do funcionário. Será a PK da tabela.';
comment on column elmasri.funcionario.primeiro_nome 
is 'Primeiro nome do funcionário.';
comment on column elmasri.funcionario.nome_meio 
is 'Inicial do nome do meio.';
comment on column elmasri.funcionario.ultimo_nome  
is 'Sobrenome do funcionário.';
comment on column elmasri.funcionario.endereco  
is 'Endereço do funcionário.';
comment on column elmasri.funcionario.sexo 
is 'Sexo do funcionário.';
comment on column elmasri.funcionario.salario 
is 'Salário do funcionário.';
comment on column elmasri.funcionario.cpf_supervisor  
is 'CPF do supervisor. Será uma FK para a própria tabela (um auto-relacionamento).';
comment on column elmasri.funcionario.numero_departamento 
is 'Número do departamento do funcionário.';

comment on table elmasri.dependente
is 'Tabela que armazena as informações dos dependentes dos funcionários.';
comment on column elmasri.dependente.cpf_funcionario
is 'CPF do funcionário. Faz parte da PK desta tabela e é uma FK para a tabela funcionário.';
comment on column elmasri.dependente.nome_dependente 
is 'Nome do dependente. Faz parte da PK desta tabela.';
comment on column elmasri.dependente.sexo 
is 'Sexo do dependente.';
comment on column elmasri.dependente.data_nascimento 
is 'Data de nascimento do dependente.';
comment on column elmasri.dependente.parentesco 
is 'Descrição do parentesco do dependente com o funcionário.';

comment on table elmasri.departamento 
is 'Tabela que armazena as informaçoẽs dos departamentos.';
comment on column elmasri.departamento.numero_departamento 
is 'Número do departamento. É a PK desta tabela.';
comment on column elmasri.departamento.nome_departamento 
is 'Nome do departamento. Deve ser único.';
comment on column elmasri.departamento.cpf_gerente 
is 'CPF do gerente do departamento. É uma FK para a tabela funcionários.';
comment on column elmasri.departamento.data_inicio_gerente 
is 'Data do início do gerente no departamento.';

comment on table elmasri.projeto 
is 'Tabela que armazena as informações sobre os projetos dos departamentos.';
comment on column elmasri.projeto.numero_projeto
is 'Número do projeto. É a PK desta tabela.';
comment on column elmasri.projeto.nome_projeto 
is 'Nome do projeto. Deve ser único.';
comment on column elmasri.projeto.local_projeto 
is 'Localização do projeto.';
comment on column elmasri.projeto.numero_departamento 
is 'Número do departamento. É uma FK para a tabela departamento.';

comment on table elmasri.localizacoes_departamento 
is 'Tabela que armazena as possíveis localizações dos departamentos.';
comment on column elmasri.localizacoes_departamento.numero_departamento
is 'Número do departamento. Faz parta da PK desta tabela e também é uma FK para a tabela departamento.';
comment on column elmasri.localizacoes_departamento."local" 
is 'Localização do departamento. Faz parte da PK desta tabela.';

comment on table elmasri.trabalha_em 
is 'Tabela para armazenar quais funcionários trabalham em quais projetos.';
comment on column elmasri.trabalha_em.cpf_funcionario 
is 'CPF do funcionário. Faz parte da PK desta tabela e é uma FK para a tabela funcionário.';
comment on column elmasri.trabalha_em.numero_projeto 
is 'Número do projeto. Faz parte da PK desta tabela e é uma FK para a tabela projeto.';
comment on column elmasri.trabalha_em.horas 
is 'Horas trabalhadas pelo funcionário neste projeto.';
```
---
# ***Dados***

**Inserindo todos os dados em suas devidas colunas e tabelas**

```
INSERT INTO elmasri.funcionario
(primeiro_nome, nome_meio, ultimo_nome, cpf, data_nascimento, endereco, sexo, salario, cpf_supervisor , numero_departamento)
values
('joao','B', 'silva', '12345678966', '09-01-1965', 'RuaDasFlores 751 São Paulo SP', 'M', 30.000, '33344555587', 5);
('Fernando','T', 'Wong', '33344555587', '08-12-1955', 'RuaDasLapa 34 São Paulo SP', 'M', 40.000, '88866555576', 5);
('Alice','J', 'Zelaya', '99988777767', '19-01-1968', 'RuaSouzaLima 35 Curitiba PR', 'F', 25.000, '98765432168', 4);
('Jeniffer','S', 'Souza', '98765432168', '20-06-1941', 'AvArthurDeLima 54 Santo Andre SP', 'F', 43.000, '88866555576', 4);
('Ronaldo','K', 'Lima', '66688444476', '15-09-1965', 'RuaRebouças 65 Piracicaba SP', 'M', 38.000, '33344555587', 5);
('Joice','A', 'Leite', '45345345376', '31-07-1972', 'AvLucasObes 74 São Paulo SP', 'F', 25.000, '33344555587', 5);
('André','V', 'Pereira', '98798798733', '29-03-1969', 'RuaTimbira 35 São Paulo SP', 'M', 25.000, '98765432168', 4);
('Jorge','E', 'Brito', '88866555576', '10-11-1937', 'RuaDoHorto 35 São Paulo SP', 'M', 55.000, 'null', 1);


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
('Administração', 4, '98765432168', 01-01-1995);
('Matriz', 1, '88866555576', 19-06-1981);


INSERT INTO elmasri.localizacoes_departamento
(numero_departamtno, local)
values
(1, 'São Paulo');
(4, 'Mauá');
(5, 'Santo Andre');
(5, 'Itu');
(5, 'São Paulo');


INSERT INTO elmasri.projeto
(nome_projeto, numero_projeto, local_projeto, numero_projeto)
values
('ProdutoX', 1, 'Santo André', 5);
('ProdutoY', 2, 'Itu', 5);
('ProdutoZ', 3, 'São Paulo', 5);
('Informatização', 10, 'Mauá', 4);
('Reorganização', 20, 'São Paulo', 1);
('Novosbenefícios', 30, 'Mauá', 4);


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
```
---
