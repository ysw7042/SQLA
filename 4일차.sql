--1. 부서 테이블과 사원테이블에서 사번, 사원명, 부서코드, 부서명을 검색하시오. ( 사원명 오름차순 정렬할 것 )
SELECT EMPNO,ENAME,DEPTNO,DNAME FROM EMP NATURAL JOIN DEPT ORDER BY ENAME;
SELECT EMPNO,ENAME,EMP.DEPTNO,DNAME FROM EMP JOIN DEPT ON EMP.DEPTNO=DEPT.DEPTNO ORDER BY ENAME;
SELECT EMPNO,ENAME,DEPT.DEPTNO,DNAME FROM EMP JOIN DEPT ON EMP.DEPTNO=DEPT.DEPTNO ORDER BY ENAME; 

--2. 부서 테이블과 사원테이블에서 사번, 사원명 , 급여 , 부서명을 검색하시오.
--단, 급여가 2000 이상인 사원에 대하여 급여기준으로 내림차순 정렬할 것.
SELECT EMPNO,ENAME,SAL,DNAME FROM EMP JOIN DEPT ON EMP.DEPTNO=DEPT.DEPTNO 
    WHERE SAL>=2000 ORDER BY SAL DESC;

--3. 부서 테이블과 사원 테이블에서 사번, 사원명, 업무, 급여 , 부서명을 검색하시오.
--단, 업무가 Manager이며 급여가 2500 이상인 사원에 대하여 사번을 기준으로 오름차순 정렬할 것.
SELECT EMPNO,ENAME,JOB,SAL,DNAME FROM EMP JOIN DEPT ON EMP.DEPTNO=DEPT.DEPTNO
    WHERE JOB='MANAGER' AND SAL>=2500 ORDER BY EMPNO;

SELECT EMPNO,ENAME,JOB,SAL,DNAME FROM EMP JOIN DEPT ON EMP.DEPTNO=DEPT.DEPTNO
    WHERE JOB='MANAGER' AND SAL>=2500 ORDER BY EMPNO;

--4. 사원 테이블과 급여 등급 테이블에서 사번, 사원명, 급여, 등급을 검색하시오.
--단, 등급은 급여가 하한값과 상한값 범위에 포함되고 등급이 4이며 급여를 기준으로 내림차순 정렬할 것.
SELECT EMPNO,ENAME,SAL,GRADE FROM EMP JOIN SALGRADE ON SAL BETWEEN LOSAL AND HISAL 
    WHERE GRADE=4 ORDER BY SAL DESC;

--5. 부서 테이블, 사원 테이블, 급여등급 테이블에서 사번, 사원명, 부서명, 급여 , 등급을 검색하시오. 
--단, 등급은 급여가 하한값과 상한값 범위에 포함되며 등급을 기준으로 내림차순 정렬할 것.
SELECT EMPNO,ENAME,DNAME,SAL,GRADE FROM EMP JOIN DEPT ON EMP.DEPTNO=DEPT.DEPTNO 
    JOIN SALGRADE ON SAL BETWEEN LOSAL AND HISAL ORDER BY GRADE DESC;

--6. 사원 테이블에서 사원명과 해당 사원의 관리자명을 검색하시오.(셀프조인)
SELECT W.ENAME "사원명",M.ENAME "관리자명" FROM EMP W JOIN EMP M ON W.MGR=M.EMPNO; 
SELECT W.ENAME "사원명",M.ENAME "관리자명" FROM EMP W LEFT JOIN EMP M ON W.MGR=M.EMPNO; --모든 사원에 대한이라고 명시 되어있을때만 사용 

--7. 사원 테이블에서 사원명, 해당 사원의 관리자명, 해당 사원의 관리자의 관리자명을 검색하시오--셀프조인
SELECT W.ENAME "사원명", M.ENAME "관리자명", MM.ENAME "최상위 관리자명" FROM EMP W JOIN 
    EMP M ON W.MGR=M.EMPNO 
        JOIN EMP MM ON M.MGR=MM.EMPNO;

--8. 7번 결과에서 상위 관리자가 없는 모든 사원의 이름도 사원명에 출력되도록 수정하시오.
SELECT W.ENAME "사원명", M.ENAME "관리자명", MM.ENAME "최상위 관리자명" FROM EMP W LEFT JOIN 
    EMP M ON W.MGR=M.EMPNO 
        LEFT JOIN EMP MM ON M.MGR=MM.EMPNO;

--서브쿼리(SUBQUERY) : SQL 명령에 포함되어 실행되는 SELECT 명령 
--여러 번의 SQL 명령으로 얻을 수 있는 결과를 하나의 SQL 명령으로 얻기 위해 사용하는 기능 

--SELECT 명령(MAIN QUERY)에 포함되어 실행되는 SELECT명령(SUBQUERY)
--서브쿼리 명령이 먼저 실행된 후 메인쿼리 명령 실행 
--서브쿼리의 명령은 메인쿼리의 FROM,WHERE,HAVING 구문에서 () 안에 작성

--EMP 테이블에서 사원이름이 SCOTT인 사원보다 많은 급여를 받는 사원의 사원번호,사원이름,급여 검색 
--SELECT 명령을 2번 사용해야 원하는 결과 검색 
SELECT SAL FROM EMP WHERE ENAME='SCOTT'; -- 검색결과 : 3000
SELECT EMPNO,ENAME,SAL FROM EMP WHERE SAL>=3000;

--서브쿼리를 이용하면 하나의 SELECT 명령을 사용하여 원하는 결과 검색
--WHERE 구문에서 조건식의 비교값 대신 서브쿼리의 검색 결과값을 사용하여 검색
--조건식의 비교대상과 같은 자료형의 값이 하나만 검색되도록 서브쿼리 작성 - 단일행(SINGLE ROW)의 단일 컬럼값(SINGLE COLUMN) 검색
SELECT EMPNO,ENAME,SAL FROM EMP WHERE SAL>=(SELECT SAL FROM EMP WHERE ENAME='SCOTT');

--EMP 테이블에서 사원번호가 7844인 사원과 같은 업무를 하는 사원의 사원번호,사원이름,업무,급여 검색 -- 본인 제외 
SELECT EMPNO,ENAME,JOB,SAL FROM EMP WHERE JOB=(SELECT JOB FROM EMP WHERE EMPNO=7844) AND EMPNO<>7844;

--EMP 테이블에서 사원번호가 7521인 사원과 같은 업무를 하는 사원 중 사원번호가 
--7900인 사원보다 많은 급여를 받는 사원의 사원번호,사원이름,업무,급여 검색
SELECT EMPNO,ENAME,JOB,SAL FROM EMP WHERE JOB=(SELECT JOB FROM EMP WHERE EMPNO=7521) AND EMPNO<>7521
    AND SAL>(SELECT SAL FROM EMP WHERE EMPNO=7900);

--EMP 테이블에서 SALES 부서에 근무하는 사원의 사원번호,사원이름,업무,급여 검색
--부서이름이 DEPT 테이블에 저장되어 있으므로 테이블 조인을 사용하여 검색
SELECT EMPNO,ENAME,JOB,SAL FROM EMP JOIN DEPT ON EMP.DEPTNO=DEPT.DEPTNO WHERE DNAME='SALES';
--테이블 조인 대신 서브쿼리를 사용하여 검색 
SELECT EMPNO,ENAME,JOB,SAL FROM EMP WHERE DEPTNO=(SELECT DEPTNO FROM DEPT WHERE DNAME='SALES');

--EMP 테이블에서 급여를 가장 적게 받는 사원의 사원번호,사원이름,업무,급여 검색
SELECT EMPNO,ENAME,JOB,SAL FROM EMP WHERE SAL=(SELECT MIN(SAL) FROM EMP);

--EMP 테이블에서 SALES 부서에 근무하는 사원 중 급여를 가장 많이 받는 사원의 사원번호,사원이름,업무,급여 검색
--ORACLE은 서브쿼리 안에 서브쿼리 사용 가능
SELECT EMPNO,ENAME,JOB,SAL FROM EMP WHERE SAL=(SELECT MAX(SAL) FROM EMP 
    WHERE DEPTNO=(SELECT DEPTNO FROM DEPT WHERE DNAME='SALES'));
    
--EMP 테이블에서 부서별 평균 급여 중 가장 많은 평균 급여를 받는 부서의 부서번호,평균급여 검색 
SELECT DEPTNO,CEIL(AVG(SAL)) AVG_SAL FROM EMP GROUP BY DEPTNO 
    HAVING AVG(SAL)=(SELECT MAX(AVG(SAL)) FROM EMP GROUP BY DEPTNO);

--EMP 테이블에서 부서별로 구분하여 가장 적은 급여를 받는 사원의 사원번호,사원이름,급여,부서번호 검색 
--서브쿼리의 검색 결과값이 다중행(MULTI-ROW SUBQUERY)인 경우 = 연산자를 사용하여 비교하면 에러 발생 
SELECT EMPNO,ENAME,SAL,DEPTNO FROM EMP WHERE SAL=(SELECT MIN(SAL) FROM EMP GROUP BY DEPTNO);-- 에러 발생

--서브쿼리의 검색 결과값이 다중행인 경우 = 연산자 대신 IN 연산자를 이용하여 컬럼값 비교
SELECT EMPNO,ENAME,SAL,DEPTNO FROM EMP WHERE SAL IN(SELECT MIN(SAL) FROM EMP GROUP BY DEPTNO);

--서브쿼리의 검색 결과값이 다중행인 경우 > 또는 < 연산자는 ANY 또는 ALL 키워드와 같이 사용하여 검색 

--EMP 테이블에서 부서번호가 10번인 부서에 근무하는 모든 사원보다 급여가 적은 사원의 사원번호,사원이름,급여,부서번호 검색
SELECT EMPNO,ENAME,SAL,DEPTNO FROM EMP WHERE SAL<ALL(SELECT SAL FROM EMP WHERE DEPTNO=10);

--EMP 테이블에서 부서번호가 10번인 부서에 근무하는 어떤 사원보다 급여가 적은 사원의 사원번호,사원이름,급여,부서번호 검색
SELECT EMPNO,ENAME,SAL,DEPTNO FROM EMP WHERE SAL<ANY(SELECT SAL FROM EMP WHERE DEPTNO=10) AND DEPTNO<>10;

--EMP 테이블에서 부서번호가 20번인 부서에 근무하는 모든 사원보다 급여가 많은 사원의 사원번호,사원이름,급여,부서번호 검색
SELECT EMPNO,ENAME,SAL,DEPTNO FROM EMP WHERE SAL>ALL(SELECT SAL FROM EMP WHERE DEPTNO=20);

--EMP 테이블에서 부서번호가 20번인 부서에 근무하는 어떤 사원보다 급여가 많은 사원의 사원번호,사원이름,급여,부서번호 검색
SELECT EMPNO,ENAME,SAL,DEPTNO FROM EMP WHERE SAL>ANY(SELECT SAL FROM EMP WHERE DEPTNO=20) AND DEPTNO<>20;

--다중행 서브쿼리의 ANY 또는 ALL 대신 단일 행 서브쿼리의 MIN 또는 MAX 함수 사용  

--EMP 테이블에서 부서번호가 10번인 부서에 근무하는 모든 사원보다 급여가 적은 사원의 사원번호,사원이름,급여,부서번호 검색
--컬럼명<ALL(다중행 서브쿼리) 대신 컬럼명<(단일행 서브쿼리 - MIN 함수)
SELECT EMPNO,ENAME,SAL,DEPTNO FROM EMP WHERE SAL<(SELECT MIN(SAL) FROM EMP WHERE DEPTNO=10);

--EMP 테이블에서 부서번호가 10번인 부서에 근무하는 어떤 사원보다 급여가 적은 사원의 사원번호,사원이름,급여,부서번호 검색
--컬럼명<ALL(다중행 서브쿼리) 대신 컬럼명<(단일행 서브쿼리 - MAX 함수)
SELECT EMPNO,ENAME,SAL,DEPTNO FROM EMP WHERE SAL<(SELECT MAX(SAL) FROM EMP WHERE DEPTNO=10) AND DEPTNO<>10;

--EMP 테이블에서 부서번호가 20번인 부서에 근무하는 모든 사원보다 급여가 많은 사원의 사원번호,사원이름,급여,부서번호 검색
--컬럼명<ALL(다중행 서브쿼리) 대신 컬럼명<(단일행 서브쿼리 - MAX 함수)
SELECT EMPNO,ENAME,SAL,DEPTNO FROM EMP WHERE SAL>(SELECT MAX(SAL) FROM EMP WHERE DEPTNO=20);

--EMP 테이블에서 부서번호가 20번인 부서에 근무하는 어떤 사원보다 급여가 많은 사원의 사원번호,사원이름,급여,부서번호 검색
--컬럼명<ALL(다중행 서브쿼리) 대신 컬럼명<(단일행 서브쿼리 - MIN 함수)
SELECT EMPNO,ENAME,SAL,DEPTNO FROM EMP WHERE SAL>(SELECT MIN(SAL) FROM EMP WHERE DEPTNO=20) AND DEPTNO<>20;

--EMP 테이블에서 사원이름이 ALLEN인 사원과 매니저가 같은 사원 중 업무가 같은 사원의 사원번호,사원이름,매니저번호,업무,급여 검색
SELECT EMPNO,ENAME,MGR,JOB,SAL FROM EMP WHERE MGR=(SELECT MGR FROM EMP WHERE ENAME='ALLEN') AND ENAME<>'ALLEN'
    AND JOB=(SELECT JOB FROM EMP WHERE ENAME='ALLEN');

--서브쿼리의 검색대상이 여러 개(MULTI-COLUMN SUBQUERY)인 경우 비교컬럼을 ()안에 ,로 구분하여 나열하면 비교가능
SELECT EMPNO,ENAME,MGR,JOB,SAL FROM EMP WHERE (MGR,JOB)=(SELECT MGR,JOB FROM EMP WHERE ENAME='ALLEN') AND ENAME<>'ALLEN';

--1. 사원 테이블에서 BLAKE보다 급여가 많은 사원들의 사번,이름,급여 검색
SELECT EMPNO,ENAME,SAL FROM EMP WHERE SAL>(SELECT MIN(SAL) FROM EMP WHERE ENAME='BLAKE');
SELECT EMPNO,ENAME,SAL FROM EMP WHERE SAL>(SELECT SAL FROM EMP WHERE ENAME='BLAKE');

--2. 사원 테이블에서 MILLER보다 늦게 입사한 사원들의 사번,이름,입사일 검색
SELECT EMPNO,ENAME,HIREDATE FROM EMP WHERE HIREDATE>(SELECT MIN(HIREDATE) FROM EMP WHERE ENAME='MILLER');
SELECT EMPNO,ENAME,HIREDATE FROM EMP WHERE HIREDATE>(SELECT HIREDATE FROM EMP WHERE ENAME='MILLER');

--3.사원 테이블에서 사원 전체 평균 급여보다 급여가 많은 사원들의 사번,이름,급여 검색
SELECT EMPNO,ENAME,SAL FROM EMP WHERE SAL>(SELECT AVG(SAL) FROM EMP);

--4.사원 테이블에서 CLARK와 같은 부서이며, 사번이 7698인 직원의 급여보다 많은 급여를 받는 사원들의 사번,이름,급여 검색
SELECT EMPNO,ENAME,SAL FROM EMP WHERE DEPTNO=(SELECT DEPTNO FROM EMP WHERE ENAME='CLARK') 
    AND SAL>(SELECT SAL FROM EMP WHERE EMPNO=7698);

--5.사원 테이블에서 부서별 최대 급여를 받는 사원들의 사번,이름,부서코드,급여 검색
SELECT EMPNO,ENAME,DEPTNO,SAL FROM EMP WHERE SAL IN(SELECT MAX(SAL) FROM EMP GROUP BY DEPTNO);

--집합연산자(SET 연산자) : 두개의 SELECT 명령에 대한 검색결과를 이용하여 집합 결과값을 제공하는 연산자
-- >> 합집합(UNION), 교집합(INTERSECT) 차집합(MINUS)

--SUPER_HERO 테이블 생성 - 속성 : 이름(문자형)
CREATE TABLE SUPER_HERO(NAME VARCHAR2(20));

--SUPER_HERO 테이블에 행 삽입(저장)
INSERT INTO SUPER_HERO VALUES('슈퍼맨');
INSERT INTO SUPER_HERO VALUES('아이언맨');
INSERT INTO SUPER_HERO VALUES('배트맨');
INSERT INTO SUPER_HERO VALUES('앤트맨');
INSERT INTO SUPER_HERO VALUES('스파이더맨');
COMMIT;
SELECT * FROM SUPER_HERO;


--MARLEN_HERO 테이블 생성 - 속성 : 이름(문자형),등급(숫자형)
CREATE TABLE MARVEL_HERO(NAME VARCHAR2(20),GRADE NUMBER(1));

--MARLEN_HERO 테이블 행 삽입
INSERT INTO MARVEL_HERO VALUES('아이언맨',3);
INSERT INTO MARVEL_HERO VALUES('헐크',1);
INSERT INTO MARVEL_HERO VALUES('스파이더맨',4);
INSERT INTO MARVEL_HERO VALUES('토르',2);
INSERT INTO MARVEL_HERO VALUES('앤트맨',5);
COMMIT;
SELECT * FROM MARVEL_HERO;


--UNION : 두 개의 SELECT 명령으로 검색된 행을 합한 결과를 제공 - 중복행 제외
--집합연산자 사용 시 두 개의 SELECT 명령의 검색대상은 갯수와 자료형이 반드시 동일하도록 작성
SELECT NAME FROM SUPER_HERO
UNION
SELECT NAME FROM MARVEL_HERO;

--UNION ALL: 두 개의 SELECT 명령으로 검색된 행을 합한 결과를 제공 - 중복행 포함
SELECT NAME FROM SUPER_HERO
UNION ALL
SELECT NAME FROM MARVEL_HERO;

--INTERSECT: 두 개의 SELECT 명령으로 검색된 중복행의 결과를 제공
SELECT NAME FROM SUPER_HERO
INTERSECT
SELECT NAME FROM MARVEL_HERO;

--MINUS: 첫번째 SELECT 명령의 검색 결과에서 두번째 SELECT 명령의 검색 결과를 제외한 행 제공
SELECT NAME FROM SUPER_HERO
MINUS
SELECT NAME FROM MARVEL_HERO;

--집합연산자 사용 시 두개의 SELECT 명령에 대한 검색대상의 갯수 또는 자료형이 다른경우 에러 발생
SELECT NAME FROM SUPER_HERO UNION SELECT GRADE FROM MARVEL_HERO;
SELECT NAME FROM SUPER_HERO UNION SELECT NAME,GRADE FROM MARVEL_HERO;

--집합연산자 사용 시 검색대상의 갯수가 다른 경우 컬럼값 대신 동일한 자료형의 임의값 또는 NULL을 사용하여 검색 결과 제공 
SELECT NAME,0 FROM SUPER_HERO UNION SELECT NAME,GRADE FROM MARVEL_HERO;
SELECT NAME,NULL FROM SUPER_HERO UNION SELECT NAME,GRADE FROM MARVEL_HERO;

--집합연산자 사용시 검색대상의 자료형이 다른 경우 변환함수를 사용하여 같은 자료형으로 변경하여 집합 검색 결과 제공 
SELECT NAME FROM SUPER_HERO UNION SELECT TO_CHAR(GRADE,'0') FROM MARVEL_HERO;

--DML(DATA MANIPLATION LANGUAGE) : 데이터 조작어
--테이블의 행에 대한 삽입,변경,삭제 기능을 제공하는 SQL 명령
--DML 명령 실행 후 COMMIT(DML 명령 적용)또는 ROLLBACK(DML 명령 취소) 명령을 실행하는 것을 권장

--INSERT : 테이블에 행을 삽입하여 저장하는 명령
--형식)INSERT INTO 테이블명 VALUES(컬럼값,컬럼값...)
--테이블에 삽입될 행의 컬럼값은 테이블 속성에 맞게 차례대로 나열하여 저장되도록 작성
-- >> 테이블의 선언된 컬럼 순서대로 자료형에 맞는 값을 생략없이 전달하여 저장

--테이블 속성 확인 : 컬럼과 자료형 확인 
--형식)DESC 테이블명
DESC DEPT;

--DEPT 테이블에 새로운 행(부서정보) 삽입
INSERT INTO DEPT VALUES(50,'회계부','서울');
COMMIT;
SELECT * FROM DEPT;

--삽입행에 전달될 컬럼값의 갯수가 테이블의 컬럼 갯수와 맞지 않을 경우 에러 발생
INSERT INTO DEPT VALUES(60,'총무부');
INSERT INTO DEPT VALUES(60,'총무부','인천',02-1234-5678);

--삽입행에 전달될 컬럼값이 테이블의 컬럼 자료형과 맞지 않거나 자료형의 크기보다 큰 경우 에러 발생 
INSERT INTO DEPT VALUES('육십','총무부','인천');
INSERT INTO DEPT VALUES(60,'총무부','인천시 월미구');

--테이블의 컬럼에 부여된 제약조건을 위반하는 값이 전달될 경우 에러 발생
--NOT NULL 제약조건 : 컬럼에 NULL이 저장되지 않도록 설정하는 제약조건
INSERT INTO DEPT VALUES(NULL,'총무부','인천');

--PK(PRIMARY KEY) 제약조건 : 기존 행의 컬럼값과 같은 값이 저장되지 않도록 설정하는 제약조건
SELECT * FROM DEPT WHERE DEPTNO=50;
INSERT INTO DEPT VALUES(50,'총무부','인천');

--FK(FOREIGN KEY) 제약조건 : 부모 테이블에 저장된 컬럼값만 자식 테이블의 컬럼에 저장되도록 설정하는 제약조건
--EMP 테이블(자식 테이블) 속성 확인 - DEPTNO 컬럼
DESC EMP;
--DEPT 테이블(부모 테이블) 속성 확인 - DEPTNO 컬럼
DESC DEPT;
SELECT DEPTNO FROM DEPT;
--EMP 테이블에 새로운 행(사원정보)을 삽입
--DEPT 테이블(부모 테이블)에 부서번호가 35인 부서번호가 저장되어 있지 않아 EMP 테이블(자식 테이블)에 행 삽입시 에러 발생 
INSERT INTO EMP VALUES(9000,'KIM','MANAGER',7298,'00/12/10',3500,1000,35);--에러발생
INSERT INTO EMP VALUES(9000,'KIM','MANAGER',7298,'00/12/10',3500,1000,40);
COMMIT;
SELECT * FROM EMP WHERE EMPNO=9000;


--테이블 속성과 제약조건을 위반하지 않는 컬럼값을 전달해야만 행 삽입 
INSERT INTO DEPT VALUES(60,'총무부','인천');
COMMIT;
SELECT * FROM DEPT;

--테이블에 행 삽입 시 컬럼값을 저장하고 싶지 않은 경우 NULL을 전달하여 저장
INSERT INTO DEPT VALUES(70,'영업부',NULL);--명시적 NULL 사용
COMMIT;
SELECT * FROM DEPT;

--테이블의 원하는 속성에만 컬럼값을 전달하여 행을 삽입하여 저장 가능
--형식)INSERT INTO 테이블명(컬럼명,컬럼명,...) VALUES(컬럼값,컬럼값,...)
--INSERT 명령의 테이블에 나열된 컬럼 순서대로 컬럼값을 전달하여 행 삽입 
INSERT INTO DEPT(LOC,DEPTNO,DNAME) VALUES('수원',80,'자재부');
COMMIT;
SELECT * FROM DEPT;

--INSERT 명령의 테이블에 나열된 컬럼 생략 가능
-- >> 생략된 컬럼에는 컬럼 기본값(DEFAULT VALUE)이 자동 저장
-- 테이블 생성 또는 테이블 구조 변경시 컬럼 기본값을 설정하지 않은 경우 컬럼 기본값은 자동으로 NULL로 설정
INSERT INTO DEPT(DEPTNO,DNAME) VALUES(90,'인사부');--LOC 컬럼 생략 : NULL 저장 - 묵시적 NULL 저장
COMMIT;
SELECT * FROM DEPT;

--날짜형 컬럼에는 날짜값 대신 SYSDATE 키워드를 이용하여 컬럼값 저장 
INSERT INTO EMP VALUES(9001,'LEE','ANALYST',9000,SYSDATE,2000,NULL,40);
COMMIT;
SELECT * FROM EMP WHERE EMPNO=9001;

--INSERT 명령에서 SUBQUERY 사용 가능 : 테이블의 행을 검색하여 검색결과를 다른 테이블의 행으로 삽입 - 테이블 행 복사
--형식) INSERT INTO 테이블명 SELECT 검색대상,... FROM 테이블명 [WHERE 조건식] - JOIN도 가능
--행이 삽입될 테이블의 속성과 서브쿼리의 검색대상에 대한 구조(갯수,자료형,크기)가 동일 - 컬럼명 제외

--BONUS 테이블의 속성 확인 및 행 검색 
DESC BONUS;
SELECT * FROM BONUS;

--EMP 테이블에서 성과급이 NULL이 아닌 사원을 검색하여 결과행을 BONUS 테이블에 삽입
INSERT INTO BONUS SELECT ENAME,JOB,SAL,COMM FROM EMP WHERE COMM IS NOT NULL;
COMMIT;
SELECT * FROM BONUS;

--UPDATE : 테이블에 저장된 행의 컬럼값을 변경하는 명령 
--형식)UPDATE 테이블명 SET 컬럼명=변경값,컬럼명=변경값,... WHERE 조건식
--PK 제약조건이 설정된 컬럼값은 변경하지 않는 것을 권장
--WHERE 구문이 생략된 경우 테이블에 저장된 모든 행의 컬럼값을 동일하게 변경
--조건식에서 사용될 컬럼은 PK 제약조건이 설정된 컬럼을 사용하는 것을 권장

--DEPT 테이블에서 부서번호가 50인 부서 검색 
--부서이름 : 회계부, 부서위치 : 서울 
SELECT * FROM DEPT WHERE DEPTNO=50;

--DEPT 테이블에섯 부서번호가 50인 부서의 부서이름을 경리부로 변경하고 부서위치를 부천으로 변경 
UPDATE DEPT SET DNAME='경리부',LOC='부천' WHERE DEPTNO=50;
COMMIT;
SELECT * FROM DEPT WHERE DEPTNO=50;

--변경값은 컬럼의 자료형,크기,제약조건에 맞는 경우에만 변경 가능
--EMP 테이블에서 사원번호가 9000인 사원의 부서번호를 35로 변경
UPDATE EMP SET DEPTNO=35 WHERE EMPNO=9000; -- FK 제약조건 위반하여 에러 발생

--UPDATE 명령에서 서브쿼리 사용 가능 : 변경값 또는 조건식의 비교값 대신 서브쿼리 사용
--DEPT 테이블에서 부서명이 영업부인 부서위치(NULL)를 총무부의 부서위치(인천)와 같도록 변경
SELECT * FROM DEPT;
UPDATE DEPT SET LOC=(SELECT LOC FROM DEPT WHERE DNAME='총무부') WHERE DNAME='영업부';
COMMIT;
SELECT * FROM DEPT WHERE DNAME='영업부';

--BONUS 테이블에서 사원이름이 KIM인 사원보다 성과급이 적은 사원의 성과급을 100 증가되도록 변경
SELECT * FROM BONUS;
UPDATE BONUS SET COMM=COMM+100 WHERE COMM<(SELECT COMM FROM BONUS WHERE ENAME='KIM');
COMMIT;
SELECT * FROM BONUS;

--DELETE : 테이블에 저장된 행을 삭제하는 명령
--형식)DELETE FROM 테이블명 WHERE 조건식
--WHERE 구문이 생략된 경우 테이블에 저장된 모든 행 삭제
--조건식에서 사용될 컬럼은 PK 제약조건이 설정된 컬럼을 사용하는 것을 권장

--DEPT 테이블에서 부서번호 90인 부서 삭제 
SELECT * FROM DEPT;
DELETE FROM DEPT WHERE DEPTNO=90;
COMMIT;
SELECT * FROM DEPT;

--DEPT 테이블에서 부서번호 10인 부서 삭제 
--FK 제약조건에 의해 자식 테이블(EMP)이 참조하는 부모 테이블(DEPT)의 행은 삭제 불가능
DELETE FROM DEPT WHERE DEPTNO=10;


--EMP 테이블(자식 테이블)에서 모든 사원의 부서번호를 중복없이 검색 
SELECT DISTINCT DEPTNO FROM EMP;--검색결과 : 10,20,30,40
--EMP 테이블이 참조하는 DEPT 테이블의 부서를 제외한 나머지 부서정보는 삭제 가능
DELETE FROM DEPT WHERE DEPTNO=20; --삭제 불가능
DELETE FROM DEPT WHERE DEPTNO=80; --삭제 가능
COMMIT;
SELECT * FROM DEPT;

--DELETE 명령에서 서브쿼리 사용 가능 : 조건식의 비교값 대신 서브쿼리 사용
--DEPT 테이블에서 부서이름이 영업부인 부서와 같은 부서위치의 부서정보를 삭제 - 영업부 포함
SELECT * FROM DEPT;
DELETE FROM DEPT WHERE LOC=(SELECT LOC FROM DEPT WHERE DNAME='영업부');
COMMIT;
SELECT * FROM DEPT;