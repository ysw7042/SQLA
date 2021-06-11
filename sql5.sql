--MERGE : �ҽ� ���̺��� ���� �˻��Ͽ� Ÿ�� ���̺� ���� �����ϰų� ���� �÷����� �����ϴ� ��� - ���̺� ����ȭ
--����)MERGE INTO Ÿ�����̺� USING �ҽ����̺� ON (���ǽ�)
--     WHEN MATCHED THEN UPDATE SET Ÿ���÷���=�ҽ��÷���,Ÿ���÷���=�ҽ��÷���,...
--     WHEN NOT MATCHED THEN INSERT(Ÿ���÷���,Ÿ���÷���,...) VALUES(�ҽ��÷���,�ҽ��÷���,...)

--DEPT ���̺�� ������ �Ӽ��� MERGE_DEPT ���̺� ����
CREATE TABLE MERGE_DEPT(DEPTNO NUMBER(2),DNAME VARCHAR2(10),LOC VARCHAR2(11));
DESC MERGE_DEPT;

--MERGE_DEPT ���̺� �� ����
INSERT INTO MERGE_DEPT VALUES(30,'�ѹ���','����');
INSERT INTO MERGE_DEPT VALUES(60,'�����','��õ');
COMMIT;
SELECT * FROM MERGE_DEPT;

--DEPT ���̺�(�ҽ� ���̺�)�� ����� ��� �μ������� �˻��Ͽ� MERGE_DEPT ���̺�(Ÿ�� ���̺�)�� ���� �Ǵ� ���� - ���̺� ��Ī ���
SELECT * FROM DEPT;--�ҽ� ���̺�
SELECT * FROM MERGE_DEPT;--Ÿ�� ���̺�

MERGE INTO MERGE_DEPT M USING DEPT D ON (M.DEPTNO=D.DEPTNO)
    WHEN MATCHED THEN UPDATE SET M.DNAME=D.DNAME,M.LOC=D.LOC
    WHEN NOT MATCHED THEN INSERT(M.DEPTNO,M.DNAME,M.LOC) VALUES(D.DEPTNO,D.DNAME,D.LOC);

SELECT * FROM MERGE_DEPT;

--TCL(TRANSACTION CONTROL LANGUAGE) : Ʈ������ �����
--SQL ����� ����� Ʈ�������� ���� ���̺� �����ϰų� �������� �ʰ� ����ϴ� ���

--Ʈ������(TRANSACTION) : ���� ���ǿ��� DBMS ������ ���޵Ǿ� ����� SQL ����� �����ϱ� ���� �۾� ���� - SQL ����� �׷�
--����(SESSION) : DBMS ������ �����Ͽ� SQL ����� �����Ͽ� ������ �� �ִ� ������� �۾�ȯ��

--Ʈ�����ǿ� ����� SQL ����� ���� ���̺� �����ϴ� ��� : Ŀ��(COMMIT) ó�� - Ʈ������ �ʱ�ȭ
--1.���� ������ ���������� ����� ��� �ڵ����� Ŀ�� ó��
--2.DDL ��� �Ǵ� DCL ����� ���ǿ� ���޵Ǿ� Ʈ�����ǿ� ����� ��� �ڵ����� Ŀ�� ó��
--3.Ʈ�����ǿ� ����� DML ����� COMMIT ����� ����Ͽ� �������� Ŀ�� ó��

--Ʈ�����ǿ� ����� SQL ����� ���� ���̺� �������� �ʰ� Ʈ������ �ʱ�ȭ�ϴ� ��� - �ѹ�(ROLLBACK) ó��
--1.���� ������ ������������ ����� ��� �ڵ����� �ѹ� ó��
--2.Ʈ�����ǿ� ����� DML ����� ROLLBACK ����� ����Ͽ� �������� �ѹ� ó��

--DPET ���̺� ����� ��� �μ����� �˻� - Ʈ�����ǿ� ����� DML ����� �������� ���� ���̺��� �˻���� ����
SELECT * FROM DEPT;

--DPET ���̺��� �μ���ȣ�� 50�� �μ����� ����
-- >> ���� ���̺� DELETE ����� ����Ǿ� ���� �������� �ʰ� Ʈ�����ǿ� DELETE ����� ����
DELETE FROM DEPT WHERE DEPTNO=50;

--DPET ���̺� ����� ��� �μ����� �˻�
-- >> ���� ���̺��� �˻������ Ʈ�����ǿ� ����� DELETE ����� ����� �˻������ ����
SELECT * FROM DEPT;

--�ѹ� ó�� : Ʈ������ �ʱ�ȭ - Ʈ�����ǿ� ����� ��� SQL ��� ����
ROLLBACK;
SELECT * FROM DEPT;

--DPET ���̺��� �μ���ȣ�� 50�� �μ����� ���� - Ʈ�����ǿ� DELETE ��� ����
DELETE FROM DEPT WHERE DEPTNO=50;
--���� ���̺� DELETE ����� �����ϱ� ���� Ŀ�� ó�� - Ŀ�� ó�� �� Ʈ������ �ʱ�ȭ
COMMIT;
SELECT * FROM DEPT;

--EMP ���̺� ����� ��� ������� ����
DELETE FROM EMP;
SELECT * FROM EMP;
--���޵Ǿ� ����� DML ����� �߸��� ��� �ѹ�ó���� ���� ������ ���� Ʈ������ �̿�
ROLLBACK;
SELECT * FROM EMP;

--����Ÿ �ϰ����� �����ϱ� ���� Ʈ������ �̿�
--����Ÿ �ϰ��� : DBMS�� ����ϴ� ��� ����ڿ��� ������ �˻� ����� �����ϱ� ���� ���
--���� ���ǿ��� �۾����� ����� �ٸ� ����ڿ��� Ŀ��ó�� ������ �������� �ʵ��� Ʈ������ �̿�

--BONUS ���̺��� ����̸� KIM�� ������� ����
SELECT * FROM BONUS;
DELETE FROM BONUS WHERE ENAME='KIM';
SELECT * FROM BONUS;

--�ٸ� ���ǿ����� BONUS ���̺��� ����̸��� KIM ��� �˻�
--���� ���ǿ��� �۾��� �Ϸ��ϱ� ������ �ٸ� ���ǿ����� �۾� ���� �˻� ��� ���� - ����Ÿ �ϰ���
--���� ���ǿ��� Ŀ�� ó���� �ϸ� �ٸ� ���ǿ����� �۾� �Ϸ� ���� �˻� ��� ����
COMMIT;

--����Ÿ LOCK ����� �����ϱ� ���� Ʈ������ �̿�
--DBMS�� ���� ����� ȯ������ ���� ���̺��� ���� ���Ǹ��� ���� ����
--���� ���ǿ��� �۾� ���� ���̺��� ���� �ٸ� ���ǿ��� �۾����� ���ϵ��� Ʈ�������� �̿��Ͽ� ����Ÿ ��� ��� ����

--BONUS ���̺��� ����̸��� ALLEN�� ����� �޿��� 2000���� ����
SELECT * FROM BONUS;
UPDATE BONUS SET SAL=2000 WHERE ENAME='ALLEN';
SELECT * FROM BONUS;

--�ٸ� ���ǿ��� BONUS ���̺� ����� ��� �� ����̸��� ALLEN�� ����� �������� �޿��� 50%�� ����
--UPDATE BONUS SET COMM=SAL*0.5 WHERE ENAME='ALLEN';
--���� ���ǿ��� �۾� ���� ���� �ٸ� ���ǿ����� �۾����� ���ϵ��� Ʈ�����ǿ� ���� ����Ÿ ��� ��� Ȱ��ȭ
--�ٸ� ���ǿ��� ���� ������ �۾����� ������ ��� ������ ���°� �Ͻ� ���� ���·� ����
-- >> ���� ���ǿ��� Ŀ�� ó�� �Ǵ� �ѹ� ó���� �ؾ߸� �ٸ� ������ ��� ����
COMMIT;
SELECT * FROM BONUS;

--SAVEPOINT : Ʈ�����ǿ� ���� ���̴� ���
--���� �̿��Ͽ� ���ϴ� ��ġ������ SQL ����� �ѹ� ó���ϱ� ���� ���
--����)SAVEPOINT �󺧸�

--BONUS ���̺��� ����̸��� ALLEN�� ������� ����
SELECT * FROM BONUS;
DELETE FROM BONUS WHERE ENAME='ALLEN';
SELECT * FROM BONUS;

--BONUS ���̺��� ����̸��� MARTIN�� ������� ����
DELETE FROM BONUS WHERE ENAME='MARTIN';
SELECT * FROM BONUS;

--�ѹ� ó�� : Ʈ������ �ʱ�ȭ - Ʈ�����ǿ� ����� ��� DML ��� ����
ROLLBACK;
SELECT * FROM BONUS;

--BONUS ���̺��� ����̸��� ALLEN�� ������� ����
DELETE FROM BONUS WHERE ENAME='ALLEN';
SELECT * FROM BONUS;
SAVEPOINT ALLEN_DELETE_AFTER;

--BONUS ���̺��� ����̸��� MARTIN�� ������� ����
DELETE FROM BONUS WHERE ENAME='MARTIN';
SELECT * FROM BONUS;

--SAVEPOINT ������� ������ ���� �̿��� �ѹ� ó��
--����)ROLLBACK TO �󺧸�

--MARTIN ������� ���� ��ɿ� ���ؼ��� �ѹ� ó��
ROLLBACK TO ALLEN_DELETE_AFTER;
SELECT * FROM BONUS;

--ALLEN ������� ���� ��ɿ� ���ؼ��� �ѹ� ó��
ROLLBACK;
SELECT * FROM BONUS;

--DDL(DATA DEFINITION LANGUAGE) : ����Ÿ ���Ǿ�
--����Ÿ���̽� ��ü(���̺�,��,������,�ε���,���Ǿ�,����� ��)�� �����ϱ� ���� ���

--���̺�(TABLE) : ����Ÿ���̽����� ����Ÿ(��)�� �����ϱ� ���� ���� �⺻���� ��ü

--���̺� ���� : ���̺� �Ӽ�(ATTRIBUTE)�� ����
--����)CREATE TABLE ���̺��(�÷��� �ڷ���[(ũ��)] [DEFAULT �⺻��] [�÷���������]
--    ,�÷��� �ڷ���[(ũ��)] [DEFAULT �⺻��] [�÷���������],...[,���̺���������])

--�ĺ��� �ۼ� ��Ģ : ���̺��, �÷���, ��Ī, �󺧸� ��
--1.�����ڷ� ���۵Ǹ� 1~30 ������ ���ڵ�� ����
--2.A~Z,0~9,_,$,# ���ڸ� �����Ͽ� �ۼ� - ��ҹ��� �̱��� : ������ũ ǥ���(�ܾ�� �ܾ�� _�� ����)
--3.�����ڿ� �ٸ� ���� ��� ���� - �����
--4.Ű���带 �ĺ��ڷ� ������ ��� ���� �߻�

--�ڷ���(DATATYPE) : �÷��� ���� ������ ���� ǥ���ϱ� ���� Ű����
--1.������ : NUMBER[(��ü�ڸ���,�Ҽ����ڸ���)]
--2.������ : CHAR(ũ��) - ũ�� : 1~2000(BYTE) >> ������ ����
--          VARCHAR2(ũ��) - ũ�� : 1~4000(BYTE) >> ������ ����
--          LONG - �ִ� 2GBYTE ���� >> ������ : ���̺��� �ϳ��� �÷����� �ο� �����ϸ� ���� �Ұ���
--          CLOB - �ִ� 4GBYTE ���� >> ������ : ���ڵ� ó���� ���ڰ��� ����� �ؽ�Ʈ ������ �����ϱ� ���� �ڷ���
--          BLOB - �ִ� 4GBYTE ���� >> ������ : ���ð��� ����� �Ϲ�(����) ������ �����ϱ� ���� �ڷ���
--3.��¥�� : DATE - ��¥�� �ð�
--          TIMESTAMP - ��(MS) ���� �ð�

--SALESMAN ���̺� ���� - �����ȣ(������),����̸�(������),�Ի���(��¥��)
CREATE TABLE SALESMAN(NO NUMBER(4),NAME VARCHAR2(20),STARTDATE DATE);

--��ųʸ�(DICTIONARY): �ý��� ������ Ȯ�� �� �� �ִ� ������ ���̺�(��)
-- >> USER_DICTIONARY(�Ϲ� �����),DBA_DICTIONARY(������),ALL_DICTIONARY(��� �����)

--USER_OBJECTS : ���� ���� ������� ��ü ������ �����ϴ� ��ųʸ�
SELECT OBJECT_NAME FROM USER_OBJECTS WHERE OBJECT_TYPE='TABLE';

--USER_TABLES : ���� ���� ������� ���̺� ������ �����ϴ� ��ųʸ�
SELECT TABLE_NAME FROM USER_TABLES;
--USER_TABLES ��ųʸ��� ���� ���Ǿ�(SYNONYM)�� TABS ����
SELECT TABLE_NAME FROM TABS;

--���̺� ���� Ȯ��
DESC SALESMAN;

--SALESMAN ���̺� �� ����
INSERT INTO SALESMAN VALUES(1000,'ȫ�浿','00/03/19');
SELECT * FROM SALESMAN;
COMMIT;

--�÷��� ���������� ���� ��� � ���̵� ���� ���� - ����Ÿ ���Ἲ ���� ����
--����Ÿ ���Ἲ : ���̺� �߸��� ��(�÷���)�� ������� �ʵ��� ����
INSERT INTO SALESMAN VALUES(2000,'�Ӳ���',NULL);
INSERT INTO SALESMAN VALUES(1000,'����ġ','10/10/10');
SELECT * FROM SALESMAN;
COMMIT;

--�� ���Խ� �÷� ���� ���� : ������ �÷����� �÷� �⺻�� �ڵ� ����
--���̺� ������ �÷� �⺻���� �������� ���� ��� �÷� �⺻���� NULL�� �ڵ� ����
INSERT INTO SALESMAN(NO,NAME) VALUES(3000,'������');
SELECT * FROM SALESMAN;
COMMIT;

--MANAGER ���̺� ���� : �����ȣ(������),����̸�(������),�Ի���(��¥��-�⺻��:����),�޿�(������-�⺻��:1000)
CREATE TABLE MANAGER(NO NUMBER(4),NAME VARCHAR2(20),STARTDATE DATE DEFAULT SYSDATE,PAY NUMBER DEFAULT 1000);

--���̺� ��� �� ���̺� ���� Ȯ��
SELECT TABLE_NAME FROM TABS WHERE TABLE_NAME='MANAGER';
DESC MANAGER;

--USER_TAB_COLUMNS : ���̺��� �÷� ������ �����ϴ� ��ųʸ�
SELECT COLUMN_NAME,DATA_DEFAULT FROM USER_TAB_COLUMNS WHERE TABLE_NAME='MANAGER';

--MANAGER ���̺� �� ���� - �÷� ����
INSERT INTO MANAGER(NO,NAME) VALUES(1000,'ȫ�浿');
SELECT * FROM MANAGER;
COMMIT;

--��������(CONSTRAINT) : �÷��� �߸��� ���� ����Ǵ� ���� �����ϱ� ���� ��� - ����Ÿ ���Ἲ ����
--�÷� ������ �������� : ���̺��� �Ӽ� ����� �÷��� �������� ����
--���̺� ������ �������� : ���̺� ����� ���̺��� Ư�� �÷��� �������� ����

--NOT NULL : �÷��� NULL�� ����Ǵ� ���� �����ϱ� ���� ��������
--�÷� ������ �����������θ� ���� ����
--NOT NULL ���������� �������� ���� �÷��� �⺻������ NULL ���� ���

--DEPT1 ���̺� ���� : �μ���ȣ(������),�μ��̸�(������),�μ���ġ(������)
CREATE TABLE DEPT1(DEPTNO NUMBER(2),DNAME VARCHAR2(12),LOC VARCHAR2(11));
DESC DEPT1;

--DEPT1 ���̺� �� ���� - �÷��� ��� NULL�� �����Ͽ� ���� ����
INSERT INTO DEPT1 VALUES(10,NULL,NULL);--����� NULL ����
INSERT INTO DEPT1(DEPTNO) VALUES(20);--������ NULL ����
SELECT * FROM DEPT1;
COMMIT;

--DEPT2 ���̺� ���� : �μ���ȣ(������:NOT NULL),�μ��̸�(������:NOT NULL),�μ���ġ(������:NOT NULL)
CREATE TABLE DEPT2(DEPTNO NUMBER(2) NOT NULL,DNAME VARCHAR2(12) NOT NULL,LOC VARCHAR2(11) NOT NULL);
--DESC ������� �÷��� ���� NULL ��� ���� ���� Ȯ�� ����
DESC DEPT2;

--DEPT2 ���̺� �� ����
INSERT INTO DEPT2 VALUES(10,'�ѹ���','����');
--NOT NULL ���������� ������ �÷��� NULL�� ������ ��� ���� �߻�
INSERT INTO DEPT2 VALUES(20,NULL,NULL);
--������ �÷��� �÷� �⺻���� NULL�� ��� �ڵ����� NULL�� ���޵����� NOT NULL �������ǿ� ���� ���� �߻�
INSERT INTO DEPT2(DEPTNO) VALUES(30);
SELECT * FROM DEPT2;
COMMIT;

--USER_CONSTAINTS : ���̺� �÷��� ������ ���������� �����ϴ� ��ųʸ�
--CONSTRAINT_NAME : �������Ǹ� - �������Ǹ��� �������� ������ SYS_XXXXXXX �������� �ڵ� ����
--CONSTRAINT_TYPE : �������� ���� - C(CHECK),P(PRIMARY),U(UNIQUE),R(REFERENCE)
SELECT CONSTRAINT_NAME,CONSTRAINT_TYPE FROM USER_CONSTRAINTS WHERE TABLE_NAME='DEPT2';

--���������� ������ ��� �������� ������ ���� �������Ǹ��� �����ϴ� ���� ����
--����)�÷��� �ڷ���[(ũ��)] CONSTRAINT �������Ǹ� �������� >> �÷� ������ ��������

--DEPT3 ���̺� ���� : �μ���ȣ(������:NOT NULL),�μ��̸�(������:NOT NULL),�μ���ġ(������:NOT NULL)
CREATE TABLE DEPT3(DEPTNO NUMBER(2) CONSTRAINT DEPT3_DEPTNO_NN NOT NULL
    ,DNAME VARCHAR2(11) CONSTRAINT DEPT3_DNAME_NN NOT NULL,LOC VARCHAR2(12) CONSTRAINT DEPT3_LOC_NN NOT NULL);
    
--���̺��� �������� Ȯ��
SELECT CONSTRAINT_NAME,CONSTRAINT_TYPE FROM USER_CONSTRAINTS WHERE TABLE_NAME='DEPT3';

--CHECK : �÷����� ���� ������ �����Ͽ� ���ǿ� �´� ���� ����ǵ��� �����ϴ� ��������
--�÷� ������ �������� �Ǵ� ���̺� ������ ������������ ���� ����

--SAWON1 ���̺� ���� - �����ȣ(������),����̸�(������),�޿�(������)
CREATE TABLE SAWON1(NO NUMBER(4),NAME VARCHAR2(20),PAY NUMBER);

--SAWON1 ���̺� �� ���� - �޿� �÷����� ���޵Ǵ� ���ڰ��� ������ ����
INSERT INTO SAWON1 VALUES(1000,'ȫ�浿',8000000);
INSERT INTO SAWON1 VALUES(2000,'�Ӳ���',800000);
SELECT * FROM SAWON1;
COMMIT;

--SAWON2 ���̺� ���� - �����ȣ(������),����̸�(������),�޿�(������:�ּұ޿�-5000000)
-- >> CHEKC ���������� �÷� ������ ������������ ���� - �ش� �÷����� �̿��Ͽ� ���ǽ� ����
CREATE TABLE SAWON2(NO NUMBER(4),NAME VARCHAR2(20),PAY NUMBER CONSTRAINT SAWON2_PAY_CEHCK CHECK(PAY>=5000000));

--�������� Ȯ��
SELECT CONSTRAINT_NAME,CONSTRAINT_TYPE,SEARCH_CONDITION FROM USER_CONSTRAINTS WHERE TABLE_NAME='SAWON2';

--SAWON2 ���̺� �� ���� 
INSERT INTO SAWON2 VALUES(1000,'ȫ�浿',8000000);
--CHEKC �������ǿ� ���� ������ ���ǽĿ� ���� �ʴ� ���� ������ ��� ���� �߻�
INSERT INTO SAWON2 VALUES(2000,'�Ӳ���',800000);

--SAWON3 ���̺� ���� - �����ȣ(������),����̸�(������),�޿�(������:�ּұ޿�-5000000)
-- >> CHEKC ���������� ���̺� ������ ������������ ���� - ��� �÷��� �̿��Ͽ� ���ǽ� ����
CREATE TABLE SAWON3(NO NUMBER(4),NAME VARCHAR2(20),PAY NUMBER,CONSTRAINT SAWON3_PAY_CEHCK CHECK(NAME<>'ȫ�浿' AND PAY>=5000000));

--�������� Ȯ��
SELECT CONSTRAINT_NAME,CONSTRAINT_TYPE,SEARCH_CONDITION FROM USER_CONSTRAINTS WHERE TABLE_NAME='SAWON3';

--UNIQUE : �ߺ��� �÷��� ������ �����ϱ� ���� ��������
--�÷� ������ �������� �Ǵ� ���̺� ������ ������������ ���� ����
--���̺��� ���� �÷��� UNIQUE �������� ������ �����ϸ� NULL ���

--USER1 ���̺� ���� : ���̵�(������),�̸�(������),��ȭ��ȣ(������)
CREATE TABLE USER1(ID VARCHAR2(20),NAME VARCHAR2(30),PHONE VARCHAR2(15));

--USER1 ���̺� �� ����
INSERT INTO USER1 VALUES('ABC','ȫ�浿','010-1234-5678');
INSERT INTO USER1 VALUES('ABC','ȫ�浿','010-1234-5678');
SELECT * FROM USER1;
COMMIT;

--USER2 ���̺� ���� : ���̵�(������-UNIQUE),�̸�(������),��ȭ��ȣ(������-UNIQUE)
-- >> UNIQUE ���������� �÷� ������ ������������ ����
CREATE TABLE USER2(ID VARCHAR2(20) CONSTRAINT USER2_ID_UK UNIQUE,NAME VARCHAR2(30)
    ,PHONE VARCHAR2(15) CONSTRAINT USER2_PHONE_UK UNIQUE);
    
--�������� Ȯ��
SELECT CONSTRAINT_NAME,CONSTRAINT_TYPE FROM USER_CONSTRAINTS WHERE TABLE_NAME='USER2';

--USER2 ���̺� �� ����
INSERT INTO USER2 VALUES('ABC','ȫ�浿','010-1234-5678');
--ID �÷��� ������ UNIQUE �������ǿ� ���� �������� �÷����� ������ ���� ������ ��� ���� �߻�
INSERT INTO USER2 VALUES('ABC','�Ӳ���','010-7890-1234');
--PHONE �÷��� ������ UNIQUE �������ǿ� ���� �������� �÷����� ������ ���� ������ ��� ���� �߻�
INSERT INTO USER2 VALUES('XYZ','�Ӳ���','010-1234-5678');
--ID �÷� �Ǵ� PHONE �÷����� �������� �÷����� �������� ���� ���� �����ؾ߸� ���� ����
INSERT INTO USER2 VALUES('XYZ','�Ӳ���','010-7890-1234');
SELECT * FROM USER2;
COMMIT;

--UNIQUE ���������� ������ �÷��� NULL�� �����Ͽ� �� ���� ����
INSERT INTO USER2 VALUES('KIM','����ġ',NULL);
--NULL�� ���� �ƴϹǷ� UNIQUE ���������� �������� �ʾ� �� ���� ����
INSERT INTO USER2 VALUES('LEE','������',NULL);
SELECT * FROM USER2;

--USER3 ���̺� ���� : ���̵�(������-UNIQUE),�̸�(������),��ȭ��ȣ(������-UNIQUE)
-- >> UNIQUE ���������� ���̺� ������ ������������ ����
CREATE TABLE USER3(ID VARCHAR2(20),NAME VARCHAR2(30),PHONE VARCHAR2(15)
    ,CONSTRAINT USER3_ID_UK UNIQUE(ID),CONSTRAINT USER3_PHONE_UK UNIQUE(PHONE));

--�������� Ȯ��
SELECT CONSTRAINT_NAME,CONSTRAINT_TYPE FROM USER_CONSTRAINTS WHERE TABLE_NAME='USER3';

--USER3 ���̺� �� ����
INSERT INTO USER3 VALUES('ABC','ȫ�浿','010-1234-5678');
--ID �÷��� ������ UNIQUE �������ǿ� ���� �������� �÷����� ������ ���� ������ ��� ���� �߻�
INSERT INTO USER3 VALUES('ABC','�Ӳ���','010-7890-1234');
--PHONE �÷��� ������ UNIQUE �������ǿ� ���� �������� �÷����� ������ ���� ������ ��� ���� �߻�
INSERT INTO USER3 VALUES('XYZ','�Ӳ���','010-1234-5678');
--ID �÷� �Ǵ� PHONE �÷����� �������� �÷����� �������� ���� ���� �����ؾ߸� ���� ����
INSERT INTO USER3 VALUES('XYZ','�Ӳ���','010-7890-1234');
SELECT * FROM USER3;
COMMIT;

--USER4 ���̺� ���� : ���̵�(������),�̸�(������),��ȭ��ȣ(������) - ���̵�� ��ȭ��ȣ�� UNIQUE ���������� ���ÿ� ����
-- >> UNIQUE ���������� ���̺� ������ ������������ ����
CREATE TABLE USER4(ID VARCHAR2(20),NAME VARCHAR2(30),PHONE VARCHAR2(15),CONSTRAINT USER4_ID_PHONE_UK UNIQUE(ID,PHONE));

--�������� Ȯ��
SELECT CONSTRAINT_NAME,CONSTRAINT_TYPE FROM USER_CONSTRAINTS WHERE TABLE_NAME='USER4';

--USER4 ���̺� �� ����
INSERT INTO USER4 VALUES('ABC','ȫ�浿','010-1234-5678');
--ID �÷��� �������� �÷����� ������ ���� �����Ͽ� �� ���� ����
INSERT INTO USER4 VALUES('ABC','�Ӳ���','010-7890-1234');
--PHONE �÷��� �������� �÷����� ������ ���� �����Ͽ� �� ���� ����
INSERT INTO USER4 VALUES('XYZ','����ġ','010-1234-5678');
--UNIQUE ���������� ���ÿ� ������ ID �÷��� PHONE �÷��� �������� �÷����� ������ ���� ������ ��� ���� �߻�
INSERT INTO USER4 VALUES('ABC','������','010-1234-5678');
SELECT * FROM USER4;
COMMIT;