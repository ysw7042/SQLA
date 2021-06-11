--��ũ��Ʈ ���� ó��

--��ũ��Ʈ���� �ۼ��� SQL ����� ORACLE�� �����Ͽ� �����ϴ� ��� : [CTRL]+[ENTER] �Ǵ� [F5]
--[CTRL]+[ENTER] : Ŀ�� ��ġ�� SQL ����� �����Ͽ� ���� - [F9]
--[F5] : ��ũ��Ʈ�� �ۼ��� ��� SQL ����� �����Ͽ� ����
--������ �����Ͽ� [CTRL]+[ENTER] �Ǵ� [F5]�� ����ϸ� ���� �ȿ� �ۼ��� SQL ����� �����Ͽ� ����
--���޵� SQL ����� ���� ����� [��ũ��Ʈ ���] �� �Ǵ� [���� ���] �ǿ� ���

--SQL ����� ��ҹ��ڸ� �������� ������ �ϳ��� SQL ������� ó���ǵ��� ; ��ȣ ���

--���̺�(TABLE) : ����Ÿ���̽����� ����Ÿ(��)�� �����ϱ� ���� �⺻ ��ü
--���� ���� ������� ��Ű���� �����ϴ� ���̺� ��� Ȯ��
SELECT TABLE_NAME FROM TABS;
SELECT * FROM TAB;

--���̺��� ���� Ȯ�� : ���̺� �Ӽ� ���� - �÷���� �ڷ���
--����)DESC ���̺��
--EMP ���̺� : ��������� �����ϱ� ���� ���̺�
DESC EMP;
--DEPT ���̺� : �μ������� �����ϱ� ���� ���̺�
DESC DEPT;

--DQL(DATA QUERY LANGUAGE) : ����Ÿ ���Ǿ�
--���̺��� �࿡ ���� �˻� ����� �����ϱ� ���� SQL ���

--SELECT : �ϳ� �̻��� ���̺��� ���� �˻��ϱ� ���� ���
--����)SELECT �˻����,�˻����,... FROM ���̺��,���̺��,...
--���̺� ����� ��� �� �˻�
--�˻���� : *(��� �÷�) - �ٸ� �˻����� ���ÿ� ��� �Ұ���, �÷���, �����, �Լ� ��
SELECT * FROM EMP;
SELECT EMPNO,ENAME,SAL,DEPTNO FROM EMP;

--COLUMN ALIAS : �˻���� ��Ī(�ӽ� �÷���)�� �ο��ϴ� ���
--�˻������ ��Ȯ�ϰ� �����Ͽ� ǥ���ϱ� ���� ��Ī
--����)SELECT �˻���� [AS] ��Ī,�˻���� [AS] ��Ī,... FROM ���̺��,���̺��,...
SELECT EMPNO,ENAME,DEPTNO FROM EMP;
SELECT EMPNO AS NO,ENAME AS NAME,DEPTNO AS DNO FROM EMP;
--AS Ű���� ���� ����
SELECT EMPNO NO,ENAME NAME,DEPTNO DNO FROM EMP;
SELECT EMPNO �����ȣ,ENAME ����̸�, DEPTNO �μ���ȣ FROM EMP;

SELECT EMPNO,ENAME,SAL*12 FROM EMP;
SELECT EMPNO,ENAME,SAL*12 ANNUAL FROM EMP;

--�ĺ���(���̺��,�÷���,��Ī ��)�� ������ũ ǥ���(�ܾ�� �ܾ _�� �����Ͽ� ǥ��) ���
SELECT EMPNO,ENAME,SAL*12 ANNUAL_SALARY FROM EMP;

SELECT EMPNO �����ȣ,ENAME ����̸�,SAL*12 ���� FROM EMP;
--�÷� ��Ī���� ���鹮�� �Ǵ� Ư������ ��� �Ұ���
SELECT EMPNO ��� ��ȣ,ENAME ��� �̸�,SAL*12 ����^^ FROM EMP;--���� �߻�
--�÷� ��Ī�� " " ��ȣ �ȿ� ǥ���ϸ� ��� ������ ��Ī ��� ���� - " " ��ȣ�� ��Ī�� ǥ���ϱ� ���� ��ȣ
SELECT EMPNO "��� ��ȣ",ENAME "��� �̸�",SAL*12 "����^^" FROM EMP;

SELECT ENAME,JOB FROM EMP;
--|| ��ȣ�� �̿��Ͽ� ���� �����Ͽ� ǥ�� ����
SELECT ENAME||JOB FROM EMP;
--����Ŭ������ ���ڰ��� ' ' ��ȣ�� �̿��Ͽ� ǥ��
SELECT ENAME||'���� ������ '||JOB||'�Դϴ�.' FROM EMP;

--EMP ���̺� ����� ��� ����� ���� �˻� - �ߺ� �÷��� �˻�
SELECT JOB FROM EMP;

--EMP ���̺� ����� ��� ����� ���� �˻� - �ߺ� �÷����� ������ ������ �ϳ��� �÷��� �˻�
--DISTINCT : �˻������ �ߺ����� �����ϰ� ������ �ϳ��� ������� �˻��ϴ� ����� �����ϴ� Ű����
--����)SELECT DISTINCT �˻����[,�˻����,...] FROM ���̺��
SELECT DISTINCT JOB FROM EMP;

--����Ŭ�� DISTINCT Ű���� �ڿ� �˻������ ������ �����Ͽ� �˻� ����
SELECT DISTINCT JOB,DEPTNO FROM EMP;

--WHERE : ���ǽ��� ����Ͽ� ������ ���� �ุ �˻��ϴ� ����� ����
--����)SELECT �˻����,�˻����,... FROM ���̺��,���̺��,... WHERE ���ǽ�

--EMP ���̺��� ��� ����� �����ȣ,����̸�,����,�޿� �˻�
SELECT EMPNO,ENAME,JOB,SAL FROM EMP;

--EMP ���̺��� �����ȣ�� [7698]�� ����� �����ȣ,����̸�,����,�޿� �˻�
SELECT EMPNO,ENAME,JOB,SAL FROM EMP WHERE EMPNO=7698;

--EMP ���̺��� ����̸��� [KING]�� ����� �����ȣ,����̸�,����,�޿� �˻�
SELECT EMPNO,ENAME,JOB,SAL FROM EMP WHERE ENAME='KING';
--���ڰ��� ��ҹ��ڸ� �����Ͽ� ��
SELECT EMPNO,ENAME,JOB,SAL FROM EMP WHERE ENAME='king';

--EMP ���̺��� �Ի����� [1981�� 6�� 9��]�� ����� �����ȣ,����̸�,����,�޿�,�Ի��� �˻�
--��¥���� ' ' ��ȣ �ȿ� [RR/MM/DD]������ �������� ǥ��
SELECT EMPNO,ENAME,JOB,SAL,HIREDATE FROM EMP WHERE HIREDATE='81/06/09';
--��¥���� ' ' ��ȣ �ȿ� [YYYY-MM-DD]������ �������� ǥ��
SELECT EMPNO,ENAME,JOB,SAL,HIREDATE FROM EMP WHERE HIREDATE='1981-06-09';

--EMP ���̺��� ������ [SALESMAN]�� �ƴ� ����� �����ȣ,����̸�,����,�޿� �˻�
SELECT EMPNO,ENAME,JOB,SAL FROM EMP WHERE JOB<>'SALESMAN';
SELECT EMPNO,ENAME,JOB,SAL FROM EMP WHERE JOB!='SALESMAN';

--EMP ���̺��� �޿��� [2000]�̻��� ����� �����ȣ,����̸�,����,�޿� �˻�
SELECT EMPNO,ENAME,JOB,SAL FROM EMP WHERE SAL>=2000;

--EMP ���̺��� ����̸��� [A],[B],[C]�� ���۵Ǵ� ����� �����ȣ,����̸�,����,�޿� �˻�
SELECT EMPNO,ENAME,JOB,SAL FROM EMP WHERE ENAME<'D';

--EMP ���̺��� [1981�� 5�� 1��]������ �Ի��� ����� �����ȣ,����̸�,����,�޿�,�Ի��� �˻�
SELECT EMPNO,ENAME,JOB,SAL,HIREDATE FROM EMP WHERE HIREDATE<'81/05/01';

--EMP ���̺��� ������ [SALESMAN]�� ��� �� �޿��� [1500]�̻��� ����� �����ȣ,����̸�,����,�޿� �˻�
SELECT EMPNO,ENAME,JOB,SAL FROM EMP WHERE JOB='SALESMAN' AND SAL>=1500;

--EMP ���̺��� �μ���ȣ�� [10]�̰ų� ������ [MANAGER]�� ����� �����ȣ,����̸�,����,�޿�,�μ���ȣ �˻�
SELECT EMPNO,ENAME,JOB,SAL,DEPTNO FROM EMP WHERE DEPTNO=10 OR JOB='MANAGER';

--EMP ���̺��� �޿��� [1000~3000]�� ����� �����ȣ,����̸�,����,�޿� �˻�
SELECT EMPNO,ENAME,JOB,SAL FROM EMP WHERE SAL>=1000 AND SAL<=3000;

--���� �����ڸ� �̿��Ͽ� �÷����� ���������� ū�� ������ ���Ե� ����� ���ǽ� ǥ��
--����)�÷��� BETWEEN ������ AND ū��
SELECT EMPNO,ENAME,JOB,SAL FROM EMP WHERE SAL BETWEEN 1000 AND 3000;

--EMP ���̺��� ������ [ANALYST]�̰ų� [SALESMAN]�� ����� �����ȣ,����̸�,����,�޿� �˻�
SELECT EMPNO,ENAME,JOB,SAL FROM EMP WHERE JOB='ANALYST' OR JOB='SALESMAN';

--���� �����ڸ� �̿��Ͽ� �÷����� ������ ���� �� �ϳ��� ����� ���ǽ� ǥ��
--����)�÷��� IN (��1,��2,...)
SELECT EMPNO,ENAME,JOB,SAL FROM EMP WHERE JOB IN('ANALYST','SALESMAN');

--EMP ���̺��� ����̸��� [ALLEN]�� ����� �����ȣ,����̸�,����,�޿� �˻�
SELECT EMPNO,ENAME,JOB,SAL FROM EMP WHERE ENAME='ALLEN';

--EMP ���̺��� ����̸��� [A]�� ���۵Ǵ� ����� �����ȣ,����̸�,����,�޿� �˻�
SELECT EMPNO,ENAME,JOB,SAL FROM EMP WHERE ENAME>='A' AND ENAME<'B';
SELECT EMPNO,ENAME,JOB,SAL FROM EMP WHERE ENAME BETWEEN 'A' AND 'B' AND ENAME<>'B';

--�˻����Ϲ��� : ����Ȯ�� ���� �˻��ϱ� ���� ����ϴ� ���� - [%] : ��ü, [_] : ���� ���� �ϳ�
--���� = �����ڷ� ���� ��� [%] �Ǵ� [_]�� �Ϲݹ��ڷ� �ν��Ͽ� ��
SELECT EMPNO,ENAME,JOB,SAL FROM EMP WHERE ENAME='A%';

--���� �����ڸ� �̿��Ͽ� [%] �Ǵ� [_]�� �˻����Ϲ��ڷ� ó���Ͽ� ���ǽ� ǥ��
--����)�÷��� LIKE '�� �Ǵ� �˻����Ϲ���'
SELECT EMPNO,ENAME,JOB,SAL FROM EMP WHERE ENAME LIKE 'A%';

--�˻����Ϲ��ڰ� ��� [=] ������ ��� [LIKE] �����ڸ� ����Ͽ� �� �� ����
SELECT EMPNO,ENAME,JOB,SAL FROM EMP WHERE ENAME='ALLEN';
SELECT EMPNO,ENAME,JOB,SAL FROM EMP WHERE ENAME LIKE 'ALLEN';

--EMP ���̺��� ����̸��� [A]�� ���ԵǴ� ����� �����ȣ,����̸�,����,�޿� �˻�
SELECT EMPNO,ENAME,JOB,SAL FROM EMP WHERE ENAME LIKE '%A%';

--EMP ���̺��� ����̸��� �ι�° ���ڰ� [L]�� ����� �����ȣ,����̸�,����,�޿� �˻�
SELECT EMPNO,ENAME,JOB,SAL FROM EMP WHERE ENAME LIKE '_L%';

--EMP ���̺� ���ο� ��������� �����Ͽ� ����
INSERT INTO EMP VALUES(9000,'M_BEER','CLERK',7788,'81/12/12',1300,NULL,10);
COMMIT;
SELECT * FROM EMP WHERE EMPNO=9000;

--EMP ���̺��� ����̸��� [_]�� ���ԵǴ� ����� �����ȣ,����̸�,����,�޿� �˻�
--LIKE �����ڴ� [%] �Ǵ� [_]�� ���� �ƴ� �˻����Ϲ��ڷ� ó���Ͽ� �˻��ϹǷ� ��� ������� �˻� - �˻�����
SELECT EMPNO,ENAME,JOB,SAL FROM EMP WHERE ENAME LIKE '%_%';

--ESCAPE Ű���带 �̿��Ͽ� ǥ�� �Ұ����� ���ڸ� ESCAPE ���ڷ� ǥ��
SELECT EMPNO,ENAME,JOB,SAL FROM EMP WHERE ENAME LIKE '%\_%' ESCAPE '\';

--EMP ���̺� �����ȣ�� 9000�� ������� ����
DELETE FROM EMP WHERE EMPNO=9000;
COMMIT;
SELECT * FROM EMP WHERE EMPNO=9000;

--EMP ���̺��� ������ [MANAGER]�� �ƴ� ����� �����ȣ,����̸�,����,�޿� �˻�
SELECT EMPNO,ENAME,JOB,SAL FROM EMP WHERE JOB<>'MANAGER';

--NOT �����ڸ� �̿��Ͽ� ���ǽ��� ����� �ݴ�� ǥ��
--����)NOT(���ǽ�)
SELECT EMPNO,ENAME,JOB,SAL FROM EMP WHERE NOT(JOB='MANAGER');

--EMP ���̺��� ��� ����� �����ȣ,����̸�,����,�޿�,������ �˻�
SELECT EMPNO,ENAME,JOB,SAL,COMM FROM EMP;

--EMP ���̺��� �������� �������� �ʴ� ����� �����ȣ,����̸�,����,�޿�,������ �˻�
--NULL : �������� �ʴ� ���� ǥ���ϱ� ���� Ű����
--NULL�� �����ϴ� ���� �ƴϹǷ� ���� �Ұ��� - �˻� ����
SELECT EMPNO,ENAME,JOB,SAL,COMM FROM EMP WHERE COMM=NULL;

--IS �����ڸ� �̿��Ͽ� [NULL] ��
����)�÷��� IS NULL �Ǵ� �÷��� IS NOT NULL
SELECT EMPNO,ENAME,JOB,SAL,COMM FROM EMP WHERE COMM IS NULL;

--EMP ���̺��� �������� �����ϴ� ����� �����ȣ,����̸�,����,�޿�,������ �˻�
SELECT EMPNO,ENAME,JOB,SAL,COMM FROM EMP WHERE COMM IS NOT NULL;

--ORDER BY : �÷����� ���Ͽ� ���� ���ĵǵ��� �˻��ϴ� ����� ����
--����)SELECT �˻����,�˻����,... FROM ���̺��,���̺��,... [WHERE ���ǽ�] 
--    ORDER BY {�÷���|�����|��Ī|INDEX} {ASC|DESC},{�÷���|�����|��Ī|INDEX} {ASC|DESC},...
--ASC : �������� ����, DESC : �������� ����
--���� ������ ������ �����Ͽ� �����ϸ� ���� �˻����� ���� ��� ���� �˻����� ���Ͽ� ����

--EMP ���̺��� ��� ����� �����ȣ,����̸�,����,�޿�,�μ���ȣ �˻�
--�⺻������ ���̺� ���� ���ԵǾ� ����� ������� �˻�
SELECT EMPNO,ENAME,JOB,SAL,DEPTNO FROM EMP;

--EMP ���̺��� ��� ����� �����ȣ,����̸�,����,�޿�,�μ���ȣ�� �μ���ȣ�� �������� �����Ͽ� �˻�
SELECT EMPNO,ENAME,JOB,SAL,DEPTNO FROM EMP ORDER BY DEPTNO ASC;
--�������� ������ ��� [ASC] Ű���� ���� ����
SELECT EMPNO,ENAME,JOB,SAL,DEPTNO FROM EMP ORDER BY DEPTNO;

--EMP ���̺��� ��� ����� �����ȣ,����̸�,����,�޿�,�μ���ȣ�� �޿��� �������� �����Ͽ� �˻�
SELECT EMPNO,ENAME,JOB,SAL,DEPTNO FROM EMP ORDER BY SAL DESC;

--EMP ���̺��� ��� ����� �����ȣ,����̸�,����,�޿�,�μ���ȣ�� ����̸����� �������� �����Ͽ� �˻�
SELECT EMPNO,ENAME,JOB,SAL,DEPTNO FROM EMP ORDER BY ENAME;

--EMP ���̺��� ��� ����� �����ȣ,����̸�,����,�޿�,�Ի���,�μ���ȣ�� �Ի��Ϸ� �������� �����Ͽ� �˻�
SELECT EMPNO,ENAME,JOB,SAL,HIREDATE,DEPTNO FROM EMP ORDER BY HIREDATE DESC;

--EMP ���̺��� ��� ����� �����ȣ,����̸�,����(�޿�*12)�� �������� �������� �����Ͽ� �˻�
SELECT EMPNO,ENAME,SAL*12 ANNUAL FROM EMP ORDER BY SAL*12 DESC;
SELECT EMPNO,ENAME,SAL*12 ANNUAL FROM EMP ORDER BY ANNUAL DESC;
--SELECT ����� �˻���󿡴� �ڵ����� ÷��(COLUMN INDEX)�� �ο�
--����Ŭ�� ÷��(INDEX)�� 1���� 1�� �����Ǵ� ���ڰ����� ǥ��
SELECT EMPNO,ENAME,SAL*12 ANNUAL FROM EMP ORDER BY 3 DESC;

--EMP ���̺��� ��� ����� �����ȣ,����̸�,����,�޿�,�μ���ȣ�� �μ���ȣ�� �������� �����ϰ� ���� ��� �޿��� �������� �����Ͽ� �˻�
SELECT EMPNO,ENAME,JOB,SAL,DEPTNO FROM EMP ORDER BY DEPTNO, SAL DESC;

--EMP ���̺��� �޿��� [3000]�̻��� ����� �����ȣ,����̸�,����,�޿�,�μ���ȣ�� �μ���ȣ�� �������� �����Ͽ� �˻�
SELECT EMPNO,ENAME,JOB,SAL,DEPTNO FROM EMP WHERE SAL>=3000 ORDER BY DEPTNO;

--�˻���� : EMP ���̺� ��� �÷��� �˻�
--����1.����̸��� SCOTT�� ��� �˻�
SELECT * FROM EMP WHERE ENAME='SCOTT';
SELECT * FROM EMP WHERE ENAME LIKE 'SCOTT';
--USER : ���� ���� ������� �̸��� ǥ���ϴ� Ű����
SELECT * FROM EMP WHERE ENAME=USER;

--����2.�޿��� 1500������ ��� �˻�
SELECT * FROM EMP WHERE SAL<=1500;

--����3.1981�⵵�� �Ի��� ��� �˻�
SELECT * FROM EMP WHERE HIREDATE>='81/01/01' AND HIREDATE<='81/12/31';
SELECT * FROM EMP WHERE HIREDATE>='1981-01-01' AND HIREDATE<='1981-12-31';
SELECT * FROM EMP WHERE HIREDATE BETWEEN '81/01/01' AND '81/12/31';
SELECT * FROM EMP WHERE HIREDATE LIKE '81%';
SELECT * FROM EMP WHERE HIREDATE LIKE '81/__/__';

--����4.������ SALESMAN�̰ų� MANAGER�� ��� �� �޿��� 1500�̻��� ��� �˻�
SELECT * FROM EMP WHERE (JOB='SALESMAN' OR JOB='MANAGER') AND SAL>=1500;
SELECT * FROM EMP WHERE JOB IN('SALESMAN','MANAGER') AND SAL>=1500;

--����5.�μ���ȣ�� 10�� ��� �� �޿��� 1000~3000 ������ ��� �˻�
SELECT * FROM EMP WHERE DEPTNO=10 AND SAL>=1000 AND SAL<=3000;
SELECT * FROM EMP WHERE DEPTNO=10 AND SAL BETWEEN 1000 AND 3000;

--����6.�μ���ȣ�� 30�� ��� �� �������� NULL�� �ƴ� ��� �˻�
SELECT * FROM EMP WHERE DEPTNO=30 AND COMM IS NOT NULL;

--����7.��� ����� ������ �������� �����ϰ� ���� ������ ����� �޿��� �������� �����Ͽ� �˻�
SELECT * FROM EMP ORDER BY JOB,SAL DESC;

--����8.������ SALESMAN�� ����� �޿��� �������� �����Ͽ� �˻�
SELECT * FROM EMP WHERE JOB='SALESMAN' ORDER BY SAL DESC;