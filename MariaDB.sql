CREATE TABLE funcionario (
                cpf CHAR(11) NOT NULL,
                primeiro_nome VARCHAR(15) NOT NULL,
                nome_meio CHAR(1),
                ultimo_nome VARCHAR(15) NOT NULL,
                data_nascimento DATE,
                endereco VARCHAR(30),
                sexo CHAR(1),
                salario DECIMAL(10,2),
                cpf_supervisor CHAR(11) NOT NULL,
                numero_departamento INT NOT NULL,
                PRIMARY KEY (cpf)
);


CREATE TABLE dependente (
                cpf_funcionario CHAR(11) NOT NULL,
                nome_dependente VARCHAR(15) NOT NULL,
                sexo CHAR(1),
                data_nascimento DATE,
                parentesco VARCHAR(15),
                PRIMARY KEY (cpf_funcionario, nome_dependente)
);


CREATE TABLE departamento (
                numero_departamento INT NOT NULL,
                nome_departamento VARCHAR(15) NOT NULL,
                cpf_gerente CHAR(11) NOT NULL,
                data_inicio_gerente DATE,
                PRIMARY KEY (numero_departamento)
);


CREATE UNIQUE INDEX nome_departameno
 ON departamento
 ( nome_departamento );

CREATE TABLE projeto (
                numero_projeto INT NOT NULL,
                nome_projeto VARCHAR(15) NOT NULL,
                local_projeto VARCHAR(15),
                numero_departamento INT NOT NULL,
                PRIMARY KEY (numero_projeto)
);


CREATE UNIQUE INDEX nome_projeto
 ON projeto
 ( nome_projeto );

CREATE TABLE localizacoes_departamento (
                numero_departamento INT NOT NULL,
                local VARCHAR(15) NOT NULL,
                PRIMARY KEY (numero_departamento, local)
);


CREATE TABLE trabalha_em (
                cpf_funcionario CHAR(11) NOT NULL,
                numero_projeto INT NOT NULL,
                horas DECIMAL(3,1) NOT NULL,
                PRIMARY KEY (cpf_funcionario, numero_projeto)
);


ALTER TABLE trabalha_em ADD CONSTRAINT funcionario_trabalha_em_fk
FOREIGN KEY (cpf_funcionario)
REFERENCES funcionario (cpf)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE departamento ADD CONSTRAINT funcionario_departamento_fk
FOREIGN KEY (cpf_gerente)
REFERENCES funcionario (cpf)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE funcionario ADD CONSTRAINT funcionario_funcionario_fk
FOREIGN KEY (cpf_supervisor)
REFERENCES funcionario (cpf)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE dependente ADD CONSTRAINT funcionario_dependente_fk
FOREIGN KEY (cpf_funcionario)
REFERENCES funcionario (cpf)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE localizacoes_departamento ADD CONSTRAINT departamento_localizacoes_departamento_fk
FOREIGN KEY (numero_departamento)
REFERENCES departamento (numero_departamento)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE projeto ADD CONSTRAINT departamento_projeto_fk
FOREIGN KEY (numero_departamento)
REFERENCES departamento (numero_departamento)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE trabalha_em ADD CONSTRAINT projeto_trabalha_em_fk
FOREIGN KEY (numero_projeto)
REFERENCES projeto (numero_projeto)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

INSERT INTO funcionario 
(primeiro_nome, nome_meio, ultimo_nome, cpf, data_nascimento, endereco, sexo, salario, cpf_supervisor , numero_departamento)
values
('joao','B', 'silva', '12345678966', '1965-01-09', 'RuaDasFlores 751 São Paulo SP', 'M', 30.000, '33344555587', 5);
('Fernando','T', 'Wong', '33344555587', '1955-12-08', 'RuaDasLapa 34 São Paulo SP', 'M', 40.000, '88866555576', 5);
('Alice','J', 'Zelaya', '99988777767', '1968-01-19', 'RuaSouzaLima 35 Curitiba PR', 'F', 25.000, '98765432168', 4);
('Jeniffer','S', 'Souza', '98765432168', '1941-06-20', 'AvArthurDeLima 54 Santo Andre SP', 'F', 43.000, '88866555576', 4);
('Ronaldo','K', 'Lima', '66688444476', '1965-09-15', 'RuaRebouças 65 Piracicaba SP', 'M', 38.000, '33344555587', 5);
('Joice','A', 'Leite', '45345345376', '1972-07-31', 'AvLucasObes 74 São Paulo SP', 'F', 25.000, '33344555587', 5);
('André','V', 'Pereira', '98798798733', '1969-03-29', 'RuaTimbira 35 São Paulo SP', 'M', 25.000, '98765432168', 4);
('Jorge','E', 'Brito', '88866555576', '1937-11-10', 'RuaDoHorto 35 São Paulo SP', 'M', 55.000, 'null', 1);


INSERT INTO dependente 
(cpf_funcionario, nome_dependente, sexo, data_nascimento, parentesco)
values
('33344555587', 'Alicia', F, 1986-04-05, 'Filha');
('33344555587', 'Tiago', M, 1983-04-05, 'Filho');
('33344555587', 'Janaina', F, 1958-04-05, 'Esposa');
('98765432168', 'Antonio', M, 1942-04-05, 'Marido');
('12345678966', 'Michael', M, 1988-04-05, 'Filho');
('12345678966', 'Alicia', F, 1988-04-05, 'Filha');
('12345678966', 'Elizabeth', F, 1967-05-05, 'Esposa');


INSERT INTO departamento 
(nome_departamento, numero_departamento, cpf_gerente, data_inicio_gerente)
values
('Pesquisa', 5, '33344555587', 1988-05-22);
('Administração', 4, '98765432168',1995-01-01;
('Matriz', 1, '88866555576', 1981-06-19);


INSERT INTO localizacoes_departamento 
(numero_departamtno, local)
values
(1, 'São Paulo');
(4, 'Mauá');
(5, 'Santo Andre');
(5, 'Itu');
(5, 'São Paulo');


INSERT INTO projeto 
(nome_projeto, numero_projeto, local_projeto, numero_projeto)
values
('ProdutoX', 1, 'Santo André', 5);
('ProdutoY', 2, 'Itu', 5);
('ProdutoZ', 3, 'São Paulo', 5);
('Informatização', 10, 'Mauá', 4);
('Reorganização', 20, 'São Paulo', 1);
('Novosbenefícios', 30, 'Mauá', 4);


INSERT INTO trabalha_em 
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
