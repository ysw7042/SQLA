--PRIMARY KEY : 중복된 컬럼값 저장을 방지하기 위한 제약조건
--컬럼 수준의 제약조건 또는 테이블 수준의 제약조건으로 설정 가능
--PRIMARY KEY 제약조건은 테이블 하나의 컬럼에만 설정하며 NULL 미허용
--테이블의 행을 식별할 수 있는 고유값을 저장하기 위한 컬럼에 PRIMARY KEY 제약조건 설정

--MGR1 테이블 생성 : 사원번호(숫자형-PRIMARY KEY:PK),사원이름(문자형),입사일(날짜형) - 컬럼 수준의 제약조건으로 설정
CREATE TABLE MGR1(NO NUMBER(4) CONSTRAINT MGR1_NO_PK PRIMARY KEY,NAME VARCHAR2(20),STARTDATE DATE);
DESC MGR1;

--제약조건 확인
SELECT CONSTRAINT_NAME,CONSTRAINT_TYPE FROM USER_CONSTRAINTS WHERE TABLE_NAME='MGR1';

--MGR1 테이블에 행 삽입
INSERT INTO MGR1 VALUES(1000,'홍길동',SYSDATE);
--PRIMARY KEY 제약조건이 설정된 컬럼에 기존행의 컬럼값과 같은 값을 전달할 경우 에러 발생
INSERT INTO MGR1 VALUES(1000,'임꺽정',SYSDATE);
--PRIMARY KEY 제약조건이 설정된 컬럼에 NULL을 전달할 경우 에러 발생
INSERT INTO MGR1 VALUES(NULL,'임꺽정',SYSDATE);
SELECT * FROM MGR1;
COMMIT;

--MGR2 테이블 생성 : 사원번호(숫자형-PRIMARY KEY:PK),사원이름(문자형),입사일(날짜형) - 테이블 수준의 제약조건으로 설정
CREATE TABLE MGR2(NO NUMBER(4),NAME VARCHAR2(20),STARTDATE DATE,CONSTRAINT MGR2_NO_PK PRIMARY KEY(NO));
DESC MGR2;

--제약조건 확인
SELECT CONSTRAINT_NAME,CONSTRAINT_TYPE FROM USER_CONSTRAINTS WHERE TABLE_NAME='MGR2';

--FOREIGN KEY : 부모 테이블에 저장된 행의 컬럼값을 참조하여 자식 테이블의 컬럼에 잘못된 값이 저장되는 것을 방지하는 제약조건
--테이블 수준의 제약조건만 설정 가능
--부모 테이블의 PRIMARY KEY 제약조건이 설정된 컬럼을 참조하여 자식 테이블의 컬럼에 FOREIGN KEY 제약조건을 설정

--SUBJECT1 테이블 생성 : 과목코드(숫자형-PRIMARY KEY),과목명(문자형) -부모 테이블
CREATE TABLE SUBJECT1(SNO NUMBER(2) CONSTRAINT SUBJECT1_SNO_PK PRIMARY KEY,SNAME VARCHAR2(20));

--SUBJECT1 테이블에 행 삽입
INSERT INTO SUBJECT1 VALUES(10,'JAVA');
INSERT INTO SUBJECT1 VALUES(20,'JSP');
INSERT INTO SUBJECT1 VALUES(30,'SPRING');
SELECT * FROM SUBJECT1;
COMMIT;

--TRAINEE1 테이블 생성 : 수강생번호(숫자형-PRIMARY KEY),수강생이름(문자형),수강과목코드(숫자형)
CREATE TABLE TRAINEE1(TNO NUMBER(4) CONSTRAINT TRAINEE1_TNO_PK PRIMARY KEY,TNAME VARCHAR2(20),SCODE NUMBER(2));

--TRAINEE1 테이블에 행 삽입
INSERT INTO TRAINEE1 VALUES(1000,'홍길동',10);
INSERT INTO TRAINEE1 VALUES(2000,'임꺽정',20);
INSERT INTO TRAINEE1 VALUES(3000,'전우치',30);
INSERT INTO TRAINEE1 VALUES(4000,'일지매',40);
SELECT * FROM TRAINEE1;
COMMIT;

--TRAINEE1 테이블과 SUBJECT1 테이블에서 모든 수강생의 수강생번호,수강생이름,수강과목명 검색
--INNER JOIN인 경우 조인조건이 맞는 행만 결합하여 검색 - 조인조건이 맞지 않는 수강생 정보 미검색
-- >> 검색 오류 : 데이타 무결성 위반 - 컬럼에 참조할 없는 컬럼값 저장
SELECT TNO,TNAME,SNAME FROM TRAINEE1 JOIN SUBJECT1 ON SCODE=SNO;
--OUTER JOIN인 경우 조인조건이 맞는 행뿐만 아니라 조인조건이 맞지 않는 행도 검색 
SELECT TNO,TNAME,SNAME FROM TRAINEE1 LEFT JOIN SUBJECT1 ON SCODE=SNO;

--TRAINEE2 테이블 생성 : 수강생번호(숫자형-PRIMARY KEY),수강생이름(문자형),수강과목코드(숫자형-FORGIEN KEY:FK) - 자식 테이블
CREATE TABLE TRAINEE2(TNO NUMBER(4) CONSTRAINT TRAINEE2_TNO_PK PRIMARY KEY,TNAME VARCHAR2(20),SCODE NUMBER(2)
    ,CONSTRAINT TRAINEE2_SCODE_FK FOREIGN KEY(SCODE) REFERENCES SUBJECT1(SNO));
    
--제약조건 확인
SELECT CONSTRAINT_NAME,CONSTRAINT_TYPE,R_CONSTRAINT_NAME FROM USER_CONSTRAINTS WHERE TABLE_NAME='TRAINEE2';
    
--TRAINEE2 테이블에 행 삽입
--자식 테이블에 행을 삽입할 경우 FOREIGN KEY 제약조건이 설정된 컬럼에 값이 전달되면 부모 테이블의 컬럼값을 참조한 후 삽입 처리
INSERT INTO TRAINEE2 VALUES(1000,'홍길동',10);
INSERT INTO TRAINEE2 VALUES(2000,'임꺽정',20);
INSERT INTO TRAINEE2 VALUES(3000,'전우치',30);
--FOREIGN KEY 제약조건이 설정된 컬럼에 부모 테이블의 참조 컬럼에 저장되지 않는 값을 전달한 경우 에러 발생
INSERT INTO TRAINEE2 VALUES(4000,'일지매',40);
SELECT * FROM TRAINEE2;
COMMIT;

--TRAINEE2 테이블과 SUBJECT1 테이블에서 모든 수강생의 수강생번호,수강생이름,수강과목명 검색
SELECT TNO,TNAME,SNAME FROM TRAINEE2 JOIN SUBJECT1 ON SCODE=SNO;

--TRAINEE2 테이블에서 수강생번호가 1000인 학생의 수강과목코드를 40으로 변경
--FOREIGN KEY 제약조건이 설정된 컬럼에 부모 테이블의 참조 컬럼에 저장되지 않는 값을 전달한 경우 에러 발생
UPDATE TRAINEE2 SET SCODE=40 WHERE TNO=1000;

--SUBJECT1 테이블에서 과목코드가 10인 과목정보 삭제
--FOREIGN KEY 제약조건이 설정된 자식 테이블의 컬럼이 참조하는 부모 테이블의 컬럼값이 포함된 행을 삭제할 경우 에러 발생
DELETE FROM SUBJECT1 WHERE SNO=10;
--FOREIGN KEY 제약조건이 설정된 자식 테이블의 컬럼이 참조하는 부모 테이블의 컬럼값 검색 - 검색된 컬럼값이 저장된 부모 테이블의 행 삭제 불가
SELECT DISTINCT SCODE FROM TRAINEE2;

--SUBJECT2 테이블 생성 : 과목코드(숫자형-PRIMARY KEY),과목명(문자형) -부모 테이블
CREATE TABLE SUBJECT2(SNO NUMBER(2) CONSTRAINT SUBJECT2_SNO_PK PRIMARY KEY,SNAME VARCHAR2(20));

--SUBJECT2 테이블에 행 삽입
INSERT INTO SUBJECT2 VALUES(10,'JAVA');
INSERT INTO SUBJECT2 VALUES(20,'JSP');
INSERT INTO SUBJECT2 VALUES(30,'SPRING');
SELECT * FROM SUBJECT2;
COMMIT;

--TRAINEE3 테이블 생성 : 수강생번호(숫자형-PRIMARY KEY),수강생이름(문자형),수강과목코드(숫자형-FORGIEN KEY:FK) - 자식 테이블
--FOREIGN KEY 제약조건을 설정할 때 ON DELETE CASCADE 또는 ON DELETE SET NULL 기능 추가
--ON DELETE CASCADE : 부모 테이블의 행을 삭제 할 경우 자식 테이블에 참조 컬럼값이 저장된 행도 같이 삭제하는 기능
--ON DELETE SET NULL : 부모 테이블의 행을 삭제 할 경우 자식 테이블에 참조 컬럼값을 NULL로 변경하는 기능
CREATE TABLE TRAINEE3(TNO NUMBER(4) CONSTRAINT TRAINEE3_TNO_PK PRIMARY KEY,TNAME VARCHAR2(20),SCODE NUMBER(2)
    ,CONSTRAINT TRAINEE3_SCODE_FK FOREIGN KEY(SCODE) REFERENCES SUBJECT2(SNO) ON DELETE CASCADE);
    
--TRAINEE3 테이블에 행 삽입
INSERT INTO TRAINEE3 VALUES(1000,'홍길동',10);
INSERT INTO TRAINEE3 VALUES(2000,'임꺽정',20);
INSERT INTO TRAINEE3 VALUES(3000,'전우치',30);
SELECT * FROM TRAINEE3;
COMMIT;

--SUBJECT2 테이블에서 과목코드가 10인 과목정보 삭제
DELETE FROM SUBJECT2 WHERE SNO=10;
SELECT * FROM SUBJECT2;
--TRAINEE3 테이블에 저장된 수강생 중 수강과목코드가 10이 저장된 모든 수강생 정보 삭제 확인
SELECT * FROM TRAINEE3;

--서브쿼리를 이용하여 테이블 생성 : 기존 테이블을 이용하여 새로운 테이블 생성 - 행 복사
--형식)CREATE TABLE 테이블명[(컬럼명,컬럼명,...)] AS SELECT 검색대상,검색대상,... FROM 테이블명 [WHERE 조건식]
--서브쿼리의 검색결과와 동일한 속성의 테이블을 생성하며 검색행을 생성된 테이블에 삽입
--생성 테이블의 컬럼명이 생략된 경우 서브쿼리의 검색대상을 컬럼명으로 사용
--기존 테이블과 속성은 같지만 생성 테이블에는 제약조건 미설정

--EMP 테이블에서 모든 사원정보를 검색하여 EMP2 테이블을 생성하고 검색행을 복사하여 삽입
CREATE TABLE EMP2 AS SELECT * FROM EMP;

--EMP 테이블과 EMP2 테이블의 속성 비교 - 두 테이블의 속성 동일
DESC EMP;
DESC EMP2;

--EMP 테이블과 EMP2 테이블의 제약조건 비교 - EMP 테이블에는 제약조건이 설정되어 있지만 EMP2 테이블에는 제약조건 미설정
SELECT CONSTRAINT_NAME,CONSTRAINT_TYPE FROM USER_CONSTRAINTS WHERE TABLE_NAME='EMP';
SELECT CONSTRAINT_NAME,CONSTRAINT_TYPE FROM USER_CONSTRAINTS WHERE TABLE_NAME='EMP2';

--EMP 테이블과 EMP2 테이블의 행 비교 - 두 테이블의 행 동일
SELECT * FROM EMP;
SELECT * FROM EMP2;

--EMP 테이블에서 모든 사원의 사원번호,사원이름,급여를 검색하여 EMP3 테이블을 생성하고 검색행을 복사하여 삽입
CREATE TABLE EMP3 AS SELECT EMPNO,ENAME,SAL FROM EMP;

--EMP3 테이블의 속성 확인 및 저장행 검색
DESC EMP3;
SELECT * FROM EMP3;

--EMP 테이블에서 급여가 2000 이상인 사원의 사원번호,사원이름,급여를 검색하여 EMP4 테이블을 생성하고 검색행을 복사하여 삽입
CREATE TABLE EMP4 AS SELECT EMPNO,ENAME,SAL FROM EMP WHERE SAL>=2000;

--EMP4 테이블의 속성 확인 및 저장행 검색
DESC EMP4;
SELECT * FROM EMP4;

--EMP 테이블에서 급여가 2000 이상인 사원의 사원번호,사원이름,급여를 검색하여 EMP5 테이블을 생성하고 검색행을 복사하여 삽입
-- >> EMP5 테이블의 컬럼명을 각각 사원번호 NO,사원이름 NAME,급여 PAY로 설정 - 검색대상의 갯수와 컬럼의 갯수 동일
CREATE TABLE EMP5(NO,NAME,PAY) AS SELECT EMPNO,ENAME,SAL FROM EMP WHERE SAL>=2000;

--EMP5 테이블의 속성 확인 및 저장행 검색
DESC EMP5;
SELECT * FROM EMP5;

--EMP 테이블과 동일한 속성의 EMP6 테이블 생성 - 기존 테이블의 행이 복사되지 않도록 작성
CREATE TABLE EMP6 AS SELECT * FROM EMP WHERE 0=1;--조건식을 무조건 거짓이 되도록 설정

--EMP6 테이블의 속성 확인 및 저장행 검색
DESC EMP6;
SELECT * FROM EMP6;

--테이블 삭제 : 테이블에 저장된 모든 행 삭제
--형식)DROP TABLE 테이블명

--테이블 목록 확인
SELECT TABLE_NAME FROM TABS;

--USER1 테이블 검색 및 USER1 테이블의 저장행 검색
SELECT TABLE_NAME FROM TABS WHERE TABLE_NAME='USER1';
SELECT * FROM USER1;

--USER1 테이블 삭제
DROP TABLE USER1;
SELECT TABLE_NAME FROM TABS WHERE TABLE_NAME='USER1';
SELECT * FROM USER1;

--오라클에서는 테이블을 삭제할 경우 테이블과 테이블 관련 INDEX 객체를 휴지통(RECYCLEBIN)으로 이동
-- >> 삭제 테이블과 테이블 관련 INDEX 객체 복구 가능

--테이블 목록 확인 - USER_TABLES(TABS)
SELECT TABLE_NAME FROM TABS;

--테이블 목록 확인 - TAB 뷰 이용
--TNAME 컬럼에 BIN으로 시작되는 테이블은 오라클 휴지통에 존재하는 삭제 테이블
SELECT * FROM TAB;

--오라클 휴지통의 객체 목록 확인
SHOW RECYCLEBIN;

--오라클 휴지통에 존재하는 삭제 테이블 복구 - 테이블 관련 INDEX 객체도 같이 복구
--형식)FLASHBACK TABLE 테이블명 TO BEFORE DROP;

--USER1 삭제 테이블 복구 - 테이블에 저장된 행도 같이 복구
FLASHBACK TABLE USER1 TO BEFORE DROP;
SELECT TABLE_NAME FROM TABS WHERE TABLE_NAME='USER1';
SELECT * FROM USER1;

--USER2 테이블 삭제 - 테이블에 종속된 INDEX 객체도 같이 삭제
SELECT TABLE_NAME FROM TABS WHERE TABLE_NAME='USER2';
DROP TABLE USER2;
SELECT TABLE_NAME FROM TABS WHERE TABLE_NAME='USER2';

--오라클 휴지통의 객체 목록 확인
SHOW RECYCLEBIN;

--USER2 삭제 테이블 복구 - 삭제 테이블에 종속된 INDEX 객체도 같이 복구
FLASHBACK TABLE USER2 TO BEFORE DROP;
SHOW RECYCLEBIN;
SELECT TABLE_NAME FROM TABS WHERE TABLE_NAME='USER2';

--USER1,USER2,USER3,USER4 테이블 삭제
SELECT TABLE_NAME FROM TABS WHERE TABLE_NAME LIKE 'USER%';
DROP TABLE USER1;
DROP TABLE USER2;
DROP TABLE USER3;
DROP TABLE USER4;
SELECT TABLE_NAME FROM TABS WHERE TABLE_NAME LIKE 'USER%';
SHOW RECYCLEBIN;

--오라클 휴지통의 삭제 테이블 제거 - 테이블이 종속된 INDEX 객체도 같이 제거
--형식)PURGE TABLE 테이블명
PURGE TABLE USER4;
SHOW RECYCLEBIN;

--오라클 휴지통의 모든 삭제 테이블 제거
PURGE RECYCLEBIN;
SHOW RECYCLEBIN;

--MGR1 테이블 삭제 - 오라클 휴지통으로 이동
SELECT TABLE_NAME FROM TABS WHERE TABLE_NAME LIKE 'MGR%';
DROP TABLE MGR1;
SHOW RECYCLEBIN;
--오라클 휴지통에서 삭제 테이블 제거
PURGE TABLE MGR1;
SHOW RECYCLEBIN;

--MGR2 테이블 삭제 - 오라클 휴지통을 이용하지 않고 삭제 처리
--형식)DROP TABLE 테이블명 PURGE
DROP TABLE MGR2 PURGE;
SHOW RECYCLEBIN;

--테이블 초기화 : 테이블 생성 직후의 상태로 초기화 처리하는 명령 - 테이블의 저장행 삭제
--형식)TRUNCATE TABLE 테이블명

--BONUS 테이블에 저장된 모든 행 삭제 - 트렌젝션에 DELETE 명령 저장 : 실제 테이블의 저장행 미삭제
SELECT * FROM BONUS;
DELETE FROM BONUS;
SELECT * FROM BONUS;

--롤백 처리 가능
ROLLBACK;
SELECT * FROM BONUS;

--BONUS 테이블 초기화 - 자동 커밋 : 롤백 처리 불가능 
TRUNCATE TABLE BONUS;
SELECT * FROM BONUS;

--테이블 이름 변경
--형식)RENAME 기존테이블명 TO 변경테이블명

--BONUS 테이블의 이름을 COMM으로 변경
SELECT TABLE_NAME FROM TABS WHERE TABLE_NAME='BONUS';
RENAME BONUS TO COMM;
SELECT TABLE_NAME FROM TABS WHERE TABLE_NAME='COMM';

--테이블 속성 변경
--형식)ALTER TABLE 테이블명 변경옵션
--변경옵션에 의해 컬럼 추가, 컬럼 삭제, 컬럼명 변경, 컬럼 자료형과 크기 변경, 컬럼 기본값 변경, 제약조건 추가, 제약조건 제거 등 처리작업

--USER1 테이블 생성 : 회원번호(숫자형),회원이름(문자형),전화번호(문자형)
CREATE TABLE USER1(NO NUMBER(4),NAME VARCHAR2(20),PHONE VARCHAR2(15));
DESC USER1;

--USER1 테이블에 행 삽입
INSERT INTO USER1 VALUES(1000,'홍길동','010-1234-5678');
SELECT * FROM USER1;
COMMIT;

--테이블 컬럼 추가 : 컬럼 기본값과 컬럼 수준의 제약조건 설정 가능
--형식)ALTER TABLE 테이블명 ADD(컬럼명 자료형[(크기)] [DEFAULR 기본값] [제약조건])

--USER1 테이블에 주소(문자형) 컬럼 추가 - 저장행이 있어도 컬럼 추가 가능
ALTER TABLE USER1 ADD(ADDRESS VARCHAR2(100));
DESC USER1;
--저장행의 추가 컬럼에는 컬럼 기본값이 자동 저장
SELECT * FROM USER1;

--USER1 테이블의 ADDRESS 컬럼값 변경
UPDATE USER1 SET ADDRESS='서울시 강남구' WHERE NO=1000;
SELECT * FROM USER1;
COMMIT;

--테이블의 컬럼 자료형 또는 크기 변경 : 컬럼 기본값과 컬럼 수준의 제약조건 설정 가능
--형식)ALTER TABLE 테이블명 MODIFY(컬럼명 자료형[(크기)] [DEFAULR 기본값] [제약조건])

--USER1 테이블 초기화
TRUNCATE TABLE USER1;
SELECT * FROM USER1;

--USER1 테이블의 NO 컬럼 자료형(숫자형)을 문자형으로 변경
DESC USER1;
ALTER TABLE USER1 MODIFY(NO VARCHAR2(4));
DESC USER1;

--USER1 테이블에 행 삽입
INSERT INTO USER1 VALUES('1000','홍길동','010-1234-5678','서울시 강남구');
SELECT * FROM USER1;
COMMIT;

--USER1 테이블의 NO 컬럼 자료형(문자형)을 숫자형으로 변경
DESC USER1;
--값이 저장된 컬럼의 자료형을 변경할 경우 에러 발생
ALTER TABLE USER1 MODIFY(NO NUMBER(4));

--USER1 테이블의 NAME 컬럼의 크기를 10BYTE 변경
DESC USER1;
--컬럼에 값이 저장되어 있는 경우 컬럼값의 크기보다 변경되는 자료형의 크기가 크면 변경 가능
SELECT * FROM USER1;
ALTER TABLE USER1 MODIFY(NAME VARCHAR2(10));
DESC USER1;
SELECT * FROM USER1;

--USER1 테이블의 NAME 컬럼의 크기를 5BYTE 변경
--컬럼에 값이 저장되어 있는 경우 컬럼값의 크기보다 변경되는 자료형의 크기가 작으면 변경 불가능
ALTER TABLE USER1 MODIFY(NAME VARCHAR2(5));

--테이블의 컬럼명 변경
--형식)ALTER TABLE 테이블명 RENAME COLUMN 기존컬럼명 TO 변경컬럼명

--USER1 테이블의 ADDRESS 컬럼명을 ADDR 컬럼명으로 변경
DESC USER1;
ALTER TABLE USER1 RENAME COLUMN ADDRESS TO ADDR;
DESC USER1;

--테이블의 컬럼 삭제 : 컬럼값도 같이 삭제
--형식)ALTER TABLE 테이블명 DROP COLUMN 컬럼명

--USER1 테이블의 PHONE 컬럼 삭제
DESC USER1;
ALTER TABLE USER1 DROP COLUMN PHONE;
DESC USER1;
SELECT * FROM USER1;

--컬럼의 제약조건은 MODIFY 옵션을 사용하여 컬럼 변경시 컬럼 수준의 제약조건 설정
--USER1 테이블의 NAME 컬럼에 NOT NULL 제약조건 설정
SELECT CONSTRAINT_NAME,CONSTRAINT_TYPE FROM USER_CONSTRAINTS WHERE TABLE_NAME='USER1';
ALTER TABLE USER1 MODIFY(NAME VARCHAR2(10) CONSTRAINT USER1_NAME_NN NOT NULL);
SELECT CONSTRAINT_NAME,CONSTRAINT_TYPE FROM USER_CONSTRAINTS WHERE TABLE_NAME='USER1';

--테이블 수준의 제약 조건은 ADD 옵션을 사용하여 설정
--형식)ALTER TABLE 테이블명 ADD [CONSTRAINT 제약조건명] 제약조건(컬럼명)

--USER1 테이블에 NO 컬럼명에 PRIMARY KEY 제약조건 설정
ALTER TABLE USER1 ADD CONSTRAINT USER1_NO_PK PRIMARY KEY(NO);
SELECT CONSTRAINT_NAME,CONSTRAINT_TYPE FROM USER_CONSTRAINTS WHERE TABLE_NAME='USER1';

--제약조건 삭제
--형식)ALTER TABLE 테이블명 DROP {PRIMARY KEY|CONSTRAINT 제약조건명} [CASCADE]

--USER1 테이블의 NAME 컬럼에 설정된 NOT NULL 제약조건 삭제
ALTER TABLE USER1 DROP CONSTRAINT USER1_NAME_NN;
SELECT CONSTRAINT_NAME,CONSTRAINT_TYPE FROM USER_CONSTRAINTS WHERE TABLE_NAME='USER1';

--USER1 테이블의 NO 컬럼에 설정된 PRIMARY KEY 제약조건 삭제
ALTER TABLE USER1 DROP PRIMARY KEY;
SELECT CONSTRAINT_NAME,CONSTRAINT_TYPE FROM USER_CONSTRAINTS WHERE TABLE_NAME='USER1';

--BUSEO 테이블 생성 : 부서번호(숫자형-PRIMARY KEY),부서명(문자형) - 부모 테이블
CREATE TABLE BUSEO(BNO NUMBER(2) CONSTRAINT BUSEO_BNO_PK PRIMARY KEY,DNAME VARCHAR2(20));

--BUSEO 테이블에 행 삽입
INSERT INTO BUSEO VALUES(10,'총무부');
INSERT INTO BUSEO VALUES(20,'영업부');
SELECT * FROM BUSEO;
COMMIT;

--SAWON 테이블 생성 - 사원번호(숫자형-PRIMARY KEY),사원이름(문자형),부서번호(숫자형-FOREIGN KEY:BUSEO 테이블의 BNO 컬럼 참조) - 자식 테이블
CREATE TABLE SAWON(SNO NUMBER(4) CONSTRAINT SAWON_SNO_PK PRIMARY KEY,SNAME VARCHAR2(20),BNO NUMBER(20)
    ,CONSTRAINT SAWON_BNO_FK FOREIGN KEY(BNO) REFERENCES BUSEO(BNO));
    
--SAWON 테이블에 행 삽입
INSERT INTO SAWON VALUES(1000,'홍길동',10);
INSERT INTO SAWON VALUES(2000,'임꺽정',20);
SELECT * FROM SAWON;
COMMIT;
    
--제약조건 확인
SELECT CONSTRAINT_NAME,CONSTRAINT_TYPE,R_CONSTRAINT_NAME FROM USER_CONSTRAINTS WHERE TABLE_NAME IN ('BUSEO','SAWON');

--FOREIGN KEY 제약조건에 의해 부모 테이블에 없는 값을 전달할 경우 에러 발생
INSERT INTO SAWON VALUES(3000,'전우치',30);    

--제약조건의 비활성화 : 컬럼에 설정된 제약조건을 일시적으로 중지하는 기능
--형식)ALTER TABLE 테이블명 DISABLE {PRIMARY KEY|CONSTRAINT 제약조건명} [CASCADE]
SELECT CONSTRAINT_NAME,CONSTRAINT_TYPE,R_CONSTRAINT_NAME,STATUS FROM USER_CONSTRAINTS WHERE TABLE_NAME='SAWON';

--SAWON 테이블의 BNO 컬럼에 설정된 FOREIGN KEY 제약조건을 비활성화 처리
ALTER TABLE SAWON DISABLE CONSTRAINT SAWON_BNO_FK;
SELECT CONSTRAINT_NAME,CONSTRAINT_TYPE,R_CONSTRAINT_NAME,STATUS FROM USER_CONSTRAINTS WHERE TABLE_NAME='SAWON';

--FOREIGN KEY 제약조건이 비활성화 처리되어 참조 관련 에러 미발생
INSERT INTO SAWON VALUES(3000,'전우치',30);    
SELECT * FROM SAWON;

--제약조건의 활성화 : 일시적으로 중지된 제약조건이 동작되도록 처리하는 기능
--형식)ALTER TABLE 테이블명 ENABLE {PRIMARY KEY|CONSTRAINT 제약조건명}
SELECT CONSTRAINT_NAME,CONSTRAINT_TYPE,R_CONSTRAINT_NAME,STATUS FROM USER_CONSTRAINTS WHERE TABLE_NAME='SAWON';
--활성화 처리하기 위한 제약조건을 위반하는 컬럼값이 테이블에 저장되어 있는 경우 제약조건 활성화 처리시 에러 발생
ALTER TABLE SAWON ENABLE CONSTRAINT SAWON_BNO_FK;

--제약조건을 위반하는 컬럼값을 변경하거나 컬럼값이 저장된 행을 삭제해야만 제약조건 활성화 처리 가능
SELECT * FROM SAWON;
DELETE FROM SAWON WHERE BNO=30;
ALTER TABLE SAWON ENABLE CONSTRAINT SAWON_BNO_FK;
SELECT CONSTRAINT_NAME,CONSTRAINT_TYPE,R_CONSTRAINT_NAME,STATUS FROM USER_CONSTRAINTS WHERE TABLE_NAME='SAWON';

--BUSEO 테이블의 BNO 컬럼에 설정된 PRIMARY KEY 제약조건을 비활성화 처리
SELECT CONSTRAINT_NAME,CONSTRAINT_TYPE,R_CONSTRAINT_NAME,STATUS FROM USER_CONSTRAINTS WHERE TABLE_NAME='BUSEO';
--FOREIGN KEY 제약조건에 의해 참조되는 부모 테이블의 PRIMARY KEY 제약조건은 비활성화 처리시 에러 발생
ALTER TABLE BUSEO DISABLE PRIMARY KEY; 
SELECT CONSTRAINT_NAME,CONSTRAINT_TYPE,R_CONSTRAINT_NAME,STATUS FROM USER_CONSTRAINTS WHERE TABLE_NAME IN ('BUSEO','SAWON');

--CASCADE 키워드를 사용하여 부모 테이블의 PRIMARY KEY 제약조건을 비활성화 처리하면 자식 테이블의 설정된 
--FOREIGN KEY 제약조건도 같이 비활성화 처리
ALTER TABLE BUSEO DISABLE PRIMARY KEY CASCADE; 
SELECT CONSTRAINT_NAME,CONSTRAINT_TYPE,R_CONSTRAINT_NAME,STATUS FROM USER_CONSTRAINTS WHERE TABLE_NAME IN ('BUSEO','SAWON');

--부모 테이블에 설정된 PRIMARY KEY 제약조건을 활성화 처리 처리 후 자식 테이블에 설정된 FOREIGN KEY 제약조건을 활성화 처리
ALTER TABLE BUSEO ENABLE PRIMARY KEY; 
ALTER TABLE SAWON ENABLE CONSTRAINT SAWON_BNO_FK;
SELECT CONSTRAINT_NAME,CONSTRAINT_TYPE,R_CONSTRAINT_NAME,STATUS FROM USER_CONSTRAINTS WHERE TABLE_NAME IN ('BUSEO','SAWON');

--BUSEO 테이블의 BNO 컬럼에 설정된 PRIMARY KEY 제약조건 삭제
--FOREIGN KEY 제약조건에 의해 참조되는 부모 테이블의 PRIMARY KEY 제약조건은 삭제시 에러 발생
ALTER TABLE BUSEO DROP PRIMARY KEY;

--CASCADE 키워드를 사용하여 부모 테이블의 PRIMARY KEY 제약조건을 삭제하면 자식 테이블의 설정된 FOREIGN KEY 제약조건도 같이 삭제
ALTER TABLE BUSEO DROP PRIMARY KEY CASCADE;
SELECT CONSTRAINT_NAME,CONSTRAINT_TYPE,R_CONSTRAINT_NAME,STATUS FROM USER_CONSTRAINTS WHERE TABLE_NAME IN ('BUSEO','SAWON');

--뷰(VIEW) : 테이블을 기반으로 만들어지는 가상의 테이블
--뷰를 이용하여 보다 쉬운 행 검색 기능을 제공하거나 보안(객체 권한) 기능 제공

--단순뷰 : 하나의 테이블을 기반으로 만들어진 뷰 - 검색뿐만 아니라 행의 삽입,변경,삭제 가능(테이블 적용)
--복합뷰 : 여러 개 테이블을 기반으로 만들어진 뷰 - 검색만 가능
--단순뷰는 DISTINCT 키워드 또는 그룹함수 사용이 불가능하지만 복합뷰는 가능

--뷰 생성 : 서브쿼리 이용
--형식)CREATE [OR REPLACE] [{FORCE|NOFORCE}] VIEW 뷰이름[(컬럼명,컬럼명,...)] 
--    AS SELECT 검색대상,검색대상,... FROM 테이블명 [WHERE 조건식] [WITH CHECK OPTION] [WITH READ ONLY] 
--CREATE OR REPLACE : 동일한 이름의 기존 뷰가 있으면 제거하고 새로운 뷰 생성
--FORCE : 서브쿼리의 검색결과가 없어도 강제로 뷰를 생성하는 기능 제공
--WITH CHECK OPTION : 뷰를 생성한 서브쿼리의 조건식에 컬럼값을 변경하지 못하도록 설정하는 기능 제공
--WITH READ ONLY : 검색 기능만 제공하도록 설정하는 기능(단순뷰)
