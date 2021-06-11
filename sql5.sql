--MERGE : 소스 테이블의 행을 검색하여 타겟 테이블에 행을 삽입하거나 행의 컬럼값을 변경하는 명령 - 테이블 동기화
--형식)MERGE INTO 타겟테이블 USING 소스테이블 ON (조건식)
--     WHEN MATCHED THEN UPDATE SET 타겟컬럼명=소스컬럼명,타겟컬럼명=소스컬럼명,...
--     WHEN NOT MATCHED THEN INSERT(타겟컬럼명,타겟컬럼명,...) VALUES(소스컬럼명,소스컬럼명,...)

--DEPT 테이블과 동일한 속성의 MERGE_DEPT 테이블 생성
CREATE TABLE MERGE_DEPT(DEPTNO NUMBER(2),DNAME VARCHAR2(10),LOC VARCHAR2(11));
DESC MERGE_DEPT;

--MERGE_DEPT 테이블에 행 삽입
INSERT INTO MERGE_DEPT VALUES(30,'총무부','서울');
INSERT INTO MERGE_DEPT VALUES(60,'자재부','인천');
COMMIT;
SELECT * FROM MERGE_DEPT;

--DEPT 테이블(소스 테이블)에 저장된 모든 부서정보을 검색하여 MERGE_DEPT 테이블(타겟 테이블)에 삽입 또는 변경 - 테이블 별칭 사용
SELECT * FROM DEPT;--소스 테이블
SELECT * FROM MERGE_DEPT;--타겟 테이블

MERGE INTO MERGE_DEPT M USING DEPT D ON (M.DEPTNO=D.DEPTNO)
    WHEN MATCHED THEN UPDATE SET M.DNAME=D.DNAME,M.LOC=D.LOC
    WHEN NOT MATCHED THEN INSERT(M.DEPTNO,M.DNAME,M.LOC) VALUES(D.DEPTNO,D.DNAME,D.LOC);

SELECT * FROM MERGE_DEPT;

--TCL(TRANSACTION CONTROL LANGUAGE) : 트렌젝션 제어어
--SQL 명령이 저장된 트렌젝션을 실제 테이블에 적용하거나 적용하지 않고 취소하는 명령

--트렌젝션(TRANSACTION) : 현재 세션에서 DBMS 서버에 전달되어 실행된 SQL 명령을 저장하기 위한 작업 단위 - SQL 명령의 그룹
--세션(SESSION) : DBMS 서버에 접속하여 SQL 명령을 전달하여 실행할 수 있는 사용자의 작업환경

--트렌젝션에 저장된 SQL 명령을 실제 테이블에 적용하는 방법 : 커밋(COMMIT) 처리 - 트렌젝션 초기화
--1.현재 세션이 정상적으로 종료된 경우 자동으로 커밋 처리
--2.DDL 명령 또는 DCL 명령이 세션에 전달되어 트렌젝션에 저장된 경우 자동으로 커밋 처리
--3.트렌젝션에 저장된 DML 명령은 COMMIT 명령을 사용하여 수동으로 커밋 처리

--트렌젝션에 저장된 SQL 명령을 실제 테이블에 적용하지 않고 트렌젝션 초기화하는 방법 - 롤백(ROLLBACK) 처리
--1.현재 세션이 비정상적으로 종료된 경우 자동으로 롤백 처리
--2.트렌젝션에 저장된 DML 명령은 ROLLBACK 명령을 사용하여 수동으로 롤백 처리

--DPET 테이블에 저장된 모든 부서정보 검색 - 트렌젝션에 저장된 DML 명령이 없으으로 실제 테이블의 검색결과 제공
SELECT * FROM DEPT;

--DPET 테이블에서 부서번호가 50인 부서정보 삭제
-- >> 실제 테이블에 DELETE 명령이 적용되어 행이 삭제되지 않고 트렌젝션에 DELETE 명령이 저장
DELETE FROM DEPT WHERE DEPTNO=50;

--DPET 테이블에 저장된 모든 부서정보 검색
-- >> 실제 테이블의 검색결과를 트렌젝션에 저장된 DELETE 명령이 적용된 검색결과로 제공
SELECT * FROM DEPT;

--롤백 처리 : 트렌젝션 초기화 - 트렌젝션에 저장된 모든 SQL 명령 제거
ROLLBACK;
SELECT * FROM DEPT;

--DPET 테이블에서 부서번호가 50인 부서정보 삭제 - 트렌젝션에 DELETE 명령 저장
DELETE FROM DEPT WHERE DEPTNO=50;
--실제 테이블에 DELETE 명령을 적용하기 위해 커밋 처리 - 커밋 처리 후 트렌젝션 초기화
COMMIT;
SELECT * FROM DEPT;

--EMP 테이블에 저장된 모든 사원정보 삭제
DELETE FROM EMP;
SELECT * FROM EMP;
--전달되어 실행된 DML 명령이 잘못된 경우 롤백처리를 통한 복구를 위해 트렌젝션 이용
ROLLBACK;
SELECT * FROM EMP;

--데이타 일관성을 제공하기 위해 트렌젝션 이용
--데이타 일관성 : DBMS를 사용하는 모든 사용자에게 동일한 검색 결과를 제공하기 위한 기능
--현재 세션에서 작업중인 결과를 다른 사용자에게 커밋처리 전까지 제공되지 않도록 트렌젝션 이용

--BONUS 테이블에서 사원이름 KIM인 사원정보 삭제
SELECT * FROM BONUS;
DELETE FROM BONUS WHERE ENAME='KIM';
SELECT * FROM BONUS;

--다른 세션에서는 BONUS 테이블에서 사원이름이 KIM 사원 검색
--현재 세션에서 작업을 완료하기 전까지 다른 세션에서는 작업 전의 검색 결과 제공 - 데이타 일관성
--현재 세션에서 커밋 처리를 하면 다른 세션에서도 작업 완료 후의 검색 결과 제공
COMMIT;

--데이타 LOCK 기능을 제공하기 위해 트렌젝션 이용
--DBMS는 다중 사용자 환경으로 같은 테이블의 행을 세션마다 조작 가능
--현재 세션에서 작업 중인 테이블의 행을 다른 세션에서 작업하지 못하도록 트렌젝션을 이용하여 테이타 잠금 기능 제공

--BONUS 테이블에서 사원이름이 ALLEN인 사원의 급여를 2000으로 변경
SELECT * FROM BONUS;
UPDATE BONUS SET SAL=2000 WHERE ENAME='ALLEN';
SELECT * FROM BONUS;

--다른 세션에서 BONUS 테이블에 저장된 사원 중 사원이름이 ALLEN인 사원의 성과급을 급여의 50%로 변경
--UPDATE BONUS SET COMM=SAL*0.5 WHERE ENAME='ALLEN';
--현재 세션에서 작업 중인 행은 다른 세션에서는 작업하지 못하도록 트렌젝션에 의해 테이타 잠금 기능 활성화
--다른 세션에서 현재 세션의 작업행을 조작할 경우 세션의 상태가 일시 중지 상태로 변경
-- >> 현재 세션에서 커밋 처리 또는 롤백 처리를 해야만 다른 세션의 명령 실행
COMMIT;
SELECT * FROM BONUS;

--SAVEPOINT : 트렌제션에 라벨을 붙이는 명령
--라벨을 이용하여 원하는 위치까지의 SQL 명령을 롤백 처리하기 위해 사용
--형식)SAVEPOINT 라벨명

--BONUS 테이블에서 사원이름이 ALLEN인 사원정보 삭제
SELECT * FROM BONUS;
DELETE FROM BONUS WHERE ENAME='ALLEN';
SELECT * FROM BONUS;

--BONUS 테이블에서 사원이름이 MARTIN인 사원정보 삭제
DELETE FROM BONUS WHERE ENAME='MARTIN';
SELECT * FROM BONUS;

--롤백 처리 : 트렌젝션 초기화 - 트렌젝션에 저장된 모든 DML 명령 제거
ROLLBACK;
SELECT * FROM BONUS;

--BONUS 테이블에서 사원이름이 ALLEN인 사원정보 삭제
DELETE FROM BONUS WHERE ENAME='ALLEN';
SELECT * FROM BONUS;
SAVEPOINT ALLEN_DELETE_AFTER;

--BONUS 테이블에서 사원이름이 MARTIN인 사원정보 삭제
DELETE FROM BONUS WHERE ENAME='MARTIN';
SELECT * FROM BONUS;

--SAVEPOINT 명령으로 설정된 라벨을 이용한 롤백 처리
--형식)ROLLBACK TO 라벨명

--MARTIN 사원정보 삭제 명령에 대해서만 롤백 처리
ROLLBACK TO ALLEN_DELETE_AFTER;
SELECT * FROM BONUS;

--ALLEN 사원정보 삭제 명령에 대해서만 롤백 처리
ROLLBACK;
SELECT * FROM BONUS;

--DDL(DATA DEFINITION LANGUAGE) : 데이타 정의어
--데이타베이스 객체(테이블,뷰,시퀸스,인덱스,동의어,사용자 등)를 관리하기 위한 명령

--테이블(TABLE) : 데이타베이스에서 데이타(행)를 저장하기 위한 가장 기본적인 객체

--테이블 생성 : 테이블 속성(ATTRIBUTE)의 집합
--형식)CREATE TABLE 테이블명(컬럼명 자료형[(크기)] [DEFAULT 기본값] [컬럼제약조건]
--    ,컬럼명 자료형[(크기)] [DEFAULT 기본값] [컬럼제약조건],...[,테이블제약조건])

--식별자 작성 규칙 : 테이블명, 컬럼명, 별칭, 라벨명 등
--1.영문자로 시작되며 1~30 범위의 문자들로 구성
--2.A~Z,0~9,_,$,# 문자를 조합하여 작성 - 대소문자 미구분 : 스네이크 표기법(단어와 단어는 _로 구분)
--3.영문자외 다른 문자 사용 가능 - 비권장
--4.키워드를 식별자로 선언할 경우 에러 발생

--자료형(DATATYPE) : 컬럼에 저장 가능한 값을 표현하기 위한 키워드
--1.숫자형 : NUMBER[(전체자릿수,소숫점자릿수)]
--2.문자형 : CHAR(크기) - 크기 : 1~2000(BYTE) >> 고정형 길이
--          VARCHAR2(크기) - 크기 : 1~4000(BYTE) >> 가변형 길이
--          LONG - 최대 2GBYTE 저장 >> 가변형 : 테이블에서 하나의 컬럼에만 부여 가능하며 정렬 불가능
--          CLOB - 최대 4GBYTE 저장 >> 가변형 : 인코딩 처리된 문자값이 저장된 텍스트 파일을 저장하기 위한 자료형
--          BLOB - 최대 4GBYTE 저장 >> 가변형 : 원시값이 저장된 일반(이진) 파일을 저장하기 위한 자료형
--3.날짜형 : DATE - 날짜와 시간
--          TIMESTAMP - 초(MS) 단위 시간

--SALESMAN 테이블 생성 - 사원번호(숫자형),사원이름(문자형),입사일(날짜형)
CREATE TABLE SALESMAN(NO NUMBER(4),NAME VARCHAR2(20),STARTDATE DATE);

--딕셔너리(DICTIONARY): 시스템 정보를 확인 할 수 있는 가상의 테이블(뷰)
-- >> USER_DICTIONARY(일반 사용자),DBA_DICTIONARY(관리자),ALL_DICTIONARY(모든 사용자)

--USER_OBJECTS : 현재 접속 사용자의 객체 정보를 제공하는 딕셔너리
SELECT OBJECT_NAME FROM USER_OBJECTS WHERE OBJECT_TYPE='TABLE';

--USER_TABLES : 현재 접속 사용자의 테이블 정보를 제공하는 딕셔너리
SELECT TABLE_NAME FROM USER_TABLES;
--USER_TABLES 딕셔너리에 대한 동의어(SYNONYM)로 TABS 제공
SELECT TABLE_NAME FROM TABS;

--테이블 구조 확인
DESC SALESMAN;

--SALESMAN 테이블에 행 삽입
INSERT INTO SALESMAN VALUES(1000,'홍길동','00/03/19');
SELECT * FROM SALESMAN;
COMMIT;

--컬럼에 제약조건이 없는 경우 어떤 값이든 저장 가능 - 데이타 무결성 위반 가능
--데이타 무결성 : 테이블에 잘못된 행(컬럼값)이 저장되지 않도록 설정
INSERT INTO SALESMAN VALUES(2000,'임꺽정',NULL);
INSERT INTO SALESMAN VALUES(1000,'전우치','10/10/10');
SELECT * FROM SALESMAN;
COMMIT;

--행 삽입시 컬럼 생략 가능 : 생략된 컬럼에는 컬럼 기본값 자동 저장
--테이블 생성시 컬럼 기본값을 설정하지 않은 경우 컬럼 기본값은 NULL로 자동 설정
INSERT INTO SALESMAN(NO,NAME) VALUES(3000,'일지매');
SELECT * FROM SALESMAN;
COMMIT;

--MANAGER 테이블 생성 : 사원번호(숫자형),사원이름(문자형),입사일(날짜형-기본값:현재),급여(숫자형-기본값:1000)
CREATE TABLE MANAGER(NO NUMBER(4),NAME VARCHAR2(20),STARTDATE DATE DEFAULT SYSDATE,PAY NUMBER DEFAULT 1000);

--테이블 목록 및 테이블 구조 확인
SELECT TABLE_NAME FROM TABS WHERE TABLE_NAME='MANAGER';
DESC MANAGER;

--USER_TAB_COLUMNS : 테이블의 컬럼 정보를 제공하는 딕셔너리
SELECT COLUMN_NAME,DATA_DEFAULT FROM USER_TAB_COLUMNS WHERE TABLE_NAME='MANAGER';

--MANAGER 테이블에 행 삽입 - 컬럼 생략
INSERT INTO MANAGER(NO,NAME) VALUES(1000,'홍길동');
SELECT * FROM MANAGER;
COMMIT;

--제약조건(CONSTRAINT) : 컬럼에 잘못된 값이 저장되는 것을 방지하기 위한 기능 - 데이타 무결성 유지
--컬럼 수준의 제약조건 : 테이블의 속성 선언시 컬럼에 제약조건 설정
--테이블 수준의 제약조건 : 테이블 선언시 테이블의 특정 컬럼에 제약조건 설정

--NOT NULL : 컬럼에 NULL이 저장되는 것을 방지하기 위한 제약조건
--컬럼 수준의 제약조건으로만 설정 가능
--NOT NULL 제약조건이 설정되지 않은 컬럼은 기본적으로 NULL 저장 허용

--DEPT1 테이블 생성 : 부서번호(숫자형),부서이름(문자형),부서위치(문자형)
CREATE TABLE DEPT1(DEPTNO NUMBER(2),DNAME VARCHAR2(12),LOC VARCHAR2(11));
DESC DEPT1;

--DEPT1 테이블에 행 삽입 - 컬럼값 대신 NULL을 전달하여 저장 가능
INSERT INTO DEPT1 VALUES(10,NULL,NULL);--명시적 NULL 저장
INSERT INTO DEPT1(DEPTNO) VALUES(20);--묵시적 NULL 저장
SELECT * FROM DEPT1;
COMMIT;

--DEPT2 테이블 생성 : 부서번호(숫자형:NOT NULL),부서이름(문자형:NOT NULL),부서위치(문자형:NOT NULL)
CREATE TABLE DEPT2(DEPTNO NUMBER(2) NOT NULL,DNAME VARCHAR2(12) NOT NULL,LOC VARCHAR2(11) NOT NULL);
--DESC 명령으로 컬럼에 대한 NULL 사용 관련 정보 확인 가능
DESC DEPT2;

--DEPT2 테이블에 행 삽입
INSERT INTO DEPT2 VALUES(10,'총무부','서울');
--NOT NULL 제약조건이 설정된 컬럼에 NULL를 전달할 경우 에러 발생
INSERT INTO DEPT2 VALUES(20,NULL,NULL);
--생략된 컬럼의 컬럼 기본값이 NULL인 경우 자동으로 NULL이 전달되지만 NOT NULL 제약조건에 의해 에러 발생
INSERT INTO DEPT2(DEPTNO) VALUES(30);
SELECT * FROM DEPT2;
COMMIT;

--USER_CONSTAINTS : 테이블 컬럼에 설정된 제약조건을 제공하는 딕셔너리
--CONSTRAINT_NAME : 제약조건명 - 제약조건명을 설정하지 않으면 SYS_XXXXXXX 형식으로 자동 설정
--CONSTRAINT_TYPE : 제약조건 종류 - C(CHECK),P(PRIMARY),U(UNIQUE),R(REFERENCE)
SELECT CONSTRAINT_NAME,CONSTRAINT_TYPE FROM USER_CONSTRAINTS WHERE TABLE_NAME='DEPT2';

--제약조건을 설정할 경우 제약조건 관리를 위해 제약조건명을 지정하는 것을 권장
--형식)컬럼명 자료형[(크기)] CONSTRAINT 제약조건명 제약조건 >> 컬럼 수준의 제약조건

--DEPT3 테이블 생성 : 부서번호(숫자형:NOT NULL),부서이름(문자형:NOT NULL),부서위치(문자형:NOT NULL)
CREATE TABLE DEPT3(DEPTNO NUMBER(2) CONSTRAINT DEPT3_DEPTNO_NN NOT NULL
    ,DNAME VARCHAR2(11) CONSTRAINT DEPT3_DNAME_NN NOT NULL,LOC VARCHAR2(12) CONSTRAINT DEPT3_LOC_NN NOT NULL);
    
--테이블의 제약조건 확인
SELECT CONSTRAINT_NAME,CONSTRAINT_TYPE FROM USER_CONSTRAINTS WHERE TABLE_NAME='DEPT3';

--CHECK : 컬럼값에 대한 조건을 제공하여 조건에 맞는 값만 저장되도록 설정하는 제약조건
--컬럼 수준의 제약조건 또는 테이블 수준의 제약조건으로 설정 가능

--SAWON1 테이블 생성 - 사원번호(숫자형),사원이름(문자형),급여(숫자형)
CREATE TABLE SAWON1(NO NUMBER(4),NAME VARCHAR2(20),PAY NUMBER);

--SAWON1 테이블에 행 삽입 - 급여 컬럼에는 전달되는 숫자값이 무조건 저장
INSERT INTO SAWON1 VALUES(1000,'홍길동',8000000);
INSERT INTO SAWON1 VALUES(2000,'임꺽정',800000);
SELECT * FROM SAWON1;
COMMIT;

--SAWON2 테이블 생성 - 사원번호(숫자형),사원이름(문자형),급여(숫자형:최소급여-5000000)
-- >> CHEKC 제약조건을 컬럼 수준의 제약조건으로 설정 - 해당 컬럼만을 이용하여 조건식 설정
CREATE TABLE SAWON2(NO NUMBER(4),NAME VARCHAR2(20),PAY NUMBER CONSTRAINT SAWON2_PAY_CEHCK CHECK(PAY>=5000000));

--제약조건 확인
SELECT CONSTRAINT_NAME,CONSTRAINT_TYPE,SEARCH_CONDITION FROM USER_CONSTRAINTS WHERE TABLE_NAME='SAWON2';

--SAWON2 테이블에 행 삽입 
INSERT INTO SAWON2 VALUES(1000,'홍길동',8000000);
--CHEKC 제약조건에 의해 설정된 조건식에 맞지 않는 값을 전달할 경우 에러 발생
INSERT INTO SAWON2 VALUES(2000,'임꺽정',800000);

--SAWON3 테이블 생성 - 사원번호(숫자형),사원이름(문자형),급여(숫자형:최소급여-5000000)
-- >> CHEKC 제약조건을 테이블 수준의 제약조건으로 설정 - 모든 컬럼을 이용하여 조건식 설정
CREATE TABLE SAWON3(NO NUMBER(4),NAME VARCHAR2(20),PAY NUMBER,CONSTRAINT SAWON3_PAY_CEHCK CHECK(NAME<>'홍길동' AND PAY>=5000000));

--제약조건 확인
SELECT CONSTRAINT_NAME,CONSTRAINT_TYPE,SEARCH_CONDITION FROM USER_CONSTRAINTS WHERE TABLE_NAME='SAWON3';

--UNIQUE : 중복된 컬럼값 저장을 방지하기 위한 제약조건
--컬럼 수준의 제약조건 또는 테이블 수준의 제약조건으로 설정 가능
--테이블의 여러 컬럼에 UNIQUE 제약조건 설정이 가능하며 NULL 허용

--USER1 테이블 생성 : 아이디(문자형),이름(문자형),전화번호(문자형)
CREATE TABLE USER1(ID VARCHAR2(20),NAME VARCHAR2(30),PHONE VARCHAR2(15));

--USER1 테이블에 행 삽입
INSERT INTO USER1 VALUES('ABC','홍길동','010-1234-5678');
INSERT INTO USER1 VALUES('ABC','홍길동','010-1234-5678');
SELECT * FROM USER1;
COMMIT;

--USER2 테이블 생성 : 아이디(문자형-UNIQUE),이름(문자형),전화번호(문자형-UNIQUE)
-- >> UNIQUE 제약조건을 컬럼 수준의 제약조건으로 설정
CREATE TABLE USER2(ID VARCHAR2(20) CONSTRAINT USER2_ID_UK UNIQUE,NAME VARCHAR2(30)
    ,PHONE VARCHAR2(15) CONSTRAINT USER2_PHONE_UK UNIQUE);
    
--제약조건 확인
SELECT CONSTRAINT_NAME,CONSTRAINT_TYPE FROM USER_CONSTRAINTS WHERE TABLE_NAME='USER2';

--USER2 테이블에 행 삽입
INSERT INTO USER2 VALUES('ABC','홍길동','010-1234-5678');
--ID 컬럼에 설정된 UNIQUE 제약조건에 의해 기존행의 컬럼값과 동일한 값을 전달할 경우 에러 발생
INSERT INTO USER2 VALUES('ABC','임꺽정','010-7890-1234');
--PHONE 컬럼에 설정된 UNIQUE 제약조건에 의해 기존행의 컬럼값과 동일한 값을 전달할 경우 에러 발생
INSERT INTO USER2 VALUES('XYZ','임꺽정','010-1234-5678');
--ID 컬럼 또는 PHONE 컬럼에는 기존행의 컬럼값과 동일하지 않은 값을 전달해야만 삽입 가능
INSERT INTO USER2 VALUES('XYZ','임꺽정','010-7890-1234');
SELECT * FROM USER2;
COMMIT;

--UNIQUE 제약조건이 설정된 컬럼에 NULL을 전달하여 행 삽입 가능
INSERT INTO USER2 VALUES('KIM','전우치',NULL);
--NULL은 값이 아니므로 UNIQUE 제약조건을 위반하지 않아 행 삽입 가능
INSERT INTO USER2 VALUES('LEE','일지매',NULL);
SELECT * FROM USER2;

--USER3 테이블 생성 : 아이디(문자형-UNIQUE),이름(문자형),전화번호(문자형-UNIQUE)
-- >> UNIQUE 제약조건을 테이블 수준의 제약조건으로 설정
CREATE TABLE USER3(ID VARCHAR2(20),NAME VARCHAR2(30),PHONE VARCHAR2(15)
    ,CONSTRAINT USER3_ID_UK UNIQUE(ID),CONSTRAINT USER3_PHONE_UK UNIQUE(PHONE));

--제약조건 확인
SELECT CONSTRAINT_NAME,CONSTRAINT_TYPE FROM USER_CONSTRAINTS WHERE TABLE_NAME='USER3';

--USER3 테이블에 행 삽입
INSERT INTO USER3 VALUES('ABC','홍길동','010-1234-5678');
--ID 컬럼에 설정된 UNIQUE 제약조건에 의해 기존행의 컬럼값과 동일한 값을 전달할 경우 에러 발생
INSERT INTO USER3 VALUES('ABC','임꺽정','010-7890-1234');
--PHONE 컬럼에 설정된 UNIQUE 제약조건에 의해 기존행의 컬럼값과 동일한 값을 전달할 경우 에러 발생
INSERT INTO USER3 VALUES('XYZ','임꺽정','010-1234-5678');
--ID 컬럼 또는 PHONE 컬럼에는 기존행의 컬럼값과 동일하지 않은 값을 전달해야만 삽입 가능
INSERT INTO USER3 VALUES('XYZ','임꺽정','010-7890-1234');
SELECT * FROM USER3;
COMMIT;

--USER4 테이블 생성 : 아이디(문자형),이름(문자형),전화번호(문자형) - 아이디와 전화번호에 UNIQUE 제약조건을 동시에 설정
-- >> UNIQUE 제약조건을 테이블 수준의 제약조건으로 설정
CREATE TABLE USER4(ID VARCHAR2(20),NAME VARCHAR2(30),PHONE VARCHAR2(15),CONSTRAINT USER4_ID_PHONE_UK UNIQUE(ID,PHONE));

--제약조건 확인
SELECT CONSTRAINT_NAME,CONSTRAINT_TYPE FROM USER_CONSTRAINTS WHERE TABLE_NAME='USER4';

--USER4 테이블에 행 삽입
INSERT INTO USER4 VALUES('ABC','홍길동','010-1234-5678');
--ID 컬럼에 기존행의 컬럼값과 동일한 값을 전달하여 행 삽입 가능
INSERT INTO USER4 VALUES('ABC','임꺽정','010-7890-1234');
--PHONE 컬럼에 기존행의 컬럼값과 동일한 값을 전달하여 행 삽입 가능
INSERT INTO USER4 VALUES('XYZ','전우치','010-1234-5678');
--UNIQUE 제약조건이 동시에 설정된 ID 컬럼과 PHONE 컬럼에 기존행의 컬럼값과 동일한 값을 전달할 경우 에러 발생
INSERT INTO USER4 VALUES('ABC','일지매','010-1234-5678');
SELECT * FROM USER4;
COMMIT;