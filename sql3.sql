--단일함수 문제
--문제1.사원테이블에서 입사일이 12월인 사원의 사번,사원명,입사일 검색하시오.
SELECT EMPNO,ENAME,HIREDATE FROM EMP WHERE HIREDATE LIKE '%/12/%';
SELECT EMPNO,ENAME,HIREDATE FROM EMP WHERE HIREDATE LIKE '__/12/__';
SELECT EMPNO,ENAME,HIREDATE FROM EMP WHERE TO_CHAR(HIREDATE,'MM')='12';

--문제2.다음과 같은 결과를 검색할 수 있는 SQL 문장을 작성하시오.
SELECT EMPNO,ENAME,LPAD(SAL,10,'*') "급여" FROM EMP;

--문제3.다음과 같은 결과를 검색할 수 있는 SQL 문장을 작성하시오.
SELECT EMPNO,ENAME,TO_CHAR(HIREDATE,'YYYY-MM-DD') "입사일" FROM EMP;

--그룹함수 문제
--문제1.사원테이블에서 부서별 인원수가 6명 이상인 부서코드 검색?
SELECT DEPTNO,COUNT(*) FROM EMP GROUP BY DEPTNO HAVING COUNT(*)>=6; 

--문제2.사원테이블로부터 부서번호, 업무별 급여합계를 계산하고자 한다. 다음과 같은 결과를 출력할수 있는 SQL문장 작성?
SELECT DEPTNO,SUM(DECODE(JOB,'CLERK',SAL)) "CLERK",SUM(DECODE(JOB,'MANAGER',SAL)) "MANAGER"
    ,SUM(DECODE(JOB,'PRESIDENT',SAL)) "PRESIDENT",SUM(DECODE(JOB,'ANALYST',SAL)) "ANALYST"
    ,SUM(DECODE(JOB,'SALESMAN',SAL)) "SALESMAN" FROM EMP GROUP BY DEPTNO ORDER BY DEPTNO;
    
--문제3.사원테이블로부터 년도별, 월별 급여합계를 출력할 수 있는 SQL문장 작성?    
SELECT TO_CHAR(HIREDATE,'YYYY') "년",TO_CHAR(HIREDATE,'MM') "월",SUM(SAL) FROM EMP
    GROUP BY TO_CHAR(HIREDATE,'YYYY'),TO_CHAR(HIREDATE,'MM') ORDER BY "년","월";
    
--문제4.사원테이블에서 부서별 comm(커미션)을 포함하지 않은 연봉의 합과 포함한 연봉의 합을 구하는 SQL을 작성하시오.    
SELECT DEPTNO,SUM(SAL*12) "연봉" FROM EMP GROUP BY DEPTNO ORDER BY DEPTNO;
SELECT DEPTNO,SUM((SAL+NVL(COMM,0))*12) "연봉" FROM EMP GROUP BY DEPTNO ORDER BY DEPTNO;

--문제5.사원테이블에서 SALESMAN을 제외한 JOB별 급여합계?
SELECT JOB,SUM(SAL) FROM EMP WHERE JOB<>'SALESMAN' GROUP BY JOB;
SELECT JOB,SUM(SAL) FROM EMP GROUP BY JOB HAVING JOB<>'SALESMAN';

--분석함수 : 윈도우 함수(그룹함수,순위함수,순서함수 등)에 의해 반환된 결과값을 제공받아 처리하여 반환하는 함수
--형식)SELECT 윈도우함수 OVER([PARTITION BY 컬럼명][ORDER BY 컬럼명][WINDOWING]),검색대상,... FROM 테이블명 [WHERE 조건식]

--EMP 테이블에서 모든 사원 중 가장 많은 급여를 받는 사원의 사원번호,사원이름,급여 검색
--그룹함수를 사용할 경우 다른 검색대상을 같이 사용하면 에러 발생
SELECT EMPNO,ENAME,MAX(SAL) FROM EMP;--에러

--SELECT 명령을 여러번 사용하여 가장 많은 급여를 받는 사원의 사원번호,사원이름,급여 검색 가능
SELECT MAX(SAL) FROM EMP;--검색결과:5000
SELECT EMPNO,ENAME,SAL FROM EMP WHERE SAL=5000;

--그룹함수를 분석함수와 같이 사용할 경우 다른 검색대상 사용 가능
SELECT EMPNO,ENAME,SAL,MAX(SAL) OVER() FROM EMP;

--EMP 테이블에서 모든 사원의 부서별 평균 급여 검색
SELECT DEPTNO,CEIL(AVG(SAL)) "부서별 평균 급여" FROM EMP GROUP BY DEPTNO;

--EMP 테이블에서 모든 사원의 사원번호,사원이름,급여,부서번호,부서별 평균 급여 검색
--분석함수를 사용할 경우 GROUP BY 구문을 사용하면 에러 발생
SELECT EMPNO,ENAME,SAL,DEPTNO,CEIL(AVG(SAL) OVER()) "부서별 평균 급여" FROM EMP GROUP BY DEPTNO;--에러

--GROUP BY 구문 대신 분석함수에서는 PARTITION BY 기능 제공
SELECT EMPNO,ENAME,SAL,DEPTNO,CEIL(AVG(SAL) OVER(PARTITION BY DEPTNO)) "부서별 평균 급여" FROM EMP;

--EMP 테이블에서 모든 사원의 사원번호,사원이름,급여,급여합계를 급여로 내림차순 정렬하여 검색
SELECT EMPNO,ENAME,SAL,SUM(SAL) OVER() "급여합계" FROM EMP ORDER BY SAL DESC;

--EMP 테이블에서 모든 사원의 사원번호,사원이름,급여,순차적으로 누적된 급여합계를 급여로 내림차순 정렬하여 검색
--분석함수에 ORDER BY 기능을 이용하면 정렬하면서 윈도우 함수의 결과를 검색된 행의 순서대로 처리하여 반환
--정렬값이 같은 경우 윈도우 함수의 동시 처리 결과값 반환
SELECT EMPNO,ENAME,SAL,SUM(SAL) OVER(ORDER BY SAL DESC) "순차적 누적 급여합계" FROM EMP;

--정렬값이 같은 경우 다른 정렬값을 제공하면 윈도우 함수의 동시 처리 결과값 반환 방지
SELECT EMPNO,ENAME,SAL,SUM(SAL) OVER(ORDER BY SAL DESC,EMPNO) "순차적 누적 급여합계" FROM EMP;

--분석함수에 WINDOWS 기능을 이용하면 정렬값이 동일한 경우레도 동시 처리 결과값 반환 방지
--ROWS UNBOUNDED PRECEDING : 검색행을 기준으로 이전에 존재하는 모든 행들을 검색대상으로 설정
SELECT EMPNO,ENAME,SAL,SUM(SAL) OVER(ORDER BY SAL DESC ROWS UNBOUNDED PRECEDING) "순차적 누적 급여합계" FROM EMP;

--EMP 테이블에서 모든 사원의 사원번호,사원이름,급여,검색사원 직전 사원의 급여와 검색사원 직후 사원의 급여의 합계를 급여로 오름차순 정렬하여 검색
SELECT EMPNO,ENAME,SAL,SUM(SAL) OVER(ORDER BY SAL ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING) "부분합계" FROM EMP;

--EMP 테이블에서 모든 사원의 사원번호,사원이름,급여,검색사원의 급여보다 100 작거나 200 큰 사원의 인수원수를 급여로 오름차순 정렬하여 검색
SELECT EMPNO,ENAME,SAL,COUNT(*) OVER(ORDER BY SAL RANGE BETWEEN 100 PRECEDING AND 200 FOLLOWING)-1 "인원수" FROM EMP;

--순위함수 : RANK, DENSE_RANK, ROW_NUMBER - 반드시 분석함수와 같이 사용

--EMP 테이블에서 모든 사원의 사원번호,사원이름,급여를 급여로 내림차순 정렬하여 검색
SELECT EMPNO,ENAME,SAL FROM EMP ORDER BY SAL DESC;

--EMP 테이블에서 모든 사원의 사원번호,사원이름,급여,급여순위를 급여로 내림차순 정렬하여 검색
--RANK 함수 : 정렬값이 같은 경우 같은 순위로 검색되며 다음 순위를 건너뛰고 검색하는 함수
SELECT EMPNO,ENAME,SAL,RANK() OVER(ORDER BY SAL DESC) "급여순위" FROM EMP;

--DENSE_RANK 함수 : 정렬값이 같은 경우 같은 순위로 검색되며 다음 순위를 건너뛰지 않고 검색하는 함수
SELECT EMPNO,ENAME,SAL,DENSE_RANK() OVER(ORDER BY SAL DESC) "급여순위" FROM EMP;

--ROW_NUMBER 함수 : 정렬값이 같은 경우에도 다른 순위로 검색하는 함수
SELECT EMPNO,ENAME,SAL,ROW_NUMBER() OVER(ORDER BY SAL DESC) "급여순위" FROM EMP;

--순서함수 : FIRST_VALUE, LAST_VALUE, LAG, LEAD - 반드시 분석함수와 같이 사용

--EMP 테이블에서 모든 사원의 사원번호,사원이름,급여,급여를 가장 많이 받는 사원의 사원이름,급여를 가장 적게 받는 사원이름을 
--급여로 내림차순 정렬하여 검색
--FIRST_VALUE 함수 : 첫번째 검색행의 컬럼값을 반환하는 함수
--LAST_VALUE 함수 : 마지막 검색행의 컬럼값을 반환하는 함수
SELECT EMPNO,ENAME,SAL,FIRST_VALUE(ENAME) OVER(ORDER BY SAL DESC),LAST_VALUE(ENAME)
    OVER(ORDER BY SAL DESC ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING) FROM EMP;
    
--EMP 테이블에서 모든 사원의 사원번호,사원이름,급여,검색사원 직전 사원의 급여,검색사원 직후 사원의 급여를 급여로 내림차순 정렬하여 검색
--LAG 함수 : 검색행의 이전 행의 컬럼값을 반환하는 함수
--형식)LAG(컬럼명,이전행위치,기본값) : 이전 위치에 행의 컬럼값을 반환하되 이전 위치에 행이 없으면 기본값 반환
--LEAD 함수 : 검색행의 이후 행의 컬럼값을 반환하는 함수
--형식)LAED(컬럼명,이전행위치,기본값) : 이후 위치에 행의 컬럼값을 반환하되 이후 위치에 행이 없으면 기본값 반환
SELECT EMPNO,ENAME,SAL,LAG(SAL,1,0) OVER(ORDER BY SAL DESC),LEAD(SAL,1,0) OVER(ORDER BY SAL DESC) FROM EMP;   

--JOIN : 두 개이상의 테이블에서 원하는 컬럼값을 검색하기 위한 기능

--EMP 테이블에서 모든 사원의 사원번호,사원이름,급여,부서번호 검색
SELECT EMPNO,ENAME,SAL,DEPTNO FROM EMP;

--DEPT 테이블에서 모든 부서의 부서번호,부서이름,위치 검색
SELECT DEPTNO,DNAME,LOC FROM DEPT;

--EMP 테이블과 DEPT 테이블에서 모든 사원의 사원번호,사원이름,급여,부서이름,부서위치 검색
--두 개이상의 테이블에서 컬럼값을 검색하기 위해서는 반드시 조인조건을 명시하여 검색
--카타시안 프로덕트(CATASIAN PRODUCT) : 두 개이상의 테이블을 조인할 때 조인조건을 명시하지 않은 경우 발생 - 교차조인
SELECT EMPNO,ENAME,SAL,DNAME,LOC FROM EMP,DEPT;

--동등조인(EQUI JOIN) : 조인조건에 = 연산자를 사용하여 결과가 참인 행만 검색
--조인조건을 WHERE 구문의 조건식으로 표현하여 사용
--EMP 테이블과 DEPT 테이블의 조인조건 : EMP 테이블의 부서번호(DEPTNO)와 DEPT 테이블의 부서번호(DEPTNO)가 같은 행만 검색
--조인 테이블에 동일한 이름의 컬럼이 존재할 경우 테이블명을 명시하여 컬럼을 명확히 구분 - 테이블명.컬럼명
SELECT EMPNO,ENAME,SAL,DNAME,LOC FROM EMP,DEPT WHERE EMP.DEPTNO=DEPT.DEPTNO;

--EMP 테이블과 DEPT 테이블에서 모든 사원의 사원번호,사원이름,급여,부서번호,부서이름,부서위치 검색
SELECT EMPNO,ENAME,SAL,EMP.DEPTNO,DNAME,LOC FROM EMP,DEPT WHERE EMP.DEPTNO=DEPT.DEPTNO;
SELECT EMPNO,ENAME,SAL,DEPT.DEPTNO,DNAME,LOC FROM EMP,DEPT WHERE EMP.DEPTNO=DEPT.DEPTNO;

--조인 테이블에 동일한 이름의 컬럼명을 같이 검색할 경우 첫번째 컬럼을 제외한 나머지 컬럼명은 자동으로 변경되어 검색
SELECT EMPNO,ENAME,SAL,EMP.DEPTNO,DEPT.DEPTNO,DNAME,LOC FROM EMP,DEPT WHERE EMP.DEPTNO=DEPT.DEPTNO;

--조인 테이블에 동일한 이름의 컬럼명을 같이 검색할 경우 컬럼에 별칭을 설정하여 검색
SELECT EMPNO,ENAME,SAL,EMP.DEPTNO EMP_DEPTNO,DEPT.DEPTNO DEPT_DEPTNO,DNAME,LOC FROM EMP,DEPT WHERE EMP.DEPTNO=DEPT.DEPTNO;

--테이블 별칭(TABLE ALIAS) : 테이블에 새로운 이름을 일시적으로 부여하는 기능 
--형식)SELECT 검색대상,... FROM 테이블명 별칭,...
-- >> 테이블 별칭을 설정한 경우 별칭 대신 테이블명을 사용하면 에러 발생
--테이블명을 간단하게 표현하기 위해 사용하거나 같은 테이블을 여러 개의 테이블로 표현하기 위해 사용
SELECT EMPNO,ENAME,SAL,E.DEPTNO EMP_DEPTNO,D.DEPTNO DEPT_DEPTNO,DNAME,LOC FROM EMP E,DEPT D WHERE E.DEPTNO=D.DEPTNO;

--비동등 조인(NON-EQUI JOIN) : 조인조건에 = 연산자를 제외한 연산자를 사용하여 결과가 참인 행만 검색

--EMP 테이블에서 모든 사원의 사원번호,사원이름,급여 검색
SELECT EMPNO,ENAME,SAL FROM EMP;

--SALGRADE  테이블에서 모든 급여등급의 등급,최소급여,최대급여 검색
SELECT GRADE,LOSAL,HISAL FROM SALGRADE;

--EMP 테이블과 SALGRADE 테이블에서 모든 사원의 사원번호,사원이름,급여,급여등급 검색
--조인조건 : 사원의 급여가 최소급여부터 최대급여 범위에 포함될 경우에 급여등급 검색
SELECT EMPNO,ENAME,SAL,GRADE FROM EMP,SALGRADE WHERE SAL BETWEEN LOSAL AND HISAL;

--외부조인(OUTER JOIN) : 조건조건이 참인 행만 검색하는 것이 아니라 조건조건에 누락된 행도 검색
--조인조건의 테이블에 (+)를 사용하여 조언조건에 누락된 행의 컬럼값이 NULL로 검색되도록 설정

--EMP 테이블에서 모든 사원의 부서번호를 중복되지 않는 유일한 값으로 검색
SELECT DISTINCT DEPTNO FROM EMP;--검색결과 : 10, 20, 30

--DEPT 테이블에서 모든 부서의 부서번호 검색
SELECT DEPTNO FROM DEPT;--검색결과 : 10, 20, 30, 40

--EMP 테이블과 DEPT 테이블에서 모든 사원의 사원번호,사원이름,급여,부서이름,부서위치 검색
--조인조건(동등조인) : EMP 테이블의 부서번호와 DEPT 테이블의 부서번호가 같은 행만 결합되어 검색
--40번 부서에 근무하는 사원이 없으므로 40번 부서에 대한 부서이름과 부서위치 미검색
SELECT EMPNO,ENAME,SAL,DNAME,LOC FROM EMP,DEPT WHERE EMP.DEPTNO=DEPT.DEPTNO;

--EMP 테이블과 DEPT 테이블에서 모든 사원의 사원번호,사원이름,급여,부서이름,부서위치 검색
--조인조건(외부조인) : EMP 테이블의 부서번호와 DEPT 테이블의 부서번호가 같은 행을 결합되어 검색하고 사원이 근무하지 않는 부서도 검색
--사원이 없는 부서를 검색해야 되는 경우 EMP 테이블의 조인조건에 (+)을 붙여 EMP 테이블의 컬럼값 대신 NULL이 검색되도록 설정
SELECT EMPNO,ENAME,SAL,DNAME,LOC FROM EMP,DEPT WHERE EMP.DEPTNO(+)=DEPT.DEPTNO;

--셀프조인(SELF JOIN) : 하나의 테이블에 다른 여러 개의 별칭을 설정하여 조인하는 기능

--EMP 테이블에서 모든 사원의 사원번호,사원이름,매니저번호(매니저의 사원번호) 검색
SELECT EMPNO,ENAME,MGR FROM EMP;

--EMP 테이블에서 모든 사원의 사원번호,사원이름,매니저번호(매니저의 사원번호),매니저 이름(매니저의 사원이름) 검색
--조인조건 : EMP 테이블(WORKER)의 매니저번호를 EMP 테이블(MANAGER)의 사원번호와 비교하여 같은 행만 결합하여 검색 - 동등조인
--매니저번호가 NULL인 사원 미검색
SELECT WORKER.EMPNO,WORKER.ENAME WORKER_ENAME,WORKER.MGR,MANAGER.ENAME MANAGER_ENAME
    FROM EMP WORKER,EMP MANAGER WHERE WORKER.MGR=MANAGER.EMPNO;
    
--매니저번호가 NULL인 사원도 검색하고자 할 경우 외부조인 이용
SELECT WORKER.EMPNO,WORKER.ENAME WORKER_ENAME,WORKER.MGR,MANAGER.ENAME MANAGER_ENAME
    FROM EMP WORKER,EMP MANAGER WHERE WORKER.MGR=MANAGER.EMPNO(+);

--EMP 테이블과 DEPT 테이블에서 SALES 부서에 근무하는 사원의 사원번호,사원이름,급여,부서이름,부서위치 검색
SELECT EMPNO,ENAME,SAL,DNAME,LOC FROM EMP,DEPT WHERE EMP.DEPTNO=DEPT.DEPTNO AND DNAME='SALES';

--1999 JOIN : 1999년에 채택된 표준 SQL(SQL3)에 추가된 JOIN 구문

--CROSS JOIN : 조인 테이블의 모든 행을 교차조인하기 위한 조인 - 조인조건을 명시하지 않고 조인
--형식)SELECT 검색대상,... FROM 테이블명1 CROSS JOIN 테이블명2
SELECT EMPNO,ENAME,SAL,DNAME,LOC FROM EMP CROSS JOIN DEPT;

--NATURAL JOIN : 조인 테이블에 같은 이름의 컬럼이 하나만 있는 경우 같은 이름의 컬럼값을 비교하여 조인 - 조인조건을 명시하지 않고 조인
--형식)SELECT 검색대상,... FROM 테이블명1 NATURAL JOIN 테이블명2
--EMP 테이블의 DEPTNO 컬럼값과 DEPT 테이블의 DEPTNO 컬럼값을 비교하여 조인
SELECT EMPNO,ENAME,SAL,DNAME,LOC FROM EMP NATURAL JOIN DEPT;

--NATURAL JOIN에서는 같은 이름의 컬럼은 테이블명을 명시하지 않아도 사용 가능
SELECT EMPNO,ENAME,SAL,DEPTNO,DNAME,LOC FROM EMP NATURAL JOIN DEPT;

--조인 테이블에 같은 이름의 컬럼이 여러 개 있는 경우 JOIN~USING 구문을 이용하여 같은 이름의 컬럼값을 비교하여 조인 - 조인조건을 명시하지 않고 조인
--형식)SELECT 검색대상,... FROM 테이블명1 JOIN 테이블명2 USING(컬럼명)
--USING 구문에서 명시된 컬럼명은 테이블명을 명시하지 않아도 사용 가능
SELECT EMPNO,ENAME,SAL,DEPTNO,DNAME,LOC FROM EMP JOIN DEPT USING(DEPTNO);

--INNER JOIN : 조인조건을 명시하여 조인조건이 맞는 행만 결합하여 검색하는 조인
--형식)SELECT 검색대상,... FROM 테이블명1 [INNER] JOIN 테이블명2 ON 조인조건
--조인 테이블에 같은 이름의 컬럼이 존재할 경우 테이블명을 반드시 명시하여 검색
SELECT EMPNO,ENAME,SAL,DNAME,LOC FROM EMP INNER JOIN DEPT ON EMP.DEPTNO=DEPT.DEPTNO;
SELECT EMPNO,ENAME,SAL,DNAME,LOC FROM EMP JOIN DEPT ON EMP.DEPTNO=DEPT.DEPTNO;

--EMP 테이블과 SALGRADE 테이블에서 모든 사원의 사원번호,사원이름,급여,급여등급 검색
--조인조건 : 사원의 급여가 최소급여부터 최대급여 범위에 포함될 경우에 급여등급 검색
SELECT EMPNO,ENAME,SAL,GRADE FROM EMP JOIN SALGRADE ON SAL BETWEEN LOSAL AND HISAL;

--EMP 테이블과 DEPT 테이블에서 SALES 부서에 근무하는 사원의 사원번호,사원이름,급여,부서이름,부서위치 검색
SELECT EMPNO,ENAME,SAL,DNAME,LOC FROM EMP JOIN DEPT ON EMP.DEPTNO=DEPT.DEPTNO WHERE DNAME='SALES';

--OUTER JOIN : 조인조건을 명시하여 조인조건이 맞는 행과 조인조건이 맞지 않아 누락된 행도 결합하여 검색하는 조인
--형식)SELECT 검색대상,... FROM 테이블명1 {LEFT|RIGHT|FULL} [OUTER] JOIN 테이블명2 ON 조인조건
--LEFT OUTER JOIN : 왼쪽 방향에 선언된 테이블의 모든 행을 검색하되 오른쪽방향의 선언된 테이블은 조인조건이 참인 행과 결합하여 검색하고
--조인조건에 참인 행이 없는 경우 NULL로 결합하여 검색
--RIGHT OUTER JOIN : 오른쪽 방향에 선언된 테이블의 모든 행을 검색하되 왼쪽 방향의 선언된 테이블은 조인조건이 참인 행과 결합하여 검색하고
--조인조건에 참인 행이 없는 경우 NULL로 결합하여 검색
--FULL OUTER JOIN : 양쪽 방향에 선언된 테이블의 모든 행을 검색하되 조인조건이 참인 행은 결합하여 검색하고 조인조건이 참인 행이 없는 경우 
--NULL로 결합하여 검색
SELECT EMPNO,ENAME,SAL,DNAME,LOC FROM EMP LEFT JOIN DEPT ON EMP.DEPTNO=DEPT.DEPTNO;
SELECT EMPNO,ENAME,SAL,DNAME,LOC FROM EMP RIGHT JOIN DEPT ON EMP.DEPTNO=DEPT.DEPTNO;
SELECT EMPNO,ENAME,SAL,DNAME,LOC FROM EMP FULL JOIN DEPT ON EMP.DEPTNO=DEPT.DEPTNO;

--EMP 테이블에서 모든 사원의 사원번호,사원이름,매니저번호(매니저의 사원번호),매니저 이름(매니저의 사원이름) 검색 - 셀프조인
--조인조건 : EMP 테이블(WORKER)의 매니저번호를 EMP 테이블(MANAGER)의 사원번호와 비교하여 같은 행만 결합하여 검색 - INNER JOIN
SELECT WORKER.EMPNO,WORKER.ENAME WORKER_ENAME,WORKER.MGR,MANAGER.ENAME MANAGER_ENAME 
    FROM EMP WORKER JOIN EMP MANAGER ON WORKER.MGR=MANAGER.EMPNO;--KING 사원 제외
    
--OUTER JOIN를 사용하여 모든 사원 검색    
SELECT WORKER.EMPNO,WORKER.ENAME WORKER_ENAME,WORKER.MGR,MANAGER.ENAME MANAGER_ENAME 
    FROM EMP WORKER LEFT JOIN EMP MANAGER ON WORKER.MGR=MANAGER.EMPNO;