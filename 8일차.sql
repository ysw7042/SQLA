--�����(USER) : DBMS ������ �����Ͽ� ����� �� �ִ� ������� ����� - ����(ACCOUNT)
--���� ������ ������(SYS �Ǵ� SYSTEM)�� ����

--���� ����
--����)CREATE USER ������ IDENTIFIED BY ��й�ȣ

--KIM ���� ���� - ������ ���� ����
--CREATE USER KIM IDENTIFIED BY 1234;

--���� Ȯ�� - DBA_USERS : ����� ������ �����ϴ� ��ųʸ�
--SELECT USERNAME,ACCOUNT_STATUS,DEFAULT_TABLESPACE,CREATED FROM DBA_USERS WHERE USERNAME='KIM';

--������ ��й�ȣ ���� - ������ ��й�ȣ�� �⺻������ 180���� ��ȿ�Ⱓ���� ����
--����)ALTER USER ����ڸ� IDENTIFIED BY ��й�ȣ

--KIM ������ ��й�ȣ ���� - ������ ���� ����
--ALTER USER KIM IDENTIFIED BY 5678;

--���� ���� ���� : OPEN(���� Ȱ��ȭ - ���� ����) �Ǵ� LOCK(���� ��Ȱ�� - ���� �Ұ���)
--����Ŭ ���ӽ� ������ ��й�ȣ�� 5�� Ʋ���� ���� ���°� �ڵ����� LOCK ���·� ����Ǿ� ���� �Ұ���
--����)ALTER USER ������ ACCOUNT {LOCK|UNLOCK}

--KIM ������ OPEN ���¸� LOCK ���·� ���� - ������ ���� ����
--SELECT USERNAME,ACCOUNT_STATUS,DEFAULT_TABLESPACE,CREATED FROM DBA_USERS WHERE USERNAME='KIM';
--ALTER USER KIM ACCOUNT LOCK;
--SELECT USERNAME,ACCOUNT_STATUS,DEFAULT_TABLESPACE,CREATED FROM DBA_USERS WHERE USERNAME='KIM';

--KIM ������ LOCK ���¸� OPNE ���·� ���� - ������ ���� ����
--ALTER USER KIM ACCOUNT UNLOCK;
--SELECT USERNAME,ACCOUNT_STATUS,DEFAULT_TABLESPACE,CREATED FROM DBA_USERS WHERE USERNAME='KIM';

--������ �⺻ ���̺����̽� ����
--���̺����̽�(TABLESPACE) : ����Ÿ���̽� ��ü(���̺�,������,�ε��� ��)�� ����Ǵ� ����
-- >> �ý��� ���̺����̽�(SYSTEM - �⺻)�� ����� ���̺����̽�(USERS)
--����)ALTER USER ������ DEFAULT TABLESPACE ���̺����̽���

--KIM ������ �⺻ ���̺����̽��� SYSTEM���� USERS�� ���� - ������ ���� ����
--SELECT USERNAME,ACCOUNT_STATUS,DEFAULT_TABLESPACE,CREATED FROM DBA_USERS WHERE USERNAME='KIM';
--ALTER USER KIM DEFAULT TABLESPACE USERS;
--SELECT USERNAME,ACCOUNT_STATUS,DEFAULT_TABLESPACE,CREATED FROM DBA_USERS WHERE USERNAME='KIM';

--������ ���� ���̺����̽��� ������ ���� ũ���� ���� ���� ����
--����)ALTER USER ������ QUOTA ����ũ�� ON ���̺����̽���

--KIM ������ ������ ����ũ�⸦ ���������� ���� - ������ ���� ����
--ALTER USER KIM QUOTA UNLIMITED ON USERS;

--������ ���� �뷮 Ȯ�� - DBA_TS_QUOTAS : ������� ���̺����̽� ���� �뷮�� ���� ������ �����ϴ� ��ųʸ�
--SELECT TABLESPACE_NAME,USERNAME,MAX_BYTES FROM DBA_TS_QUOTAS WHERE USERNAME='KIM';

--���� ����
--����)DROP USER ������

--KIM ���� ���� - ������ ���� ����
--DROP USER KIM;
--SELECT USERNAME,ACCOUNT_STATUS,DEFAULT_TABLESPACE,CREATED FROM DBA_USERS WHERE USERNAME='KIM';

--DCL(DATA CONTROL LANGUAGE) - ����Ÿ �����
--�������� ������ �ο��ϰų� ȸ���ϴ� ���
--����Ŭ ����(PRIVILEGE) : �ý��� ����(������) �Ǵ� ��ü ����(�Ϲ� �����)
--��(ROLE) : �ý��� ������ �׷�ȭ�Ͽ� ǥ���� ��Ī

--�ý��� ���� �ο�
--����)GRANT {PRIVILEGE|ROLE},{PRIVILEGE|ROLE},... TO ������ [WITH ADMIN OPTION] [IDENTIFIED BY ��й�ȣ]
--������ ��� PUBLIC Ű���带 ����� ��� ��� ����ڿ��� �ϰ������� �ý��� ���� �ο�
--������ �ο��� ������ ���� ��� ���� �ڵ� ����
--������ �ڵ����� ������ ��� �ݵ�� IDENTIFIED BY �������� ��й�ȣ ����
--WITH ADMIN OPTION : �ο� ���� �ý��� ������ �ٸ� ����ڿ��� �ο��ϰų� ȸ���ϴ� ��� ����

--KIM ���� ���� - ������ ���� ����
--CREATE USER KIM IDENTIFIED BY 1234;

--KIM �������� DBMS ���� ���� - SQLPLUS ��� : ���� �Ұ���
--SQL> CONN KIM/1234
-- >> KIM �������� CREATE SESSION �ý��� ������ ��� ���� �ź�

--�����ڰ� KIM �������� CREATE SESSION �ý��� ���� �ο� - ������ ���� ����
--GRANT CREATE SESSION TO KIM;

--CREATE SESSION �ý��� ���� �ο� �� KIM �������� DBMS ���� ���� - SQLPLUS : ���� ����
--SQL> CONN KIM/1234
--SQL> SHOW USER

--KIM �������� SAWON ���̺� ���� : �����ȣ(������-PRIMARY KEY),����̸�(������),�޿�(������) - SQLPLUS ��� : ���� �Ұ���
--SQL>CREATE TABLE SAWON(NO NUMBER(4) PRIMARY KEY,NAME VARCHAR2(2),PAY NUMBER);
-- >> KIM �������� CREATE TABLE �ý��� ������ ��� ���̺� ���� ��� ���� ���� �߻�

--�����ڰ� KIM �������� CREATE TABLE �ý��� ���� �ο� - ������ ���� ����
--GRANT CREATE TABLE TO KIM;
--�����ڰ� KIM ������ �⺻ ���̺����̿� ���� �뷮 ���� - ������ ���� ����
--ALTER USER KIM DEFAULT TABLESPACE USERS;
--ALTER USER KIM QUOTA 50M ON USERS;

--KIM ������ CREATE TABLE �ý��� ���� �ο� �� ������ ���̺����̽� ���� �� SAWON ���̺� ���� - SQLPLUS ��� : ���� ����
--SQL>CREATE TABLE SAWON(NO NUMBER(4) PRIMARY KEY,NAME VARCHAR2(2),PAY NUMBER);

--��ü ���� : ������� �ܺ� ��Ű���� �ִ� ��ü ��� ��� ����
--INSERT,UPDATE,DELETE,SELECT ���� ��ɰ� ���õ� ���
--����)GRANT {ALL|PRIVILEGE,PRIVILEGE,...} ON ��ü�� TO ������ [WITH GRANT OPTION]
--ALL : ��ü�� ���õ� ��� ��� ��� ���� ǥ��
--WITH GRANT OPTION : �ο����� ��ü������ �ٸ� �������� �ο��ϰų� ȸ���� �� �ִ� ��� ����

--DEPT ���̺��� ��� �μ����� �˻� - ������� �ܺ� ��Ű���� ��ü�� ǥ��
SELECT * FROM SCOTT.DEPT;
--���� ������� �ܺ� ��Ű���� �����ϴ� ��ü�� ��� ��Ű���� ���� ����
SELECT * FROM DEPT;

--KIM ������ SCOTT ��Ű���� �����ϴ� DEPT ���̺��� ��� �μ����� �˻� -SQLPLUS ��� : �˻� �Ұ���
-- >> SCOTT ��Ű���� �ִ� DEPT ���̺� ���� SELECT ��� ��� ������ �����Ƿ� ���� �߻�
--SQL>SELECT * FROM SCOTT.DEPT;

--SCOTT ������ KIM �������� SCOTT ��Ű���� �ִ� DEPT ���̺� ���� SELECT ��� ���� �ο�
GRANT SELECT ON DEPT TO KIM;

--KIM ������ ��ü ������ �ο����� �� SCOTT ��Ű���� �����ϴ� DEPT ���̺��� ��� �μ����� �˻� -SQLPLUS ��� : �˻� ����
--SQL>SELECT * FROM SCOTT.DEPT;

--�ٸ� �������� �ο��� ��ü ���� Ȯ�� - USER_TAB_PRIVS_MADE : ��ü ������ �ο��� ������ �����ϴ� ��ųʸ�
SELECT * FROM USER_TAB_PRIVS_MADE;

--�ٸ� ������ ������ ��ü ���� Ȯ�� - USER_TAB_PRIVS_RECD : ��ü ������ �ο� ���� ������ �����ϴ� ��ųʸ�
SELECT * FROM USER_TAB_PRIVS_RECD;

--�ý��� ���� ȸ�� : �������� �ο��� ��� �ý��� ������ ȸ���ص� ���� �̻���
--����)REVOKE {PRIVILEGE|ROLE},{PRIVILEGE|ROLE},... FROM ������ [WITH ADMIN OPTION]

--��ü ���� ȸ��
--����)REVOKE {ALL|PRIVILEGE,PRIVILEGE,...} ON ��ü�� FROM ������ [WITH GRANT OPTION]

--SOCTT ������ KIM �������� �ο��� DEPT ���̺� ���� SELECT ��� ��� ���� ȸ��
REVOKE SELECT ON DEPT FROM KIM;
SELECT * FROM USER_TAB_PRIVS_MADE;

--�����ڰ� KIM �������� �ο��� CREATE SESSION �ý��� ���� ȸ�� - ������ ���� ����
--REVOKE CREATE SESSION FROM KIM;

--��(ROLE) : �����ڰ� ������ �ý��� ���ϴ� ���� ȿ�������� �ο��ϰų� ȸ���ϱ� ���� ����ϴ� �ý��� ���� �׷�
--����Ŭ������ �⺻������ �����Ǵ� �� ����
--CONNECT : 8���� �ý��� ���� �׷� - CREATE SESSION,CREATE TABLE,ALTER SESSION,CREATE SYNONYM ��
--RESOURCE : ��ü ���� �ý��� ���� �׷� - CREATE TABLE,CREATE SEQUENCE, CREATE TRIGGER ��
--DBA : �ý��� ������ �ʿ��� ��� �ý��� ���� �׷� - ������ ���� ���� ��

--�����ڰ� LEE �������� CONNECT�� RESOURCE �� �ο� - ������ ���� ����
--LEE ������ ���� ��� �ý��� ���� �ο��� ���� �ڵ� ���� : ��й�ȣ ����
--GRANT CONNECT,RESOURCE TO LEE IDENTIFIED BY 5678;

--LEE �������� DBMS ������ �����Ͽ� SAWON ���̺� ���� : �����ȣ(������-PRIMARY KEY),����̸�(������),�޿�(������) - SQLPLUS ���
--SQL>CONN LEE/5678
--SQL>CREATE TABLE SAWON(NO NUMBER(4) PRIMARY KEY,NAME VARCHAR2(2),PAY NUMBER);

--�����ڰ� LEE �������� �ο��� CONNECT�� RESOURCE �� ȸ��
--REVOKE CONNECT,RESOURCE FROM LEE;

--PL/SQL(PROCEDUARAL LANGUAGE EXTENSION TO SQL) : SQL�� ���� ���� ����,���� ó��,�ݺ� ó�� ����� �����ϴ� ���

--���κ��� �������� �����Ͽ� PL/SQL �ۼ�
--1.DECLARE ����(�����) : DECLARE - ����
--2.EXECUTABLE ����(�����) : BEGIN - �ʼ�
--3.EXCEPTION ����(����ó����) : EXCEPTION - ����

--�������� �ϳ��� ����� �����ϱ� ���� ; ���
--������ ������ END Ű����� ������ �� ; ���
--PL/SQL ������ ���� �������� /�� ���

--�޼����� ����� �� �ֵ��� ������ ȯ�溯�� ������ ����
SET SERVEROUT ON;

--�޼����� ����ϴ� �Լ� : PL/SQL ����ο��� ȣ���Ͽ� ���
--����)DBMS_OUTPUT.PUT_LINE(��¸޼���)

--������ �޼����� ����ϴ� PL/SQL �ۼ�
BEGIN
    DBMS_OUTPUT.PUT_LINE('HELLO, ORACLE!!!');
END;
/

--���� ����� �ʱⰪ �Է� - �����
--����)������ [CONSTANT] �ڷ��� [NOT NULL] [{:=|DEFAULT} ǥ����]
--CONSTANT : ������ ����� �ʱⰪ�� �������� ���ϵ��� �����ϴ� Ű���� - ��� ����
--NOT NULL : ������ NULL ���� �Ұ���
--:= : ���Կ�����
--ǥ���� : ������ ����Ǵ� ���� ���� ǥ�� ��� - ��,����(���尪),�����(�����),�Լ�(��ȯ��)

--����� ������ ���尪 ���� - �����
--����)������ := ǥ����

--��Į�� ���� : ���� ����Ŭ �ڷ����� �̿��Ͽ� ���� ����

--��Į�� ������ �����Ͽ� ���� �����ϰ� ȭ�鿡 �������� ����ϴ� PL/SQL �ۼ�
DECLARE
    VEMPNO NUMBER(4) := 7788;
    VENAME VARCHAR2(20) := 'SCOTT';
BEGIN
    DBMS_OUTPUT.PUT_LINE('�����ȣ / ����Ƹ�');
    DBMS_OUTPUT.PUT_LINE('--------------------------------');
    DBMS_OUTPUT.PUT_LINE(VEMPNO||' / '||VENAME);
    DBMS_OUTPUT.PUT_LINE('--------------------------------');
    VEMPNO := 7893;
    VENAME := 'KING';
    DBMS_OUTPUT.PUT_LINE(VEMPNO||' / '||VENAME);
END;
/

--���۷��� ���� : �ٸ� ������ �ڷ��� �Ǵ� ���̺��� �÷� �ڷ����� �̿��Ͽ� ���� ���� - �����
--����)������ {������%TYPE|���̺��.�÷���%TYPE}

--���̺� �˻����� �÷����� ������ �����ϴ� ��� - �����
--����)SELECT �˻����,�˻����,... INTO ������,������,... FROM ���̺�� [WHERE ���ǽ�] 
-- >> �˻����� ������ �ڷ��� �� ������ �ݵ�� ����

--EMP ���̺��� EMPNO �÷��� ENAME �÷��� �ڷ����� �̿��Ͽ� ���۷��� ������ �����ϰ� EMP ���̺��� ����̸���
--SCOTT�� ����� �����ȣ,����̸��� �˻��Ͽ� ���۷��� ������ ���� �� ����ϴ� PL/SQL �ۼ�
DECLARE
    VEMPNO EMP.EMPNO%TYPE;
    VENAME EMP.ENAME%TYPE;
BEGIN
    SELECT EMPNO,ENAME INTO VEMPNO,VENAME FROM EMP WHERE ENAME='SCOTT';
    DBMS_OUTPUT.PUT_LINE('�����ȣ / ����Ƹ�');
    DBMS_OUTPUT.PUT_LINE('--------------------------------');
    DBMS_OUTPUT.PUT_LINE(VEMPNO||' / '||VENAME);
END;
/

--���̺� ���� : ���̺��� ���� �˻��࿡ ���� �÷����� �����ϱ� ���� ���� - �迭
--����)���̺����� ���̺�Ÿ�Ը�
--���̺� ������ �����ϱ� ���� ���̺� ������ ���� �ڷ���(���̺� Ÿ��) ����
--����)TYPE ���̺�Ÿ�Ը� IS TABLE OF {�ڷ���|������%TYPE|���̺��.�÷���%TYPE} [NOT NULL] [INDEX BY BINARY_INTEGER]

--���̺� ���� ����� : ���̺� ������ ��Ҵ� ÷�ڸ� �̿��Ͽ� ǥ�� - ÷�ڴ� 1���� 1�� �����Ǵ� ���ڰ����� ǥ��
--����)���̺���(÷��)
    
--EMP ���̺��� EMPNO �÷��� ENAME �÷��� �ڷ����� �̿��Ͽ� ���̺� ������ �����ϰ� EMP ���̺��� ���
--����� �����ȣ,����̸��� �˻��Ͽ� ���̺� ������ ���� �� ����ϴ� PL/SQL �ۼ�
DECLARE
    /* ���̺� Ÿ�� ���� */
    TYPE EMPNO_TABLE_TYPE IS TABLE OF EMP.EMPNO%TYPE INDEX BY BINARY_INTEGER;
    TYPE ENAME_TABLE_TYPE IS TABLE OF EMP.ENAME%TYPE INDEX BY BINARY_INTEGER;
    
    /* ���̺� ���� ���� */
    VEMPNO_TABLE EMPNO_TABLE_TYPE;
    VENAME_TABLE ENAME_TABLE_TYPE;
    
    /* ���̺� ������ ÷�� ��Ȱ�� �ϱ� ���� ���� ���� - �ʱⰪ ���� */
    I BINARY_INTEGER := 0;
BEGIN
    /* EMP ���̺��� ��� ����� �����ȣ,����̸��� �˻��Ͽ� ���̺� ������ ��ҿ� ���ʴ�� �����ϵ��� �ݺ� ó�� */
    FOR K IN (SELECT EMPNO,ENAME FROM EMP) LOOP
        I := I + 1;
        VEMPNO_TABLE(I) := K.EMPNO;
        VENAME_TABLE(I) := K.ENAME;
    END LOOP;
    
    DBMS_OUTPUT.PUT_LINE('�����ȣ / ����Ƹ�');
    DBMS_OUTPUT.PUT_LINE('--------------------------------');   
    /* ���̺� ������ ��Ұ��� ȭ�鿡 ��µǵ��� �ݺ� ó�� */
    FOR J IN 1..I LOOP
        DBMS_OUTPUT.PUT_LINE(VEMPNO_TABLE(J)||' / '||VENAME_TABLE(J));
    END LOOP;
END;
/

--���ڵ� ���� : ���̺� ���� ��� �÷����� �����ϱ� ���� ���� - VO Ŭ���� 
--����)���ڵ庯�� ���ڵ�Ÿ�Ը�
--���ڵ� ������ �����ϱ� ���� ���ڵ� ������ ���� �ڷ���(���ڵ� Ÿ��) ����
--����)TYPE ���ڵ�Ÿ�Ը� IS RECORD(�ʵ�� {�ڷ���|������%TYPE|���̺��.�÷���%TYPE} [NOT NULL] [{:=|DEFAULT} ǥ����]
--     ,�ʵ�� {�ڷ���|������%TYPE|���̺��.�÷���%TYPE} [NOT NULL] [{:=|DEFAULT} ǥ����],...)

--���ڵ� ���� ��� ���
--����)���ڵ庯��.�ʵ��

--EMP ���̺��� �����ȣ,����̸�,����,�޿�,�μ���ȣ�� ������ �� �ִ� ���ڵ� ������ �����ϰ� EMP ���̺��� �����ȣ�� 
--7844�� ����� �����ȣ,����̸�,����,�޿�,�μ���ȣ�� �˻��Ͽ� ���ڵ� ������ ���� �� ȭ�鿡 ����ϴ� PL/SQL �ۼ�
DECLARE
    /* ���ڵ� Ÿ�� ���� */
    TYPE EMP_RECORD_TYPE IS RECORD(VEMPNO EMP.EMPNO%TYPE,VENAME EMP.ENAME%TYPE,VJOB EMP.JOB%TYPE
        ,VSAL EMP.SAL%TYPE,VDEPTNO EMP.DEPTNO%TYPE);

    /* ���ڵ� ���� ���� */
    EMP_RECORD EMP_RECORD_TYPE;
BEGIN
    /* �˻����� �÷����� ���ڵ� ������ �ʵ忡 ���� */
    SELECT EMPNO,ENAME,JOB,SAL,DEPTNO INTO EMP_RECORD.VEMPNO,EMP_RECORD.VENAME,EMP_RECORD.VJOB,
        EMP_RECORD.VSAL,EMP_RECORD.VDEPTNO FROM EMP WHERE EMPNO=7844;

    DBMS_OUTPUT.PUT_LINE('�����ȣ = '||EMP_RECORD.VEMPNO);
    DBMS_OUTPUT.PUT_LINE('����̸� = '||EMP_RECORD.VENAME);
    DBMS_OUTPUT.PUT_LINE('���� = '||EMP_RECORD.VJOB);
    DBMS_OUTPUT.PUT_LINE('�޿� = '||EMP_RECORD.VSAL);
    DBMS_OUTPUT.PUT_LINE('�μ���ȣ = '||EMP_RECORD.VDEPTNO);
END;
/

--���ڵ� Ÿ�� ���� ���̺��� ���� �̿��Ͽ� ���ڵ� ���� ���� ���� 
-- >> ���ڵ� ������ �ʵ��� �ڷ�����  ���̺��� �÷���� �ڷ����� �̿��Ͽ� ����
--����)���ڵ庯�� ���̺��%ROWTYPE

--EMP ���̺��� �����ȣ,����̸�,����,�޿�,�μ���ȣ�� ������ �� �ִ� ���ڵ� ������ �����ϰ� EMP ���̺��� �����ȣ�� 
--7844�� ����� �����ȣ,����̸�,����,�޿�,�μ���ȣ�� �˻��Ͽ� ���ڵ� ������ ���� �� ȭ�鿡 ����ϴ� PL/SQL �ۼ�
DECLARE
    EMP_RECORD EMP%ROWTYPE;
BEGIN
    /* �˻���(������)�� ��� �÷����� ���ڵ� ������ ���� �̸��� �ʵ忡 �ڵ� ���� */
    SELECT * INTO EMP_RECORD FROM EMP WHERE EMPNO=7844;
    
    DBMS_OUTPUT.PUT_LINE('�����ȣ = '||EMP_RECORD.EMPNO);
    DBMS_OUTPUT.PUT_LINE('����̸� = '||EMP_RECORD.ENAME);
    DBMS_OUTPUT.PUT_LINE('���� = '||EMP_RECORD.JOB);
    DBMS_OUTPUT.PUT_LINE('�޿� = '||EMP_RECORD.SAL);
    DBMS_OUTPUT.PUT_LINE('�μ���ȣ = '||EMP_RECORD.DEPTNO);
END;
/
    
--���ù� : ����� �����Ͽ� �����ϱ� ���� ����
--IF : ���ǽĿ� ���� ����� ���� ����
--����)IF(���ǽ�) THEN ���;���;... END IF;
-- >> ( )�� �����Ͽ� ���ǽ� �ۼ� ����

--EMP ���̺��� �����ȣ�� 7788�� ����� �˻��Ͽ� �����ȣ,����̸�,�μ���ȣ�� ���� �μ��̸��� ����ϴ� PL/SQL �ۼ�
--�μ���ȣ�� ���� �μ��̸� : 10(ACCOUNTING),20(RESEARCH),30(SALES),40(OPERATION)
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

    DBMS_OUTPUT.PUT_LINE('�����ȣ = '||VEMP.EMPNO);
    DBMS_OUTPUT.PUT_LINE('����̸� = '||VEMP.ENAME);
    DBMS_OUTPUT.PUT_LINE('�μ��̸� = '||VDNAME);
END;
/

--����)IF(���ǽ�) THEN ���;���;... ELSE ���;���;... END IF;

--EMP ���̺��� �����ȣ�� 7788�� ����� �˻��Ͽ� �����ȣ,����̸�,������ ����ϴ� PL/SQL �ۼ�
--���� : (�޿�+������)*12
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
        
    DBMS_OUTPUT.PUT_LINE('�����ȣ = '||VEMP.EMPNO);
    DBMS_OUTPUT.PUT_LINE('����̸� = '||VEMP.ENAME);
    DBMS_OUTPUT.PUT_LINE('���� = '||ANNUAL);
END;
/

--����)IF(���ǽ�) THEN ���;���;... ELSIF(���ǽ�) THEN ���;���;... [ELSE ���;...] END IF;

--EMP ���̺��� �����ȣ�� 7788�� ����� �˻��Ͽ� �����ȣ,����̸�,�μ���ȣ�� ���� �μ��̸��� ����ϴ� PL/SQL �ۼ�
--�μ���ȣ�� ���� �μ��̸� : 10(ACCOUNTING),20(RESEARCH),30(SALES),40(OPERATION)
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

    DBMS_OUTPUT.PUT_LINE('�����ȣ = '||VEMP.EMPNO);
    DBMS_OUTPUT.PUT_LINE('����̸� = '||VEMP.ENAME);
    DBMS_OUTPUT.PUT_LINE('�μ��̸� = '||VDNAME);
END;
/

--CASE : ������ ����� ���� ���Ͽ� ����� ���� �����ϰų� ���ǽ��� �̿��Ͽ� ����� ���� �����ϴ� ����
--����)CASE ������ WHEN ��1 THEN ���;... WHEN ��2 THEN ���;... END CASE;

--EMP ���̺��� �����ȣ�� 7788�� ����� �˻��Ͽ� �����ȣ,����̸�,����,�޿�,������ �޿� ���޾��� ����ϴ� PL/SQL �ۼ�
--������ �޿� ���޾� : ������ ���� ������ ���ҵ� �޿�
-- >> ANALYST : �޿�*1.1, CLERK : �޿�*1.2, MANAGER : �޿�*1.3, PRESIDENT : �޿�*1.4, SAELSMAN : �޿�*1.5
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
    
    DBMS_OUTPUT.PUT_LINE('�����ȣ = '||VEMP.EMPNO);
    DBMS_OUTPUT.PUT_LINE('����̸� = '||VEMP.ENAME);
    DBMS_OUTPUT.PUT_LINE('���� = '||VEMP.JOB);
    DBMS_OUTPUT.PUT_LINE('�޿� = '||VEMP.SAL);
    DBMS_OUTPUT.PUT_LINE('�����޾� = '||VPAY);
END;
/    

--����)CASE WHEN ���ǽ� THEN ���;... WHEN ���ǽ� THEN ���;... END CASE;

--EMP ���̺��� �����ȣ�� 7788�� ����� �˻��Ͽ� �����ȣ,����̸�,�޿�,�޿������ ����ϴ� PL/SQL �ۼ�
--�޿���� : E(0~1000), D(1001~2000), C(2001~3000), B(3001~4000), A(40001~5000) 
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

        DBMS_OUTPUT.PUT_LINE('�����ȣ = '||VEMP.EMPNO);
        DBMS_OUTPUT.PUT_LINE('����̸� = '||VEMP.ENAME);
        DBMS_OUTPUT.PUT_LINE('�޿� = '||VEMP.SAL);
        DBMS_OUTPUT.PUT_LINE('�޿���� = '||VGRADE);
END;
/    


















