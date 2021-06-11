--사용자(USER) : DBMS 서버에 접속하여 사용할 수 있는 허락받은 사용자 - 계정(ACCOUNT)
--계정 관리는 관리자(SYS 또는 SYSTEM)만 가능

--계정 생성
--형식)CREATE USER 계정명 IDENTIFIED BY 비밀번호

--KIM 계정 생성 - 관리자 접속 세션
--CREATE USER KIM IDENTIFIED BY 1234;

--계정 확인 - DBA_USERS : 사용자 정보를 제공하는 딕셔너리
--SELECT USERNAME,ACCOUNT_STATUS,DEFAULT_TABLESPACE,CREATED FROM DBA_USERS WHERE USERNAME='KIM';

--계정의 비밀번호 변경 - 계정의 비밀번호는 기본적으로 180일의 유효기간으로 설정
--형식)ALTER USER 사용자명 IDENTIFIED BY 비밀번호

--KIM 계정의 비밀번호 변경 - 관리자 접속 세션
--ALTER USER KIM IDENTIFIED BY 5678;

--계정 상태 변경 : OPEN(계정 활성화 - 접속 가능) 또는 LOCK(계정 비활성 - 접속 불가능)
--오라클 접속시 계정의 비밀번호를 5번 틀리면 계정 상태가 자동으로 LOCK 상태로 변경되어 접속 불가능
--형식)ALTER USER 계정명 ACCOUNT {LOCK|UNLOCK}

--KIM 계정의 OPEN 상태를 LOCK 상태로 변경 - 관리자 접속 세션
--SELECT USERNAME,ACCOUNT_STATUS,DEFAULT_TABLESPACE,CREATED FROM DBA_USERS WHERE USERNAME='KIM';
--ALTER USER KIM ACCOUNT LOCK;
--SELECT USERNAME,ACCOUNT_STATUS,DEFAULT_TABLESPACE,CREATED FROM DBA_USERS WHERE USERNAME='KIM';

--KIM 계정의 LOCK 상태를 OPNE 상태로 변경 - 관리자 접속 세션
--ALTER USER KIM ACCOUNT UNLOCK;
--SELECT USERNAME,ACCOUNT_STATUS,DEFAULT_TABLESPACE,CREATED FROM DBA_USERS WHERE USERNAME='KIM';

--계정의 기본 테이블스페이스 변경
--테이블스페이스(TABLESPACE) : 데이타베이스 객체(테이블,시퀀스,인덱스 등)가 저장되는 영역
-- >> 시스템 테이블스페이스(SYSTEM - 기본)와 사용자 테이블스페이스(USERS)
--형식)ALTER USER 계정명 DEFAULT TABLESPACE 테이블스페이스명

--KIM 계정의 기본 테이블스페이스를 SYSTEM에서 USERS로 변경 - 관리자 접속 세션
--SELECT USERNAME,ACCOUNT_STATUS,DEFAULT_TABLESPACE,CREATED FROM DBA_USERS WHERE USERNAME='KIM';
--ALTER USER KIM DEFAULT TABLESPACE USERS;
--SELECT USERNAME,ACCOUNT_STATUS,DEFAULT_TABLESPACE,CREATED FROM DBA_USERS WHERE USERNAME='KIM';

--계정에 대한 테이블스페이스의 물리적 저장 크기의 대한 제한 변경
--형식)ALTER USER 계정명 QUOTA 제한크기 ON 테이블스페이스명

--KIM 계정의 물리적 저장크기를 무제한으로 변경 - 관리자 접속 세션
--ALTER USER KIM QUOTA UNLIMITED ON USERS;

--계정의 제한 용량 확인 - DBA_TS_QUOTAS : 사용자의 테이블스페이스 제한 용량에 대한 정보를 제공하는 딕셔너리
--SELECT TABLESPACE_NAME,USERNAME,MAX_BYTES FROM DBA_TS_QUOTAS WHERE USERNAME='KIM';

--계정 삭제
--형식)DROP USER 계정명

--KIM 계정 삭제 - 관리자 접속 세션
--DROP USER KIM;
--SELECT USERNAME,ACCOUNT_STATUS,DEFAULT_TABLESPACE,CREATED FROM DBA_USERS WHERE USERNAME='KIM';

--DCL(DATA CONTROL LANGUAGE) - 데이타 제어어
--계정에게 권한을 부여하거나 회수하는 명령
--오라클 권한(PRIVILEGE) : 시스템 권한(관리자) 또는 객체 권한(일반 사용자)
--롤(ROLE) : 시스템 권한을 그룹화하여 표현한 명칭

--시스템 권한 부여
--형식)GRANT {PRIVILEGE|ROLE},{PRIVILEGE|ROLE},... TO 계정명 [WITH ADMIN OPTION] [IDENTIFIED BY 비밀번호]
--계정명 대신 PUBLIC 키워드를 사용할 경우 모든 사용자에게 일괄적으로 시스템 권한 부여
--권한을 부여할 계정이 없는 경우 계정 자동 생성
--계정이 자동으로 생성될 경우 반드시 IDENTIFIED BY 구문으로 비밀번호 설정
--WITH ADMIN OPTION : 부여 받은 시스템 권한을 다른 사용자에게 부여하거나 회수하는 기능 제공

--KIM 계정 생성 - 관리자 접속 세션
--CREATE USER KIM IDENTIFIED BY 1234;

--KIM 계정으로 DBMS 서버 접속 - SQLPLUS 사용 : 접속 불가능
--SQL> CONN KIM/1234
-- >> KIM 계정에게 CREATE SESSION 시스템 권한이 없어서 접속 거부

--관리자가 KIM 계정에게 CREATE SESSION 시스템 권한 부여 - 관리자 접속 세션
--GRANT CREATE SESSION TO KIM;

--CREATE SESSION 시스템 권한 부여 후 KIM 계정으로 DBMS 서버 접속 - SQLPLUS : 접속 가능
--SQL> CONN KIM/1234
--SQL> SHOW USER

--KIM 계정으로 SAWON 테이블 생성 : 사원번호(숫자형-PRIMARY KEY),사원이름(문자형),급여(숫자형) - SQLPLUS 사용 : 생성 불가능
--SQL>CREATE TABLE SAWON(NO NUMBER(4) PRIMARY KEY,NAME VARCHAR2(2),PAY NUMBER);
-- >> KIM 계정에게 CREATE TABLE 시스템 권한이 없어서 테이블 관련 명령 사용시 에러 발생

--관리자가 KIM 계정에게 CREATE TABLE 시스템 권한 부여 - 관리자 접속 세션
--GRANT CREATE TABLE TO KIM;
--관리자가 KIM 계정의 기본 테이블스페이와 제한 용량 변경 - 관리자 접속 세션
--ALTER USER KIM DEFAULT TABLESPACE USERS;
--ALTER USER KIM QUOTA 50M ON USERS;

--KIM 계정이 CREATE TABLE 시스템 권한 부여 및 계정의 테이블스페이스 변경 후 SAWON 테이블 생성 - SQLPLUS 사용 : 생성 가능
--SQL>CREATE TABLE SAWON(NO NUMBER(4) PRIMARY KEY,NAME VARCHAR2(2),PAY NUMBER);

--객체 권한 : 사용자의 외부 스키마에 있는 객체 명령 사용 권한
--INSERT,UPDATE,DELETE,SELECT 등의 명령과 관련된 명령
--형식)GRANT {ALL|PRIVILEGE,PRIVILEGE,...} ON 객체명 TO 계정명 [WITH GRANT OPTION]
--ALL : 객체와 관련된 모든 명령 사용 권한 표현
--WITH GRANT OPTION : 부여받은 객체권한을 다른 계정에게 부여하거나 회수할 수 있는 기능 제공

--DEPT 테이블의 모든 부서정보 검색 - 사용자의 외부 스키마로 객체를 표현
SELECT * FROM SCOTT.DEPT;
--접속 사용자의 외부 스키마에 존재하는 객체인 경우 스키마명 생략 가능
SELECT * FROM DEPT;

--KIM 계정이 SCOTT 스키마의 존재하는 DEPT 테이블의 모든 부서정보 검색 -SQLPLUS 사용 : 검색 불가능
-- >> SCOTT 스키마에 있는 DEPT 테이블에 대한 SELECT 명령 사용 권한이 없으므로 에러 발생
--SQL>SELECT * FROM SCOTT.DEPT;

--SCOTT 계정이 KIM 계정에게 SCOTT 스키마에 있는 DEPT 테이블에 대한 SELECT 명령 권한 부여
GRANT SELECT ON DEPT TO KIM;

--KIM 계정이 객체 권한을 부여받은 후 SCOTT 스키마의 존재하는 DEPT 테이블의 모든 부서정보 검색 -SQLPLUS 사용 : 검색 가능
--SQL>SELECT * FROM SCOTT.DEPT;

--다른 계정에게 부여한 객체 권한 확인 - USER_TAB_PRIVS_MADE : 객체 권한을 부여한 정보를 제공하는 딕셔너리
SELECT * FROM USER_TAB_PRIVS_MADE;

--다른 계정이 제공한 객체 권한 확인 - USER_TAB_PRIVS_RECD : 객체 권한을 부여 받은 정보를 제공하는 딕셔너리
SELECT * FROM USER_TAB_PRIVS_RECD;

--시스템 권한 회수 : 계정에게 부여한 모든 시스템 권한을 회수해도 계정 미삭제
--형식)REVOKE {PRIVILEGE|ROLE},{PRIVILEGE|ROLE},... FROM 계정명 [WITH ADMIN OPTION]

--객체 권한 회수
--형식)REVOKE {ALL|PRIVILEGE,PRIVILEGE,...} ON 객체명 FROM 계정명 [WITH GRANT OPTION]

--SOCTT 계정이 KIM 계정에게 부여한 DEPT 테이블에 대한 SELECT 명령 사용 권한 회수
REVOKE SELECT ON DEPT FROM KIM;
SELECT * FROM USER_TAB_PRIVS_MADE;

--관리자가 KIM 계정에게 부여한 CREATE SESSION 시스템 권한 회수 - 관리자 접속 세션
--REVOKE CREATE SESSION FROM KIM;

--롤(ROLE) : 관리자가 계정의 시스템 권하는 보다 효율적으로 부여하거나 회수하기 위해 사용하는 시스템 권한 그룹
--오라클에서는 기본적으로 제공되는 롤 존재
--CONNECT : 8개의 시스템 권한 그룹 - CREATE SESSION,CREATE TABLE,ALTER SESSION,CREATE SYNONYM 등
--RESOURCE : 객체 관련 시스템 권한 그룹 - CREATE TABLE,CREATE SEQUENCE, CREATE TRIGGER 등
--DBA : 시스템 관리에 필요한 모든 시스템 권한 그룹 - 관리자 생성 관련 롤

--관리자가 LEE 계정에게 CONNECT와 RESOURCE 롤 부여 - 관리자 접속 세션
--LEE 계정이 없는 경우 시스템 권한 부여시 계정 자동 생성 : 비밀번호 설정
--GRANT CONNECT,RESOURCE TO LEE IDENTIFIED BY 5678;

--LEE 계정으로 DBMS 서버에 접속하여 SAWON 테이블 생성 : 사원번호(숫자형-PRIMARY KEY),사원이름(문자형),급여(숫자형) - SQLPLUS 사용
--SQL>CONN LEE/5678
--SQL>CREATE TABLE SAWON(NO NUMBER(4) PRIMARY KEY,NAME VARCHAR2(2),PAY NUMBER);

--관리자가 LEE 계정에게 부여한 CONNECT와 RESOURCE 롤 회수
--REVOKE CONNECT,RESOURCE FROM LEE;

--PL/SQL(PROCEDUARAL LANGUAGE EXTENSION TO SQL) : SQL에 없는 변수 선언,선택 처리,반복 처리 기능을 제공하는 언어

--세부분의 영역으로 구분하여 PL/SQL 작성
--1.DECLARE 영역(선언부) : DECLARE - 선택
--2.EXECUTABLE 영역(실행부) : BEGIN - 필수
--3.EXCEPTION 영역(예외처리부) : EXCEPTION - 선택

--영역에서 하나의 명령을 구분하기 위해 ; 사용
--마지막 영역은 END 키워드로 마무리 후 ; 사용
--PL/SQL 실행을 위해 마지막에 /를 사용

--메세지를 출력할 수 있도록 세션의 환경변수 설정값 변경
SET SERVEROUT ON;

--메세지를 출력하는 함수 : PL/SQL 실행부에서 호출하여 사용
--형식)DBMS_OUTPUT.PUT_LINE(출력메세지)

--간단한 메세지를 출력하는 PL/SQL 작성
BEGIN
    DBMS_OUTPUT.PUT_LINE('HELLO, ORACLE!!!');
END;
/

--변수 선언과 초기값 입력 - 선언부
--형식)변수명 [CONSTANT] 자료형 [NOT NULL] [{:=|DEFAULT} 표현식]
--CONSTANT : 변수에 저장된 초기값을 변경하지 못하도록 설정하는 키워드 - 상수 선언
--NOT NULL : 변수에 NULL 저장 불가능
--:= : 대입연산자
--표현식 : 변수에 저장되는 값에 대한 표현 방법 - 값,변수(저장값),연산식(결과값),함수(반환값)

--선언된 변수의 저장값 저장 - 실행부
--형식)변수명 := 표현식

--스칼라 변수 : 직접 오라클 자료형을 이용하여 변수 선언

--스칼라 변수를 선언하여 값을 저장하고 화면에 변수값을 출력하는 PL/SQL 작성
DECLARE
    VEMPNO NUMBER(4) := 7788;
    VENAME VARCHAR2(20) := 'SCOTT';
BEGIN
    DBMS_OUTPUT.PUT_LINE('사원번호 / 사원아름');
    DBMS_OUTPUT.PUT_LINE('--------------------------------');
    DBMS_OUTPUT.PUT_LINE(VEMPNO||' / '||VENAME);
    DBMS_OUTPUT.PUT_LINE('--------------------------------');
    VEMPNO := 7893;
    VENAME := 'KING';
    DBMS_OUTPUT.PUT_LINE(VEMPNO||' / '||VENAME);
END;
/

--레퍼런스 변수 : 다른 변수의 자료형 또는 테이블의 컬럼 자료형을 이용하여 변수 선언 - 선언부
--형식)변수명 {변수명%TYPE|테이블명.컬럼명%TYPE}

--테이블 검색행의 컬럼값을 변수에 저장하는 명령 - 실행부
--형식)SELECT 검색대상,검색대상,... INTO 변수명,변수명,... FROM 테이블명 [WHERE 조건식] 
-- >> 검색대상과 변수의 자료형 및 갯수가 반드시 동일

--EMP 테이블의 EMPNO 컬럼과 ENAME 컬럼의 자료형을 이용하여 레퍼런스 변수를 선언하고 EMP 테이블에서 사원이름이
--SCOTT인 사원의 사원번호,사원이름을 검색하여 레퍼런스 변수에 저장 후 출력하는 PL/SQL 작성
DECLARE
    VEMPNO EMP.EMPNO%TYPE;
    VENAME EMP.ENAME%TYPE;
BEGIN
    SELECT EMPNO,ENAME INTO VEMPNO,VENAME FROM EMP WHERE ENAME='SCOTT';
    DBMS_OUTPUT.PUT_LINE('사원번호 / 사원아름');
    DBMS_OUTPUT.PUT_LINE('--------------------------------');
    DBMS_OUTPUT.PUT_LINE(VEMPNO||' / '||VENAME);
END;
/

--테이블 변수 : 테이블의 다중 검색행에 대한 컬럼값을 저장하기 위한 변수 - 배열
--형식)테이블변수명 테이블타입명
--테이블 변수를 선언하기 전에 테이블 변수에 대한 자료형(테이블 타입) 선언
--형식)TYPE 테이블타입명 IS TABLE OF {자료형|변수명%TYPE|테이블명.컬럼명%TYPE} [NOT NULL] [INDEX BY BINARY_INTEGER]

--테이블 변수 사용방법 : 테이블 변수의 요소는 첨자를 이용하여 표현 - 첨자는 1부터 1씩 증가되는 숫자값으로 표현
--형식)테이블변수(첨자)
    
--EMP 테이블의 EMPNO 컬럼과 ENAME 컬럼의 자료형을 이용하여 테이블 변수를 선언하고 EMP 테이블에서 모든
--사원의 사원번호,사원이름을 검색하여 테이블 변수에 저장 후 출력하는 PL/SQL 작성
DECLARE
    /* 테이블 타입 선언 */
    TYPE EMPNO_TABLE_TYPE IS TABLE OF EMP.EMPNO%TYPE INDEX BY BINARY_INTEGER;
    TYPE ENAME_TABLE_TYPE IS TABLE OF EMP.ENAME%TYPE INDEX BY BINARY_INTEGER;
    
    /* 테이블 변수 선언 */
    VEMPNO_TABLE EMPNO_TABLE_TYPE;
    VENAME_TABLE ENAME_TABLE_TYPE;
    
    /* 테이블 변수의 첨자 역활을 하기 위한 변수 선언 - 초기값 저장 */
    I BINARY_INTEGER := 0;
BEGIN
    /* EMP 테이블의 모든 사원의 사원번호,사원이름을 검색하여 테이블 변수의 요소에 차례대로 저장하도록 반복 처리 */
    FOR K IN (SELECT EMPNO,ENAME FROM EMP) LOOP
        I := I + 1;
        VEMPNO_TABLE(I) := K.EMPNO;
        VENAME_TABLE(I) := K.ENAME;
    END LOOP;
    
    DBMS_OUTPUT.PUT_LINE('사원번호 / 사원아름');
    DBMS_OUTPUT.PUT_LINE('--------------------------------');   
    /* 테이블 변수의 요소값을 화면에 출력되도록 반복 처리 */
    FOR J IN 1..I LOOP
        DBMS_OUTPUT.PUT_LINE(VEMPNO_TABLE(J)||' / '||VENAME_TABLE(J));
    END LOOP;
END;
/

--레코드 변수 : 테이블 행의 모든 컬럼값을 저장하기 위한 변수 - VO 클래스 
--형식)레코드변수 레코드타입명
--레코드 변수를 선언하기 전에 레코드 변수에 대한 자료형(레코드 타입) 선언
--형식)TYPE 레코드타입명 IS RECORD(필드명 {자료형|변수명%TYPE|테이블명.컬럼명%TYPE} [NOT NULL] [{:=|DEFAULT} 표현식]
--     ,필드명 {자료형|변수명%TYPE|테이블명.컬럼명%TYPE} [NOT NULL] [{:=|DEFAULT} 표현식],...)

--레코드 변수 사용 방법
--형식)레코드변수.필드명

--EMP 테이블의 사원번호,사원이름,업무,급여,부서번호를 저장할 수 있는 레코드 변수를 선언하고 EMP 테이블에서 사원번호가 
--7844인 사원의 사원번호,사원이름,업무,급여,부서번호를 검색하여 레코드 변수에 저장 후 화면에 출력하는 PL/SQL 작성
DECLARE
    /* 레코드 타입 선언 */
    TYPE EMP_RECORD_TYPE IS RECORD(VEMPNO EMP.EMPNO%TYPE,VENAME EMP.ENAME%TYPE,VJOB EMP.JOB%TYPE
        ,VSAL EMP.SAL%TYPE,VDEPTNO EMP.DEPTNO%TYPE);

    /* 레코드 변수 선언 */
    EMP_RECORD EMP_RECORD_TYPE;
BEGIN
    /* 검색행의 컬럼값을 레코드 변수의 필드에 저장 */
    SELECT EMPNO,ENAME,JOB,SAL,DEPTNO INTO EMP_RECORD.VEMPNO,EMP_RECORD.VENAME,EMP_RECORD.VJOB,
        EMP_RECORD.VSAL,EMP_RECORD.VDEPTNO FROM EMP WHERE EMPNO=7844;

    DBMS_OUTPUT.PUT_LINE('사원번호 = '||EMP_RECORD.VEMPNO);
    DBMS_OUTPUT.PUT_LINE('사원이름 = '||EMP_RECORD.VENAME);
    DBMS_OUTPUT.PUT_LINE('업무 = '||EMP_RECORD.VJOB);
    DBMS_OUTPUT.PUT_LINE('급여 = '||EMP_RECORD.VSAL);
    DBMS_OUTPUT.PUT_LINE('부서번호 = '||EMP_RECORD.VDEPTNO);
END;
/

--레코드 타입 없이 테이블의 행을 이용하여 래코드 변수 선언 가능 
-- >> 레코드 변수의 필드명과 자료형은  테이블의 컬럼명과 자료형을 이용하여 생성
--형식)레코드변수 테이블명%ROWTYPE

--EMP 테이블의 사원번호,사원이름,업무,급여,부서번호를 저장할 수 있는 레코드 변수를 선언하고 EMP 테이블에서 사원번호가 
--7844인 사원의 사원번호,사원이름,업무,급여,부서번호를 검색하여 레코드 변수에 저장 후 화면에 출력하는 PL/SQL 작성
DECLARE
    EMP_RECORD EMP%ROWTYPE;
BEGIN
    /* 검색행(단일행)의 모든 컬럼값을 레코드 변수의 동일 이름의 필드에 자동 저장 */
    SELECT * INTO EMP_RECORD FROM EMP WHERE EMPNO=7844;
    
    DBMS_OUTPUT.PUT_LINE('사원번호 = '||EMP_RECORD.EMPNO);
    DBMS_OUTPUT.PUT_LINE('사원이름 = '||EMP_RECORD.ENAME);
    DBMS_OUTPUT.PUT_LINE('업무 = '||EMP_RECORD.JOB);
    DBMS_OUTPUT.PUT_LINE('급여 = '||EMP_RECORD.SAL);
    DBMS_OUTPUT.PUT_LINE('부서번호 = '||EMP_RECORD.DEPTNO);
END;
/
    
--선택문 : 명령을 선택하여 실행하기 위한 구문
--IF : 조건식에 의해 명령을 선택 실행
--형식)IF(조건식) THEN 명령;명령;... END IF;
-- >> ( )를 생략하여 조건식 작성 가능

--EMP 테이블에서 사원번호가 7788인 사원을 검색하여 사원번호,사원이름,부서번호에 대한 부서이름을 출력하는 PL/SQL 작성
--부서번호에 대한 부서이름 : 10(ACCOUNTING),20(RESEARCH),30(SALES),40(OPERATION)
DECLARE
    VEMP EMP%ROWTYPE;
    VDNAME VARCHAR2(20) := NULL;
BEGIN
    SELECT * INTO VEMP FROM EMP WHERE EMPNO=7788;
    
    IF(VEMP.DEPTNO = 10) THEN
        VDNAME := 'ACCOUNTING';
    END IF;
    
    IF(VEMP.DEPTNO = 20) THEN
        VDNAME := 'RESEARCH';
    END IF;
    
    IF(VEMP.DEPTNO = 30) THEN
        VDNAME := 'SALES';
    END IF;
    
    IF(VEMP.DEPTNO = 40) THEN
        VDNAME := 'OPERATION';
    END IF;

    DBMS_OUTPUT.PUT_LINE('사원번호 = '||VEMP.EMPNO);
    DBMS_OUTPUT.PUT_LINE('사원이름 = '||VEMP.ENAME);
    DBMS_OUTPUT.PUT_LINE('부서이름 = '||VDNAME);
END;
/

--형식)IF(조건식) THEN 명령;명령;... ELSE 명령;명령;... END IF;

--EMP 테이블에서 사원번호가 7788인 사원을 검색하여 사원번호,사원이름,연봉을 출력하는 PL/SQL 작성
--연봉 : (급여+성과급)*12
DECLARE
    VEMP EMP%ROWTYPE;
    ANNUAL NUMBER(7,2) := 0;
BEGIN
    SELECT * INTO VEMP FROM EMP WHERE EMPNO=7788;
    
    IF VEMP.COMM IS NULL THEN 
        ANNUAL := VEMP.SAL * 12;
    ELSE    
        ANNUAL := (VEMP.SAL + VEMP.COMM) * 12;
    END IF;    
        
    DBMS_OUTPUT.PUT_LINE('사원번호 = '||VEMP.EMPNO);
    DBMS_OUTPUT.PUT_LINE('사원이름 = '||VEMP.ENAME);
    DBMS_OUTPUT.PUT_LINE('연봉 = '||ANNUAL);
END;
/

--형식)IF(조건식) THEN 명령;명령;... ELSIF(조건식) THEN 명령;명령;... [ELSE 명령;...] END IF;

--EMP 테이블에서 사원번호가 7788인 사원을 검색하여 사원번호,사원이름,부서번호에 대한 부서이름을 출력하는 PL/SQL 작성
--부서번호에 대한 부서이름 : 10(ACCOUNTING),20(RESEARCH),30(SALES),40(OPERATION)
DECLARE
    VEMP EMP%ROWTYPE;
    VDNAME VARCHAR2(20) := NULL;
BEGIN
    SELECT * INTO VEMP FROM EMP WHERE EMPNO=7788;
    
    IF(VEMP.DEPTNO = 10) THEN
        VDNAME := 'ACCOUNTING';
    ELSIF(VEMP.DEPTNO = 20) THEN
        VDNAME := 'RESEARCH';
    ELSIF(VEMP.DEPTNO = 30) THEN
        VDNAME := 'SALES';
    ELSIF(VEMP.DEPTNO = 40) THEN
        VDNAME := 'OPERATION';
    END IF;

    DBMS_OUTPUT.PUT_LINE('사원번호 = '||VEMP.EMPNO);
    DBMS_OUTPUT.PUT_LINE('사원이름 = '||VEMP.ENAME);
    DBMS_OUTPUT.PUT_LINE('부서이름 = '||VDNAME);
END;
/

--CASE : 변수에 저장된 값을 비교하여 명령을 선택 실행하거나 조건식을 이용하여 명령을 선택 실행하는 구문
--형식)CASE 변수명 WHEN 값1 THEN 명령;... WHEN 값2 THEN 명령;... END CASE;

--EMP 테이블에서 사원번호가 7788인 사원을 검색하여 사원번호,사원이름,업무,급여,업무별 급여 지급액을 출력하는 PL/SQL 작성
--업무별 급여 지급액 : 업무에 따라 실제로 지불될 급여
-- >> ANALYST : 급여*1.1, CLERK : 급여*1.2, MANAGER : 급여*1.3, PRESIDENT : 급여*1.4, SAELSMAN : 급여*1.5
DECLARE
    VEMP EMP%ROWTYPE;
    VPAY NUMBER(7,2);
BEGIN
    SELECT * INTO VEMP FROM EMP WHERE EMPNO=7788;
    
    CASE VEMP.JOB
        WHEN 'ANALYST' THEN VPAY := VEMP.SAL * 1.1;
        WHEN 'CLERK' THEN VPAY := VEMP.SAL * 1.2;
        WHEN 'MANAGER' THEN VPAY := VEMP.SAL * 1.3;
        WHEN 'PRESIDENT' THEN VPAY := VEMP.SAL * 1.4;
        WHEN 'SAELSMAN' THEN VPAY := VEMP.SAL * 1.5;
    END CASE;
    
    DBMS_OUTPUT.PUT_LINE('사원번호 = '||VEMP.EMPNO);
    DBMS_OUTPUT.PUT_LINE('사원이름 = '||VEMP.ENAME);
    DBMS_OUTPUT.PUT_LINE('업무 = '||VEMP.JOB);
    DBMS_OUTPUT.PUT_LINE('급여 = '||VEMP.SAL);
    DBMS_OUTPUT.PUT_LINE('실지급액 = '||VPAY);
END;
/    

--형식)CASE WHEN 조건식 THEN 명령;... WHEN 조건식 THEN 명령;... END CASE;

--EMP 테이블에서 사원번호가 7788인 사원을 검색하여 사원번호,사원이름,급여,급여등급을 출력하는 PL/SQL 작성
--급여등급 : E(0~1000), D(1001~2000), C(2001~3000), B(3001~4000), A(40001~5000) 
DECLARE
    VEMP EMP%ROWTYPE;
    VGRADE VARCHAR2(1);
    BEGIN
        SELECT * INTO VEMP FROM EMP WHERE EMPNO=7788;
        
        CASE 
            WHEN VEMP.SAL BETWEEN 0 AND 1000 THEN VGRADE := 'E';
            WHEN VEMP.SAL BETWEEN 1001 AND 2000 THEN VGRADE := 'D';
            WHEN VEMP.SAL BETWEEN 2001 AND 3000 THEN VGRADE := 'C';
            WHEN VEMP.SAL BETWEEN 3001 AND 4000 THEN VGRADE := 'B';
            WHEN VEMP.SAL BETWEEN 4001 AND 5000 THEN VGRADE := 'A';
        END CASE;

        DBMS_OUTPUT.PUT_LINE('사원번호 = '||VEMP.EMPNO);
        DBMS_OUTPUT.PUT_LINE('사원이름 = '||VEMP.ENAME);
        DBMS_OUTPUT.PUT_LINE('급여 = '||VEMP.SAL);
        DBMS_OUTPUT.PUT_LINE('급여등급 = '||VGRADE);
END;
/    


















