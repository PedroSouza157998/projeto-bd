-- Grupy by/ having 
-- A quantidade de livros alugados em cada biblioteca com mais de 2 aluguéis:
SELECT B.COD_BIBLIOTECA, COUNT(A.CPF) AS Qtd_Alugueis
FROM ALUGA A, BIBLIOTECA B 
WHERE A.COD_BIBLIOTECA = B.COD_BIBLIOTECA
GROUP BY B.COD_BIBLIOTECA
HAVING COUNT(A.CPF) > 2;


-- INNER JOIN
-- Exibir o Isbn , o nome do livro, seu ano  e sua editora.
SELECT L.ISBN, L.NOME AS LIVRO, L.ANO, E.NOME AS EDITORA
FROM LIVRO L
INNER JOIN EDITORA E ON L.CNPJ = E.CNPJ;


-- JUNÇÃO EXTERNA
-- Listar todos os cpfs, email, data de aluguel e o código da biblioteca dos usuários que alugaram ou não um livro


SELECT U.CPF , U.EMAIL, A.DATA_ALUGUEL, A.COD_BIBLIOTECA FROM USUARIO U
LEFT OUTER JOIN ALUGA A
ON (U.CPF = A.CPF);




--Anti junção
--Exibir o cpf e telefone dos usuários que não alugaram livro


SELECT CPF, telefone
FROM USUARIO
WHERE NOT EXISTS (SELECT 1 FROM ALUGA WHERE USUARIO.CPF = ALUGA.CPF);




--Semi junção
--Listar os usuários que alugaram pelo menos um livro


SELECT U.CPF, U.email
FROM USUARIO U
WHERE EXISTS (
    SELECT 1
    FROM ALUGA A
    WHERE A.CPF = U.CPF);


--Tipo Linha
--Exibir o id da cópia em que O isbn seja igual a 9780987654321


SELECT ID FROM COPIA
WHERE (ID, ISBN) IN (SELECT C.ID, C.ISBN FROM COPIA C WHERE C.ISBN = '9780987654321');


--Tipo tabela
--Listar todos os funcionários que não são bibliotecários


SELECT F.CPF, F.NOME
FROM FUNCIONARIO F
WHERE F.CPF  NOT IN (
    SELECT CPF
    FROM BIBLIOTECARIO
);


--ESCALAR 
--Exibir o nome e o ano de publicação dos livros cujo ano é maior do que a média


SELECT L.NOME, L.ANO
FROM LIVRO L
WHERE L.ANO > (SELECT AVG(ANO) FROM LIVRO);


--OPERAÇÃO DE UNIÃO


SELECT B.CPF 
FROM BIBLIOTECARIO B
UNION
SELECT U.CPF
FROM USUARIO U