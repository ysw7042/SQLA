--EMP ���̺��� ��� ����� �˻��Ͽ� EMP_COPY ���̺��� �����ϰ� �˻��� ����
CREATE TABLE EMP_COPY AS SELECT * FROM EMP;
SELECT * FROM EMP_COPY;

--EMP_COPY ���̺��� �μ���ȣ�� 30�� ����� �����ȣ,����̸�,�μ���ȣ�� �˻��Ͽ� EMP_VIEW30 ��� ����
--���� ���� ����ڴ� �信 ���� �ý��� ������ �����Ƿ� �並 ������ ��� ���� �߻� - �����ڿ��� �信 ���� �ý��� ���� ��û
CREATE VIEW EMP_VIEW30 AS SELECT EMPNO,ENAME,DEPTNO FROM EMP WHERE DEPTNO=30;

--�ý��� ������(SYS �Ǵ� SYSTEM)�� �����Ͽ� �Ϲ� �����(SCOTT)���� �信 ���� �ý��� ���� �ο�
--GRANT CREATE VIEW TO SCOTT;

--�����ڷκ��� �信 ���� �ý��� ������ �ο� ���� �� �� ���� ��� ��� ����
--�ܼ��� : �信 ���� �� ����,����,����,�˻� ��� ��� ����
CREATE VIEW EMP_VIEW30 AS SELECT EMPNO,ENAME,DEPTNO FROM EMP_COPY WHERE DEPTNO=30;

--�� ��� Ȯ�� - USER_VIEWS : �� ������ �����ϴ� ��ųʸ�
SELECT VIEW_NAME,TEXT FROM USER_VIEWS;
DESC EMP_VIEW30;

--�� �˻� : ���̺��� �������� �̿��Ͽ� �˻�
SELECT * FROM EMP_VIEW30;

--�ܼ��並 �̿��� �� ���� - ���̺� �� ���� : �信 ���� ������ �÷����� �÷� �⺻�� ����
INSERT INTO EMP_VIEW30 VALUES(1111,'ȫ�浿',30);
SELECT * FROM EMP_VIEW30;
SELECT * FROM EMP_COPY;
COMMIT;

--EMP ���̺�� DEPT ���̺��� ��� ����� �����ȣ,����̸�,�޿�,�μ��̸�,�μ���ġ �˻�
SELECT EMPNO,ENAME,SAL,DNAME,LOC FROM EMP JOIN DEPT ON EMP.DEPTNO=DEPT.DEPTNO;

--EMP ���̺�� DEPT ���̺��� ��� ����� �����ȣ,����̸�,�޿�,�μ��̸�,�μ���ġ�� �˻��Ͽ� EMP_VIEW ��� ����
--���պ� : �� �˻� ��ɸ� ��� ���� - ���� �˻� ��� ����
CREATE VIEW EMP_VIEW AS SELECT EMPNO,ENAME,SAL,DNAME,LOC FROM EMP JOIN DEPT ON EMP.DEPTNO=DEPT.DEPTNO;
SELECT * FROM EMP_VIEW;

--EMP_COPY ���̺��� ��� ����� �����ȣ,����̸�,����,�Ի���,�޿� �˻��Ͽ� EMP_VIEW01 ��� ����
CREATE VIEW EMP_VIEW01 AS SELECT EMPNO,ENAME,JOB,HIREDATE,SAL FROM EMP_COPY;

--EMP_COPY ���̺��� ������ SALESMAN�� ����� �����ȣ,����̸�,������ �˻��Ͽ� EMP_VIEW02 ��� ����
CREATE VIEW EMP_VIEW02 AS SELECT EMPNO,ENAME,COMM FROM EMP_COPY WHERE JOB='SALESMAN';

--�並 �̿��� ���� ��ü ���� ���� ����
--���� ���� ����ڸ� ������ ��� ����ڴ� EMP_COPY ���̺� ���� ���� ���� �̺ο�
--�λ�ο� �ٹ��ϴ� ������Դ� EMP_VIEW01 �信 ������ �� ������ �ο�
SELECT * FROM EMP_VIEW01;
--�����ο� �ٹ��ϴ� ������Դ� EMP_VIEW02 �信 ������ �� �ִ� ���� �ο�
SELECT * FROM EMP_VIEW02;

--�� ��� Ȯ��
SELECT VIEW_NAME,TEXT FROM USER_VIEWS;

--EMP_VIEW30 �信 SAL �÷� �߰� - �� ���� ���� �Ұ��� : ���� �並 �����ϰ� �並 �ٽ� ����
--CREATE OR REPLACE VIEW ������� ���� �並 �����ϰ� ���ο� �� ���� - ���� �Ǵ� ����
CREATE OR REPLACE VIEW EMP_VIEW30 AS SELECT EMPNO,ENAME,SAL,DEPTNO FROM EMP_COPY WHERE DEPTNO=30;
SELECT VIEW_NAME,TEXT FROM USER_VIEWS;

--EMP_COPY ���̺��� �μ���ȣ�� 10�� ����� �����ȣ,����̸�,�޿�,�μ���ȣ�� �˻��Ͽ� EMP_VIEW10 ��� ����
CREATE OR REPLACE VIEW EMP_VIEW10 AS SELECT EMPNO,ENAME,SAL,DEPTNO FROM EMP_COPY WHERE DEPTNO=10; 
SELECT * FROM EMP_VIEW10;

--EMP_VIEW10 �信�� �����ȣ�� 7782�� ����� �μ���ȣ�� 20���� ����
UPDATE EMP_VIEW10 SET DEPTNO=20 WHERE EMPNO=7782;
SELECT * FROM EMP_VIEW10;

--�ѹ� ó��
ROLLBACK;
SELECT * FROM EMP_VIEW10;

--EMP_COPY ���̺��� �μ���ȣ�� 10�� ����� �����ȣ,����̸�,�޿�,�μ���ȣ�� �˻��Ͽ� EMP_VIEW10 ��� ����
-- >> WITH CHECK OPTION ��� �߰�
CREATE OR REPLACE VIEW EMP_VIEW10 AS SELECT EMPNO,ENAME,SAL,DEPTNO FROM EMP_COPY WHERE DEPTNO=10 WITH CHECK OPTION; 

--EMP_VIEW10 �信�� �����ȣ�� 7782�� ����� �μ���ȣ�� 20���� ����
--WITH CHECK OPTION ��ɿ� ���� �並 ������ ���������� ���ǽĿ��� ����� �÷����� ������ ��� ���� �߻�
UPDATE EMP_VIEW10 SET DEPTNO=20 WHERE EMPNO=7782;

--EMP_COPY ���̺��� �μ���ȣ�� 20�� ����� �����ȣ,����̸�,�޿�,�μ���ȣ�� �˻��Ͽ� EMP_VIEW20 ��� ����
CREATE OR REPLACE VIEW EMP_VIEW20 AS SELECT EMPNO,ENAME,SAL,DEPTNO FROM EMP_COPY WHERE DEPTNO=20; 
SELECT * FROM EMP_VIEW20;

--EMP_VIEW20 �信�� �����ȣ�� 7788�� ��������� ����
DELETE FROM EMP_VIEW20 WHERE EMPNO=7788;
SELECT * FROM EMP_VIEW20;

--�ѹ� ó��
ROLLBACK;
SELECT * FROM EMP_VIEW20;

--EMP_COPY ���̺��� �μ���ȣ�� 20�� ����� �����ȣ,����̸�,�޿�,�μ���ȣ�� �˻��Ͽ� EMP_VIEW20 ��� ����
-- >> WITH READ ONLY ��� �߰�
CREATE OR REPLACE VIEW EMP_VIEW20 AS SELECT EMPNO,ENAME,SAL,DEPTNO FROM EMP_COPY WHERE DEPTNO=20 WITH READ ONLY; 
SELECT * FROM EMP_VIEW20;

--EMP_VIEW20 �信�� �����ȣ�� 7788�� ��������� ����
--WITH READ ONLY ��ɿ� ���� �ܼ��信�� �� ����,����,���� ����� ����� ��� ���� �߻�
DELETE FROM EMP_VIEW20 WHERE EMPNO=7788;

--�� ���� 
--����)DROP VIEW ���̸�

--�� ��� Ȯ��
SELECT VIEW_NAME,TEXT FROM USER_VIEWS;

--EMP_VIEW �� ����
DROP VIEW EMP_VIEW;
SELECT VIEW_NAME,TEXT FROM USER_VIEWS;

--EMP_COPY ���̺� ����
DROP TABLE EMP_COPY PURGE;
--���̺��� �����ص� ���̺��� ������� ������ ��� �̻���
SELECT VIEW_NAME,TEXT FROM USER_VIEWS;

--EMP_VIEW30 �� �˻� - ������ ���̺��� ������� ������ �並 ����� ��� ���� �߻�
SELECT * FROM EMP_VIEW30;

--ROWNUM : �˻��࿡ ���������� ���ȣ�� �����ϴ� Ű����
SELECT EMPNO,ENAME,SAL FROM EMP;
SELECT ROWNUM,EMPNO,ENAME,SAL FROM EMP;

--EMP ���̺��� ��� ����� �����ȣ,����̸�,�޿��� �޿��� �������� �����Ͽ� �˻�
SELECT EMPNO,ENAME,SAL FROM EMP ORDER BY SAL DESC;

--EMP ���̺��� ��� ����� �����ȣ,����̸�,�޿��� �޿��� �������� �����Ͽ� �˻� >> ���ȣ �˻�
--���� ���� �˻��࿡ ���ȣ�� ������ �� ���ĵǾ� �˻��ǹǷ� ���������� ���� ���ȣ �˻�
SELECT ROWNUM,EMPNO,ENAME,SAL FROM EMP ORDER BY SAL DESC;

--ROWNUM Ű���� ��� ROW_NUMBER() �����Լ��� �̿��Ͽ� ���ȣ�� ��ȯ�޾� �˻� - OVER() �м��Լ� ���
SELECT ROW_NUMBER() OVER(ORDER BY SAL DESC) NUM,EMPNO,ENAME,SAL FROM EMP;

--EMP ���̺��� ��� ����� �����ȣ,����̸�,�޿��� �޿��� �������� �����Ͽ� �˻��ϵ� ���ȣ�� �����Ͽ�  
--�˻��ϰ� �˻��� ���ȣ�� 5���� ���� ��鸸 �˻�
--������ �Լ�(�׷��Լ�,�����Լ�,�����Լ� ��)�� WHERE �������� ����� ��� ���� �߻�
SELECT ROW_NUMBER() OVER(ORDER BY SAL DESC) NUM,EMPNO,ENAME,SAL FROM EMP WHERE ROW_NUMBER() OVER(ORDER BY SAL DESC)<5;
--���ǽĿ��� �÷��� ��Ī�� ����� ��� ���� �߻�
SELECT ROW_NUMBER() OVER(ORDER BY SAL DESC) NUM,EMPNO,ENAME,SAL FROM EMP WHERE NUM<5;

--EMP ���̺��� ��� ����� �����ȣ,����̸�,�޿��� �޿��� �������� �����Ͽ� EMP_VIEW ��� ����
CREATE OR REPLACE VIEW EMP_VIEW AS SELECT EMPNO,ENAME,SAL FROM EMP ORDER BY SAL DESC;
SELECT * FROM EMP_VIEW;

--EMP_VIEW �信 ���ȣ�� �����Ͽ� �˻�
SELECT ROWNUM,EMPNO,ENAME,SAL FROM EMP_VIEW;
--�ٸ� �˻������ ���̺�(��)�� ��� �÷��� ���� ǥ���ϰ��� �� ��� ���̺�(��).* �������� ǥ�� ����
SELECT ROWNUM,EMP_VIEW.* FROM EMP_VIEW;

--EMP_VIEW �信 ���ȣ�� �����Ͽ� �˻��ϵ� ���ȣ�� 5���� ���� ��鸸 �˻�
-- >> ROWNUM Ű����� WHERE ������ ���ǽĿ��� ��� ����
SELECT ROWNUM,EMP_VIEW.* FROM EMP_VIEW WHERE ROWNUM<5;

--�ζ��� ��(INLINE VIEW) : SELECT ��ɿ��� FROM ������ ���������� ����Ͽ� �Ͻ������� �����Ǿ� ���Ǵ� ��
SELECT EMPNO,ENAME,SAL FROM EMP;--���̺��� �̿��Ͽ� �˻�
SELECT EMPNO,ENAME,SAL FROM (SELECT * FROM EMP);--�ζ��� �並 �̿��Ͽ� �˻�
SELECT EMPNO,ENAME,SAL FROM (SELECT * FROM EMP WHERE DEPTNO=10);
--�ζ��� �信 ���� �÷��� �˻��� ��� ���� �߻�
SELECT EMPNO,ENAME,SAL,DEPTNO FROM (SELECT EMPNO,ENAME,SAL FROM EMP);

--EMP ���̺��� ��� ����� �����ȣ,����̸�,�޿��� �޿��� �������� �����Ͽ� �˻��ϵ� �˻��࿡ ���ȣ�� �����Ͽ� �˻� >> �ζ��� �� ���
SELECT ROWNUM,EMPNO,ENAME,SAL FROM (SELECT EMPNO,ENAME,SAL FROM EMP ORDER BY SAL DESC);

--�ζ��� �信�� ��Ī�� �����Ͽ� �˻� ���� - �ζ��� ���� ��Ī�� �̿��Ͽ� ��� �÷� ǥ��
SELECT ROWNUM,TEMP.* FROM (SELECT EMPNO,ENAME,SAL FROM EMP ORDER BY SAL DESC) TEMP;

--EMP ���̺��� ��� ����� �����ȣ,����̸�,�޿��� �޿��� �������� �����Ͽ� �˻��ϵ� �˻��࿡ ���ȣ�� �����Ͽ� �˻��ϰ� 
--���ȣ�� 5���� ���� ��鸸 �˻�
SELECT ROWNUM,TEMP.* FROM (SELECT EMPNO,ENAME,SAL FROM EMP ORDER BY SAL DESC) TEMP WHERE ROWNUM<5;

--EMP ���̺��� ��� ����� �����ȣ,����̸�,�޿��� �޿��� �������� �����Ͽ� �˻��ϵ� �˻��࿡ ���ȣ�� �����Ͽ� �˻��ϰ� 
--���ȣ�� 10�� �� �˻�
--WHERE �������� ���ȣ�� ���ǽĿ��� ����� ��� ���ǽ��� �����ڰ� < �Ǵ� <= �����ڴ� ��� ���������� ������ �� �����ڸ� ����� ���
--�˻� �Ұ��� - ���ȣ�� �࿡ ���������� �����ǹǷ� ���� ���ȣ�� ���ų� ū ���� �̰˻�
SELECT ROWNUM,TEMP.* FROM (SELECT EMPNO,ENAME,SAL FROM EMP ORDER BY SAL DESC) TEMP WHERE ROWNUM=10;

--ROWNUM Ű���忡 ��Ī�� ����Ͽ� �˻� - ���ǽĿ��� ��Ī�� ����� ��� ���� �߻�
SELECT ROWNUM RN,TEMP.* FROM (SELECT EMPNO,ENAME,SAL FROM EMP ORDER BY SAL DESC) TEMP WHERE RN=10;
 
-- �ζ��� �並 �̿��ϸ� ROWNUM Ű������ ��Ī�� ���ǽĿ��� ��� ����
SELECT * FROM (SELECT ROWNUM RN,TEMP.* FROM (SELECT EMPNO,ENAME,SAL FROM EMP ORDER BY SAL DESC) TEMP) WHERE RN=10;

--EMP ���̺��� ��� ����� �����ȣ,����̸�,�޿��� �޿��� �������� �����Ͽ� �˻��ϵ� �˻��࿡ ���ȣ�� �����Ͽ� �˻��ϰ� 
--���ȣ�� 6���� 10 ������ ��鸸 �˻�
SELECT * FROM (SELECT ROWNUM RN,TEMP.* FROM (SELECT EMPNO,ENAME,SAL FROM EMP ORDER BY SAL DESC) TEMP) 
    WHERE RN BETWEEN 6 AND 10;

--EMP ���̺��� ��� ����� �����ȣ,����̸�,�˻��� �������� �����ȣ�� ����̸�,�˻��� �������� �����ȣ�� ����̸��� 
--�����ȣ�� �������� �����Ͽ� �˻�. ��, ������ �Ǵ� �������� ���� ��� �����ȣ�� 0, ����̸��� NULL�� �˻�
SELECT EMPNO,ENAME,LAG(EMPNO,1,0) OVER(ORDER BY SAL) BEFORE_EMPNO,LAG(ENAME,1,NULL) OVER(ORDER BY SAL) BEFORE_ENAME
    ,LEAD(EMPNO,1,0) OVER(ORDER BY SAL) AFTER_EMPNO,LEAD(ENAME,1,NULL) OVER(ORDER BY SAL) AFTER_ENAME FROM EMP;
    
--EMP ���̺��� �����ȣ�� 7844�� ����� �����ȣ,����̸�,�˻��� �������� �����ȣ�� ����̸�,�˻��� �������� �����ȣ�� ����̸��� 
--�����ȣ�� �������� �����Ͽ� �˻�. ��, ������ �Ǵ� �������� ���� ��� �����ȣ�� 0, ����̸��� NULL�� �˻�
--WHERE ������ ���� ����Ǿ� �˻��ǹǷ� ������� �������� �������� �ʾ� ������� �������� �÷��� ��� 0�� NULL �˻�
SELECT EMPNO,ENAME,LAG(EMPNO,1,0) OVER(ORDER BY SAL) BEFORE_EMPNO,LAG(ENAME,1,NULL) OVER(ORDER BY SAL) BEFORE_ENAME
    ,LEAD(EMPNO,1,0) OVER(ORDER BY SAL) AFTER_EMPNO,LEAD(ENAME,1,NULL) OVER(ORDER BY SAL) AFTER_ENAME FROM EMP WHERE EMPNO=7844;
    
--�ζ��� �並 �̿��Ͽ� ��� ����� �˻��� �� ���ϴ� �࿡ ���� �˻� ��� ����    
SELECT * FROM (SELECT EMPNO,ENAME,LAG(EMPNO,1,0) OVER(ORDER BY SAL) BEFORE_EMPNO,LAG(ENAME,1,NULL) OVER(ORDER BY SAL) BEFORE_ENAME
    ,LEAD(EMPNO,1,0) OVER(ORDER BY SAL) AFTER_EMPNO,LEAD(ENAME,1,NULL) OVER(ORDER BY SAL) AFTER_ENAME FROM EMP) WHERE EMPNO=7844;

--������(SEQUENCE) : ���ڰ�(����)�� �����Ͽ� �ڵ� �����Ǵ� ���� �����ϴ� ��ü

--������ ����
--����)CREATE SEQUENCE �������� [START WITH �ʱⰪ] [INCREMENT BY ������] [MAXVALUE �ִ밪] 
--    [MINVALUE �ּҰ�] [CYCLE] [CACHE ����]
--START WITH �ʱⰪ : ������ ��ü�� ����� �ʱⰪ ���� - ���� : NULL
--INCREMENT BY ������ : �ڵ� �����Ǵ� ���ڰ� ���� - ���� : 1
--MAXVALUE �ִ밪 : ������ ��ü�� ������ �� �ִ� �ִ밪 ���� - ���� : ���ڰ����� ǥ���� �� �ִ� �ִ밪
--MINVALUE �ּҰ� : ������ ��ü�� ������ �� �ִ� �ּҰ� ���� - ���� : 1
--CYCLE : ������ ��ü�� ���尪�� �ִ밪�� �ʰ��� ��� �ּҰ����� �ٽ� �����ǵ��� �ݺ��ϴ� ��� ����
--CACHE ���� : �ӽ� ��������� �ڵ� �������� �̸� �����Ͽ� ������ �� �ִ� ������ �����ϴ� ��� ���� - ���� : 20

--USER2 ���̺� ���� : ��ȣ(������-PRIMARY KEY),�̸�(������),�������(��¥��)
CREATE TABLE USER2(NO NUMBER(2) PRIMARY KEY, NAME VARCHAR2(20),BIRTHDAY DATE);
DESC USER2;

--USER2 ���̺��� NO �÷������� ����� �ڵ� �������� �����ϱ� ���� ������ ��ü ����
CREATE SEQUENCE USER2_SEQ;

--������ Ȯ�� - USER_SEQUENCES : ������ ������ �����ϴ� ��ųʸ�
SELECT SEQUENCE_NAME,MAX_VALUE,MIN_VALUE,INCREMENT_BY FROM USER_SEQUENCES;

--�������� ����� ���ڰ� Ȯ�� - ����)��������.CURRVAL
--�������� NULL�� ����� ��� ���ڰ��� Ȯ���ϸ� ���� �߻�
SELECT USER2_SEQ.CURRVAL FROM DUAL;

--�������� �̿��� �ڵ� ������ ���� - ����)��������.NEXTVAL
--�������� NULL�� ����� ��� �������� �ּҰ��� �����ϰ� �������� ������ ���ڰ����� �ڵ� ����
--�������� ���ڰ��� ����� ��� ��������ŭ ������ ���ڰ��� �����ϰ� �������� ������ ���ڰ����� �ڵ� ����
SELECT USER2_SEQ.NEXTVAL FROM DUAL;-- 1(�ּҰ�)�� �˻��ǰ� �������� ���ڰ� ����
SELECT USER2_SEQ.CURRVAL FROM DUAL;--������ ���簪 : 1
SELECT USER2_SEQ.NEXTVAL FROM DUAL;--������ : 1 - 2�� �˻��ǰ� �������� ���ڰ� ����
SELECT USER2_SEQ.CURRVAL FROM DUAL;--������ ���簪 : 2

--USER2 ���̺� �� ���� - �������� �ڵ� �������� NO �÷��� �����Ͽ� ����
INSERT INTO USER2 VALUES(USER2_SEQ.NEXTVAL,'ȫ�浿','00/01/01');
INSERT INTO USER2 VALUES(USER2_SEQ.NEXTVAL,'�Ӳ���','01/12/31');
INSERT INTO USER2 VALUES(USER2_SEQ.NEXTVAL,'����ġ','02/12/21');
SELECT * FROM USER2;
COMMIT;

--������ ����
--����)ALTER SEQUENCE �������� {MAXVALUE|MINVALUE|INCREMENT BY} ���氪

--USER2_SEQ �������� �ִ밪�� 99,�������� 5�� ����
SELECT SEQUENCE_NAME,MAX_VALUE,MIN_VALUE,INCREMENT_BY FROM USER_SEQUENCES;
ALTER SEQUENCE USER2_SEQ MAXVALUE 99 INCREMENT BY 5;
SELECT SEQUENCE_NAME,MAX_VALUE,MIN_VALUE,INCREMENT_BY FROM USER_SEQUENCES;

--USER2 ���̺� �� ���� - �������� �ڵ� �������� NO �÷��� �����Ͽ� ����
INSERT INTO USER2 VALUES(USER2_SEQ.NEXTVAL,'������','03/09/09');
SELECT * FROM USER2;
COMMIT;

--������ ����
--����)DROP SEQUENCE ��������

--USER2_SEQ ������ ����
SELECT SEQUENCE_NAME,MAX_VALUE,MIN_VALUE,INCREMENT_BY FROM USER_SEQUENCES;
DROP SEQUENCE USER2_SEQ;
SELECT SEQUENCE_NAME,MAX_VALUE,MIN_VALUE,INCREMENT_BY FROM USER_SEQUENCES;

--�ε���(INDEX) : ���̺� ����� ���� ���� ������ �˻��ϱ� ���� ����� �����ϴ� ��ü
--�÷��� �ε����� �����ϸ� �ε��� ������ �����Ͽ� �÷��� ���� �� �˻� �ӵ� ����
--���ǽĿ��� ���� ���Ǵ� �÷��� �����ϸ� ���� ���� �� �����ϴ� ���� ȿ����

--����ũ �ε���(UNIQUE INDEX) : PRIMARY KEY �Ǵ� UNIQUE �������ǿ� ���� �ڵ����� �����Ǵ� �ε���
--������ũ �ε���(NON-UNIQUE INDEX) : ����ڰ� �������� ���̺� �÷��� �����ϴ� �ε���

--USER3 ���̺� ���� : ��ȣ(������-PRIMARY KEY),�̸�(������),�̸���(������-UNIQUE)
CREATE TABLE USER3(NO NUMBER(2) CONSTRAINT USER3_NO_PK PRIMARY KEY, NAME VARCHAR2(20)
    ,EMAIL VARCHAR2(50) CONSTRAINT USER3_EMAIL_UK UNIQUE);
    
--�������� Ȯ��   
SELECT CONSTRAINT_NAME,CONSTRAINT_TYPE FROM USER_CONSTRAINTS WHERE TABLE_NAME='USER3';
 
--�ε��� Ȯ�� - USER_INDEXES : �ε��� ������ �����ϴ� ��ųʸ�, USER_IND_COLUMNS : �÷� �ε��� ������ �����ϴ� ��ųʸ�  
SELECT C.INDEX_NAME,COLUMN_NAME,UNIQUENESS,INDEX_TYPE FROM USER_INDEXES I JOIN USER_IND_COLUMNS C 
    ON I.INDEX_NAME=C.INDEX_NAME WHERE C.TABLE_NAME='USER3'; 
    
--�ε���(NON-UNIQUE INDEX) ����    
--����)CREATE INDEX �ε����� ON ���̺��(�÷���)
--�������� ���� ���̺��� ���ǽĿ��� ���� ���Ǵ� �÷��� ����
--�˻������ �������� 2~4%�� ��� �Ǵ� ������������ ���Ǵ� �÷�, NULL�� ���� ����� �÷��� �����ϴ� ���� ����

--USER3 ���̺��� NAME �÷��� �ε����� �����Ͽ� ����
CREATE INDEX USER3_NAME_INDEX ON USER3(NAME);

--�ε��� Ȯ��
SELECT C.INDEX_NAME,COLUMN_NAME,UNIQUENESS,INDEX_TYPE FROM USER_INDEXES I JOIN USER_IND_COLUMNS C 
    ON I.INDEX_NAME=C.INDEX_NAME WHERE C.TABLE_NAME='USER3'; 

--�ε���(NON-UNIQUE INDEX) ����
--����)DROP INDEX �ε�����
--UNIQUNE INDEX�� ���������� �����ϸ� �ڵ����� ���� ó��

--USER3 ���̺��� EMAIL �÷��� ������ �ε��� ���� - UNIQUE �������� ����
ALTER TABLE USER3 DROP CONSTRAINT USER3_EMAIL_UK;

--�������� �� �ε��� Ȯ��
SELECT CONSTRAINT_NAME,CONSTRAINT_TYPE FROM USER_CONSTRAINTS WHERE TABLE_NAME='USER3';
SELECT C.INDEX_NAME,COLUMN_NAME,UNIQUENESS,INDEX_TYPE FROM USER_INDEXES I JOIN USER_IND_COLUMNS C 
    ON I.INDEX_NAME=C.INDEX_NAME WHERE C.TABLE_NAME='USER3'; 

--USER3 ���̺��� NAME �÷��� ������ �ε��� ����
DROP INDEX USER3_NAME_INDEX;
SELECT C.INDEX_NAME,COLUMN_NAME,UNIQUENESS,INDEX_TYPE FROM USER_INDEXES I JOIN USER_IND_COLUMNS C 
    ON I.INDEX_NAME=C.INDEX_NAME WHERE C.TABLE_NAME='USER3'; 

--���Ǿ�(SYNONYM) : ����Ŭ ��ü�� ������ �ο��Ͽ� ����ϴ� ��ü
--���� ���Ǿ� : Ư�� ����ڸ� ����� �� �ִ� ���Ǿ� - �Ϲ� ����� ����
--���� ���Ǿ� : ��� ����ڰ� ����� �� �ִ� ���Ǿ� - ������ ����

--���Ǿ� ����
--����)CREATE [PUBLIC] SYNONYM ���Ǿ� FOR ��ü��
--PUBLIC : ���� ���Ǿ �����ϱ� ���� Ű����

--���̺� ��� Ȯ�� - SYS.USER_TABLES : SYS ����� ��Ű���� �����ϴ� USER_TABLES �並 �̿��Ͽ� Ȯ��
SELECT TABLE_NAME FROM SYS.USER_TABLES;
SELECT TABLE_NAME FROM USER_TABLES;--SYS.USER_TABLES ��ü�� ���� ���Ǿ� : USER_TABLES
SELECT TABLE_NAME FROM TABS;--SYS.USER_TABLES ��ü�� ���� ���Ǿ� : TABS

--EMP ���̺��� �������� NULL�� �ƴ� ����� ����̸�,����,�޿�,�������� �˻��Ͽ� COMM ���̺� ����
DESC COMM;
SELECT * FROM COMM;
INSERT INTO COMM SELECT ENAME,JOB,SAL,COMM FROM EMP WHERE COMM IS NOT NULL;
SELECT * FROM COMM;
COMMIT;

--COMM ���̺� ���� ���Ǿ�� BONUS ����
--���� �����ڿ��� ���Ǿ ���� �ý��� ������ ������ ���� �߻� - �����ڿ��� ���Ǿ ���� �ý��� ���� ��û
CREATE SYNONYM BONUS FOR COMM;

--�ý��� ������(SYS �Ǵ� SYSTEM)�� �����Ͽ� �Ϲ� �����(SCOTT)���� ���Ǿ ���� �ý��� ���� �ο�
--GRANT CREATE SYNONYM TO SCOTT;

--�����ڷκ��� ���Ǿ ���� �ý��� ������ �ο� ���� �� ���Ǿ� ���� ��� ��� ����
CREATE SYNONYM BONUS FOR COMM;
SELECT * FROM COMM;
SELECT * FROM BONUS;

--���Ǿ� Ȯ�� - USER_SYNONYMS : ���Ǿ� ���� ������ �����ϴ� ��ųʸ�
SELECT TABLE_NAME,SYNONYM_NAME,TABLE_OWNER FROM USER_SYNONYMS WHERE TABLE_NAME='COMM';

--���� ���Ǿ� ���� : �����ڰ� �����Ͽ� ��� ����ڿ��� �����ϴ� ���Ǿ�
--�ý��� �����ڷ� ���ӵ� ���ǿ��� �۾�
--����Ŭ ��ü�� ������� �ܺ� ��Ű��(SCHEMA)�� �̿��Ͽ� ǥ�� - ����)��Ű����.��ü��
--�ܺ� ��Ű���� ������ ��� ���� ������� �ܺ� ��Ű���� �̿��Ͽ� ��ü ǥ��
--SELECT EMPNO,ENAME,SAL FROM SCOTT.EMP;

--SCOTT ������� �ܺ� ��Ű���� �����ϴ� EMP ���̺� ���� ���� ���Ǿ�� SCOTT_EMP ����
--CREATE PUBLIC SYNONYM SCOTT_EMP FOR SCOTT.EMP;
--SELECT EMPNO,ENAME,SAL FROM SCOTT_EMP;

--���� ���Ǿ�� ��� ����ڰ� ��� ����
SELECT EMPNO,ENAME,SAL FROM SCOTT_EMP;

--��ǥ���� ���� ���Ǿ� : DUAL �Ǵ� ��ųʸ�
SELECT SYSDATE FROM SYS.DUAL;
SELECT SYSDATE FROM DUAL;
SELECT OWNER,TABLE_NAME,SYNONYM_NAME,TABLE_OWNER FROM ALL_SYNONYMS WHERE TABLE_NAME='DUAL';

SELECT TABLE_NAME FROM SYS.USER_TABLES;
SELECT TABLE_NAME FROM USER_TABLES;
SELECT TABLE_NAME FROM TABS;
SELECT OWNER,TABLE_NAME,SYNONYM_NAME,TABLE_OWNER FROM ALL_SYNONYMS WHERE TABLE_NAME='USER_TABLES';

--���Ǿ� ����
--����)DROP [PUBLIC] SYNONYM ���Ǿ�

--SCOTT_EMP ���� ���Ǿ� ���� >> ������
--DROP PUBLIC SYNONYM SCOTT_EMP;
SELECT OWNER,TABLE_NAME,SYNONYM_NAME,TABLE_OWNER FROM ALL_SYNONYMS WHERE TABLE_NAME='EMP';
SELECT * FROM SCOTT_EMP;--���� �߻�

--���� ������� BONUS ���� ���Ǿ� ����
SELECT OWNER,TABLE_NAME,SYNONYM_NAME,TABLE_OWNER FROM ALL_SYNONYMS WHERE TABLE_NAME='COMM';
DROP SYNONYM BONUS;
SELECT OWNER,TABLE_NAME,SYNONYM_NAME,TABLE_OWNER FROM ALL_SYNONYMS WHERE TABLE_NAME='COMM';
SELECT * FROM BONUS;--���� �߻�