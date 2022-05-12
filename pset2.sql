--QUESTÃO 01:

SELECT 
	f.numero_departamento AS "número do departamento",
	d.nome_departamento AS "nome do departamento",
	CAST(AVG(f.salario) AS MONEY) AS "média total do salário"
FROM
	funcionario AS f
	INNER JOIN
	departamento AS d
	ON
		(f.numero_departamento = d.numero_departamento)
GROUP BY
	d.numero_departamento, f.numero_departamento
ORDER BY
	d.numero_departamento ASC;

----------------------------------------||----------------------------------------

--QUESTÃO 02:

SELECT
	CASE f.sexo
	 	WHEN 'M' THEN 'Masculino'
		WHEN 'F' THEN 'Feminino'
	END AS "Sexo",
	CAST(AVG(f.salario) AS MONEY) AS "Média Salarial"
FROM
	funcionario AS f
GROUP BY
	f.sexo
ORDER BY
	f.sexo ASC;

----------------------------------------||----------------------------------------

-- QUESTÃO 03:

SELECT
	d.nome_departamento AS "Nome do Departamento",
	CONCAT(f.primeiro_nome, ' ', f.nome_meio, '. ', f.ultimo_nome) AS "Nome do Funcionário",
	TO_CHAR(f.data_nascimento, 'dd/mm/yyyy') AS "Data de Nascimento",
	DATE_PART('year', AGE(CURRENT_DATE, f.data_nascimento)) AS "Idade",
	CAST(f.salario AS MONEY) AS "Salário"
FROM
	departamento AS d
	INNER JOIN
	funcionario AS f
ON
	(d.numero_departamento = f.numero_departamento)
ORDER BY
	d.nome_departamento ASC;

----------------------------------------||----------------------------------------

-- QUESTÃO 04:

SELECT
	CONCAT(f.primeiro_nome, ' ', f.nome_meio, '. ', f.ultimo_nome) AS "Nome do Funcionário",
	DATE_PART('year', AGE(CURRENT_DATE, f.data_nascimento)) AS "Idade",
	CAST(f.salario AS MONEY) AS "Salário Atual",
	CAST(f.salario * 1.2 AS MONEY) AS "Salário com Reajuste"
FROM
	funcionario AS f
WHERE
	f.salario < 35000
UNION
SELECT
	CONCAT(f.primeiro_nome, ' ', f.nome_meio, '. ', f.ultimo_nome) AS "Nome do Funcionário",
	DATE_PART('year', AGE(CURRENT_DATE, f.data_nascimento)) AS "Idade",
	CAST(f.salario AS MONEY) AS "Salário Atual",
	CAST(f.salario * 1.15 AS MONEY) AS "Salário com Reajuste"
FROM
	funcionario AS f
WHERE
	f.salario >= 35000
ORDER BY
	"Nome do Funcionário" ASC;

----------------------------------------||----------------------------------------

-- QUESTÃO 05:

SELECT
	d.nome_departamento AS "Nome do Departamento",
	CONCAT(f2.primeiro_nome, ' ', f2.nome_meio, '. ', f2.ultimo_nome) AS "Nome do Gerente",
	CONCAT(f1.primeiro_nome, ' ', f1.nome_meio, '. ', f1.ultimo_nome) AS "Nome do Funcionario"
FROM
	departamento AS d
	NATURAL JOIN
	funcionario AS f1
	INNER JOIN
	funcionario AS f2
	ON
		d.cpf_gerente = f2.cpf
ORDER BY
	d.nome_departamento ASC,
	f1.salario DESC;

----------------------------------------||----------------------------------------

-- QUESTÃO 06:

SELECT
	CONCAT(f.primeiro_nome, ' ', f.nome_meio, '. ', f.ultimo_nome) AS "Nome do Funcionário",
	d.nome_departamento AS "Nome do Departamento",
	dep.nome_dependente AS "Nome do Dependente",
	DATE_PART('year', AGE(CURRENT_DATE, dep.data_nascimento)) AS "Idade do Dependente",
	CASE dep.sexo
		WHEN 'M' THEN 'Masculino'
		WHEN 'F' THEN 'Feminino'
	END AS "Sexo do Dependente"
FROM
	funcionario AS F
	INNER JOIN
	departamento AS d
	ON
		f.numero_departamento = d.numero_departamento
	INNER JOIN
	dependente AS dep
	ON
		f.cpf = dep.cpf_funcionario
ORDER BY
	"Idade do Dependente" ASC;

----------------------------------------||----------------------------------------

-- QUESTÃO 07:

SELECT
	CONCAT(f.primeiro_nome, ' ', f.nome_meio, '. ', f.ultimo_nome) AS "Nome do Funcionário",
	d.nome_departamento AS "Nome do Departamento",
	CAST(f.salario AS MONEY) AS "Salário"
FROM
	funcionario AS f
	INNER JOIN
	departamento AS d
	ON
		f.numero_departamento = d.numero_departamento
WHERE NOT EXISTS
	(
		SELECT
			*
		FROM
			dependente AS dep
		WHERE
			f.cpf = dep.cpf_funcionario
	)
ORDER BY
	"Nome do Funcionário" ASC;

----------------------------------------||----------------------------------------

-- QUESTÃO 08:

SELECT
	d.nome_departamento AS "Nome do Departamento",
	p.nome_projeto AS "Nome do Projeto",
	CONCAT(f.primeiro_nome, ' ', f.nome_meio, '. ', f.ultimo_nome) AS "Nome do Funcionário",
	te.horas AS "Horas Trabalhadas"
FROM
	departamento AS d
	NATURAL JOIN
	projeto AS p
	NATURAL JOIN
	trabalha_em AS te
	INNER JOIN
	funcionario AS f
	ON
		f.cpf = te.cpf_funcionario
ORDER BY
	d.nome_departamento ASC,
	p.nome_projeto ASC,
	"Nome do Funcionário" ASC;

----------------------------------------||----------------------------------------

-- QUESTÃO 09:

SELECT
	d.nome_departamento AS "Nome do Departamento",
	p.nome_projeto AS "Nome do Projeto",
	SUM(te.horas) AS "Total de Horas Trabalhadas"
FROM
	trabalha_em AS te
	NATURAL JOIN
	projeto AS p
	NATURAL JOIN
	departamento AS d
GROUP BY
	d.nome_departamento,
	p.nome_projeto
ORDER BY
	d.nome_departamento ASC,
	p.nome_projeto ASC;

----------------------------------------||----------------------------------------

-- QUESTÃO 10:

SELECT
	d.nome_departamento AS "Nome do Departamento",
	CAST(AVG(f.salario) AS MONEY) AS "Média Salarial"
FROM
	departamento AS d
	NATURAL JOIN
	funcionario AS f
GROUP BY
	d.nome_departamento
ORDER BY
	d.nome_departamento ASC;

----------------------------------------||----------------------------------------

-- QUESTÃO 11:

SELECT
	CONCAT(f.primeiro_nome, ' ', f.nome_meio, '. ', f.ultimo_nome) AS "Nome do Funcionário",
	p.nome_projeto AS "Nome do Projeto",
	CAST(50 * te.horas AS MONEY) AS "Valor"
FROM
	trabalha_em AS te
	NATURAL JOIN
	projeto AS p
	INNER JOIN
	funcionario AS f
	ON
		te.cpf_funcionario = f.cpf
ORDER BY
	"Nome do Funcionário" ASC,
	"Nome do Projeto" ASC;

----------------------------------------||----------------------------------------

-- QUESTÃO 12:

SELECT
	d.nome_departamento AS "Nome do Departamento",
	p.nome_projeto AS "Nome do Projeto",
	CONCAT(f.primeiro_nome, ' ', f.nome_meio, '. ', f.ultimo_nome) AS "Nome do Funcionário"
FROM
	departamento AS d
	NATURAL JOIN
	projeto AS p
	NATURAL JOIN
	funcionario AS f
	INNER JOIN
	trabalha_em AS te
	ON
		te.cpf_funcionario = f.cpf
WHERE
	te.horas IS NULL;

----------------------------------------||----------------------------------------

-- QUESTÃO 13:

SELECT
	CONCAT(f.primeiro_nome, ' ', f.nome_meio, '. ', f.ultimo_nome) AS "Nome",
	CASE f.sexo
		WHEN 'F' THEN 'Feminino'
		WHEN 'M' THEN 'Masculino'
	END AS "Sexo",
	DATE_PART('year', AGE(CURRENT_DATE, f.data_nascimento)) AS "Idade"
FROM
	funcionario AS f
UNION
SELECT
	dep.nome_dependente AS "Nome",
	CASE dep.sexo
		WHEN 'F' THEN 'Feminino'
		WHEN 'M' THEN 'Masculino'
	END AS "Sexo",
	DATE_PART('year', AGE(CURRENT_DATE, dep.data_nascimento)) AS "Idade"
FROM
	dependente AS dep
ORDER BY
	"Idade" DESC;

----------------------------------------||----------------------------------------

-- QUESTÃO 14:

SELECT
	d.nome_departamento AS "Nome do Departamento",
	COUNT(f.cpf) AS "Número de Funcionários"
FROM
	departamento AS d
	NATURAL JOIN
	funcionario AS f
GROUP BY
	d.numero_departamento
ORDER BY
	"Nome do Departamento" ASC;

----------------------------------------||----------------------------------------

-- QUESTÃO 15:

SELECT
	CONCAT(f.primeiro_nome, ' ', f.nome_meio, '. ', f.ultimo_nome) AS "Nome do Funcionário",
	d.nome_departamento AS "Nome do Departamento",
	p.nome_projeto AS "Nome do Projeto"
FROM
	departamento AS d
	NATURAL JOIN
	projeto AS p
	NATURAL JOIN
	trabalha_em AS te
	RIGHT OUTER JOIN
	funcionario AS f
	ON
		te.cpf_funcionario = f.cpf
ORDER BY
	"Nome do Funcionário" ASC,
	"Nome do Departamento" ASC;
