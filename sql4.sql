--����1.�μ� ���̺�� ��� ���̺��� ���,�����,�μ��ڵ�,�μ����� �˻��Ͻÿ�.(����� �������� ������ ��)
SELECT EMPNO,ENAME,DEPTNO,DNAME FROM EMP NATURAL JOIN DEPT ORDER BY ENAME;
SELECT EMPNO,ENAME,EMP.DEPTNO,DNAME FROM EMP JOIN DEPT ON EMP.DEPTNO=DEPT.DEPTNO ORDER BY ENAME;
SELECT EMPNO,ENAME,DEPT.DEPTNO,DNAME FROM EMP JOIN DEPT ON EMP.DEPTNO=DEPT.DEPTNO ORDER BY ENAME;

--����2.�μ� ���̺�� ��� ���̺��� ���,�����,�޿�,�μ����� �˻��Ͻÿ�. 
--��, �޿��� 2000 �̻��� ����� ���Ͽ� �޿� �������� �������� ������ ��.
SELECT EMPNO,ENAME,SAL,DNAME FROM EMP JOIN DEPT ON EMP.DEPTNO=DEPT.DEPTNO WHERE SAL>=2000 ORDER BY SAL DESC;

--����3.�μ� ���̺�� ��� ���̺��� ���,�����,�޿�,�μ����� �˻��Ͻÿ�. 
--��, ������ Manager�̸� �޿��� 2500 �̻��� ����� ���Ͽ� ����� �������� �������� ������ ��.
SELECT EMPNO,ENAME,SAL,DNAME FROM EMP JOIN DEPT ON EMP.DEPTNO=DEPT.DEPTNO WHERE JOB='MANAGER' AND SAL>=2500 ORDER BY EMPNO;

--����4.��� ���̺�� �޿� ��� ���̺��� ���,�����,�޿�,����� �˻��Ͻÿ�. 
--��, ����� �޿��� ���Ѱ��� ���Ѱ� ������ ���Եǰ� ����� 4�̸� �޿��� �������� �������� ������ ��.
SELECT EMPNO,ENAME,SAL,GRADE FROM EMP JOIN SALGRADE ON SAL BETWEEN LOSAL AND HISAL WHERE GRADE=4 ORDER BY SAL DESC;

--����5.�μ� ���̺�,��� ���̺�, �޿� ��� ���̺��� ���,�����,�μ���,�޿�,����� �˻��Ͻÿ�. 
--��, ����� �޿��� ���Ѱ��� ���Ѱ� ������ ���ԵǸ� ����� �������� �������� ������ ��.
SELECT EMPNO,ENAME,DNAME,SAL,GRADE FROM EMP JOIN DEPT ON EMP.DEPTNO=DEPT.DEPTNO 
    JOIN SALGRADE ON SAL BETWEEN LOSAL AND HISAL ORDER BY GRADE DESC;
    
--����6.��� ���̺��� ������ �ش� ����� �����ڸ��� �˻��Ͻÿ�.    
SELECT W.ENAME "�����",M.ENAME "�����ڸ�" FROM EMP W JOIN EMP M ON W.MGR=M.EMPNO;
SELECT W.ENAME "�����",M.ENAME "�����ڸ�" FROM EMP W LEFT JOIN EMP M ON W.MGR=M.EMPNO;

--����7.��� ���̺��� �����, �ش� ����� �����ڸ�, �ش� ����� �������� �����ڸ��� �˻��Ͻÿ�.
SELECT W.ENAME "�����",M.ENAME "�����ڸ�",MM.ENAME "�������� �����ڸ�" 
    FROM EMP W JOIN EMP M ON W.MGR=M.EMPNO JOIN EMP MM ON M.MGR=MM.EMPNO; 

--����8.7�� ������� ���� �����ڰ� ���� ��� ����� �̸��� ����� ��µǵ��� �����Ͻÿ�.
SELECT W.ENAME "�����",M.ENAME "�����ڸ�",MM.ENAME "�������� �����ڸ�" 
    FROM EMP W LEFT JOIN EMP M ON W.MGR=M.EMPNO LEFT JOIN EMP MM ON M.MGR=MM.EMPNO; 

--��������(SUBQUERY) : SQL ��ɿ� ���ԵǾ� ����Ǵ� SELECT ���
--���� ���� SQL ������� ���� �� �ִ� ����� �ϳ��� SQL ������� ��� ���� ����ϴ� ���

--SELECT ���(MAINQUERY)�� ���ԵǾ� ����Ǵ� SELECT ���(SUBQUERY)
--�������� ����� ���� ����� �� �������� ��� ����
--���������� ����� ���������� FROM, WHERE, HAVING �������� () �ȿ� �ۼ�

--EMP ���̺��� ����̸��� SCOTT�� ������� ���� �޿��� �޴� ����� �����ȣ,����̸�,�޿� �˻�
--SELECT ����� 2�� ����Ͽ� ���ϴ� ��� �˻�
SELECT SAL FROM EMP WHERE ENAME='SCOTT';--�˻���� : 3000
SELECT EMPNO,ENAME,SAL FROM EMP WHERE SAL>=3000;
 
--���������� �̿��ϸ� �ϳ��� SELECT ����� ����Ͽ� ���ϴ� ��� �˻�
--WHERE �������� ���ǽ��� �񱳰� ��� ���������� �˻� ������� ����Ͽ� �˻�
--���ǽ��� �񱳴��� ���� �ڷ����� ���� �ϳ��� �˻��ǵ��� �������� �ۼ� - ������(SINGLE ROW)�� ���� �÷���(SINGLE COLUMN) �˻�
SELECT EMPNO,ENAME,SAL FROM EMP WHERE SAL>=(SELECT SAL FROM EMP WHERE ENAME='SCOTT');

--EMP ���̺��� �����ȣ�� 7844�� ����� ���� ������ �ϴ� ����� �����ȣ,����̸�,����,�޿� �˻�
SELECT EMPNO,ENAME,JOB,SAL FROM EMP WHERE JOB=(SELECT JOB FROM EMP WHERE EMPNO=7844) AND EMPNO<>7844;

--EMP ���̺��� �����ȣ�� 7521�� ����� ���� ������ �ϴ� ��� �� �����ȣ�� 7900�� ������� ���� �޿��� �޴� �����
--�����ȣ,����̸�,����,�޿� �˻�
SELECT EMPNO,ENAME,JOB,SAL FROM EMP WHERE JOB=(SELECT JOB FROM EMP WHERE EMPNO=7521) AND EMPNO<>7521
    AND SAL>(SELECT SAL FROM EMP WHERE EMPNO=7900);

--EMP ���̺��� SALES �μ��� �ٹ��ϴ� ����� �����ȣ,����̸�,����,�޿� �˻�
--�μ��̸��� DEPT ���̺� ����Ǿ� �����Ƿ� ���̺� ������ ����Ͽ� �˻�
SELECT EMPNO,ENAME,JOB,SAL FROM EMP JOIN DEPT ON EMP.DEPTNO=DEPT.DEPTNO WHERE DNAME='SALES';
--���̺� ���� ��� ���������� ����Ͽ� �˻�
SELECT EMPNO,ENAME,JOB,SAL FROM EMP WHERE DEPTNO=(SELECT DEPTNO FROM DEPT WHERE DNAME='SALES');

--EMP ���̺��� �޿��� ���� ���� �޴� ����� �����ȣ,����̸�,����,�޿� �˻�
SELECT EMPNO,ENAME,JOB,SAL FROM EMP WHERE SAL=(SELECT MIN(SAL) FROM EMP);

--EMP ���̺��� SALES �μ��� �ٹ��ϴ� ��� �� �޿��� ���� ���� ����� �����ȣ,����̸�,����,�޿� �˻�
--����Ŭ�� �������� �ȿ� �������� ��� ����
SELECT EMPNO,ENAME,JOB,SAL FROM EMP WHERE SAL=(SELECT MAX(SAL) FROM EMP 
    WHERE DEPTNO=(SELECT DEPTNO FROM DEPT WHERE DNAME='SALES'));
    
--EMP ���̺��� �μ��� ��� �޿� �� ���� ���� ��� �޿��� �޴� �μ��� �μ���ȣ,��ձ޿� �˻�
SELECT DEPTNO,CEIL(AVG(SAL)) AVG_SAL FROM EMP GROUP BY DEPTNO 
    HAVING AVG(SAL)=(SELECT MAX(AVG(SAL)) FROM EMP GROUP BY DEPTNO);
    
--EMP ���̺��� �μ����� ���� ���� �޿��� �޴� ����� �����ȣ,����̸�,�޿�,�μ���ȣ �˻�    
--���������� �˻� ������� ������(MULTI-ROW SUBQUERY)�� ��� = �����ڸ� ����Ͽ� ���ϸ� ���� �߻�
SELECT EMPNO,ENAME,SAL,DEPTNO FROM EMP WHERE SAL=(SELECT MIN(SAL) FROM EMP GROUP BY DEPTNO);--����

--���������� �˻� ������� �������� ��� = ������ ��� IN �����ڸ� ����Ͽ� �÷��� ��
SELECT EMPNO,ENAME,SAL,DEPTNO FROM EMP WHERE SAL IN(SELECT MIN(SAL) FROM EMP GROUP BY DEPTNO);

--���������� �˻� ������� �������� ��� > �Ǵ� < �����ڴ� ANY �Ǵ� ALL Ű����� ���� ����Ͽ� �˻�

--EMP ���̺��� �μ���ȣ�� 10�� �μ��� �ٹ��ϴ� ��� ������� �޿��� ���� ����� �����ȣ,����̸�,�޿�,�μ���ȣ �˻�
SELECT EMPNO,ENAME,SAL,DEPTNO FROM EMP WHERE SAL<ALL(SELECT SAL FROM EMP WHERE DEPTNO=10);

--EMP ���̺��� �μ���ȣ�� 10�� �μ��� �ٹ��ϴ� � ������� �޿��� ���� ����� �����ȣ,����̸�,�޿�,�μ���ȣ �˻�
SELECT EMPNO,ENAME,SAL,DEPTNO FROM EMP WHERE SAL<ANY(SELECT SAL FROM EMP WHERE DEPTNO=10) AND DEPTNO<>10;

--EMP ���̺��� �μ���ȣ�� 20�� �μ��� �ٹ��ϴ� ��� ������� �޿��� ���� ����� �����ȣ,����̸�,�޿�,�μ���ȣ �˻�
SELECT EMPNO,ENAME,SAL,DEPTNO FROM EMP WHERE SAL>ALL(SELECT SAL FROM EMP WHERE DEPTNO=20);

--EMP ���̺��� �μ���ȣ�� 20�� �μ��� �ٹ��ϴ� � ������� �޿��� ���� ����� �����ȣ,����̸�,�޿�,�μ���ȣ �˻�
SELECT EMPNO,ENAME,SAL,DEPTNO FROM EMP WHERE SAL>ANY(SELECT SAL FROM EMP WHERE DEPTNO=20) AND DEPTNO<>20;

--������ ���������� ANY �Ǵ� ALL ��� ������ ���������� MIN �Ǵ� MAX �Լ� ���

--EMP ���̺��� �μ���ȣ�� 10�� �μ��� �ٹ��ϴ� ��� ������� �޿��� ���� ����� �����ȣ,����̸�,�޿�,�μ���ȣ �˻�
--�÷���<ALL(������ ��������) ��� �÷���<(������ �������� - MIN �Լ�)
SELECT EMPNO,ENAME,SAL,DEPTNO FROM EMP WHERE SAL<(SELECT MIN(SAL) FROM EMP WHERE DEPTNO=10);

--EMP ���̺��� �μ���ȣ�� 10�� �μ��� �ٹ��ϴ� � ������� �޿��� ���� ����� �����ȣ,����̸�,�޿�,�μ���ȣ �˻�
--�÷���<ANY(������ ��������) ��� �÷���<(������ �������� - MAX �Լ�)
SELECT EMPNO,ENAME,SAL,DEPTNO FROM EMP WHERE SAL<(SELECT MAX(SAL) FROM EMP WHERE DEPTNO=10) AND DEPTNO<>10;

--EMP ���̺��� �μ���ȣ�� 20�� �μ��� �ٹ��ϴ� ��� ������� �޿��� ���� ����� �����ȣ,����̸�,�޿�,�μ���ȣ �˻�
--�÷���>ALL(������ ��������) ��� �÷���>(������ �������� - MAX �Լ�)
SELECT EMPNO,ENAME,SAL,DEPTNO FROM EMP WHERE SAL>(SELECT MAX(SAL) FROM EMP WHERE DEPTNO=20);

--EMP ���̺��� �μ���ȣ�� 20�� �μ��� �ٹ��ϴ� � ������� �޿��� ���� ����� �����ȣ,����̸�,�޿�,�μ���ȣ �˻�
--�÷���>ANY(������ ��������) ��� �÷���>(������ �������� - MIN �Լ�)
SELECT EMPNO,ENAME,SAL,DEPTNO FROM EMP WHERE SAL>(SELECT MIN(SAL) FROM EMP WHERE DEPTNO=20) AND DEPTNO<>20;

--EMP ���̺��� ����̸��� ALLEN�� ����� �Ŵ����� ���� ��� �� ������ ���� ����� �����ȣ,����̸�,�Ŵ�����ȣ,����,�޿� �˻�
SELECT EMPNO,ENAME,MGR,JOB,SAL FROM EMP WHERE MGR=(SELECT MGR FROM EMP WHERE ENAME='ALLEN') AND ENAME<>'ALLEN'
    AND JOB=(SELECT JOB FROM EMP WHERE ENAME='ALLEN');

--���������� �˻������ ���� ��(MULTI-COLUMN SUBQUERY)�� ��� ���� �÷��� () �ȿ� ,�� �����Ͽ� �����ϸ� �� ����   
SELECT EMPNO,ENAME,MGR,JOB,SAL FROM EMP WHERE (MGR,JOB)=(SELECT MGR,JOB FROM EMP WHERE ENAME='ALLEN') AND ENAME<>'ALLEN';

--����1.��� ���̺��� BLAKE ���� �޿��� ���� ������� ���,�̸�,�޿��� �˻��Ͻÿ�.
SELECT EMPNO,ENAME,SAL FROM EMP WHERE SAL>(SELECT SAL FROM EMP WHERE ENAME='BLAKE');

--����2.��� ���̺��� MILLER ���� �ʰ� �Ի��� ����� ���,�̸�,�Ի����� �˻��Ͻÿ�.
SELECT EMPNO,ENAME,HIREDATE FROM EMP WHERE HIREDATE>(SELECT HIREDATE FROM EMP WHERE ENAME='MILLER');

--����3.��� ���̺��� ��� ��ü ��� �޿����� �޿��� ���� ������� ���,�̸�,�޿��� �˻��Ͻÿ�.
SELECT EMPNO,ENAME,SAL FROM EMP WHERE SAL>(SELECT AVG(SAL) FROM EMP);

--����4.��� ���̺��� CLARK�� ���� �μ��̸�, ����� 7698�� ������ �޿����� ���� �޿��� �޴� ������� ���,�̸�,�޿��� �˻��Ͻÿ�.
SELECT EMPNO,ENAME,SAL FROM EMP WHERE DEPTNO=(SELECT DEPTNO FROM EMP WHERE ENAME='CLARK') 
    AND SAL>(SELECT SAL FROM EMP WHERE EMPNO=7698);
    
--����5.��� ���̺��� �μ��� �ִ� �޿��� �޴� ������� ���,�̸�,�μ��ڵ�,�޿��� �˻��Ͻÿ�.
SELECT EMPNO,ENAME,DEPTNO,SAL FROM EMP WHERE SAL IN(SELECT MAX(SAL) FROM EMP GROUP BY DEPTNO);

--���տ�����(SET ������) : �� ���� SELECT ��ɿ� ���� �˻������ �̿��Ͽ� ���� ������� �����ϴ� ������
-- >> ������(UNION), ������(INTERSECT), ������(MINUS)

--SUPER_HIRO ���̺� ���� - �Ӽ� : �̸�(������)
CREATE TABLE SUPER_HIRO(NAME VARCHAR2(20));

--SUPER_HIRE ���̺� �� ����(����)
INSERT INTO SUPER_HIRO VALUES('���۸�');
INSERT INTO SUPER_HIRO VALUES('���̾��');
INSERT INTO SUPER_HIRO VALUES('��Ʈ��');
INSERT INTO SUPER_HIRO VALUES('��Ʈ��');
INSERT INTO SUPER_HIRO VALUES('�����̴���');
COMMIT;
SELECT * FROM SUPER_HIRO;

--MARVEL_HIRO ���̺� ���� - �Ӽ� : �̸�(������), ���(������)
CREATE TABLE MARVEL_HIRO(NAME VARCHAR2(20),GRADE NUMBER(1));

--MARVEL_HIRO ���̺� �� ����
INSERT INTO MARVEL_HIRO VALUES('���̾��',3);
INSERT INTO MARVEL_HIRO VALUES('��ũ',1);
INSERT INTO MARVEL_HIRO VALUES('�����̴���',4);
INSERT INTO MARVEL_HIRO VALUES('�丣',2);
INSERT INTO MARVEL_HIRO VALUES('��Ʈ��',5);
COMMIT;
SELECT * FROM MARVEL_HIRO;

--UNION : �� ���� SELECT ������� �˻��� ���� ���� ����� ���� - �ߺ��� ����
--���տ����ڸ� ����� ��� �� ���� SELECT ����� �˻������ ������ �ڷ����� �ݵ�� �����ϵ��� �ۼ�
SELECT NAME FROM SUPER_HIRO
UNION
SELECT NAME FROM MARVEL_HIRO;

--UNION ALL : �� ���� SELECT ������� �˻��� ���� ���� ����� ���� - �ߺ��� ����
SELECT NAME FROM SUPER_HIRO
UNION ALL
SELECT NAME FROM MARVEL_HIRO;

--INTERSECT : �� ���� SELECT ������� �˻��� �ߺ����� ����� ����
SELECT NAME FROM SUPER_HIRO
INTERSECT
SELECT NAME FROM MARVEL_HIRO;

--MINUS : ù��° SELECT ����� �˻� ������� �ι�° SELECT ����� �˻� ����� ������ �� ����
SELECT NAME FROM SUPER_HIRO
MINUS
SELECT NAME FROM MARVEL_HIRO;

--���տ����� ���� �� ���� SELECT ��ɿ� ���� �˻������ ���� �Ǵ� �ڷ����� �ٸ� ��� ���� �߻�
SELECT NAME FROM SUPER_HIRO UNION SELECT GRADE FROM MARVEL_HIRO;
SELECT NAME FROM SUPER_HIRO UNION SELECT NAME,GRADE FROM MARVEL_HIRO;

--���տ����� ���� �˻������ ������ �ٸ� ��� �÷��� ��� ������ �ڷ����� ���ǰ� �Ǵ� NULL�� ����Ͽ� ���� �˻� ��� ����
SELECT NAME,0 FROM SUPER_HIRO UNION SELECT NAME,GRADE FROM MARVEL_HIRO;
SELECT NAME,NULL FROM SUPER_HIRO UNION SELECT NAME,GRADE FROM MARVEL_HIRO;

--���տ����� ���� �˻������ �ڷ����� �ٸ� ��� ��ȯ�Լ��� ����Ͽ� ���� �ڷ������� �����Ͽ� ���� �˻� ��� ����
SELECT NAME FROM SUPER_HIRO UNION SELECT TO_CHAR(GRADE,'0') FROM MARVEL_HIRO;

--DML(DATA MANIPLATION LANGUAGE) : ����Ÿ ���۾�
--���̺��� �࿡ ���� ����,����,���� ����� �����ϴ� SQL ���
--DML ��� ���� �� COMMIT(DML ��� ����) �Ǵ� ROLLBACK(DML ��� ���) ����� �����ϴ� ���� ����

--INSERT : ���̺� ���� �����Ͽ� �����ϴ� ���
--����)INSERT INTO ���̺�� VALUES(�÷���,�÷���,...)
--���̺� ���Ե� ���� �÷����� ���̺� �Ӽ��� �°� ���ʴ�� �����Ͽ� ����ǵ��� �ۼ�
-- >> ���̺� ����� �÷� ������� �ڷ����� �´� ���� �������� �����Ͽ� ����

--���̺� �Ӽ� Ȯ�� : �÷��� �ڷ��� Ȯ��
--����)DESC ���̺��
DESC DEPT;

--DEPT ���̺� ���ο� ��(�μ�����) ����
INSERT INTO DEPT VALUES(50,'ȸ���','����');
COMMIT;
SELECT * FROM DEPT;

--�����࿡ ���޵� �÷����� ������ ���̺��� �÷� ������ ���� ���� ��� ���� �߻�
INSERT INTO DEPT VALUES(60,'�ѹ���');
INSERT INTO DEPT VALUES(60,'�ѹ���','��õ','02-1234-5678');

--�����࿡ ���޵� �÷����� ���̺��� �÷� �ڷ����� ���� �ʰų� �ڷ����� ũ�⺸�� ū ��� ���� �߻�
INSERT INTO DEPT VALUES('����','�ѹ���','��õ');
INSERT INTO DEPT VALUES(60,'�ѹ���','��õ�� ���̱�');

--���̺��� �÷��� �ο��� ���������� �����ϴ� ���� ���޵� ��� ���� �߻�
--NOT NULL �������� : �÷��� NULL�� ������� �ʵ��� �����ϴ� ��������
INSERT INTO DEPT VALUES(NULL,'�ѹ���','��õ');

--PK(PRIMARY KEY) �������� : ���� ���� �÷����� ���� ���� ������� �ʵ��� �����ϴ� ��������
SELECT * FROM DEPT WHERE DEPTNO=50;
INSERT INTO DEPT VALUES(50,'�ѹ���','��õ');

--FK(FOREIGN KEY) �������� : �θ� ���̺� ����� �÷����� �ڽ� ���̺��� �÷��� ����ǵ��� �����ϴ� ��������
--EMP ���̺�(�ڽ� ���̺�) �Ӽ� Ȯ�� - DEPTNO �÷�
DESC EMP;
--DEPT ���̺�(�θ� ���̺�) �Ӽ� Ȯ�� - DEPTNO �÷�
DESC DEPT;
SELECT DEPTNO FROM DEPT;
--EMP ���̺� ���ο� ��(�������) ����
--DEPT ���̺�(�θ� ���̺�)�� 35�� �μ���ȣ�� ����Ǿ� ���� �ʾ� EMP ���̺�(�ڽ� ���̺�)�� �� ���Խ� ���� �߻�
INSERT INTO EMP VALUES(9000,'KIM','MANAGER',7298,'00/12/10',3500,1000,35);
INSERT INTO EMP VALUES(9000,'KIM','MANAGER',7298,'00/12/10',3500,1000,40);
COMMIT;
SELECT * FROM EMP WHERE EMPNO=9000;

--���̺� �Ӽ��� ���������� �������� �ʴ� �÷����� �����ؾ߸� �� ����
INSERT INTO DEPT VALUES(60,'�ѹ���','��õ');
COMMIT;
SELECT * FROM DEPT;

--���̺� �� ���Խ� �÷����� �����ϰ� ���� ���� ��� NULL�� �����Ͽ� ����
INSERT INTO DEPT VALUES(70,'������',NULL);--����� NULL ����
COMMIT;
SELECT * FROM DEPT;

--���̺��� ���ϴ� �Ӽ����� �÷����� �����Ͽ� ���� �����Ͽ� ���� ����
--����)INSERT INTO ���̺��(�÷���,�÷���,...) VALUES(�÷���,�÷���,...)
--INSERT ����� ���̺� ������ �÷� ������� �÷����� �����Ͽ� �� ����
INSERT INTO DEPT(LOC,DEPTNO,DNAME) VALUES('����',80,'�����');
COMMIT;
SELECT * FROM DEPT;

--INSERT ����� ���̺� ������ �÷� ���� ����
-- >> ������ �÷����� �÷� �⺻��(DEFAULT VALUE)�� �ڵ� ����
--���̺� ���� �Ǵ� ���̺� ���� ����� �÷� �⺻���� �������� ���� ��� �÷� �⺻���� �ڵ����� NULL�� ����
INSERT INTO DEPT(DEPTNO,DNAME) VALUES(90,'�λ��');--LOC �÷� ���� : NULL ���� - ������ NULL ����
COMMIT;
SELECT * FROM DEPT;

--��¥�� �÷����� ��¥�� ��� SYSDATE Ű���带 �̿��Ͽ� �÷��� ����
INSERT INTO EMP VALUES(9001,'LEE','ANALYST',9000,SYSDATE,2000,NULL,40);
COMMIT;
SELECT * FROM EMP WHERE EMPNO=9001;

--INSERT ��ɿ��� SUBQUERY ��� ���� : ���̺��� ���� �˻��Ͽ� �˻������ �ٸ� ���̺��� ������ ���� - ���̺� �� ����
--����)INSERT INTO ���̺�� SELECT �˻����,... FROM ���̺�� [WHERE ���ǽ�]
--���� ���Ե� ���̺��� �Ӽ��� ���������� �˻���� ���� ����(����,�ڷ���,ũ��)�� ���� - �÷��� ����

--BONUS ���̺��� �Ӽ� Ȯ�� �� �� �˻�
DESC BONUS;
SELECT * FROM BONUS;

--EMP ���̺��� �������� NULL�� �ƴ� ����� �˻��Ͽ� �˻����� BONUS ���̺� ����
INSERT INTO BONUS SELECT ENAME,JOB,SAL,COMM FROM EMP WHERE COMM IS NOT NULL;
COMMIT;
SELECT * FROM BONUS;

--UPDATE : ���̺� ����� ���� �÷����� �����ϴ� ���
--����)UPDATE ���̺�� SET �÷���=���氪,�÷���=���氪,... WHERE ���ǽ�
--PK ���������� ������ �÷����� �������� �ʴ� ���� ����
--WHERE ������ ������ ��� ���̺� ����� ��� ���� �÷����� �����ϰ� ����
--���ǽĿ��� ���� �÷��� PK ���������� ������ �÷��� ����ϴ� ���� ����

--DEPT ���̺��� �μ���ȣ�� 50�� �μ� �˻�
--�μ��̸� : ȸ���, �μ���ġ : ����
SELECT * FROM DEPT WHERE DEPTNO=50;

--DEPT ���̺��� �μ���ȣ�� 50�� �μ��� �μ��̸��� �渮�η� �����ϰ� �μ���ġ�� ��õ���� ����
UPDATE DEPT SET DNAME='�渮��',LOC='��õ' WHERE DEPTNO=50;
COMMIT;
SELECT * FROM DEPT WHERE DEPTNO=50;

--���氪�� �÷��� �ڷ���,ũ��,�������ǿ� �´� ��쿡�� ���� ����
--EMP ���̺��� �����ȣ�� 9000�� ����� �μ���ȣ�� 35�� ����
UPDATE EMP SET DEPTNO=35 WHERE EMPNO=9000;--FK ���������� �����Ͽ� ���� �߻�

--UPDATE ��ɿ��� �������� ��� ���� : ���氪 �Ǵ� ���ǽ��� �񱳰� ��� �������� ���
--DEPT ���̺��� �μ����� �������� �μ���ġ(NULL)�� �ѹ����� �μ���ġ(��õ)�� ������ ����
SELECT * FROM DEPT;
UPDATE DEPT SET LOC=(SELECT LOC FROM DEPT WHERE DNAME='�ѹ���') WHERE DNAME='������';
COMMIT;
SELECT * FROM DEPT WHERE DNAME='������';

--BONUS ���̺��� ����̸��� KIM�� ������� �������� ���� ����� �������� 100 �����ǵ��� ����
SELECT * FROM BONUS;
UPDATE BONUS SET COMM=COMM+100 WHERE COMM<(SELECT COMM FROM BONUS WHERE ENAME='KIM');
COMMIT;
SELECT * FROM BONUS;

--DELETE : ���̺� ����� ���� �����ϴ� ���
--����)DELETE FROM ���̺�� WHERE ���ǽ�
--WHERE ������ ������ ��� ���̺� ����� ��� �� ����
--���ǽĿ��� ���� �÷��� PK ���������� ������ �÷��� ����ϴ� ���� ����

--DEPT ���̺��� �μ���ȣ�� 90�� �μ� ����
SELECT * FROM DEPT;
DELETE FROM DEPT WHERE DEPTNO=90;
COMMIT;
SELECT * FROM DEPT;

--DEPT ���̺��� �μ���ȣ�� 10�� �μ� ����
--FK �������ǿ� ���� �ڽ� ���̺�(EMP)�� �����ϴ� �θ� ���̺�(DEPT)�� ���� ���� �Ұ���
DELETE FROM DEPT WHERE DEPTNO=10;

--EMP ���̺�(�ڽ� ���̺�)���� ��� ����� �μ���ȣ�� �ߺ����� �˻� 
SELECT DISTINCT DEPTNO FROM EMP;--�˻���� : 10,20,30,40
--EMP ���̺��� �����ϴ� DEPT ���̺��� �μ��� ������ ������ �μ������� ���� ����
DELETE FROM DEPT WHERE DEPTNO=20;--���� �Ұ���
DELETE FROM DEPT WHERE DEPTNO=80;--���� ����
COMMIT;
SELECT * FROM DEPT;

--DELETE ��ɿ��� �������� ��� ���� : ���ǽ��� �񱳰� ��� �������� ���
--DEPT ���̺��� �μ��̸��� �������� �μ��� ���� �μ���ġ�� �μ����� ���� - ������ ����
SELECT * FROM DEPT;
DELETE FROM DEPT WHERE LOC=(SELECT LOC FROM DEPT WHERE DNAME='������');
COMMIT;
SELECT * FROM DEPT;