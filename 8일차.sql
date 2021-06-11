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

--KIM 계정으로 DBMS 서버 접속
-- >> KIM 계정에게 CREATE SESSION 시스템 권한이 없어서 접속 거부

--관리자가 KIM 계정에게 CREATE SESSION 시스템 권한 부여 - 관리자 접속 세션
--GRANT CREATE SESSION TO KIM;

--CREATE SESSION 시스템 권한 부여 후 KIM 계정으로 DBMS 서버 접속 - SQLPLUS : 접속 가능
--SQL> CONN KIM/1234
--SQL> SHOW USER




























































