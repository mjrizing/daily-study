SELECT ENAME AS "사원명", DEPTNO as "부서번호", 
DECODE(DEPTNO,10,'Accounting',20,'Research',30,'Sales') AS "부서명" 
FROM EMP;

SELECT DECODE(DEPTNO,10,1,0) 
FROM EMP; --조건１이 아니라면 0을 반환하라.

SELECT SUM(DECODE(DEPTNO,10,1,0)) 
FROM EMP; --10번 부서의 직원수.

SELECT COUNT(ENAME)
FROM EMP
WHERE DEPTNO IN (10,20)
ORDER BY ENAME;

SELECT SUM(DECODE(DEPTNO,10,1,0))
FROM EMP --조건１이 아니라면 0을 반환하라.
union all
SELECT SUM(DECODE(DEPTNO,20,1,0)) --20번 부서의 사원수
FROM EMP --조건１이 아니라면 0을 반환하라.
union all
SELECT SUM(DECODE(DEPTNO,30,1,0)) --30번 부서의 사원수
FROM EMP; --조건１이 아니라면 0을 반환하라.
--10번 부서의 사원수
--union은 합집합 이어붙여준다.


SELECT EMPNO,ENAME,JOB,SAL,
DECODE(JOB,
        'MANAGER', SAL*1.1,
        'SALESMAN', SAL*1.05,
        'ANALYST', SAL,
        SAL*1.03) AS UPSAL
FROM EMP;

SELECT  EMPNO, ENAME, JOB, SAL,
          CASE JOB --CASE문 if문과 비슷하게 검사대상이 될 열 또는 데이터, 연산이나 함수의 결과선택
                  WHEN 'MANAGER' THEN SAL*1.1	 --조건1의 결과값이 TRUE일때 반환할 결과 
                  WHEN 'SALESMAN' THEN SAL*1.05 --조건2의 결과값이 TRUE일때 반환할 결과 
                  WHEN 'ANALYST' THEN SAL
                  ELSE SAL*1.03 --위 조건 조건1과 2와 일치한 경우가 없을때 반환할 결과.
         END AS UPSAL
 FROM EMP;
 
SELECT SUM(COMM) 
FROM EMP;

SELECT  EMPNO, ENAME, COMM,
          CASE 
                  WHEN COMM IS NULL THEN '해당사항없음'
                  WHEN COMM = 0 THEN '수당없음'
                  WHEN COMM > 0 THEN '수당 :  '  ||  COMM
          END AS COMM_TEXT
FROM EMP;

CREATE TABLE DEPT_TEMP AS SELECT * FROM DEPT; --테이블생성 --TEMP는 주로 임시라는 의미로 많이사용.
SELECT * FROM DEPT_TEMP; --테이블확인.

--INSERT문 : 테이블을 잘 못 만들었거나 지워야 할 경우에는 명령어 DROP TABLE 테이블 이름; 을 사용한다.
--INSERT문 : 테이블에 데이터를 추가하는 INSERT문.

INSERT INTO DEPT_TEMP (DEPTNO, DNAME, LOC)
VALUES(50,'DATABASE','SEOUL'); --INSERT INTO 테이블명( 1번, 2번, 3번) VALUES( 들어갈값1, 들어갈값2, 들어갈값3);
SELECT * FROM DEPT_TEMP; -- 1행추가시킨다음의 DEPT_TEMP테이블 모두출력.

INSERT INTO DEPT_TEMP VALUES (60,'NETWORK','BUSAN'); --컬럼명 열지정없이 입력.
SELECT * FROM DEPT_TEMP; -- 1행 추가 시킨다음의 DEPT_TEMP테이블 모두출력.

--테이블에 NULL값 데이터를 입력하기
INSERT INTO DEPT_TEMP (DEPTNO, DNAME, LOC)
VALUES(70,'WEB', NULL);
SELECT * FROM DEPT_TEMP;

--NULL 적는것 대신에 공백으로도 NULL값 입력가능
INSERT INTO DEPT_TEMP (DEPTNO, DNAME, LOC)
VALUES(80,'MOBILE', ' ');
SELECT * FROM DEPT_TEMP;

--열 데이터를 넣지않는 방식으로도 NULL 데이터 입력가능.
INSERT  INTO  DEPT_TEMP ( DEPTNO, LOC ) 
VALUES ( 90, 'INCHEON' );
SELECT * FROM DEPT_TEMP;

CREATE TABLE EMP_TEMP AS SELECT * FROM EMP WHERE 1 <> 1;
SELECT * FROM EMP_TEMP;

INSERT INTO EMP_TEMP (EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM, DEPTNO)
VALUES (9999, '홍길동', 'PRESIDENT', NULL, '01/01/01', 5000, 1000, 10);
SELECT * FROM EMP_TEMP;

INSERT  INTO  EMP_TEMP ( EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM, DEPTNO )
                VALUES (1111, '성춘향', 'MANAGER', 9999, '01-01-02', 4000, NULL, 20);
SELECT * FROM EMP_TEMP;

--데이터를 수정. 즉, 변경
CREATE TABLE DEPT_TEMP2 AS SELECT * FROM DEPT;
SELECT * FROM DEPT_TEMP2;

--UPDATE문 사용하기- UPDATE[변경할테이블] 
--SET[변경할열1] = [데이터], [변경할열2]=[테이블]
--[WHERE 데이터를 변경할 대상 행을 선별하기 위한 조건]; 

UPDATE  DEPT_TEMP2
SET LOC = 'SEOUL';

SELECT * FROM DEPT_TEMP2; --WHERE 절이없기때문에 LOC가 전부 SEOUL로 바뀜.

ROLLBACK; -- 이전상태로 되돌아가기 롤백
SELECT * FROM DEPT_TEMP2;

UPDATE DEPT_TEMP2
SET DNAME = 'DATABASE', --DANME을 데이터베이스로 바꾸고
LOC = 'SEOUL' --LOC을 SEOUL로 변경
WHERE DEPTNO = 40; -- --조건 부서번호가 40
SELECT * FROM DEPT_TEMP2;

--데이터 삭제하기
CREATE TABLE EMP_TEMP2 AS SELECT * FROM EMP;
SELECT * FROM EMP_TEMP2;

DELETE FROM EMP_TEMP2
 WHERE JOB= 'MANAGER';

SELECT * FROM EMP_TEMP2;

ROLLBACK;
SELECT * FROM EMP_TEMP2;

DELETE FROM EMP_TEMP2; --EMP_TEMP2 테이블 전체데이터 삭제.
SELECT * FROM EMP_TEMP2;


--1번 문제 emp 테이블에서 부서인원이 6명 이상인 부서의 부서번호,부서인원,급여의 합을 출력하라
SELECT DEPTNO AS 부서번호 , COUNT(*) AS 부서인원, SUM(SAL) AS 급여합계
FROM EMP
GROUP BY DEPTNO
HAVING COUNT(*)>=6;

--2번 문제 emp 테이블에서 급여(수당 포함)가 900을 초과하는 사원들의 업무(job)와 급여합계를 출력하라.
SELECT JOB AS 업무, SAL+COMM AS 급여합계
FROM EMP
WHERE SAL+COMM > 900;

--3번 문제 emp 테이블에서 근무지(loc)와 각 근무지(loc)의 사원의 수를 출력하는 SQL 작성 ( 단, 근무지 사원수는 5명이하인경우)
SELECT COUNT(*) AS 근무지별사원수
FROM EMP
GROUP BY DEPTNO;


--4번 문제 emp테이블에서 가장 많은 부하사원을 갖는 사원의 사원 번호를 출력하는 SQL 작성.
SELECT MGR AS EMPNO 
FROM EMP
GROUP BY MGR
HAVING COUNT(MGR) = (SELECT MAX(COUNT(*))FROM EMP GROUP BY MGR);


SELECT E1.EMPNO, E1.ENAME, E1.MGR,
          E2.EMPNO AS MGR_EMPNO,
          E2.ENAME AS MGR_ENAME
FROM EMP E1, EMP E2
WHERE E1.MGR = E2.EMPNO(+)
ORDER BY E1.EMPNO;

SELECT * FROM EMP;

SELECT E1.EMPNO, E1.ENAME, E1.MGR, E2.EMPNO AS "E2_EMPNO",E2.ENAME AS "E2_ENAME" --E2_EAME 상사이름.
FROM EMP E1, EMP E2
WHERE E1.MGR = E2.EMPNO(+); --outer join 오라클에서만 쓸수있음. +기호는 관계없는 컬럼에 붙인다.


--5번 상사가 KING인 모든 사원의 이름과 급여를 출력하는 SQL작성.
SELECT ENAME, SAL
FROM EMP
WHERE MGR = (SELECT EMPNO FROM EMP
WHERE ENAME = 'KING');
              
                    
--6번 사원번호가 7566인 사원 보다 일찍 입사한 사원의 이름과 입사일을 출력하는 SQL작성.
SELECT ENAME, HIREDATE
FROM EMP
WHERE HIREDATE < (SELECT HIREDATE
                    FROM EMP
                    WHERE EMPNO = '7566');
                    

CREATE TABLE DEPT_TCL AS SELECT * FROM DEPT;
SELECT * FROM DEPT_TCL;      

INSERT INTO DEPT_TCL VALUES(50, 'DATABASE', 'SEOUL');
UPDATE DEPT_TCL SET LOC='BUSAN' WHERE DEPTNO =40;
DELETE FROM DEPT_TCL WHERE DNAME ='RESEARCH';
SELECT * FROM DEPT_TCL;

ROLLBACK;
SELECT * FROM DEPT_TCL;

INSERT INTO DEPT_TCL VALUES(50, 'NETWORK', 'SEOUL');
UPDATE DEPT_TCL SET LOC='BUSAN' WHERE DEPTNO = 20;
DELETE FROM DEPT_TCL WHERE DEPTNO = '40';
SELECT * FROM DEPT_TCL;

COMMIT;

ROLLBACK; --COMMIT 을 했기때문에 ROLLBACK 적용안됨.
SELECT * FROM DEPT_TCL;

-- 트랜잭션 : 작업단위.
-- 세션: 접속. 연결한상태 세션이 여러개라는 말은 지금oracle서버에 연결된 사용자가 여러명이라는소리.




---------------------------------------마지막교시 복습---------------------------------------------
--복습1번. EMP 테이블에서 사원 이름이 J또는 A로 시작하는 사원의 이름을 첫글자는 대문자로, 나머지 글자는 소문자로 출력하는 SQL작성.
SELECT INITCAP(ENAME), LENGTH(ENAME) 
FROM EMP
WHERE ENAME LIKE 'J%' OR ENAME LIKE 'A%';


--복습2번. 사원이름의 글자수가 6자 이상인 사원의 이름을 소문자로 출력하는 SQL작성.
SELECT LOWER(ENAME) 
FROM EMP
WHERE LENGTH(ENAME)>=6;


--복습3번. 사원 이름의 글자수가 6자 이상인 사원의 이름을 앞에서 2글자만 출력하는 SQL작성.
SELECT SUBSTR(ENAME,1,2)
FROM EMP
WHERE LENGTH(ENAME)>=6;


--복습4번. BLAKE와 같은 부서에 있는 사원들의 사원이름과 입사일을 출력하는 SQL작성.
SELECT ENAME, HIREDATE
 FROM EMP
 WHERE DEPTNO IN ( SELECT DEPTNO
                    FROM EMP
                    WHERE ENAME = 'BLAKE');
                    
                    
--복습5번. 사원전체에 대해 평균급여를 구한후  평균급여보다 많은 급여를 받는 사원들의 사원번호, 이름, 급여를 출력하는 SQL작성.
SELECT EMPNO, ENAME, SAL+COMM
FROM EMP
WHERE SAL+COMM > (SELECT FLOOR (AVG(SAL))
                FROM EMP);

    
--복습6번. 사원수가 3명이상인 부서의 부서명과 사원수를 출력하는 SQL작성.
SELECT D.DNAME, COUNT(*) 사원수
FROM EMP E, DEPT D
WHERE E.DEPTNO = D.DEPTNO
GROUP BY D.DNAME
HAVING COUNT(*)>=3;


--복습7번. 총 급여(SAL+COMM)가 평균 급여보다 많은 급여를 받는 사원의 부서번호, 사원이름, 총 급여(SAL+COMM), 추가수당(COMM)을 출력하는 SQL작성.
SELECT DEPTNO, ENAME, SAL+COMM, COMM
FROM EMP
WHERE SAL+COMM > (SELECT FLOOR(AVG(SAL)) 
                    FROM EMP);
                    
