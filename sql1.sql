--워크시트 설명문 처리

--워크시트에서 작성된 SQL 명령을 ORACLE에 전달하여 실행하는 방법 : [CTRL]+[ENTER] 또는 [F5]
--[CTRL]+[ENTER] : 커서 위치의 SQL 명령을 전달하여 실행 - [F9]
--[F5] : 워크시트에 작성된 모든 SQL 명령을 전달하여 실행
--범위를 지정하여 [CTRL]+[ENTER] 또는 [F5]를 사용하면 범위 안에 작성된 SQL 명령을 전달하여 실행
--전달된 SQL 명령의 실행 결과는 [스크립트 출력] 탭 또는 [질의 결과] 탭에 출력

--SQL 명령은 대소문자를 구분하지 않으며 하나의 SQL 명령으로 처리되도록 ; 기호 사용

--테이블(TABLE) : 데이타베이스에서 데이타(행)을 저장하기 위한 기본 객체
--현재 접속 사용자의 스키마에 존재하는 테이블 목록 확인
SELECT TABLE_NAME FROM TABS;
SELECT * FROM TAB;

--테이블의 구조 확인 : 테이블 속성 정보 - 컬럼명과 자료형
--형식)DESC 테이블명
--EMP 테이블 : 사원정보를 저장하기 위한 테이블
DESC EMP;
--DEPT 테이블 : 부서정보를 저장하기 위한 테이블
DESC DEPT;

--DQL(DATA QUERY LANGUAGE) : 데이타 질의어
--테이블의 행에 대한 검색 기능을 제공하기 위한 SQL 명령

--SELECT : 하나 이상의 테이블에서 행을 검색하기 위한 명령
--형식)SELECT 검색대상,검색대상,... FROM 테이블명,테이블명,...
--테이블에 저장된 모든 행 검색
--검색대상 : *(모든 컬럼) - 다른 검색대상과 동시에 사용 불가능, 컬럼명, 연산식, 함수 등
SELECT * FROM EMP;
SELECT EMPNO,ENAME,SAL,DEPTNO FROM EMP;

--COLUMN ALIAS : 검색대상에 별칭(임시 컬럼명)을 부여하는 기능
--검색대상을 명확하게 구분하여 표현하기 위한 별칭
--형식)SELECT 검색대상 [AS] 별칭,검색대상 [AS] 별칭,... FROM 테이블명,테이블명,...
SELECT EMPNO,ENAME,DEPTNO FROM EMP;
SELECT EMPNO AS NO,ENAME AS NAME,DEPTNO AS DNO FROM EMP;
--AS 키워드 생략 가능
SELECT EMPNO NO,ENAME NAME,DEPTNO DNO FROM EMP;
SELECT EMPNO 사원번호,ENAME 사원이름, DEPTNO 부서번호 FROM EMP;

SELECT EMPNO,ENAME,SAL*12 FROM EMP;
SELECT EMPNO,ENAME,SAL*12 ANNUAL FROM EMP;

--식별자(테이블명,컬럼명,별칭 등)은 스네이크 표기법(단어와 단어를 _로 구분하여 표현) 사용
SELECT EMPNO,ENAME,SAL*12 ANNUAL_SALARY FROM EMP;

SELECT EMPNO 사원번호,ENAME 사원이름,SAL*12 연봉 FROM EMP;
--컬럼 별칭으로 공백문자 또는 특수문자 사용 불가능
SELECT EMPNO 사원 번호,ENAME 사원 이름,SAL*12 연봉^^ FROM EMP;--에러 발생
--컬럼 별칭을 " " 기호 안에 표현하면 모든 형태의 별칭 사용 가능 - " " 기호는 별칭을 표현하기 위한 기호
SELECT EMPNO "사원 번호",ENAME "사원 이름",SAL*12 "연봉^^" FROM EMP;

SELECT ENAME,JOB FROM EMP;
--|| 기호를 이용하여 값을 결합하여 표현 가능
SELECT ENAME||JOB FROM EMP;
--오라클에서는 문자값을 ' ' 기호를 이용하여 표현
SELECT ENAME||'님의 업무는 '||JOB||'입니다.' FROM EMP;

--EMP 테이블에 저장된 모든 사원의 업무 검색 - 중복 컬럼값 검색
SELECT JOB FROM EMP;

--EMP 테이블에 저장된 모든 사원의 업무 검색 - 중복 컬럼값을 제외한 유일한 하나의 컬럼값 검색
--DISTINCT : 검색대상의 중복값을 제외하고 유일한 하나의 결과값만 검색하는 기능을 제공하는 키워드
--형식)SELECT DISTINCT 검색대상[,검색대상,...] FROM 테이블명
SELECT DISTINCT JOB FROM EMP;

--오라클은 DISTINCT 키워드 뒤에 검색대상을 여러개 나열하여 검색 가능
SELECT DISTINCT JOB,DEPTNO FROM EMP;

--WHERE : 조건식을 사용하여 조건이 참인 행만 검색하는 기능을 제공
--형식)SELECT 검색대상,검색대상,... FROM 테이블명,테이블명,... WHERE 조건식

--EMP 테이블에서 모든 사원의 사원번호,사원이름,업무,급여 검색
SELECT EMPNO,ENAME,JOB,SAL FROM EMP;

--EMP 테이블에서 사원번호가 [7698]인 사원의 사원번호,사원이름,업무,급여 검색
SELECT EMPNO,ENAME,JOB,SAL FROM EMP WHERE EMPNO=7698;

--EMP 테이블에서 사원이름이 [KING]인 사원의 사원번호,사원이름,업무,급여 검색
SELECT EMPNO,ENAME,JOB,SAL FROM EMP WHERE ENAME='KING';
--문자값은 대소문자를 구분하여 비교
SELECT EMPNO,ENAME,JOB,SAL FROM EMP WHERE ENAME='king';

--EMP 테이블에서 입사일이 [1981년 6월 9일]인 사원의 사원번호,사원이름,업무,급여,입사일 검색
--날짜값은 ' ' 기호 안에 [RR/MM/DD]형식의 패턴으로 표현
SELECT EMPNO,ENAME,JOB,SAL,HIREDATE FROM EMP WHERE HIREDATE='81/06/09';
--날짜값은 ' ' 기호 안에 [YYYY-MM-DD]형식의 패턴으로 표현
SELECT EMPNO,ENAME,JOB,SAL,HIREDATE FROM EMP WHERE HIREDATE='1981-06-09';

--EMP 테이블에서 업무가 [SALESMAN]이 아닌 사원의 사원번호,사원이름,업무,급여 검색
SELECT EMPNO,ENAME,JOB,SAL FROM EMP WHERE JOB<>'SALESMAN';
SELECT EMPNO,ENAME,JOB,SAL FROM EMP WHERE JOB!='SALESMAN';

--EMP 테이블에서 급여가 [2000]이상인 사원의 사원번호,사원이름,업무,급여 검색
SELECT EMPNO,ENAME,JOB,SAL FROM EMP WHERE SAL>=2000;

--EMP 테이블에서 사원이름이 [A],[B],[C]로 시작되는 사원의 사원번호,사원이름,업무,급여 검색
SELECT EMPNO,ENAME,JOB,SAL FROM EMP WHERE ENAME<'D';

--EMP 테이블에서 [1981년 5월 1일]이전에 입사한 사원의 사원번호,사원이름,업무,급여,입사일 검색
SELECT EMPNO,ENAME,JOB,SAL,HIREDATE FROM EMP WHERE HIREDATE<'81/05/01';

--EMP 테이블에서 업무가 [SALESMAN]인 사원 중 급여가 [1500]이상인 사원의 사원번호,사원이름,업무,급여 검색
SELECT EMPNO,ENAME,JOB,SAL FROM EMP WHERE JOB='SALESMAN' AND SAL>=1500;

--EMP 테이블에서 부서번호가 [10]이거나 업무가 [MANAGER]인 사원의 사원번호,사원이름,업무,급여,부서번호 검색
SELECT EMPNO,ENAME,JOB,SAL,DEPTNO FROM EMP WHERE DEPTNO=10 OR JOB='MANAGER';

--EMP 테이블에서 급여가 [1000~3000]인 사원의 사원번호,사원이름,업무,급여 검색
SELECT EMPNO,ENAME,JOB,SAL FROM EMP WHERE SAL>=1000 AND SAL<=3000;

--범위 연산자를 이용하여 컬럼값이 작은값부터 큰값 범위에 포함될 경우의 조건식 표현
--형식)컬럼명 BETWEEN 작은값 AND 큰값
SELECT EMPNO,ENAME,JOB,SAL FROM EMP WHERE SAL BETWEEN 1000 AND 3000;

--EMP 테이블에서 업무가 [ANALYST]이거나 [SALESMAN]인 사원의 사원번호,사원이름,업무,급여 검색
SELECT EMPNO,ENAME,JOB,SAL FROM EMP WHERE JOB='ANALYST' OR JOB='SALESMAN';

--선택 연산자를 이용하여 컬럼값이 나열된 값들 중 하나인 경우의 조건식 표현
--형식)컬럼명 IN (값1,값2,...)
SELECT EMPNO,ENAME,JOB,SAL FROM EMP WHERE JOB IN('ANALYST','SALESMAN');

--EMP 테이블에서 사원이름이 [ALLEN]인 사원의 사원번호,사원이름,업무,급여 검색
SELECT EMPNO,ENAME,JOB,SAL FROM EMP WHERE ENAME='ALLEN';

--EMP 테이블에서 사원이름이 [A]로 시작되는 사원의 사원번호,사원이름,업무,급여 검색
SELECT EMPNO,ENAME,JOB,SAL FROM EMP WHERE ENAME>='A' AND ENAME<'B';
SELECT EMPNO,ENAME,JOB,SAL FROM EMP WHERE ENAME BETWEEN 'A' AND 'B' AND ENAME<>'B';

--검색패턴문자 : 부정확한 값을 검색하기 위한 사용하는 문자 - [%] : 전체, [_] : 임의 문자 하나
--값을 = 연산자로 비교할 경우 [%] 또는 [_]를 일반문자로 인식하여 비교
SELECT EMPNO,ENAME,JOB,SAL FROM EMP WHERE ENAME='A%';

--패턴 연산자를 이용하여 [%] 또는 [_]를 검색패턴문자로 처리하여 조건식 표현
--형식)컬럼명 LIKE '값 또는 검색패턴문자'
SELECT EMPNO,ENAME,JOB,SAL FROM EMP WHERE ENAME LIKE 'A%';

--검색패턴문자가 없어도 [=] 연산자 대신 [LIKE] 연산자를 사용하여 값 비교 가능
SELECT EMPNO,ENAME,JOB,SAL FROM EMP WHERE ENAME='ALLEN';
SELECT EMPNO,ENAME,JOB,SAL FROM EMP WHERE ENAME LIKE 'ALLEN';

--EMP 테이블에서 사원이름에 [A]가 포함되는 사원의 사원번호,사원이름,업무,급여 검색
SELECT EMPNO,ENAME,JOB,SAL FROM EMP WHERE ENAME LIKE '%A%';

--EMP 테이블에서 사원이름의 두번째 문자가 [L]인 사원의 사원번호,사원이름,업무,급여 검색
SELECT EMPNO,ENAME,JOB,SAL FROM EMP WHERE ENAME LIKE '_L%';

--EMP 테이블에 새로운 사원정보를 삽입하여 저장
INSERT INTO EMP VALUES(9000,'M_BEER','CLERK',7788,'81/12/12',1300,NULL,10);
COMMIT;
SELECT * FROM EMP WHERE EMPNO=9000;

--EMP 테이블에서 사원이름에 [_]가 포함되는 사원의 사원번호,사원이름,업무,급여 검색
--LIKE 연산자는 [%] 또는 [_]를 값이 아닌 검색패턴문자로 처리하여 검색하므로 모든 사원정보 검색 - 검색오류
SELECT EMPNO,ENAME,JOB,SAL FROM EMP WHERE ENAME LIKE '%_%';

--ESCAPE 키워드를 이용하여 표현 불가능한 문자를 ESCAPE 문자로 표현
SELECT EMPNO,ENAME,JOB,SAL FROM EMP WHERE ENAME LIKE '%\_%' ESCAPE '\';

--EMP 테이블에 사원번호가 9000인 사원정보 삭제
DELETE FROM EMP WHERE EMPNO=9000;
COMMIT;
SELECT * FROM EMP WHERE EMPNO=9000;

--EMP 테이블에서 업무가 [MANAGER]가 아닌 사원의 사원번호,사원이름,업무,급여 검색
SELECT EMPNO,ENAME,JOB,SAL FROM EMP WHERE JOB<>'MANAGER';

--NOT 연산자를 이용하여 조건식의 결과를 반대로 표현
--형식)NOT(조건식)
SELECT EMPNO,ENAME,JOB,SAL FROM EMP WHERE NOT(JOB='MANAGER');

--EMP 테이블에서 모든 사원의 사원번호,사원이름,업무,급여,성과급 검색
SELECT EMPNO,ENAME,JOB,SAL,COMM FROM EMP;

--EMP 테이블에서 성과급이 존재하지 않는 사원의 사원번호,사원이름,업무,급여,성과급 검색
--NULL : 존재하지 않는 값을 표현하기 위한 키워드
--NULL은 존재하는 값이 아니므로 연산 불가능 - 검색 오류
SELECT EMPNO,ENAME,JOB,SAL,COMM FROM EMP WHERE COMM=NULL;

--IS 연산자를 이용하여 [NULL] 비교
형식)컬럼명 IS NULL 또는 컬럼명 IS NOT NULL
SELECT EMPNO,ENAME,JOB,SAL,COMM FROM EMP WHERE COMM IS NULL;

--EMP 테이블에서 성과급이 존재하는 사원의 사원번호,사원이름,업무,급여,성과급 검색
SELECT EMPNO,ENAME,JOB,SAL,COMM FROM EMP WHERE COMM IS NOT NULL;

--ORDER BY : 컬럼값을 비교하여 행이 정렬되도록 검색하는 기능을 제공
--형식)SELECT 검색대상,검색대상,... FROM 테이블명,테이블명,... [WHERE 조건식] 
--    ORDER BY {컬럼명|연산식|별칭|INDEX} {ASC|DESC},{컬럼명|연산식|별칭|INDEX} {ASC|DESC},...
--ASC : 오름차순 정렬, DESC : 내림차순 정렬
--정렬 기준을 여러개 나열하여 선언하면 앞의 검색값이 같은 경우 뒤의 검색값을 비교하여 정렬

--EMP 테이블에서 모든 사원의 사원번호,사원이름,업무,급여,부서번호 검색
--기본적으로 테이블에 행이 삽입되어 저장된 순서대로 검색
SELECT EMPNO,ENAME,JOB,SAL,DEPTNO FROM EMP;

--EMP 테이블에서 모든 사원의 사원번호,사원이름,업무,급여,부서번호를 부서번호로 오름차순 정렬하여 검색
SELECT EMPNO,ENAME,JOB,SAL,DEPTNO FROM EMP ORDER BY DEPTNO ASC;
--오름차순 정렬인 경우 [ASC] 키워드 생략 가능
SELECT EMPNO,ENAME,JOB,SAL,DEPTNO FROM EMP ORDER BY DEPTNO;

--EMP 테이블에서 모든 사원의 사원번호,사원이름,업무,급여,부서번호를 급여로 내림차순 정렬하여 검색
SELECT EMPNO,ENAME,JOB,SAL,DEPTNO FROM EMP ORDER BY SAL DESC;

--EMP 테이블에서 모든 사원의 사원번호,사원이름,업무,급여,부서번호를 사원이름으로 오름차순 정렬하여 검색
SELECT EMPNO,ENAME,JOB,SAL,DEPTNO FROM EMP ORDER BY ENAME;

--EMP 테이블에서 모든 사원의 사원번호,사원이름,업무,급여,입사일,부서번호를 입사일로 내림차순 정렬하여 검색
SELECT EMPNO,ENAME,JOB,SAL,HIREDATE,DEPTNO FROM EMP ORDER BY HIREDATE DESC;

--EMP 테이블에서 모든 사원의 사원번호,사원이름,연봉(급여*12)을 연봉으로 내림차순 정렬하여 검색
SELECT EMPNO,ENAME,SAL*12 ANNUAL FROM EMP ORDER BY SAL*12 DESC;
SELECT EMPNO,ENAME,SAL*12 ANNUAL FROM EMP ORDER BY ANNUAL DESC;
--SELECT 명령의 검색대상에는 자동으로 첨자(COLUMN INDEX)가 부여
--오라클은 첨자(INDEX)가 1부터 1씩 증가되는 숫자값으로 표현
SELECT EMPNO,ENAME,SAL*12 ANNUAL FROM EMP ORDER BY 3 DESC;

--EMP 테이블에서 모든 사원의 사원번호,사원이름,업무,급여,부서번호를 부서번호로 오름차순 정렬하고 같은 경우 급여로 내림차순 정렬하여 검색
SELECT EMPNO,ENAME,JOB,SAL,DEPTNO FROM EMP ORDER BY DEPTNO, SAL DESC;

--EMP 테이블에서 급여가 [3000]이상인 사원의 사원번호,사원이름,업무,급여,부서번호를 부서번호로 오름차순 정렬하여 검색
SELECT EMPNO,ENAME,JOB,SAL,DEPTNO FROM EMP WHERE SAL>=3000 ORDER BY DEPTNO;

--검색대상 : EMP 테이블에 모든 컬럼값 검색
--문제1.사원이름이 SCOTT인 사원 검색
SELECT * FROM EMP WHERE ENAME='SCOTT';
SELECT * FROM EMP WHERE ENAME LIKE 'SCOTT';
--USER : 현재 접속 사용자의 이름을 표현하는 키워드
SELECT * FROM EMP WHERE ENAME=USER;

--문제2.급여가 1500이하인 사원 검색
SELECT * FROM EMP WHERE SAL<=1500;

--문제3.1981년도에 입사한 사원 검색
SELECT * FROM EMP WHERE HIREDATE>='81/01/01' AND HIREDATE<='81/12/31';
SELECT * FROM EMP WHERE HIREDATE>='1981-01-01' AND HIREDATE<='1981-12-31';
SELECT * FROM EMP WHERE HIREDATE BETWEEN '81/01/01' AND '81/12/31';
SELECT * FROM EMP WHERE HIREDATE LIKE '81%';
SELECT * FROM EMP WHERE HIREDATE LIKE '81/__/__';

--문제4.업무가 SALESMAN이거나 MANAGER인 사원 중 급여가 1500이상인 사원 검색
SELECT * FROM EMP WHERE (JOB='SALESMAN' OR JOB='MANAGER') AND SAL>=1500;
SELECT * FROM EMP WHERE JOB IN('SALESMAN','MANAGER') AND SAL>=1500;

--문제5.부서번호가 10인 사원 중 급여가 1000~3000 범위인 사원 검색
SELECT * FROM EMP WHERE DEPTNO=10 AND SAL>=1000 AND SAL<=3000;
SELECT * FROM EMP WHERE DEPTNO=10 AND SAL BETWEEN 1000 AND 3000;

--문제6.부서번호가 30인 사원 중 성과급이 NULL이 아닌 사원 검색
SELECT * FROM EMP WHERE DEPTNO=30 AND COMM IS NOT NULL;

--문제7.모든 사원을 업무로 오름차순 정렬하고 같은 업무의 사원은 급여로 내림차순 정렬하여 검색
SELECT * FROM EMP ORDER BY JOB,SAL DESC;

--문제8.업무가 SALESMAN인 사원을 급여로 내림차순 정렬하여 검색
SELECT * FROM EMP WHERE JOB='SALESMAN' ORDER BY SAL DESC;