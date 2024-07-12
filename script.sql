-- ----------------------------------------------------------------
-- 1 Base de dados e criação de tabela
--escreva a sua solução aqui
CREATE TABLE students (
    student_id VARCHAR(20),
    age INTEGER,
    salary INTEGER,
    mother_edu INTEGER,
    father_edu INTEGER,
    prep_study INTEGER,
    prep_exam INTEGER,
    grade INTEGER
);

DO $$
DECLARE
   cur_pais_phd REFCURSOR;
   v_aprovados INT;
BEGIN
   OPEN cur_pais_phd FOR
   SELECT COUNT(*) FROM students
   WHERE (mother_edu = 6 OR father_edu = 6) AND grade >= 4;
   FETCH cur_pais_phd INTO v_aprovados;
   RAISE NOTICE 'Número de alunos aprovados com pelo menos um dos pais PhDs: %', v_aprovados;
   CLOSE cur_pais_phd;
END;
$$;

-- ----------------------------------------------------------------
-- 2 Resultado em função da formação dos pais
--escreva a sua solução aqui
DO $$
DECLARE
   cur_pais_phd REFCURSOR;
   v_aprovados INT;
BEGIN
   OPEN cur_pais_phd FOR
   SELECT COUNT(*) FROM students
   WHERE (mother_edu = 6 OR father_edu = 6) AND grade > 0;
   FETCH cur_pais_phd INTO v_aprovados;
   RAISE NOTICE 'Número de alunos aprovados com pelo menos um dos pais PhDs: %', v_aprovados;
   CLOSE cur_pais_phd;
END;
$$;

-- ----------------------------------------------------------------
-- 3 Resultado em função dos estudos
--escreva a sua solução aqui
DO $$
DECLARE
   cur_estudos_solitarios REFCURSOR;
   v_aprovados INT;
BEGIN
   OPEN cur_estudos_solitarios FOR EXECUTE
   'SELECT COUNT(student_id) FROM students WHERE prep_study = 1 AND grade > 0';
   FETCH cur_estudos_solitarios INTO v_aprovados;
   IF v_aprovados = 0 THEN
       v_aprovados := -1;
   END IF;
   RAISE NOTICE 'Número de alunos aprovados que estudam sozinhos: %', v_aprovados;
   CLOSE cur_estudos_solitarios;
END;
$$;

-- ----------------------------------------------------------------
-- 4 Salário versus estudos
--escreva a sua solução aqui
DO $$
DECLARE
   cur_preparacao_regular CURSOR FOR
   SELECT COUNT(*) FROM students
   WHERE salary = 5 AND prep_exam = 2;
   v_contagem INT;
BEGIN
   OPEN cur_preparacao_regular;
   FETCH cur_preparacao_regular INTO v_contagem;
   RAISE NOTICE 'Número de alunos com salário > 410 que se preparam regularmente: %', v_contagem;
   CLOSE cur_preparacao_regular;
END;
$$;

-- ----------------------------------------------------------------
-- 5. Limpeza de valores NULL
--escreva a sua solução aqui


-- ----------------------------------------------------------------