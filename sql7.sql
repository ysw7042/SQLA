--EMP 테이블에서 모든 사원을 검색하여 EMP_COPY 테이블을 생성하고 검색행 삽입
CREATE TABLE EMP_COPY AS SELECT * FROM EMP;
SELECT * FROM EMP_COPY;

--EMP_COPY 테이블에서 부서번호가 30인 사원의 사원번호,사원이름,부서번호를 검색하여 EMP_VIEW30 뷰로 생성
--현재 접속 사용자는 뷰에 대한 시스템 권한이 없으므로 뷰를 생성할 경우 에러 발생 - 관리자에게 뷰에 대한 시스템 권한 요청
CREATE VIEW EMP_VIEW30 AS SELECT EMPNO,ENAME,DEPTNO FROM EMP WHERE DEPTNO=30;

--시스템 관리자(SYS 또는 SYSTEM)로 접속하여 일반 사용자(SCOTT)에게 뷰에 대한 시스템 권한 부여
--GRANT CREATE VIEW TO SCOTT;

--관리자로부터 뷰에 대한 시스템 권한을 부여 받은 후 뷰 관련 명령 사용 가능
--단순뷰 : 뷰에 대한 행 삽입,변경,삭제,검색 명령 사용 가능
CREATE VIEW EMP_VIEW30 AS SELECT EMPNO,ENAME,DEPTNO FROM EMP_COPY WHERE DEPTNO=30;

--뷰 목록 확인 - USER_VIEWS : 뷰 정보를 제공하는 딕셔너리
SELECT VIEW_NAME,TEXT FROM USER_VIEWS;
DESC EMP_VIEW30;

--뷰 검색 : 테이블의 저장행을 이용하여 검색
SELECT * FROM EMP_VIEW30;

--단순뷰를 이용한 행 삽입 - 테이블에 행 삽입 : 뷰에 없는 생략된 컬럼에는 컬럼 기본값 저장
INSERT INTO EMP_VIEW30 VALUES(1111,'홍길동',30);
SELECT * FROM EMP_VIEW30;
SELECT * FROM EMP_COPY;
COMMIT;

--EMP 테이블과 DEPT 테이블에서 모든 사원의 사원번호,사원이름,급여,부서이름,부서위치 검색
SELECT EMPNO,ENAME,SAL,DNAME,LOC FROM EMP JOIN DEPT ON EMP.DEPTNO=DEPT.DEPTNO;

--EMP 테이블과 DEPT 테이블에서 모든 사원의 사원번호,사원이름,급여,부서이름,부서위치를 검색하여 EMP_VIEW 뷰로 생성
--복합뷰 : 행 검색 명령만 사용 가능 - 쉬운 검색 기능 제공
CREATE VIEW EMP_VIEW AS SELECT EMPNO,ENAME,SAL,DNAME,LOC FROM EMP JOIN DEPT ON EMP.DEPTNO=DEPT.DEPTNO;
SELECT * FROM EMP_VIEW;

--EMP_COPY 테이블에서 모든 사원의 사원번호,사원이름,업무,입사일,급여 검색하여 EMP_VIEW01 뷰로 생성
CREATE VIEW EMP_VIEW01 AS SELECT EMPNO,ENAME,JOB,HIREDATE,SAL FROM EMP_COPY;

--EMP_COPY 테이블에서 업무가 SALESMAN인 사원의 사원번호,사원이름,성과급 검색하여 EMP_VIEW02 뷰로 생성
CREATE VIEW EMP_VIEW02 AS SELECT EMPNO,ENAME,COMM FROM EMP_COPY WHERE JOB='SALESMAN';

--뷰를 이용한 쉬운 객체 권한 설정 가능
--현재 접속 사용자를 제외한 모든 사용자는 EMP_COPY 테이블에 대한 접근 권한 미부여
--인사부에 근무하는 사원에게는 EMP_VIEW01 뷰에 접근할 수 권한을 부여
SELECT * FROM EMP_VIEW01;
--영업부에 근무하는 사원에게는 EMP_VIEW02 뷰에 접근할 수 있는 권한 부여
SELECT * FROM EMP_VIEW02;

--뷰 목록 확인
SELECT VIEW_NAME,TEXT FROM USER_VIEWS;

--EMP_VIEW30 뷰에 SAL 컬럼 추가 - 뷰 구조 변경 불가능 : 기존 뷰를 제거하고 뷰를 다시 생성
--CREATE OR REPLACE VIEW 명령으로 기존 뷰를 제거하고 새로운 뷰 생성 - 생성 또는 변경
CREATE OR REPLACE VIEW EMP_VIEW30 AS SELECT EMPNO,ENAME,SAL,DEPTNO FROM EMP_COPY WHERE DEPTNO=30;
SELECT VIEW_NAME,TEXT FROM USER_VIEWS;

--EMP_COPY 테이블에서 부서번호가 10인 사원의 사원번호,사원이름,급여,부서번호를 검색하여 EMP_VIEW10 뷰로 생성
CREATE OR REPLACE VIEW EMP_VIEW10 AS SELECT EMPNO,ENAME,SAL,DEPTNO FROM EMP_COPY WHERE DEPTNO=10; 
SELECT * FROM EMP_VIEW10;

--EMP_VIEW10 뷰에서 사원번호가 7782인 사원의 부서번호를 20으로 변경
UPDATE EMP_VIEW10 SET DEPTNO=20 WHERE EMPNO=7782;
SELECT * FROM EMP_VIEW10;

--롤백 처리
ROLLBACK;
SELECT * FROM EMP_VIEW10;

--EMP_COPY 테이블에서 부서번호가 10인 사원의 사원번호,사원이름,급여,부서번호를 검색하여 EMP_VIEW10 뷰로 생성
-- >> WITH CHECK OPTION 기능 추가
CREATE OR REPLACE VIEW EMP_VIEW10 AS SELECT EMPNO,ENAME,SAL,DEPTNO FROM EMP_COPY WHERE DEPTNO=10 WITH CHECK OPTION; 

--EMP_VIEW10 뷰에서 사원번호가 7782인 사원의 부서번호를 20으로 변경
--WITH CHECK OPTION 기능에 의해 뷰를 생성한 서브쿼리의 조건식에서 사용한 컬럼값을 변경할 경우 에러 발생
UPDATE EMP_VIEW10 SET DEPTNO=20 WHERE EMPNO=7782;

--EMP_COPY 테이블에서 부서번호가 20인 사원의 사원번호,사원이름,급여,부서번호를 검색하여 EMP_VIEW20 뷰로 생성
CREATE OR REPLACE VIEW EMP_VIEW20 AS SELECT EMPNO,ENAME,SAL,DEPTNO FROM EMP_COPY WHERE DEPTNO=20; 
SELECT * FROM EMP_VIEW20;

--EMP_VIEW20 뷰에서 사원번호가 7788인 사원정보를 삭제
DELETE FROM EMP_VIEW20 WHERE EMPNO=7788;
SELECT * FROM EMP_VIEW20;

--롤백 처리
ROLLBACK;
SELECT * FROM EMP_VIEW20;

--EMP_COPY 테이블에서 부서번호가 20인 사원의 사원번호,사원이름,급여,부서번호를 검색하여 EMP_VIEW20 뷰로 생성
-- >> WITH READ ONLY 기능 추가
CREATE OR REPLACE VIEW EMP_VIEW20 AS SELECT EMPNO,ENAME,SAL,DEPTNO FROM EMP_COPY WHERE DEPTNO=20 WITH READ ONLY; 
SELECT * FROM EMP_VIEW20;

--EMP_VIEW20 뷰에서 사원번호가 7788인 사원정보를 삭제
--WITH READ ONLY 기능에 의해 단순뷰에서 행 삽입,변경,삭제 명령을 사용할 경우 에러 발생
DELETE FROM EMP_VIEW20 WHERE EMPNO=7788;

--뷰 삭제 
--형식)DROP VIEW 뷰이름

--뷰 목록 확인
SELECT VIEW_NAME,TEXT FROM USER_VIEWS;

--EMP_VIEW 뷰 삭제
DROP VIEW EMP_VIEW;
SELECT VIEW_NAME,TEXT FROM USER_VIEWS;

--EMP_COPY 테이블 삭제
DROP TABLE EMP_COPY PURGE;
--테이블을 삭제해도 테이블을 기반으로 생성된 뷰는 미삭제
SELECT VIEW_NAME,TEXT FROM USER_VIEWS;

--EMP_VIEW30 뷰 검색 - 삭제된 테이블을 기반으로 생성된 뷰를 사용할 경우 에러 발생
SELECT * FROM EMP_VIEW30;

--ROWNUM : 검색행에 순차적으로 행번호를 제공하는 키워드
SELECT EMPNO,ENAME,SAL FROM EMP;
SELECT ROWNUM,EMPNO,ENAME,SAL FROM EMP;

--EMP 테이블에서 모든 사원의 사원번호,사원이름,급여를 급여로 내림차순 정렬하여 검색
SELECT EMPNO,ENAME,SAL FROM EMP ORDER BY SAL DESC;

--EMP 테이블에서 모든 사원의 사원번호,사원이름,급여를 급여로 내림차순 정렬하여 검색 >> 행번호 검색
--정렬 전에 검색행에 행번호가 제공된 후 정렬되어 검색되므로 순차적이지 않은 행번호 검색
SELECT ROWNUM,EMPNO,ENAME,SAL FROM EMP ORDER BY SAL DESC;

--ROWNUM 키워드 대신 ROW_NUMBER() 순위함수를 이용하여 행번호를 반환받아 검색 - OVER() 분석함수 사용
SELECT ROW_NUMBER() OVER(ORDER BY SAL DESC) NUM,EMPNO,ENAME,SAL FROM EMP;

--EMP 테이블에서 모든 사원의 사원번호,사원이름,급여를 급여로 내림차순 정렬하여 검색하되 행번호를 제공하여  
--검색하고 검색된 행번호가 5보다 작은 행들만 검색
--원도우 함수(그룹함수,순위함수,순서함수 등)를 WHERE 구문에서 사용할 경우 에러 발생
SELECT ROW_NUMBER() OVER(ORDER BY SAL DESC) NUM,EMPNO,ENAME,SAL FROM EMP WHERE ROW_NUMBER() OVER(ORDER BY SAL DESC)<5;
--조건식에서 컬럼의 별칭을 사용할 경우 에러 발생
SELECT ROW_NUMBER() OVER(ORDER BY SAL DESC) NUM,EMPNO,ENAME,SAL FROM EMP WHERE NUM<5;

--EMP 테이블에서 모든 사원의 사원번호,사원이름,급여를 급여로 내림차순 정렬하여 EMP_VIEW 뷰로 생성
CREATE OR REPLACE VIEW EMP_VIEW AS SELECT EMPNO,ENAME,SAL FROM EMP ORDER BY SAL DESC;
SELECT * FROM EMP_VIEW;

--EMP_VIEW 뷰에 행번호를 제공하여 검색
SELECT ROWNUM,EMPNO,ENAME,SAL FROM EMP_VIEW;
--다른 검색대상을 테이블(뷰)의 모든 컬럼과 같이 표현하고자 할 경우 테이블(뷰).* 형식으로 표현 가능
SELECT ROWNUM,EMP_VIEW.* FROM EMP_VIEW;

--EMP_VIEW 뷰에 행번호를 제공하여 검색하되 행번호가 5보다 작은 행들만 검색
-- >> ROWNUM 키워드는 WHERE 구문의 조건식에서 사용 가능
SELECT ROWNUM,EMP_VIEW.* FROM EMP_VIEW WHERE ROWNUM<5;

--인라인 뷰(INLINE VIEW) : SELECT 명령에서 FROM 구문에 서브쿼리를 사용하여 일시적으로 생성되어 사용되는 뷰
SELECT EMPNO,ENAME,SAL FROM EMP;--테이블을 이용하여 검색
SELECT EMPNO,ENAME,SAL FROM (SELECT * FROM EMP);--인라인 뷰를 이용하여 검색
SELECT EMPNO,ENAME,SAL FROM (SELECT * FROM EMP WHERE DEPTNO=10);
--인라인 뷰에 없는 컬럼을 검색할 경우 에러 발생
SELECT EMPNO,ENAME,SAL,DEPTNO FROM (SELECT EMPNO,ENAME,SAL FROM EMP);

--EMP 테이블에서 모든 사원의 사원번호,사원이름,급여를 급여로 내림차순 정렬하여 검색하되 검색행에 행번호를 제공하여 검색 >> 인라인 뷰 사용
SELECT ROWNUM,EMPNO,ENAME,SAL FROM (SELECT EMPNO,ENAME,SAL FROM EMP ORDER BY SAL DESC);

--인라인 뷰에도 별칭을 설정하여 검색 가능 - 인라인 뷰의 별칭을 이용하여 모든 컬럼 표현
SELECT ROWNUM,TEMP.* FROM (SELECT EMPNO,ENAME,SAL FROM EMP ORDER BY SAL DESC) TEMP;

--EMP 테이블에서 모든 사원의 사원번호,사원이름,급여를 급여로 내림차순 정렬하여 검색하되 검색행에 행번호를 제공하여 검색하고 
--행번호가 5보다 작은 행들만 검색
SELECT ROWNUM,TEMP.* FROM (SELECT EMPNO,ENAME,SAL FROM EMP ORDER BY SAL DESC) TEMP WHERE ROWNUM<5;

--EMP 테이블에서 모든 사원의 사원번호,사원이름,급여를 급여로 내림차순 정렬하여 검색하되 검색행에 행번호를 제공하여 검색하고 
--행번호가 10인 행 검색
--WHERE 구문에서 행번호를 조건식에서 사용할 경우 조건식의 연산자가 < 또는 <= 연산자는 사용 가능하지만 나머지 비교 연산자를 사용할 경우
--검색 불가능 - 행번호는 행에 순차적으로 제공되므로 현재 행번호와 같거나 큰 행은 미검색
SELECT ROWNUM,TEMP.* FROM (SELECT EMPNO,ENAME,SAL FROM EMP ORDER BY SAL DESC) TEMP WHERE ROWNUM=10;

--ROWNUM 키워드에 별칭을 사용하여 검색 - 조건식에서 별칭을 사용할 경우 에러 발생
SELECT ROWNUM RN,TEMP.* FROM (SELECT EMPNO,ENAME,SAL FROM EMP ORDER BY SAL DESC) TEMP WHERE RN=10;
 
-- 인라인 뷰를 이용하면 ROWNUM 키워드의 별칭을 조건식에서 사용 가능
SELECT * FROM (SELECT ROWNUM RN,TEMP.* FROM (SELECT EMPNO,ENAME,SAL FROM EMP ORDER BY SAL DESC) TEMP) WHERE RN=10;

--EMP 테이블에서 모든 사원의 사원번호,사원이름,급여를 급여로 내림차순 정렬하여 검색하되 검색행에 행번호를 제공하여 검색하고 
--행번호가 6부터 10 범위의 행들만 검색
SELECT * FROM (SELECT ROWNUM RN,TEMP.* FROM (SELECT EMPNO,ENAME,SAL FROM EMP ORDER BY SAL DESC) TEMP) 
    WHERE RN BETWEEN 6 AND 10;

--EMP 테이블에서 모든 사원의 사원번호,사원이름,검색행 직전행의 사원번호와 사원이름,검색행 직후행의 사원번호와 사원이름를 
--사원번호로 오름차순 정렬하여 검색. 단, 직전행 또는 직후행이 없는 경우 사원번호는 0, 사원이름은 NULL로 검색
SELECT EMPNO,ENAME,LAG(EMPNO,1,0) OVER(ORDER BY SAL) BEFORE_EMPNO,LAG(ENAME,1,NULL) OVER(ORDER BY SAL) BEFORE_ENAME
    ,LEAD(EMPNO,1,0) OVER(ORDER BY SAL) AFTER_EMPNO,LEAD(ENAME,1,NULL) OVER(ORDER BY SAL) AFTER_ENAME FROM EMP;
    
--EMP 테이블에서 사원번호가 7844인 사원의 사원번호,사원이름,검색행 직전행의 사원번호와 사원이름,검색행 직후행의 사원번호와 사원이름를 
--사원번호로 오름차순 정렬하여 검색. 단, 직전행 또는 직후행이 없는 경우 사원번호는 0, 사원이름은 NULL로 검색
--WHERE 구문이 먼저 실행되어 검색되므로 직전행과 직후행이 존재하지 않아 직전행과 직후행의 컬럼값 대신 0과 NULL 검색
SELECT EMPNO,ENAME,LAG(EMPNO,1,0) OVER(ORDER BY SAL) BEFORE_EMPNO,LAG(ENAME,1,NULL) OVER(ORDER BY SAL) BEFORE_ENAME
    ,LEAD(EMPNO,1,0) OVER(ORDER BY SAL) AFTER_EMPNO,LEAD(ENAME,1,NULL) OVER(ORDER BY SAL) AFTER_ENAME FROM EMP WHERE EMPNO=7844;
    
--인라인 뷰를 이용하여 모든 사원을 검색한 후 원하는 행에 대한 검색 결과 제공    
SELECT * FROM (SELECT EMPNO,ENAME,LAG(EMPNO,1,0) OVER(ORDER BY SAL) BEFORE_EMPNO,LAG(ENAME,1,NULL) OVER(ORDER BY SAL) BEFORE_ENAME
    ,LEAD(EMPNO,1,0) OVER(ORDER BY SAL) AFTER_EMPNO,LEAD(ENAME,1,NULL) OVER(ORDER BY SAL) AFTER_ENAME FROM EMP) WHERE EMPNO=7844;

--시퀀스(SEQUENCE) : 숫자값(정수)을 저장하여 자동 증가되는 값을 제공하는 객체

--시퀀스 생성
--형식)CREATE SEQUENCE 시퀀스명 [START WITH 초기값] [INCREMENT BY 증가값] [MAXVALUE 최대값] 
--    [MINVALUE 최소값] [CYCLE] [CACHE 갯수]
--START WITH 초기값 : 시퀀스 객체에 저장된 초기값 설정 - 생략 : NULL
--INCREMENT BY 증가값 : 자동 증가되는 숫자값 설정 - 생략 : 1
--MAXVALUE 최대값 : 시퀀스 객체에 저장할 수 있는 최대값 설정 - 생략 : 숫자값으로 표현될 수 있는 최대값
--MINVALUE 최소값 : 시퀀스 객체에 저장할 수 있는 최소값 설정 - 생략 : 1
--CYCLE : 시퀀스 객체에 저장값이 최대값을 초과한 경우 최소값부터 다시 제공되도록 반복하는 기능 제공
--CACHE 갯수 : 임시 저장공간에 자동 증가값을 미리 생성하여 제공할 수 있는 갯수를 설정하는 기능 제공 - 생략 : 20

--USER2 테이블 생성 : 번호(숫자형-PRIMARY KEY),이름(문자형),생년월일(날짜형)
CREATE TABLE USER2(NO NUMBER(2) PRIMARY KEY, NAME VARCHAR2(20),BIRTHDAY DATE);
DESC USER2;

--USER2 테이블의 NO 컬럼값으로 저장될 자동 증가값을 제공하기 위한 시퀀스 객체 생성
CREATE SEQUENCE USER2_SEQ;

--시퀸스 확인 - USER_SEQUENCES : 시퀀스 정보를 제공하는 딕셔너리
SELECT SEQUENCE_NAME,MAX_VALUE,MIN_VALUE,INCREMENT_BY FROM USER_SEQUENCES;

--시퀀스에 저장된 숫자값 확인 - 형식)시퀀스명.CURRVAL
--시퀀스에 NULL이 저장된 경우 숫자값을 확인하면 에러 발생
SELECT USER2_SEQ.CURRVAL FROM DUAL;

--시퀀스를 이용한 자동 증가값 제공 - 형식)시퀀스명.NEXTVAL
--시퀸스에 NULL이 저장된 경우 시퀸스의 최소값을 제공하고 시퀀스는 제공된 숫자값으로 자동 변경
--시퀀스에 숫자값이 저장된 경우 증가값만큼 더해진 숫자값을 제공하고 시퀀스는 제공된 숫자값으로 자동 변경
SELECT USER2_SEQ.NEXTVAL FROM DUAL;-- 1(최소값)이 검색되고 시퀸스의 숫자값 변경
SELECT USER2_SEQ.CURRVAL FROM DUAL;--시퀸스 현재값 : 1
SELECT USER2_SEQ.NEXTVAL FROM DUAL;--증가값 : 1 - 2가 검색되고 시퀸스의 숫자값 변경
SELECT USER2_SEQ.CURRVAL FROM DUAL;--시퀸스 현재값 : 2

--USER2 테이블에 행 삽입 - 시퀸스의 자동 증가값을 NO 컬럼에 전달하여 저장
INSERT INTO USER2 VALUES(USER2_SEQ.NEXTVAL,'홍길동','00/01/01');
INSERT INTO USER2 VALUES(USER2_SEQ.NEXTVAL,'임꺽정','01/12/31');
INSERT INTO USER2 VALUES(USER2_SEQ.NEXTVAL,'전우치','02/12/21');
SELECT * FROM USER2;
COMMIT;

--시퀀스 변경
--형식)ALTER SEQUENCE 시퀸스명 {MAXVALUE|MINVALUE|INCREMENT BY} 변경값

--USER2_SEQ 시퀸스의 최대값을 99,증가값을 5로 변경
SELECT SEQUENCE_NAME,MAX_VALUE,MIN_VALUE,INCREMENT_BY FROM USER_SEQUENCES;
ALTER SEQUENCE USER2_SEQ MAXVALUE 99 INCREMENT BY 5;
SELECT SEQUENCE_NAME,MAX_VALUE,MIN_VALUE,INCREMENT_BY FROM USER_SEQUENCES;

--USER2 테이블에 행 삽입 - 시퀸스의 자동 증가값을 NO 컬럼에 전달하여 저장
INSERT INTO USER2 VALUES(USER2_SEQ.NEXTVAL,'일지매','03/09/09');
SELECT * FROM USER2;
COMMIT;

--시퀀스 삭제
--형식)DROP SEQUENCE 시퀀스명

--USER2_SEQ 시퀸스 삭제
SELECT SEQUENCE_NAME,MAX_VALUE,MIN_VALUE,INCREMENT_BY FROM USER_SEQUENCES;
DROP SEQUENCE USER2_SEQ;
SELECT SEQUENCE_NAME,MAX_VALUE,MIN_VALUE,INCREMENT_BY FROM USER_SEQUENCES;

--인덱스(INDEX) : 테이블에 저장된 행을 보다 빠르게 검색하기 위한 기능을 제공하는 객체
--컬럼에 인덱스를 설정하면 인덱스 영역을 생성하여 컬럼에 대한 행 검색 속도 증가
--조건식에서 많이 사용되는 컬럼에 설정하며 행이 많을 때 설정하는 것이 효율적

--유니크 인덱스(UNIQUE INDEX) : PRIMARY KEY 또는 UNIQUE 제약조건에 의해 자동으로 생성되는 인덱스
--비유니크 인덱스(NON-UNIQUE INDEX) : 사용자가 수동으로 테이블 컬럼에 생성하는 인덱스

--USER3 테이블 생성 : 번호(숫자형-PRIMARY KEY),이름(문자형),이메일(문자형-UNIQUE)
CREATE TABLE USER3(NO NUMBER(2) CONSTRAINT USER3_NO_PK PRIMARY KEY, NAME VARCHAR2(20)
    ,EMAIL VARCHAR2(50) CONSTRAINT USER3_EMAIL_UK UNIQUE);
    
--제약조건 확인   
SELECT CONSTRAINT_NAME,CONSTRAINT_TYPE FROM USER_CONSTRAINTS WHERE TABLE_NAME='USER3';
 
--인덱스 확인 - USER_INDEXES : 인덱스 정보를 제공하는 딕셔너리, USER_IND_COLUMNS : 컬럼 인덱스 정보를 제공하는 딕셔너리  
SELECT C.INDEX_NAME,COLUMN_NAME,UNIQUENESS,INDEX_TYPE FROM USER_INDEXES I JOIN USER_IND_COLUMNS C 
    ON I.INDEX_NAME=C.INDEX_NAME WHERE C.TABLE_NAME='USER3'; 
    
--인덱스(NON-UNIQUE INDEX) 생성    
--형식)CREATE INDEX 인덱스명 ON 테이블명(컬럼명)
--저장행이 많은 테이블의 조건식에서 많이 사용되는 컬럼에 설정
--검색결과가 저장행의 2~4%인 경우 또는 조인조건으로 사용되는 컬럼, NULL이 많이 저장된 컬럼에 설정하는 것을 권장

--USER3 테이블의 NAME 컬럼에 인덱스를 생성하여 설정
CREATE INDEX USER3_NAME_INDEX ON USER3(NAME);

--인덱스 확인
SELECT C.INDEX_NAME,COLUMN_NAME,UNIQUENESS,INDEX_TYPE FROM USER_INDEXES I JOIN USER_IND_COLUMNS C 
    ON I.INDEX_NAME=C.INDEX_NAME WHERE C.TABLE_NAME='USER3'; 

--인덱스(NON-UNIQUE INDEX) 삭제
--형식)DROP INDEX 인덱스명
--UNIQUNE INDEX는 제약조건을 삭제하면 자동으로 삭제 처리

--USER3 테이블의 EMAIL 컬럼에 설정된 인덱스 삭제 - UNIQUE 제약조건 삭제
ALTER TABLE USER3 DROP CONSTRAINT USER3_EMAIL_UK;

--제약조건 및 인덱스 확인
SELECT CONSTRAINT_NAME,CONSTRAINT_TYPE FROM USER_CONSTRAINTS WHERE TABLE_NAME='USER3';
SELECT C.INDEX_NAME,COLUMN_NAME,UNIQUENESS,INDEX_TYPE FROM USER_INDEXES I JOIN USER_IND_COLUMNS C 
    ON I.INDEX_NAME=C.INDEX_NAME WHERE C.TABLE_NAME='USER3'; 

--USER3 테이블의 NAME 컬럼에 설정된 인덱스 삭제
DROP INDEX USER3_NAME_INDEX;
SELECT C.INDEX_NAME,COLUMN_NAME,UNIQUENESS,INDEX_TYPE FROM USER_INDEXES I JOIN USER_IND_COLUMNS C 
    ON I.INDEX_NAME=C.INDEX_NAME WHERE C.TABLE_NAME='USER3'; 

--동의어(SYNONYM) : 오라클 객체에 별명을 부여하여 사용하는 객체
--전용 동의어 : 특정 사용자만 사용할 수 있는 동의어 - 일반 사용자 관리
--공용 동의어 : 모든 사용자가 사용할 수 있는 동의어 - 관리자 관리

--동의어 생성
--형식)CREATE [PUBLIC] SYNONYM 동의어 FOR 객체명
--PUBLIC : 공용 동의어를 생성하기 위한 키워드

--테이블 목록 확인 - SYS.USER_TABLES : SYS 사용자 스키마에 존재하는 USER_TABLES 뷰를 이용하여 확인
SELECT TABLE_NAME FROM SYS.USER_TABLES;
SELECT TABLE_NAME FROM USER_TABLES;--SYS.USER_TABLES 객체의 공용 동의어 : USER_TABLES
SELECT TABLE_NAME FROM TABS;--SYS.USER_TABLES 객체의 공용 동의어 : TABS

--EMP 테이블에서 성과급이 NULL이 아닌 사원의 사원이름,업무,급여,성과급을 검색하여 COMM 테이블에 삭입
DESC COMM;
SELECT * FROM COMM;
INSERT INTO COMM SELECT ENAME,JOB,SAL,COMM FROM EMP WHERE COMM IS NOT NULL;
SELECT * FROM COMM;
COMMIT;

--COMM 테이블에 대한 동의어로 BONUS 생성
--현재 접속자에게 동의어에 대한 시스템 권한이 없으면 에러 발생 - 관리자에게 동의어에 대한 시스템 권한 요청
CREATE SYNONYM BONUS FOR COMM;

--시스템 관리자(SYS 또는 SYSTEM)로 접속하여 일반 사용자(SCOTT)에게 동의어에 대한 시스템 권한 부여
--GRANT CREATE SYNONYM TO SCOTT;

--관리자로부터 동의어에 대한 시스템 권한을 부여 받은 후 동의어 관련 명령 사용 가능
CREATE SYNONYM BONUS FOR COMM;
SELECT * FROM COMM;
SELECT * FROM BONUS;

--동의어 확인 - USER_SYNONYMS : 동의어 관련 정보를 제공하는 딕셔너리
SELECT TABLE_NAME,SYNONYM_NAME,TABLE_OWNER FROM USER_SYNONYMS WHERE TABLE_NAME='COMM';

--공용 동의어 생성 : 관리자가 생성하여 모든 사용자에게 제공하는 동의어
--시스템 관리자로 접속된 세션에서 작업
--오라클 객체는 사용자의 외부 스키마(SCHEMA)를 이용하여 표현 - 형식)스키마명.객체명
--외부 스키마가 생략된 경우 현재 사용자의 외부 스키마를 이용하여 객체 표현
--SELECT EMPNO,ENAME,SAL FROM SCOTT.EMP;

--SCOTT 사용자의 외부 스키마에 존재하는 EMP 테이블에 대한 공용 동의어로 SCOTT_EMP 생성
--CREATE PUBLIC SYNONYM SCOTT_EMP FOR SCOTT.EMP;
--SELECT EMPNO,ENAME,SAL FROM SCOTT_EMP;

--공용 동의어는 모든 사용자가 사용 가능
SELECT EMPNO,ENAME,SAL FROM SCOTT_EMP;

--대표적인 공용 동의어 : DUAL 또는 딕셔너리
SELECT SYSDATE FROM SYS.DUAL;
SELECT SYSDATE FROM DUAL;
SELECT OWNER,TABLE_NAME,SYNONYM_NAME,TABLE_OWNER FROM ALL_SYNONYMS WHERE TABLE_NAME='DUAL';

SELECT TABLE_NAME FROM SYS.USER_TABLES;
SELECT TABLE_NAME FROM USER_TABLES;
SELECT TABLE_NAME FROM TABS;
SELECT OWNER,TABLE_NAME,SYNONYM_NAME,TABLE_OWNER FROM ALL_SYNONYMS WHERE TABLE_NAME='USER_TABLES';

--동의어 삭제
--형식)DROP [PUBLIC] SYNONYM 동의어

--SCOTT_EMP 공용 동의어 삭제 >> 관리자
--DROP PUBLIC SYNONYM SCOTT_EMP;
SELECT OWNER,TABLE_NAME,SYNONYM_NAME,TABLE_OWNER FROM ALL_SYNONYMS WHERE TABLE_NAME='EMP';
SELECT * FROM SCOTT_EMP;--에러 발생

--현재 사용자의 BONUS 전용 동의어 삭제
SELECT OWNER,TABLE_NAME,SYNONYM_NAME,TABLE_OWNER FROM ALL_SYNONYMS WHERE TABLE_NAME='COMM';
DROP SYNONYM BONUS;
SELECT OWNER,TABLE_NAME,SYNONYM_NAME,TABLE_OWNER FROM ALL_SYNONYMS WHERE TABLE_NAME='COMM';
SELECT * FROM BONUS;--에러 발생