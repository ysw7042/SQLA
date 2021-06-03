--함수(FUNCTION) : 값을 전달받아 처리하여 결과값을 반환하는 기능을 제공
--단일함수 : 하나의 값을 전달받아 처리하여 결과값을 반환하는 함수
-- >> 문자함수,숫자함수,날짜함수,변환함수,일반함수
--그룹함수 : 여러 개의 값을 전달받아 처리하여 결과값을 반환하는 함수

--문자함수 : 문자값을 전달하여 처리하여 결과값을 반환하는 함수

--UPPER(문자값) : 문자값을 전달받아 대문자로 변환하여 반환하는 함수
--LOWER(문자값) : 문자값을 전달받아 소문자로 변환하여 반환하는 함수
SELECT ENAME,UPPER(ENAME),LOWER(ENAME) FROM EMP;

--EMP 테이블에서 사원이름이 [SMITH]인 사원의 사원번호,사원이름,급여 검색
SELECT EMPNO,ENAME,SAL FROM EMP WHERE ENAME='SMITH';
--SQL 명령은 대소문자를 구분하지 않지만 문자값은 대소문자를 구분하여 비교
select empno,ename,sal from emp where ename='smith';--검색오류
--UPPER 함수 또는 LOWER 함수를 이용하여 대소문자 구분없이 비교 가능
SELECT EMPNO,ENAME,SAL FROM EMP WHERE UPPER(ENAME)=UPPER('SMITH');
SELECT EMPNO,ENAME,SAL FROM EMP WHERE UPPER(ENAME)=UPPER('smith');

--INITCAP(문자값) : 문자값을 전달받아 첫문자만 대문자로 변환하고 나머지는 소문자로 변환하여 반환하는 함수
SELECT ENAME,INITCAP(ENAME) FROM EMP;

--CONCAT(문자값,문자값) : 두 개의 문자값을 전달받아 결합하여 반환하는 함수 - || 기호와 동일한 기능 제공
SELECT ENAME,JOB,CONCAT(ENAME,JOB),ENAME||JOB FROM EMP;

--SUBSTR(문자값,시작위치,갯수) : 문자값을 전달받아 시작위치(INDEX)부터 갯수만큼의 문자을 분리하여 반환하는 함수
SELECT EMPNO,ENAME,JOB,SUBSTR(JOB,6,3) FROM EMP WHERE EMPNO=7499;

--LENGTH(문자값) : 문자값을 전달받아 문자의 갯수를 반환하는 함수
SELECT EMPNO,ENAME,LENGTH(ENAME) FROM EMP WHERE EMPNO=7499;

--INSTR(문자값,검색문자값,시작위치,갯수) : 문자값을 전달받아 검색문자값를 시작위치부터 검색하여 
--원하는 갯수의 시작위치를 반환하는 함수 >> 검색문자가 없는 경우 0 반환
SELECT EMPNO,ENAME,JOB,INSTR(JOB ,'A',1,2) FROM EMP WHERE EMPNO=7499;
SELECT EMPNO,ENAME,JOB,INSTR(JOB,'X',1,1) FROM EMP WHERE EMPNO=7499;

--LPAD(문자값,자릿수,채울문자) : 문자값을 전달받아 자릿수만큼의 길이로 오른쪽 정렬하여 검색하고 
--왼쪽 남은 자릿수에는 채울문자로 채워 반환하는 함수
--RPAD(문자값,자릿수,채울문자) : 문자값을 전달받아 자릿수만큼의 길이로 왼쪽 정렬하여 검색하고 
--오른쪽 남은 자릿수에는 채울문자로 채워 반환하는 함수
SELECT EMPNO,ENAME,SAL,LPAD(SAL,8,'*'),RPAD(SAL,8,'*') FROM EMP WHERE EMPNO=7844;

--TRIM({LEADING|TRAILING} 제거문자 FROM 문자값) : 문자값을 전달받아 앞(LEADING) 또는 뒤(TRAILING)에 존재하는
--제거문자를 모두 제거하여 반환하는 함수
SELECT EMPNO,ENAME,JOB,TRIM(LEADING 'S' FROM JOB),TRIM(TRAILING 'N' FROM JOB) FROM EMP WHERE EMPNO=7844;

--REPLACE(문자값,검색문자,변환문자) : 문자값을 전달받아 검색문자를 찾아 변환문자로 변환하여 반환하는 함수
SELECT EMPNO,ENAME,JOB,REPLACE(JOB,'MAN','PERSON') FROM EMP WHERE EMPNO=7844;

--숫자함수 : 숫자값을 전달받아 처리하여 결과값을 반환하는 함수

--ROUND(숫자값,소숫점자릿수) : 숫자값을 전달받아 소숫점 자릿수만큼 검색되도록 반올림 처리하여 반환하는 함수
--DUAL : 검색 테이블 없이 SELECT 명령을 작성할 경우 사용되는 가상의 테이블
SELECT ROUND(45.582,2),ROUND(45.582,0),ROUND(45.582,-1) FROM DUAL;

--TRUNC(숫자값,소숫점자릿수) : 숫자값을 전달받아 소숫점 자릿수만큼 검색되도록 절삭 처리하여 반환하는 함수
SELECT TRUNC(45.582,2),TRUNC(45.582,0),TRUNC(45.582,-1) FROM DUAL;

--CEIL(숫자값) : 숫자값을 전달받아 소숫점 이하 값이 존재할 경우 증가된 숫자값(정수)으로 반환하는 함수
SELECT CEIL(15.3),CEIL(-15.3) FROM DUAL;

--FLOOR(숫자값) : 숫자값을 전달받아 소숫점 이하 값이 존재할 경우 감소된 숫자값(정수)으로 반환하는 함수
SELECT FLOOR(15.3),FLOOR(-15.3) FROM DUAL;

--MOD(숫자값1,숫자값2) : 숫자값1을 숫자값2로 나누어 나머지 값을 반환하는 함수
SELECT 20/8,MOD(20,8) FROM DUAL;

--POWER(숫자값1,숫자값2) : 숫자값1에 대한 숫자값2의 제곱근을 계산하여 반환하는 함수
SELECT 3*3*3*3*3,POWER(3,5) FROM DUAL;

--날짜함수 : 날짜값을 전달받아 처리하여 결과값을 반환하는 함수

--SYSDATE : 시스템의 현재 날짜와 시간정보를 제공하는 키워드
--날짜값은 표면적으로 [RR/MM/DD] 형식으로 표현되지만 내부적으로는 날짜와 시간정보로 표현
SELECT SYSDATE FROM DUAL;

--ADD_MONTHS(날짜값,숫자값) : 날짜값을 전달받아 숫자값만큼의 개월수를 더한 날짜값을 반환하는 함수
SELECT SYSDATE,ADD_MONTHS(SYSDATE,5) FROM DUAL;

--NEXT_DAY(날짜값,요일) : 날짜값을 전달받아 다가오는 특정 요일의 날짜값을 반환하는 함수
SELECT SYSDATE,NEXT_DAY(SYSDATE,'토') FROM DUAL;

--오라클에 접속된 사용자 환경(세션:SESSION)에 따라 날짜와 시간정보를 다르게 표현
--세션의 날짜 표현 언어 변경
ALTER SESSION SET NLS_LANGUAGE='AMERICAN';
SELECT SYSDATE,NEXT_DAY(SYSDATE,'SAT') FROM DUAL;

ALTER SESSION SET NLS_LANGUAGE='KOREAN';
SELECT SYSDATE,NEXT_DAY(SYSDATE,'토') FROM DUAL;

--TRUNC(날짜값,표현단위) : 날짜값을 전달받아 원하는 단위까지만 표현하고 나머지는 최초값으로 변환하여 반환하는 함수
SELECT SYSDATE,TRUNC(SYSDATE,'MONTH'),TRUNC(SYSDATE,'YEAR') FROM DUAL;

--날짜값은 연산 가능
--날짜값 + 숫자값 = 날짜값 >> 일 증가
SELECT SYSDATE,SYSDATE+7 FROM DUAL;

--날짜값 + 숫자값/24 = 날짜값 >> 시간 증가
SELECT SYSDATE,SYSDATE+100/24 FROM DUAL;

--날짜값 - 숫자값 = 날짜값 >> 일 감소
SELECT SYSDATE,SYSDATE-7 FROM DUAL;

--날짜값 - 숫자값/24 = 날짜값 >> 시간 감소
SELECT SYSDATE,SYSDATE-100/24 FROM DUAL;

--날짜값 - 날짜값 = 숫자값 >> 일(실수)
SELECT EMPNO,ENAME,HIREDATE,SYSDATE-HIREDATE FROM EMP WHERE EMPNO=7499;
SELECT EMPNO,ENAME,HIREDATE,CEIL(SYSDATE-HIREDATE)||'일' "근속일자" FROM EMP WHERE EMPNO=7499;

--변환함수 : 전달값을 원하는 자료형의 값으로 변환하여 반환하는 함수

--TO_NUMBER(문자값) : 문자값을 전달받아 숫자값으로 변환하여 반환하는 함수
-- >> 문자값이 숫자 형식의 문자로 구성된 경우가 아닌 경우 에러 발생
SELECT EMPNO,ENAME,SAL FROM EMP WHERE EMPNO=7839;
--비교 컬럼의 자료형이 숫자형인 경우 비교값이 문자값이면 숫자값으로 변환하여 비교 - 강제 형변환
SELECT EMPNO,ENAME,SAL FROM EMP WHERE EMPNO=TO_NUMBER('7839');
--비교 컬럼의 자료형이 숫자형인 경우 비교값이 문자값이면 자동으로 숫자값을 변환하여 비교 - 자동 형변환
SELECT EMPNO,ENAME,SAL FROM EMP WHERE EMPNO='7839';

--문자값을 연산할 경우 자동으로 숫자값으로 변환되어 연산 처리 - 자동 형변환
SELECT 100+200 FROM DUAL;
SELECT '100'+'200' FROM DUAL;

--EMP 테이블에서 사원번호가 [7839]인 사원의 사원번호,사원이름,급여,세후급여(급여*0.9) 검색
SELECT EMPNO,ENAME,SAL,SAL*0.9 FROM EMP WHERE EMPNO=7839;
SELECT EMPNO,ENAME,SAL,SAL*TO_NUMBER('0.9') FROM EMP WHERE EMPNO=7839;
SELECT EMPNO,ENAME,SAL,SAL*'0.9' FROM EMP WHERE EMPNO=7839;

--TO_DATE(문자값) : 문자값을 전달받아 날짜값으로 변환하여 반환하는 함수
-- >> 문자값이 패턴에 맞는 날짜 형식이 아닌 경우 에러 발생 - 기본 날짜 패턴 : RR/MM/DD
--비교 컬럼의 자료형이 날짜형인 경우 비교값이 문자값이면 날짜값으로 변환하여 비교 - 강제 형변환
SELECT EMPNO,ENAME,HIREDATE FROM EMP WHERE HIREDATE=TO_DATE('82/01/23');
--비교 컬럼의 자료형이 날짜형인 경우 비교값이 문자값이면 자동으로 날짜값으로 변환하여 비교 - 자동 형변환
SELECT EMPNO,ENAME,HIREDATE FROM EMP WHERE HIREDATE='82/01/23';

--날짜값은 [RR/MM/DD] 패턴 대신 [YYYY-MM-DD] 패턴으로 표현 가능
SELECT EMPNO,ENAME,HIREDATE FROM EMP WHERE HIREDATE='1982-01-23';
--날짜 패턴에 맞지 않은 문자값을 사용한 경우 에러 발생
SELECT EMPNO,ENAME,HIREDATE FROM EMP WHERE HIREDATE='01-23-1982';--에러 발생
--TO_DATE 함수의 패턴문자를 이용하여 원하는 패턴 형식으로 문자값 변환 가능 - TO_DATE(문자값,패턴문자)
SELECT EMPNO,ENAME,HIREDATE FROM EMP WHERE HIREDATE=TO_DATE('01-23-1982','MM-DD-YYYY');

--EMP 테이블에서 사원번호가 [7844]인 사원의 사원번호,사원이름,입사일,입사일로부터 2000년 1월 1일까지 근무한 일자를 계산하여 검색
SELECT EMPNO,ENAME,HIREDATE,'2000-01-01'-HIREDATE FROM EMP WHERE EMPNO=7844;--에러 발생 : 문자값과 날짜값 연산 불가능
--TO_DATE 함수를 사용하여 문자값을 날짜값으로 변환하면 연산 가능
SELECT EMPNO,ENAME,HIREDATE,TO_DATE('2000-01-01')-HIREDATE FROM EMP WHERE EMPNO=7844;

--TO_CHAR({숫자값|날짜값},패턴문자) : 숫자값 또는 날짜값을 전달받아 원하는 패턴의 문자값으로 변환하여 반환하는 함수

--날짜패턴문자 : YYYY(년),RR(년),MM(월),DD(일),HH24(시간),HH12(시간),AM(오전),PM(오후),MI(분),SS(초)
SELECT SYSDATE FROM DUAL;
SELECT TO_CHAR(SYSDATE,'YYYY-MM-DD') FROM DUAL;
SELECT TO_CHAR(SYSDATE,'YYYY-MM-DD HH24:MI:SS') FROM DUAL;

--EMP 테이블에서 1981년도에 입사한 사원의 사원번호,사원이름,입사일 검색
--세션의 날짜패턴(NLS_DATE_FORMAT)이 [RR/MM/DD]인 경우에만 검색 가능
SELECT EMPNO,ENAME,HIREDATE FROM EMP WHERE HIREDATE LIKE '81%';
--TO_CHAR 함수를 이용하여 날짜값을 원하는 패턴의 문자값으로 변환하여 비교
SELECT EMPNO,ENAME,HIREDATE FROM EMP WHERE TO_CHAR(HIREDATE,'YYYY')='1981';

--숫자패턴문자 : 9(숫자 또는 공백),0(숫자),L(화폐기호),$(달러) - 패턴문자가 모자란 경우 #으로 표현
SELECT 100000000,TO_CHAR(100000000,'9,999,999,990') FROM DUAL;
SELECT 1000000000,TO_CHAR(1000000000,'9,999,999,990') FROM DUAL;
SELECT 10000000000,TO_CHAR(10000000000,'9,999,999,990') FROM DUAL;

--EMP 테이블에서 사원번호가 [7844]인 사원의 사원번호,사원이름,급여 검색
SELECT EMPNO,ENAME,SAL FROM EMP WHERE EMPNO=7844;
SELECT EMPNO,ENAME,TO_CHAR(SAL,'999,990') SAL FROM EMP WHERE EMPNO=7844;
SELECT EMPNO,ENAME,TO_CHAR(SAL,'L99,990') SAL FROM EMP WHERE EMPNO=7844;
SELECT EMPNO,ENAME,TO_CHAR(SAL,'$99,990.00') SAL FROM EMP WHERE EMPNO=7844;

--일반함수 : 전달값이 특정 조건인 경우에만 처리되어 결과값을 반환하는 함수

--NVL(컬럼명,변경값) : 컬럼값이 NULL인 경우 변경값으로 변환하여 반환하는 함수
--변경값은 컬럼의 자료형과 동일한 자료형의 값으로 변경하지 않으면 에러 발생

--EMP 테이블에서 모든 사원의 사원번호,사원이름,연봉(급여*12) 검색
SELECT EMPNO,ENAME,SAL*12 ANNUAL FROM EMP;

--EMP 테이블에서 모든 사원의 사원번호,사원이름,연봉((급여+성과급)*12) 검색
--성과급이 NULL인 경우 경우 연산이 불가능하므로 NULL 검색 
SELECT EMPNO,ENAME,(SAL+COMM)*12 ANNUAL FROM EMP;-- 검색 오류
--NVL 함수를 사용하여 성과급이 NULL인 경우 0으로 변환하여 연산 처리
SELECT EMPNO,ENAME,(SAL+NVL(COMM,0))*12 ANNUAL FROM EMP;

--NVL2(컬럼명,변경값1,변경값2) : 컬럼값이 NULL이 아닌 경우 변경값1로 변환하고 NULL인 경우 변경값2으로 변환하여 반환하는 함수
SELECT EMPNO,ENAME,(SAL+NVL2(COMM,COMM,0))*12 ANNUAL FROM EMP;
SELECT EMPNO,ENAME,NVL2(COMM,SAL+COMM,SAL)*12 ANNUAL FROM EMP;

--DECODE(컬럼명,비교값1,변경값1,비교값2,변경값2,...[,기본변경값]) : 컬럼값을 비교값과 차례대로 비교하여 같은 경우 
--변경값으로 변환하여 반환하는 함수
-- >> 컬럼값이 모든 비교값과 다른 경우 기본 변경값으로 변환하여 반환 - 기본 변경값이 생략된 경우 NULL 반환

--EMP 테이블에서 모든 사원의 사원번호,사원이름,업무,급여,업무별 실급여 검색
--업무별 실급여 : 업무별로 급여를 계산하여 실제로 지불될 급여
SELECT DISTINCT JOB FROM EMP;
--ANALYST : 급여*1.1, CLERK : 급여*1.2, MANAGER : 급여*1.3, PRESIDENT : 급여*1.4, SALESMAN : 급여*1.5
SELECT EMPNO,ENAME,JOB,SAL,DECODE(JOB,'ANALYST',SAL*1.1,'CLERK',SAL*1.2,'MANAGER',SAL*1.3
    ,'PRESIDENT',SAL*1.4,'SALESMAN',SAL*1.5,SAL) "업무별 실급여" FROM EMP;
    
--EMP 테이블에서 모든 사원의 사원번호,사원이름,업무,급여 검색
SELECT EMPNO,ENAME,JOB,SAL FROM EMP;

--EMP 테이블에서 모든 사원의 사원번호,사원이름,업무별 급여를 구분하여 검색하며 해당 업무가 아닌 경우 NULL 검색
SELECT EMPNO,ENAME,DECODE(JOB,'ANALYST',SAL) "ANALYST",DECODE(JOB,'CLERK',SAL) "CLERK"
    ,DECODE(JOB,'MANAGER',SAL) "MANAGER",DECODE(JOB,'PRESIDENT',SAL) "PRESIDENT",DECODE(JOB,'SALESMAN',SAL) "SALESMAN" FROM EMP;
    
--그룹함수 : 값을 여러 개 전달받아 처리하여 결과값을 반환하는 함수

--COUNT(컬럼명) : 컬럼값의 갯수를 반환하는 함수 - 검색행의 갯수 반환
SELECT COUNT(EMPNO) FROM EMP;

--그룹함수는 다른 검색대상과 같이 사용 불가능 - 검색대상의 검색행의 갯수가 서로 다르므로 에러 발생
SELECT EMPNO,COUNT(EMPNO) FROM EMP;--에러 발생

--그룹함수는 NULL를 값으로 인식하지 않아 미처리
SELECT COUNT(EMPNO),COUNT(COMM) FROM EMP;

--COUNT 함수는 컬럼명 대신 [*]를 사용하여 모든 컬럼으로 테이블에 저장된 행의 갯수 반환
SELECT COUNT(*) FROM EMP;

--MAX(컬럼명) : 컬럼값 중 최대값을 반환하는 함수
SELECT MAX(SAL) FROM EMP;
SELECT MAX(ENAME) FROM EMP;
SELECT MAX(HIREDATE) FROM EMP;

--MIN(컬럼명) : 컬럼값 중 최소값을 반환하는 함수
SELECT MIN(SAL) FROM EMP;
SELECT MIN(ENAME) FROM EMP;
SELECT MIN(HIREDATE) FROM EMP;

--SUM(컬럼명) : 숫자형 컬럼의 값을 전달받아 합계를 계산하여 반환하는 함수
SELECT SUM(SAL) FROM EMP;

--AVG(컬럼명) : 숫자형 컬럼의 값을 전달받아 평균을 계산하여 반환하는 함수
SELECT AVG(SAL) FROM EMP;
SELECT ROUND(AVG(SAL),2) FROM EMP;

--EMP 테이블에서 모든 사원의 평균 성과급을 계산하여 검색
--성과급이 NULL이 아닌 사원들에 대한 평균 급여 검색 - 검색오류
SELECT AVG(COMM) FROM EMP;

--NVL 함수를 사용하여 성과급이 NULL인 경우 0으로 변환하여 평균 성과급을 계산하여 검색
SELECT CEIL(AVG(NVL(COMM,0))) "평균 성과급" FROM EMP;

--EMP 테이블에 저장된 모든 사원에 대한 인원수 검색
SELECT COUNT(*) FROM EMP;

--EMP 테이블에 저장된 부서별 사원 인원수 검색
SELECT DISTINCT DEPTNO FROM EMP;
SELECT COUNT(*) FROM EMP WHERE DEPTNO=10;
SELECT COUNT(*) FROM EMP WHERE DEPTNO=20;
SELECT COUNT(*) FROM EMP WHERE DEPTNO=30;

--GROUP BY : 그룹함수를 사용할 경우 컬럼값으로 그룹을 구분하여 검색하는 기능
-- >> 컬럼값이 같은 경우 같은 그룹으로 처리
--형식)SELECT 그룹함수[,검색대상,...] FROM 테이블명,테이블명,... [WHERE 조건식]
--    GROUP BY {컬럼명|연산식|함수},... [ORDER BY {컬럼명|연산식|별칭|첨자} {ASC|DESC},...]

--EMP 테이블에 저장된 부서별 사원 인원수 검색
SELECT COUNT(*) FROM EMP GROUP BY DEPTNO;

--GROUP BY 구문에서 사용된 그룹 표현식은 그룹함수와 같이 검색대상으로 사용 가능
SELECT DEPTNO,COUNT(*) FROM EMP GROUP BY DEPTNO ORDER BY DEPTNO;
--검색대상의 별칭은 GROUP BY 구문의 그룹 표현식으로 사용할 경우 에러 발생
SELECT DEPTNO DNO,COUNT(*) FROM EMP GROUP BY DNO;--에러 발생

--EMP 테이블에서 모든 사원의 업무별 평균 급여 검색
SELECT JOB,CEIL(AVG(SAL)) AVG_SAL FROM EMP GROUP BY JOB;

--EMP 테이블에서 업무가 [PRESIDENT]인 사원을 제외한 모든 사원의 업무별 평균 급여 검색
SELECT JOB,CEIL(AVG(SAL)) AVG_SAL FROM EMP WHERE JOB<>'PRESIDENT' GROUP BY JOB;

--EMP 테이블에서 업무가 [PRESIDENT]인 사원을 제외한 모든 사원의 업무별 평균 급여를 평균 급여로 내림차순 정렬하여 검색
SELECT JOB,CEIL(AVG(SAL)) AVG_SAL FROM EMP WHERE JOB<>'PRESIDENT' GROUP BY JOB ORDER BY AVG_SAL DESC;

--HAVING : GROUP BY 구문으로 그룹화된 검색 결과의 그룹조건을 제공하여 검색하는 기능
--형식)SELECT 그룹함수[,검색대상,...] FROM 테이블명,테이블명,... [WHERE 조건식]
--    GROUP BY {컬럼명|연산식|함수},... HAVING 그룹조건식 [ORDER BY {컬럼명|연산식|별칭|첨자} {ASC|DESC},...]

--EMP 테이블에서 모든 사원의 부서별 급여 합계 중 급여 합계가 9000이상인 부서 검색
SELECT DEPTNO,SUM(SAL) FROM EMP GROUP BY DEPTNO HAVING SUM(SAL)>=9000;

--EMP 테이블에서 업무가 [PRESIDENT]인 사원을 제외한 모든 사원의 업무별 평균 급여 검색
SELECT JOB,CEIL(AVG(SAL)) AVG_SAL FROM EMP WHERE JOB<>'PRESIDENT' GROUP BY JOB;
SELECT JOB,CEIL(AVG(SAL)) AVG_SAL FROM EMP GROUP BY JOB HAVING JOB<>'PRESIDENT'; 
