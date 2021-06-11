--PRIMARY KEY : �ߺ��� �÷��� ������ �����ϱ� ���� ��������
--�÷� ������ �������� �Ǵ� ���̺� ������ ������������ ���� ����
--PRIMARY KEY ���������� ���̺� �ϳ��� �÷����� �����ϸ� NULL �����
--���̺��� ���� �ĺ��� �� �ִ� �������� �����ϱ� ���� �÷��� PRIMARY KEY �������� ����

--MGR1 ���̺� ���� : �����ȣ(������-PRIMARY KEY:PK),����̸�(������),�Ի���(��¥��) - �÷� ������ ������������ ����
CREATE TABLE MGR1(NO NUMBER(4) CONSTRAINT MGR1_NO_PK PRIMARY KEY,NAME VARCHAR2(20),STARTDATE DATE);
DESC MGR1;

--�������� Ȯ��
SELECT CONSTRAINT_NAME,CONSTRAINT_TYPE FROM USER_CONSTRAINTS WHERE TABLE_NAME='MGR1';

--MGR1 ���̺� �� ����
INSERT INTO MGR1 VALUES(1000,'ȫ�浿',SYSDATE);
--PRIMARY KEY ���������� ������ �÷��� �������� �÷����� ���� ���� ������ ��� ���� �߻�
INSERT INTO MGR1 VALUES(1000,'�Ӳ���',SYSDATE);
--PRIMARY KEY ���������� ������ �÷��� NULL�� ������ ��� ���� �߻�
INSERT INTO MGR1 VALUES(NULL,'�Ӳ���',SYSDATE);
SELECT * FROM MGR1;
COMMIT;

--MGR2 ���̺� ���� : �����ȣ(������-PRIMARY KEY:PK),����̸�(������),�Ի���(��¥��) - ���̺� ������ ������������ ����
CREATE TABLE MGR2(NO NUMBER(4),NAME VARCHAR2(20),STARTDATE DATE,CONSTRAINT MGR2_NO_PK PRIMARY KEY(NO));
DESC MGR2;

--�������� Ȯ��
SELECT CONSTRAINT_NAME,CONSTRAINT_TYPE FROM USER_CONSTRAINTS WHERE TABLE_NAME='MGR2';

--FOREIGN KEY : �θ� ���̺� ����� ���� �÷����� �����Ͽ� �ڽ� ���̺��� �÷��� �߸��� ���� ����Ǵ� ���� �����ϴ� ��������
--���̺� ������ �������Ǹ� ���� ����
--�θ� ���̺��� PRIMARY KEY ���������� ������ �÷��� �����Ͽ� �ڽ� ���̺��� �÷��� FOREIGN KEY ���������� ����

--SUBJECT1 ���̺� ���� : �����ڵ�(������-PRIMARY KEY),�����(������) -�θ� ���̺�
CREATE TABLE SUBJECT1(SNO NUMBER(2) CONSTRAINT SUBJECT1_SNO_PK PRIMARY KEY,SNAME VARCHAR2(20));

--SUBJECT1 ���̺� �� ����
INSERT INTO SUBJECT1 VALUES(10,'JAVA');
INSERT INTO SUBJECT1 VALUES(20,'JSP');
INSERT INTO SUBJECT1 VALUES(30,'SPRING');
SELECT * FROM SUBJECT1;
COMMIT;

--TRAINEE1 ���̺� ���� : ��������ȣ(������-PRIMARY KEY),�������̸�(������),���������ڵ�(������)
CREATE TABLE TRAINEE1(TNO NUMBER(4) CONSTRAINT TRAINEE1_TNO_PK PRIMARY KEY,TNAME VARCHAR2(20),SCODE NUMBER(2));

--TRAINEE1 ���̺� �� ����
INSERT INTO TRAINEE1 VALUES(1000,'ȫ�浿',10);
INSERT INTO TRAINEE1 VALUES(2000,'�Ӳ���',20);
INSERT INTO TRAINEE1 VALUES(3000,'����ġ',30);
INSERT INTO TRAINEE1 VALUES(4000,'������',40);
SELECT * FROM TRAINEE1;
COMMIT;

--TRAINEE1 ���̺�� SUBJECT1 ���̺��� ��� �������� ��������ȣ,�������̸�,��������� �˻�
--INNER JOIN�� ��� ���������� �´� �ุ �����Ͽ� �˻� - ���������� ���� �ʴ� ������ ���� �̰˻�
-- >> �˻� ���� : ����Ÿ ���Ἲ ���� - �÷��� ������ ���� �÷��� ����
SELECT TNO,TNAME,SNAME FROM TRAINEE1 JOIN SUBJECT1 ON SCODE=SNO;
--OUTER JOIN�� ��� ���������� �´� ��Ӹ� �ƴ϶� ���������� ���� �ʴ� �൵ �˻� 
SELECT TNO,TNAME,SNAME FROM TRAINEE1 LEFT JOIN SUBJECT1 ON SCODE=SNO;

--TRAINEE2 ���̺� ���� : ��������ȣ(������-PRIMARY KEY),�������̸�(������),���������ڵ�(������-FORGIEN KEY:FK) - �ڽ� ���̺�
CREATE TABLE TRAINEE2(TNO NUMBER(4) CONSTRAINT TRAINEE2_TNO_PK PRIMARY KEY,TNAME VARCHAR2(20),SCODE NUMBER(2)
    ,CONSTRAINT TRAINEE2_SCODE_FK FOREIGN KEY(SCODE) REFERENCES SUBJECT1(SNO));
    
--�������� Ȯ��
SELECT CONSTRAINT_NAME,CONSTRAINT_TYPE,R_CONSTRAINT_NAME FROM USER_CONSTRAINTS WHERE TABLE_NAME='TRAINEE2';
    
--TRAINEE2 ���̺� �� ����
--�ڽ� ���̺� ���� ������ ��� FOREIGN KEY ���������� ������ �÷��� ���� ���޵Ǹ� �θ� ���̺��� �÷����� ������ �� ���� ó��
INSERT INTO TRAINEE2 VALUES(1000,'ȫ�浿',10);
INSERT INTO TRAINEE2 VALUES(2000,'�Ӳ���',20);
INSERT INTO TRAINEE2 VALUES(3000,'����ġ',30);
--FOREIGN KEY ���������� ������ �÷��� �θ� ���̺��� ���� �÷��� ������� �ʴ� ���� ������ ��� ���� �߻�
INSERT INTO TRAINEE2 VALUES(4000,'������',40);
SELECT * FROM TRAINEE2;
COMMIT;

--TRAINEE2 ���̺�� SUBJECT1 ���̺��� ��� �������� ��������ȣ,�������̸�,��������� �˻�
SELECT TNO,TNAME,SNAME FROM TRAINEE2 JOIN SUBJECT1 ON SCODE=SNO;

--TRAINEE2 ���̺��� ��������ȣ�� 1000�� �л��� ���������ڵ带 40���� ����
--FOREIGN KEY ���������� ������ �÷��� �θ� ���̺��� ���� �÷��� ������� �ʴ� ���� ������ ��� ���� �߻�
UPDATE TRAINEE2 SET SCODE=40 WHERE TNO=1000;

--SUBJECT1 ���̺��� �����ڵ尡 10�� �������� ����
--FOREIGN KEY ���������� ������ �ڽ� ���̺��� �÷��� �����ϴ� �θ� ���̺��� �÷����� ���Ե� ���� ������ ��� ���� �߻�
DELETE FROM SUBJECT1 WHERE SNO=10;
--FOREIGN KEY ���������� ������ �ڽ� ���̺��� �÷��� �����ϴ� �θ� ���̺��� �÷��� �˻� - �˻��� �÷����� ����� �θ� ���̺��� �� ���� �Ұ�
SELECT DISTINCT SCODE FROM TRAINEE2;

--SUBJECT2 ���̺� ���� : �����ڵ�(������-PRIMARY KEY),�����(������) -�θ� ���̺�
CREATE TABLE SUBJECT2(SNO NUMBER(2) CONSTRAINT SUBJECT2_SNO_PK PRIMARY KEY,SNAME VARCHAR2(20));

--SUBJECT2 ���̺� �� ����
INSERT INTO SUBJECT2 VALUES(10,'JAVA');
INSERT INTO SUBJECT2 VALUES(20,'JSP');
INSERT INTO SUBJECT2 VALUES(30,'SPRING');
SELECT * FROM SUBJECT2;
COMMIT;

--TRAINEE3 ���̺� ���� : ��������ȣ(������-PRIMARY KEY),�������̸�(������),���������ڵ�(������-FORGIEN KEY:FK) - �ڽ� ���̺�
--FOREIGN KEY ���������� ������ �� ON DELETE CASCADE �Ǵ� ON DELETE SET NULL ��� �߰�
--ON DELETE CASCADE : �θ� ���̺��� ���� ���� �� ��� �ڽ� ���̺� ���� �÷����� ����� �൵ ���� �����ϴ� ���
--ON DELETE SET NULL : �θ� ���̺��� ���� ���� �� ��� �ڽ� ���̺� ���� �÷����� NULL�� �����ϴ� ���
CREATE TABLE TRAINEE3(TNO NUMBER(4) CONSTRAINT TRAINEE3_TNO_PK PRIMARY KEY,TNAME VARCHAR2(20),SCODE NUMBER(2)
    ,CONSTRAINT TRAINEE3_SCODE_FK FOREIGN KEY(SCODE) REFERENCES SUBJECT2(SNO) ON DELETE CASCADE);
    
--TRAINEE3 ���̺� �� ����
INSERT INTO TRAINEE3 VALUES(1000,'ȫ�浿',10);
INSERT INTO TRAINEE3 VALUES(2000,'�Ӳ���',20);
INSERT INTO TRAINEE3 VALUES(3000,'����ġ',30);
SELECT * FROM TRAINEE3;
COMMIT;

--SUBJECT2 ���̺��� �����ڵ尡 10�� �������� ����
DELETE FROM SUBJECT2 WHERE SNO=10;
SELECT * FROM SUBJECT2;
--TRAINEE3 ���̺� ����� ������ �� ���������ڵ尡 10�� ����� ��� ������ ���� ���� Ȯ��
SELECT * FROM TRAINEE3;

--���������� �̿��Ͽ� ���̺� ���� : ���� ���̺��� �̿��Ͽ� ���ο� ���̺� ���� - �� ����
--����)CREATE TABLE ���̺��[(�÷���,�÷���,...)] AS SELECT �˻����,�˻����,... FROM ���̺�� [WHERE ���ǽ�]
--���������� �˻������ ������ �Ӽ��� ���̺��� �����ϸ� �˻����� ������ ���̺� ����
--���� ���̺��� �÷����� ������ ��� ���������� �˻������ �÷������� ���
--���� ���̺�� �Ӽ��� ������ ���� ���̺��� �������� �̼���

--EMP ���̺��� ��� ��������� �˻��Ͽ� EMP2 ���̺��� �����ϰ� �˻����� �����Ͽ� ����
CREATE TABLE EMP2 AS SELECT * FROM EMP;

--EMP ���̺�� EMP2 ���̺��� �Ӽ� �� - �� ���̺��� �Ӽ� ����
DESC EMP;
DESC EMP2;

--EMP ���̺�� EMP2 ���̺��� �������� �� - EMP ���̺��� ���������� �����Ǿ� ������ EMP2 ���̺��� �������� �̼���
SELECT CONSTRAINT_NAME,CONSTRAINT_TYPE FROM USER_CONSTRAINTS WHERE TABLE_NAME='EMP';
SELECT CONSTRAINT_NAME,CONSTRAINT_TYPE FROM USER_CONSTRAINTS WHERE TABLE_NAME='EMP2';

--EMP ���̺�� EMP2 ���̺��� �� �� - �� ���̺��� �� ����
SELECT * FROM EMP;
SELECT * FROM EMP2;

--EMP ���̺��� ��� ����� �����ȣ,����̸�,�޿��� �˻��Ͽ� EMP3 ���̺��� �����ϰ� �˻����� �����Ͽ� ����
CREATE TABLE EMP3 AS SELECT EMPNO,ENAME,SAL FROM EMP;

--EMP3 ���̺��� �Ӽ� Ȯ�� �� ������ �˻�
DESC EMP3;
SELECT * FROM EMP3;

--EMP ���̺��� �޿��� 2000 �̻��� ����� �����ȣ,����̸�,�޿��� �˻��Ͽ� EMP4 ���̺��� �����ϰ� �˻����� �����Ͽ� ����
CREATE TABLE EMP4 AS SELECT EMPNO,ENAME,SAL FROM EMP WHERE SAL>=2000;

--EMP4 ���̺��� �Ӽ� Ȯ�� �� ������ �˻�
DESC EMP4;
SELECT * FROM EMP4;

--EMP ���̺��� �޿��� 2000 �̻��� ����� �����ȣ,����̸�,�޿��� �˻��Ͽ� EMP5 ���̺��� �����ϰ� �˻����� �����Ͽ� ����
-- >> EMP5 ���̺��� �÷����� ���� �����ȣ NO,����̸� NAME,�޿� PAY�� ���� - �˻������ ������ �÷��� ���� ����
CREATE TABLE EMP5(NO,NAME,PAY) AS SELECT EMPNO,ENAME,SAL FROM EMP WHERE SAL>=2000;

--EMP5 ���̺��� �Ӽ� Ȯ�� �� ������ �˻�
DESC EMP5;
SELECT * FROM EMP5;

--EMP ���̺�� ������ �Ӽ��� EMP6 ���̺� ���� - ���� ���̺��� ���� ������� �ʵ��� �ۼ�
CREATE TABLE EMP6 AS SELECT * FROM EMP WHERE 0=1;--���ǽ��� ������ ������ �ǵ��� ����

--EMP6 ���̺��� �Ӽ� Ȯ�� �� ������ �˻�
DESC EMP6;
SELECT * FROM EMP6;

--���̺� ���� : ���̺� ����� ��� �� ����
--����)DROP TABLE ���̺��

--���̺� ��� Ȯ��
SELECT TABLE_NAME FROM TABS;

--USER1 ���̺� �˻� �� USER1 ���̺��� ������ �˻�
SELECT TABLE_NAME FROM TABS WHERE TABLE_NAME='USER1';
SELECT * FROM USER1;

--USER1 ���̺� ����
DROP TABLE USER1;
SELECT TABLE_NAME FROM TABS WHERE TABLE_NAME='USER1';
SELECT * FROM USER1;

--����Ŭ������ ���̺��� ������ ��� ���̺�� ���̺� ���� INDEX ��ü�� ������(RECYCLEBIN)���� �̵�
-- >> ���� ���̺�� ���̺� ���� INDEX ��ü ���� ����

--���̺� ��� Ȯ�� - USER_TABLES(TABS)
SELECT TABLE_NAME FROM TABS;

--���̺� ��� Ȯ�� - TAB �� �̿�
--TNAME �÷��� BIN���� ���۵Ǵ� ���̺��� ����Ŭ �����뿡 �����ϴ� ���� ���̺�
SELECT * FROM TAB;

--����Ŭ �������� ��ü ��� Ȯ��
SHOW RECYCLEBIN;

--����Ŭ �����뿡 �����ϴ� ���� ���̺� ���� - ���̺� ���� INDEX ��ü�� ���� ����
--����)FLASHBACK TABLE ���̺�� TO BEFORE DROP;

--USER1 ���� ���̺� ���� - ���̺� ����� �൵ ���� ����
FLASHBACK TABLE USER1 TO BEFORE DROP;
SELECT TABLE_NAME FROM TABS WHERE TABLE_NAME='USER1';
SELECT * FROM USER1;

--USER2 ���̺� ���� - ���̺� ���ӵ� INDEX ��ü�� ���� ����
SELECT TABLE_NAME FROM TABS WHERE TABLE_NAME='USER2';
DROP TABLE USER2;
SELECT TABLE_NAME FROM TABS WHERE TABLE_NAME='USER2';

--����Ŭ �������� ��ü ��� Ȯ��
SHOW RECYCLEBIN;

--USER2 ���� ���̺� ���� - ���� ���̺� ���ӵ� INDEX ��ü�� ���� ����
FLASHBACK TABLE USER2 TO BEFORE DROP;
SHOW RECYCLEBIN;
SELECT TABLE_NAME FROM TABS WHERE TABLE_NAME='USER2';

--USER1,USER2,USER3,USER4 ���̺� ����
SELECT TABLE_NAME FROM TABS WHERE TABLE_NAME LIKE 'USER%';
DROP TABLE USER1;
DROP TABLE USER2;
DROP TABLE USER3;
DROP TABLE USER4;
SELECT TABLE_NAME FROM TABS WHERE TABLE_NAME LIKE 'USER%';
SHOW RECYCLEBIN;

--����Ŭ �������� ���� ���̺� ���� - ���̺��� ���ӵ� INDEX ��ü�� ���� ����
--����)PURGE TABLE ���̺��
PURGE TABLE USER4;
SHOW RECYCLEBIN;

--����Ŭ �������� ��� ���� ���̺� ����
PURGE RECYCLEBIN;
SHOW RECYCLEBIN;

--MGR1 ���̺� ���� - ����Ŭ ���������� �̵�
SELECT TABLE_NAME FROM TABS WHERE TABLE_NAME LIKE 'MGR%';
DROP TABLE MGR1;
SHOW RECYCLEBIN;
--����Ŭ �����뿡�� ���� ���̺� ����
PURGE TABLE MGR1;
SHOW RECYCLEBIN;

--MGR2 ���̺� ���� - ����Ŭ �������� �̿����� �ʰ� ���� ó��
--����)DROP TABLE ���̺�� PURGE
DROP TABLE MGR2 PURGE;
SHOW RECYCLEBIN;

--���̺� �ʱ�ȭ : ���̺� ���� ������ ���·� �ʱ�ȭ ó���ϴ� ��� - ���̺��� ������ ����
--����)TRUNCATE TABLE ���̺��

--BONUS ���̺� ����� ��� �� ���� - Ʈ�����ǿ� DELETE ��� ���� : ���� ���̺��� ������ �̻���
SELECT * FROM BONUS;
DELETE FROM BONUS;
SELECT * FROM BONUS;

--�ѹ� ó�� ����
ROLLBACK;
SELECT * FROM BONUS;

--BONUS ���̺� �ʱ�ȭ - �ڵ� Ŀ�� : �ѹ� ó�� �Ұ��� 
TRUNCATE TABLE BONUS;
SELECT * FROM BONUS;

--���̺� �̸� ����
--����)RENAME �������̺�� TO �������̺��

--BONUS ���̺��� �̸��� COMM���� ����
SELECT TABLE_NAME FROM TABS WHERE TABLE_NAME='BONUS';
RENAME BONUS TO COMM;
SELECT TABLE_NAME FROM TABS WHERE TABLE_NAME='COMM';

--���̺� �Ӽ� ����
--����)ALTER TABLE ���̺�� ����ɼ�
--����ɼǿ� ���� �÷� �߰�, �÷� ����, �÷��� ����, �÷� �ڷ����� ũ�� ����, �÷� �⺻�� ����, �������� �߰�, �������� ���� �� ó���۾�

--USER1 ���̺� ���� : ȸ����ȣ(������),ȸ���̸�(������),��ȭ��ȣ(������)
CREATE TABLE USER1(NO NUMBER(4),NAME VARCHAR2(20),PHONE VARCHAR2(15));
DESC USER1;

--USER1 ���̺� �� ����
INSERT INTO USER1 VALUES(1000,'ȫ�浿','010-1234-5678');
SELECT * FROM USER1;
COMMIT;

--���̺� �÷� �߰� : �÷� �⺻���� �÷� ������ �������� ���� ����
--����)ALTER TABLE ���̺�� ADD(�÷��� �ڷ���[(ũ��)] [DEFAULR �⺻��] [��������])

--USER1 ���̺� �ּ�(������) �÷� �߰� - �������� �־ �÷� �߰� ����
ALTER TABLE USER1 ADD(ADDRESS VARCHAR2(100));
DESC USER1;
--�������� �߰� �÷����� �÷� �⺻���� �ڵ� ����
SELECT * FROM USER1;

--USER1 ���̺��� ADDRESS �÷��� ����
UPDATE USER1 SET ADDRESS='����� ������' WHERE NO=1000;
SELECT * FROM USER1;
COMMIT;

--���̺��� �÷� �ڷ��� �Ǵ� ũ�� ���� : �÷� �⺻���� �÷� ������ �������� ���� ����
--����)ALTER TABLE ���̺�� MODIFY(�÷��� �ڷ���[(ũ��)] [DEFAULR �⺻��] [��������])

--USER1 ���̺� �ʱ�ȭ
TRUNCATE TABLE USER1;
SELECT * FROM USER1;

--USER1 ���̺��� NO �÷� �ڷ���(������)�� ���������� ����
DESC USER1;
ALTER TABLE USER1 MODIFY(NO VARCHAR2(4));
DESC USER1;

--USER1 ���̺� �� ����
INSERT INTO USER1 VALUES('1000','ȫ�浿','010-1234-5678','����� ������');
SELECT * FROM USER1;
COMMIT;

--USER1 ���̺��� NO �÷� �ڷ���(������)�� ���������� ����
DESC USER1;
--���� ����� �÷��� �ڷ����� ������ ��� ���� �߻�
ALTER TABLE USER1 MODIFY(NO NUMBER(4));

--USER1 ���̺��� NAME �÷��� ũ�⸦ 10BYTE ����
DESC USER1;
--�÷��� ���� ����Ǿ� �ִ� ��� �÷����� ũ�⺸�� ����Ǵ� �ڷ����� ũ�Ⱑ ũ�� ���� ����
SELECT * FROM USER1;
ALTER TABLE USER1 MODIFY(NAME VARCHAR2(10));
DESC USER1;
SELECT * FROM USER1;

--USER1 ���̺��� NAME �÷��� ũ�⸦ 5BYTE ����
--�÷��� ���� ����Ǿ� �ִ� ��� �÷����� ũ�⺸�� ����Ǵ� �ڷ����� ũ�Ⱑ ������ ���� �Ұ���
ALTER TABLE USER1 MODIFY(NAME VARCHAR2(5));

--���̺��� �÷��� ����
--����)ALTER TABLE ���̺�� RENAME COLUMN �����÷��� TO �����÷���

--USER1 ���̺��� ADDRESS �÷����� ADDR �÷������� ����
DESC USER1;
ALTER TABLE USER1 RENAME COLUMN ADDRESS TO ADDR;
DESC USER1;

--���̺��� �÷� ���� : �÷����� ���� ����
--����)ALTER TABLE ���̺�� DROP COLUMN �÷���

--USER1 ���̺��� PHONE �÷� ����
DESC USER1;
ALTER TABLE USER1 DROP COLUMN PHONE;
DESC USER1;
SELECT * FROM USER1;

--�÷��� ���������� MODIFY �ɼ��� ����Ͽ� �÷� ����� �÷� ������ �������� ����
--USER1 ���̺��� NAME �÷��� NOT NULL �������� ����
SELECT CONSTRAINT_NAME,CONSTRAINT_TYPE FROM USER_CONSTRAINTS WHERE TABLE_NAME='USER1';
ALTER TABLE USER1 MODIFY(NAME VARCHAR2(10) CONSTRAINT USER1_NAME_NN NOT NULL);
SELECT CONSTRAINT_NAME,CONSTRAINT_TYPE FROM USER_CONSTRAINTS WHERE TABLE_NAME='USER1';

--���̺� ������ ���� ������ ADD �ɼ��� ����Ͽ� ����
--����)ALTER TABLE ���̺�� ADD [CONSTRAINT �������Ǹ�] ��������(�÷���)

--USER1 ���̺� NO �÷��� PRIMARY KEY �������� ����
ALTER TABLE USER1 ADD CONSTRAINT USER1_NO_PK PRIMARY KEY(NO);
SELECT CONSTRAINT_NAME,CONSTRAINT_TYPE FROM USER_CONSTRAINTS WHERE TABLE_NAME='USER1';

--�������� ����
--����)ALTER TABLE ���̺�� DROP {PRIMARY KEY|CONSTRAINT �������Ǹ�} [CASCADE]

--USER1 ���̺��� NAME �÷��� ������ NOT NULL �������� ����
ALTER TABLE USER1 DROP CONSTRAINT USER1_NAME_NN;
SELECT CONSTRAINT_NAME,CONSTRAINT_TYPE FROM USER_CONSTRAINTS WHERE TABLE_NAME='USER1';

--USER1 ���̺��� NO �÷��� ������ PRIMARY KEY �������� ����
ALTER TABLE USER1 DROP PRIMARY KEY;
SELECT CONSTRAINT_NAME,CONSTRAINT_TYPE FROM USER_CONSTRAINTS WHERE TABLE_NAME='USER1';

--BUSEO ���̺� ���� : �μ���ȣ(������-PRIMARY KEY),�μ���(������) - �θ� ���̺�
CREATE TABLE BUSEO(BNO NUMBER(2) CONSTRAINT BUSEO_BNO_PK PRIMARY KEY,DNAME VARCHAR2(20));

--BUSEO ���̺� �� ����
INSERT INTO BUSEO VALUES(10,'�ѹ���');
INSERT INTO BUSEO VALUES(20,'������');
SELECT * FROM BUSEO;
COMMIT;

--SAWON ���̺� ���� - �����ȣ(������-PRIMARY KEY),����̸�(������),�μ���ȣ(������-FOREIGN KEY:BUSEO ���̺��� BNO �÷� ����) - �ڽ� ���̺�
CREATE TABLE SAWON(SNO NUMBER(4) CONSTRAINT SAWON_SNO_PK PRIMARY KEY,SNAME VARCHAR2(20),BNO NUMBER(20)
    ,CONSTRAINT SAWON_BNO_FK FOREIGN KEY(BNO) REFERENCES BUSEO(BNO));
    
--SAWON ���̺� �� ����
INSERT INTO SAWON VALUES(1000,'ȫ�浿',10);
INSERT INTO SAWON VALUES(2000,'�Ӳ���',20);
SELECT * FROM SAWON;
COMMIT;
    
--�������� Ȯ��
SELECT CONSTRAINT_NAME,CONSTRAINT_TYPE,R_CONSTRAINT_NAME FROM USER_CONSTRAINTS WHERE TABLE_NAME IN ('BUSEO','SAWON');

--FOREIGN KEY �������ǿ� ���� �θ� ���̺� ���� ���� ������ ��� ���� �߻�
INSERT INTO SAWON VALUES(3000,'����ġ',30);    

--���������� ��Ȱ��ȭ : �÷��� ������ ���������� �Ͻ������� �����ϴ� ���
--����)ALTER TABLE ���̺�� DISABLE {PRIMARY KEY|CONSTRAINT �������Ǹ�} [CASCADE]
SELECT CONSTRAINT_NAME,CONSTRAINT_TYPE,R_CONSTRAINT_NAME,STATUS FROM USER_CONSTRAINTS WHERE TABLE_NAME='SAWON';

--SAWON ���̺��� BNO �÷��� ������ FOREIGN KEY ���������� ��Ȱ��ȭ ó��
ALTER TABLE SAWON DISABLE CONSTRAINT SAWON_BNO_FK;
SELECT CONSTRAINT_NAME,CONSTRAINT_TYPE,R_CONSTRAINT_NAME,STATUS FROM USER_CONSTRAINTS WHERE TABLE_NAME='SAWON';

--FOREIGN KEY ���������� ��Ȱ��ȭ ó���Ǿ� ���� ���� ���� �̹߻�
INSERT INTO SAWON VALUES(3000,'����ġ',30);    
SELECT * FROM SAWON;

--���������� Ȱ��ȭ : �Ͻ������� ������ ���������� ���۵ǵ��� ó���ϴ� ���
--����)ALTER TABLE ���̺�� ENABLE {PRIMARY KEY|CONSTRAINT �������Ǹ�}
SELECT CONSTRAINT_NAME,CONSTRAINT_TYPE,R_CONSTRAINT_NAME,STATUS FROM USER_CONSTRAINTS WHERE TABLE_NAME='SAWON';
--Ȱ��ȭ ó���ϱ� ���� ���������� �����ϴ� �÷����� ���̺� ����Ǿ� �ִ� ��� �������� Ȱ��ȭ ó���� ���� �߻�
ALTER TABLE SAWON ENABLE CONSTRAINT SAWON_BNO_FK;

--���������� �����ϴ� �÷����� �����ϰų� �÷����� ����� ���� �����ؾ߸� �������� Ȱ��ȭ ó�� ����
SELECT * FROM SAWON;
DELETE FROM SAWON WHERE BNO=30;
ALTER TABLE SAWON ENABLE CONSTRAINT SAWON_BNO_FK;
SELECT CONSTRAINT_NAME,CONSTRAINT_TYPE,R_CONSTRAINT_NAME,STATUS FROM USER_CONSTRAINTS WHERE TABLE_NAME='SAWON';

--BUSEO ���̺��� BNO �÷��� ������ PRIMARY KEY ���������� ��Ȱ��ȭ ó��
SELECT CONSTRAINT_NAME,CONSTRAINT_TYPE,R_CONSTRAINT_NAME,STATUS FROM USER_CONSTRAINTS WHERE TABLE_NAME='BUSEO';
--FOREIGN KEY �������ǿ� ���� �����Ǵ� �θ� ���̺��� PRIMARY KEY ���������� ��Ȱ��ȭ ó���� ���� �߻�
ALTER TABLE BUSEO DISABLE PRIMARY KEY; 
SELECT CONSTRAINT_NAME,CONSTRAINT_TYPE,R_CONSTRAINT_NAME,STATUS FROM USER_CONSTRAINTS WHERE TABLE_NAME IN ('BUSEO','SAWON');

--CASCADE Ű���带 ����Ͽ� �θ� ���̺��� PRIMARY KEY ���������� ��Ȱ��ȭ ó���ϸ� �ڽ� ���̺��� ������ 
--FOREIGN KEY �������ǵ� ���� ��Ȱ��ȭ ó��
ALTER TABLE BUSEO DISABLE PRIMARY KEY CASCADE; 
SELECT CONSTRAINT_NAME,CONSTRAINT_TYPE,R_CONSTRAINT_NAME,STATUS FROM USER_CONSTRAINTS WHERE TABLE_NAME IN ('BUSEO','SAWON');

--�θ� ���̺� ������ PRIMARY KEY ���������� Ȱ��ȭ ó�� ó�� �� �ڽ� ���̺� ������ FOREIGN KEY ���������� Ȱ��ȭ ó��
ALTER TABLE BUSEO ENABLE PRIMARY KEY; 
ALTER TABLE SAWON ENABLE CONSTRAINT SAWON_BNO_FK;
SELECT CONSTRAINT_NAME,CONSTRAINT_TYPE,R_CONSTRAINT_NAME,STATUS FROM USER_CONSTRAINTS WHERE TABLE_NAME IN ('BUSEO','SAWON');

--BUSEO ���̺��� BNO �÷��� ������ PRIMARY KEY �������� ����
--FOREIGN KEY �������ǿ� ���� �����Ǵ� �θ� ���̺��� PRIMARY KEY ���������� ������ ���� �߻�
ALTER TABLE BUSEO DROP PRIMARY KEY;

--CASCADE Ű���带 ����Ͽ� �θ� ���̺��� PRIMARY KEY ���������� �����ϸ� �ڽ� ���̺��� ������ FOREIGN KEY �������ǵ� ���� ����
ALTER TABLE BUSEO DROP PRIMARY KEY CASCADE;
SELECT CONSTRAINT_NAME,CONSTRAINT_TYPE,R_CONSTRAINT_NAME,STATUS FROM USER_CONSTRAINTS WHERE TABLE_NAME IN ('BUSEO','SAWON');

--��(VIEW) : ���̺��� ������� ��������� ������ ���̺�
--�並 �̿��Ͽ� ���� ���� �� �˻� ����� �����ϰų� ����(��ü ����) ��� ����

--�ܼ��� : �ϳ��� ���̺��� ������� ������� �� - �˻��Ӹ� �ƴ϶� ���� ����,����,���� ����(���̺� ����)
--���պ� : ���� �� ���̺��� ������� ������� �� - �˻��� ����
--�ܼ���� DISTINCT Ű���� �Ǵ� �׷��Լ� ����� �Ұ��������� ���պ�� ����

--�� ���� : �������� �̿�
--����)CREATE [OR REPLACE] [{FORCE|NOFORCE}] VIEW ���̸�[(�÷���,�÷���,...)] 
--    AS SELECT �˻����,�˻����,... FROM ���̺�� [WHERE ���ǽ�] [WITH CHECK OPTION] [WITH READ ONLY] 
--CREATE OR REPLACE : ������ �̸��� ���� �䰡 ������ �����ϰ� ���ο� �� ����
--FORCE : ���������� �˻������ ��� ������ �並 �����ϴ� ��� ����
--WITH CHECK OPTION : �並 ������ ���������� ���ǽĿ� �÷����� �������� ���ϵ��� �����ϴ� ��� ����
--WITH READ ONLY : �˻� ��ɸ� �����ϵ��� �����ϴ� ���(�ܼ���)
