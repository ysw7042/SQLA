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