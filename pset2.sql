-- Questão 1:

SELECT d.numero_departamento, AVG(salario) AS media_salario
FROM funcionarios AS f, departamento AS d
WHERE d.numero_departamento = f.numero_departamento
GROUP BY d.numero_departamento ;

-- Questão 2:

SELECT f.sexo, CAST(AVG(salario) AS DECIMAL (10, 2)) AS media 
FROM funcionarios AS f
WHERE (sexo = 'M')
GROUP BY f.sexo
UNION 
SELECT f.sexo, CAST(AVG(salario) AS DECIMAL (10, 2)) 
FROM funcionarios AS f
WHERE (sexo = 'F')
GROUP BY f.sexo;

-- Questão 3:

SELECT (f.primeiro_nome ||' '|| f.nome_meio ||' '|| f.ultimo_nome) AS nome, f.data_nascimento, CAST(f.salario AS DECIMAL(10,2)), d.nome_departamento, AGE(f.data_nascimento) AS data
FROM funcionarios AS f 
INNER JOIN
departamento AS d ON (f.numero_departamento = d.numero_departamento);

-- Questão 4:

SELECT (f.primeiro_nome ||' '|| f.nome_meio ||' '|| f.ultimo_nome) AS nome, CAST(f.salario AS DECIMAL (10,2)) AS salario, CAST (f.salario*1.2 AS DECIMAL (10,2)) AS salario_reajuste, d.nome_departamento
FROM funcionarios AS f, departamento AS d
WHERE salario < 35000 AND f.numero_departamento = d.numero_departamento
UNION
SELECT (f.primeiro_nome ||' '|| f.nome_meio ||' '|| f.ultimo_nome) AS nome, CAST(f.salario AS DECIMAL (10,2)) AS salario, CAST (f.salario*1.15 AS DECIMAL (10,2)) AS salario_reajuste, d.nome_departamento
FROM funcionarios AS f, departamento AS d
WHERE salario >= 35000 AND f.numero_departamento = d.numero_departamento;

-- Questão 5:

SELECT d.nome_departamento, (f.primeiro_nome ||' '|| f.nome_meio ||' '|| f.ultimo_nome) AS nome, f.salario
FROM departamento AS d, funcionarios AS f
WHERE d.numero_departamento = f.numero_departamento
ORDER BY d.nome_departamento ASC, f.salario DESC;

-- Questão 6:

SELECT f.numero_departamento, (f.primeiro_nome ||' '|| f.nome_meio ||' '|| f.ultimo_nome) AS nome_f, d.nome_dependente, AGE(d.data_nascimento) AS data_d, (case when(d.sexo = 'M')then 'Masculino' when(d.sexo = 'F')then 'Feminino'end) as sexo
FROM funcionarios AS f, dependente AS d
WHERE f.cpf = d.cpf_funcionario;

-- Questão 7:

SELECT (f.primeiro_nome||' '|| f.nome_meio||' '|| f.ultimo_nome) AS nome_f, f.numero_departamento, f.salario
FROM funcionarios AS f
WHERE f.cpf NOT IN (SELECT d.cpf_funcionario FROM dependente AS d);

-- Questão 8:

SELECT d.nome_departamento, p.nome_projeto, (f.primeiro_nome||' '|| f.nome_meio||' '|| f.ultimo_nome) AS nome_f, t.horas
FROM funcionarios AS f
INNER JOIN trabalha_em AS t
ON f.cpf = t.cpf_funcionario
INNER JOIN projeto AS p
ON t.numero_projeto = p.numero_projeto
INNER JOIN departamento AS d
ON p.numero_departamento = d.numero_departamento
ORDER BY d.nome_departamento, p.nome_projeto, f.salario DESC;

-- Questão 9:
SELECT d.nome_departamento, p.nome_projeto, SUM(T.horas) AS total
FROM funcionarios AS f
INNER JOIN trabalha_em AS t
ON f.cpf = t.cpf_funcionario
INNER JOIN projeto AS p
ON t.numero_projeto = p.numero_projeto
INNER JOIN departamento AS d
ON p.numero_departamento = d.numero_departamento
GROUP BY d.nome_departamento, p.nome_projeto;

-- Questão 10:

SELECT d.numero_departamento, AVG(salario) AS media
FROM funcionarios AS f, departamento AS d
WHERE d.numero_departamento = f.numero_departamento
GROUP BY d.numero_departamento ;

-- Questão 11:

SELECT (f.primeiro_nome||' '||f.nome_meio||' '|| f.ultimo_nome) AS nome_f, p.nome_projeto, CAST (t.horas * 50 AS DECIMAL(10,2)) AS total
FROM funcionarios AS f
INNER JOIN trabalha_em AS t
ON f.cpf = t.cpf_funcionario
INNER JOIN projeto AS p
ON t.numero_projeto = p.numero_projeto
ORDER BY f.salario DESC;

-- Questão 12:

SELECT d.nome_departamento, p.nome_projeto, (f.primeiro_nome||' '|| f.nome_meio||' '|| f.ultimo_nome) AS nome_f
FROM funcionarios AS f
INNER JOIN departamento AS d
ON f.numero_departamento = d.numero_departamento
INNER JOIN trabalha_em AS t
ON f.cpf = t.cpf_funcionario
INNER JOIN projeto AS p
ON t.numero_projeto = p.numero_projeto
WHERE t.horas IS NULL;

-- Questão 13:

SELECT (f.primeiro_nome||' '||f.nome_meio||' '||f.ultimo_nome) AS nome_f, (case when (f.sexo='m') then 'Masculino' when (f.sexo='f') then 'Feminino'end) as sexo, DATE_PART('year', AGE(f.data_nascimento)) AS data
FROM funcionarios AS f
UNION
SELECT (d.nome_dependente) AS nome_f, (case when (d.sexo='M') then 'Masculino' when (d.sexo='F') then 'Feminino'end) as sexo, DATE_PART('year', AGE(d.data_nascimento)) AS data
FROM dependente AS d
ORDER BY idade DESC; 

-- Questão 14:

SELECT d.nome_departamento, COUNT(f.cpf) AS quantidade_f
FROM funcionarios AS f
INNER JOIN departamento AS d
ON f.numero_departamento = d.numero_departamento
GROUP BY d.nome_departamento;

-- Questão 15:

SELECT (F.primeiro_nome||''|| F.nome_meio||''||F.ultimo_nome) AS nome_f, d.nome_departamento, p.nome_projeto
FROM funcionarios AS f
INNER JOIN trabalha_em AS t
ON f.cpf = t.cpf_funcionario
INNER JOIN projeto AS p
ON t.numero_projeto = p.numero_projeto
INNER JOIN departamento AS d
ON f.numero_departamento = d.numero_departamento
ORDER BY nome_funcionario;
