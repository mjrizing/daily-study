-- 시퀀스: 오라클 데이터베이스에서 특정 규칙에 맞는 연속 숫자를 생성하는 객체이다.  
-- 은행이나 병원의 대기 순번표와 마찬가지로 번호를 사용해야 하는 사용자에게 계속 다음 번호를 만들어 주는 역할을 한다.

-- 10만큼 증가하는 시퀀스 생성하기
CREATE   SEQUENCE   SEQ_DEPT_SEQUENCE
  INCREMENT  BY  10
  START   WITH  10
  MAXVALUE  90
  MINVALUE 0
  NOCYCLE
  CACHE  2;

SELECT  *  FROM  USER_SEQUENCES;

-- 시퀀스 사용하기
-- 생성된 시퀀스를 사용할 때는 [시퀀스이름.CURRVAL]과 [시퀀스이름.NEXTVAL]을 사용한다. CURRVAL은 시퀀스에서 마지막으로 생성한 번호를 반환하며 NEXTVAL은 다음 번호를 생성한다.
-- 그리고 CURRVAL은 시퀀스를 생성하고 바로 사용하면 번호가 만들어진 적이 없으므로 오류가 난다. 따라서 테이블에 시퀀스를 사용하려면 NEXTVAL을 사용해야한다.

-- 시퀀스에서 생성한 번호를 사용한 INSERT문 실행
INSERT  INTO  DEPT_SEQUENCE (DEPTNO, DNAME, LOC)
VALUES (SEQ_DEPT_SEQUENCE.NEXTVAL, 'DATABASE', 'SEOUL');

SELECT  *  FROM  DEPT_SEQUENCE   ORDER   BY   DEPTNO;

-- 시퀀스에서 생성한 번호를 사용한 INSERT문 실행 반복
INSERT  INTO  DEPT_SEQUENCE (DEPTNO, DNAME, LOC)
VALUES (SEQ_DEPT_SEQUENCE.NEXTVAL, 'DATABASE', 'SEOUL');
-- 9번째까지 입력이되고 에러가 난다.

-- ALTER 명령어로 시퀀스를 수정하고, DROP 명령어로 시퀀스를 삭제할 수 있다.
-- 시퀀스 수정은 옵션을 재설정하는 데 사용할 수 있지만 START WITH 값은 변경할 수 없다.

-- 시퀀스 수정
ALTER  SEQUENCE SEQ_DEPT_SEQUENCE
  INCREMENT BY 3
  MAXVALUE 99
  CYCLE;
  
-- 수정 확인
SELECT  *  FROM   USER_SEQUENCES;

-- 수정한 시퀀스를  사용하여 INSERT문 실행 반복
INSERT  INTO  DEPT_SEQUENCE (DEPTNO, DNAME, LOC)
VALUES (SEQ_DEPT_SEQUENCE.NEXTVAL, 'DATABASE', 'SEOUL');     <<  1번  실행

-- 시퀀스 삭제하기
DROP  SEQUENCE   SEQ_DEPT_SEQUENCE;

-- 확인
SELECT  *  FROM  USER_SEQUENCES;



--4. 사원수가 3명 이상인 부서의 부서명과 사원수를 출력하는 SQL작성.
select job
     , count(*)
from emp
group by job
having count(*) >= 3;


--5. SMITH 사원보다 일찍 입사한 사원의 이름과 입사일을 출력하는 SQL작성.
SELECT ENAME, HIREDATE
FROM EMP
WHERE HIREDATE>(SELECT HIREDATE
   FROM EMP
   WHERE ENAME='SMITH');
   

--6. 급여(SAL+COMM)가 평균 급여보다 많은 사원의 부서번호, 이름, 급여(SAL+COMM)를 출력하는 SQL작성.
SELECT DEPTNO, ename, SAL+COMM
FROM emp
WHERE SAL+COMM > (SELECT AVG(SAL) FROM EMP)
ORDER BY SAL;


--7. 업무가 SALSEMAN인 직원이 2명 이상인 부서의 이름, 근무하는 사원의 이름을 출력하는 SQL작성.
SELECT D.DNAME, E.ENAME
FROM EMP E, DEPT D
WHERE E.DEPTNO = D.DEPTNO
    AND E.DEPTNO IN (   SELECT DEPTNO 
                        FROM EMP
                        WHERE JOB = 'SALESMAN'
                        GROUP BY DEPTNO
                        HAVING COUNT(job) >= 2);
