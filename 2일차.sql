--�Լ�(FUNCTION) : ���� ���޹޾� ó���Ͽ� ������� ��ȯ�ϴ� ����� ����
--�����Լ� : �ϳ��� ���� ���޹޾� ó���Ͽ� ������� ��ȯ�ϴ� �Լ�
-- >> �����Լ�,�����Լ�,��¥�Լ�,��ȯ�Լ�,�Ϲ��Լ�
--�׷��Լ� : ���� ���� ���� ���޹޾� ó���Ͽ� ������� ��ȯ�ϴ� �Լ�

--�����Լ� : ���ڰ��� �����Ͽ� ó���Ͽ� ������� ��ȯ�ϴ� �Լ�

--UPPER(���ڰ�) : ���ڰ��� ���޹޾� �빮�ڷ� ��ȯ�Ͽ� ��ȯ�ϴ� �Լ�
--LOWER(���ڰ�) : ���ڰ��� ���޹޾� �ҹ��ڷ� ��ȯ�Ͽ� ��ȯ�ϴ� �Լ�
SELECT ENAME,UPPER(ENAME),LOWER(ENAME) FROM EMP;

--EMP ���̺��� ����̸��� [SMITH]�� ����� �����ȣ,����̸�,�޿� �˻�
SELECT EMPNO,ENAME,SAL FROM EMP WHERE ENAME='SMITH';
--SQL ����� ��ҹ��ڸ� �������� ������ ���ڰ��� ��ҹ��ڸ� �����Ͽ� ��
select empno,ename,sal from emp where ename='smith';--�˻�����
--UPPER �Լ� �Ǵ� LOWER �Լ��� �̿��Ͽ� ��ҹ��� ���о��� �� ����
SELECT EMPNO,ENAME,SAL FROM EMP WHERE UPPER(ENAME)=UPPER('SMITH');
SELECT EMPNO,ENAME,SAL FROM EMP WHERE UPPER(ENAME)=UPPER('smith');

--INITCAP(���ڰ�) : ���ڰ��� ���޹޾� ù���ڸ� �빮�ڷ� ��ȯ�ϰ� �������� �ҹ��ڷ� ��ȯ�Ͽ� ��ȯ�ϴ� �Լ�
SELECT ENAME,INITCAP(ENAME) FROM EMP;

--CONCAT(���ڰ�,���ڰ�) : �� ���� ���ڰ��� ���޹޾� �����Ͽ� ��ȯ�ϴ� �Լ� - || ��ȣ�� ������ ��� ����
SELECT ENAME,JOB,CONCAT(ENAME,JOB),ENAME||JOB FROM EMP;

--SUBSTR(���ڰ�,������ġ,����) : ���ڰ��� ���޹޾� ������ġ(INDEX)���� ������ŭ�� ������ �и��Ͽ� ��ȯ�ϴ� �Լ�
SELECT EMPNO,ENAME,JOB,SUBSTR(JOB,6,3) FROM EMP WHERE EMPNO=7499;

--LENGTH(���ڰ�) : ���ڰ��� ���޹޾� ������ ������ ��ȯ�ϴ� �Լ�
SELECT EMPNO,ENAME,LENGTH(ENAME) FROM EMP WHERE EMPNO=7499;

--INSTR(���ڰ�,�˻����ڰ�,������ġ,����) : ���ڰ��� ���޹޾� �˻����ڰ��� ������ġ���� �˻��Ͽ� 
--���ϴ� ������ ������ġ�� ��ȯ�ϴ� �Լ� >> �˻����ڰ� ���� ��� 0 ��ȯ
SELECT EMPNO,ENAME,JOB,INSTR(JOB ,'A',1,2) FROM EMP WHERE EMPNO=7499;
SELECT EMPNO,ENAME,JOB,INSTR(JOB,'X',1,1) FROM EMP WHERE EMPNO=7499;

--LPAD(���ڰ�,�ڸ���,ä�﹮��) : ���ڰ��� ���޹޾� �ڸ�����ŭ�� ���̷� ������ �����Ͽ� �˻��ϰ� 
--���� ���� �ڸ������� ä�﹮�ڷ� ä�� ��ȯ�ϴ� �Լ�
--RPAD(���ڰ�,�ڸ���,ä�﹮��) : ���ڰ��� ���޹޾� �ڸ�����ŭ�� ���̷� ���� �����Ͽ� �˻��ϰ� 
--������ ���� �ڸ������� ä�﹮�ڷ� ä�� ��ȯ�ϴ� �Լ�
SELECT EMPNO,ENAME,SAL,LPAD(SAL,8,'*'),RPAD(SAL,8,'*') FROM EMP WHERE EMPNO=7844;

--TRIM({LEADING|TRAILING} ���Ź��� FROM ���ڰ�) : ���ڰ��� ���޹޾� ��(LEADING) �Ǵ� ��(TRAILING)�� �����ϴ�
--���Ź��ڸ� ��� �����Ͽ� ��ȯ�ϴ� �Լ�
SELECT EMPNO,ENAME,JOB,TRIM(LEADING 'S' FROM JOB),TRIM(TRAILING 'N' FROM JOB) FROM EMP WHERE EMPNO=7844;

--REPLACE(���ڰ�,�˻�����,��ȯ����) : ���ڰ��� ���޹޾� �˻����ڸ� ã�� ��ȯ���ڷ� ��ȯ�Ͽ� ��ȯ�ϴ� �Լ�
SELECT EMPNO,ENAME,JOB,REPLACE(JOB,'MAN','PERSON') FROM EMP WHERE EMPNO=7844;

--�����Լ� : ���ڰ��� ���޹޾� ó���Ͽ� ������� ��ȯ�ϴ� �Լ�

--ROUND(���ڰ�,�Ҽ����ڸ���) : ���ڰ��� ���޹޾� �Ҽ��� �ڸ�����ŭ �˻��ǵ��� �ݿø� ó���Ͽ� ��ȯ�ϴ� �Լ�
--DUAL : �˻� ���̺� ���� SELECT ����� �ۼ��� ��� ���Ǵ� ������ ���̺�
SELECT ROUND(45.582,2),ROUND(45.582,0),ROUND(45.582,-1) FROM DUAL;

--TRUNC(���ڰ�,�Ҽ����ڸ���) : ���ڰ��� ���޹޾� �Ҽ��� �ڸ�����ŭ �˻��ǵ��� ���� ó���Ͽ� ��ȯ�ϴ� �Լ�
SELECT TRUNC(45.582,2),TRUNC(45.582,0),TRUNC(45.582,-1) FROM DUAL;

--CEIL(���ڰ�) : ���ڰ��� ���޹޾� �Ҽ��� ���� ���� ������ ��� ������ ���ڰ�(����)���� ��ȯ�ϴ� �Լ�
SELECT CEIL(15.3),CEIL(-15.3) FROM DUAL;

--FLOOR(���ڰ�) : ���ڰ��� ���޹޾� �Ҽ��� ���� ���� ������ ��� ���ҵ� ���ڰ�(����)���� ��ȯ�ϴ� �Լ�
SELECT FLOOR(15.3),FLOOR(-15.3) FROM DUAL;

--MOD(���ڰ�1,���ڰ�2) : ���ڰ�1�� ���ڰ�2�� ������ ������ ���� ��ȯ�ϴ� �Լ�
SELECT 20/8,MOD(20,8) FROM DUAL;

--POWER(���ڰ�1,���ڰ�2) : ���ڰ�1�� ���� ���ڰ�2�� �������� ����Ͽ� ��ȯ�ϴ� �Լ�
SELECT 3*3*3*3*3,POWER(3,5) FROM DUAL;

--��¥�Լ� : ��¥���� ���޹޾� ó���Ͽ� ������� ��ȯ�ϴ� �Լ�

--SYSDATE : �ý����� ���� ��¥�� �ð������� �����ϴ� Ű����
--��¥���� ǥ�������� [RR/MM/DD] �������� ǥ�������� ���������δ� ��¥�� �ð������� ǥ��
SELECT SYSDATE FROM DUAL;

--ADD_MONTHS(��¥��,���ڰ�) : ��¥���� ���޹޾� ���ڰ���ŭ�� �������� ���� ��¥���� ��ȯ�ϴ� �Լ�
SELECT SYSDATE,ADD_MONTHS(SYSDATE,5) FROM DUAL;

--NEXT_DAY(��¥��,����) : ��¥���� ���޹޾� �ٰ����� Ư�� ������ ��¥���� ��ȯ�ϴ� �Լ�
SELECT SYSDATE,NEXT_DAY(SYSDATE,'��') FROM DUAL;

--����Ŭ�� ���ӵ� ����� ȯ��(����:SESSION)�� ���� ��¥�� �ð������� �ٸ��� ǥ��
--������ ��¥ ǥ�� ��� ����
ALTER SESSION SET NLS_LANGUAGE='AMERICAN';
SELECT SYSDATE,NEXT_DAY(SYSDATE,'SAT') FROM DUAL;

ALTER SESSION SET NLS_LANGUAGE='KOREAN';
SELECT SYSDATE,NEXT_DAY(SYSDATE,'��') FROM DUAL;

--TRUNC(��¥��,ǥ������) : ��¥���� ���޹޾� ���ϴ� ���������� ǥ���ϰ� �������� ���ʰ����� ��ȯ�Ͽ� ��ȯ�ϴ� �Լ�
SELECT SYSDATE,TRUNC(SYSDATE,'MONTH'),TRUNC(SYSDATE,'YEAR') FROM DUAL;

--��¥���� ���� ����
--��¥�� + ���ڰ� = ��¥�� >> �� ����
SELECT SYSDATE,SYSDATE+7 FROM DUAL;

--��¥�� + ���ڰ�/24 = ��¥�� >> �ð� ����
SELECT SYSDATE,SYSDATE+100/24 FROM DUAL;

--��¥�� - ���ڰ� = ��¥�� >> �� ����
SELECT SYSDATE,SYSDATE-7 FROM DUAL;

--��¥�� - ���ڰ�/24 = ��¥�� >> �ð� ����
SELECT SYSDATE,SYSDATE-100/24 FROM DUAL;

--��¥�� - ��¥�� = ���ڰ� >> ��(�Ǽ�)
SELECT EMPNO,ENAME,HIREDATE,SYSDATE-HIREDATE FROM EMP WHERE EMPNO=7499;
SELECT EMPNO,ENAME,HIREDATE,CEIL(SYSDATE-HIREDATE)||'��' "�ټ�����" FROM EMP WHERE EMPNO=7499;

--��ȯ�Լ� : ���ް��� ���ϴ� �ڷ����� ������ ��ȯ�Ͽ� ��ȯ�ϴ� �Լ�

--TO_NUMBER(���ڰ�) : ���ڰ��� ���޹޾� ���ڰ����� ��ȯ�Ͽ� ��ȯ�ϴ� �Լ�
-- >> ���ڰ��� ���� ������ ���ڷ� ������ ��찡 �ƴ� ��� ���� �߻�
SELECT EMPNO,ENAME,SAL FROM EMP WHERE EMPNO=7839;
--�� �÷��� �ڷ����� �������� ��� �񱳰��� ���ڰ��̸� ���ڰ����� ��ȯ�Ͽ� �� - ���� ����ȯ
SELECT EMPNO,ENAME,SAL FROM EMP WHERE EMPNO=TO_NUMBER('7839');
--�� �÷��� �ڷ����� �������� ��� �񱳰��� ���ڰ��̸� �ڵ����� ���ڰ��� ��ȯ�Ͽ� �� - �ڵ� ����ȯ
SELECT EMPNO,ENAME,SAL FROM EMP WHERE EMPNO='7839';

--���ڰ��� ������ ��� �ڵ����� ���ڰ����� ��ȯ�Ǿ� ���� ó�� - �ڵ� ����ȯ
SELECT 100+200 FROM DUAL;
SELECT '100'+'200' FROM DUAL;

--EMP ���̺��� �����ȣ�� [7839]�� ����� �����ȣ,����̸�,�޿�,���ı޿�(�޿�*0.9) �˻�
SELECT EMPNO,ENAME,SAL,SAL*0.9 FROM EMP WHERE EMPNO=7839;
SELECT EMPNO,ENAME,SAL,SAL*TO_NUMBER('0.9') FROM EMP WHERE EMPNO=7839;
SELECT EMPNO,ENAME,SAL,SAL*'0.9' FROM EMP WHERE EMPNO=7839;

--TO_DATE(���ڰ�) : ���ڰ��� ���޹޾� ��¥������ ��ȯ�Ͽ� ��ȯ�ϴ� �Լ�
-- >> ���ڰ��� ���Ͽ� �´� ��¥ ������ �ƴ� ��� ���� �߻� - �⺻ ��¥ ���� : RR/MM/DD
--�� �÷��� �ڷ����� ��¥���� ��� �񱳰��� ���ڰ��̸� ��¥������ ��ȯ�Ͽ� �� - ���� ����ȯ
SELECT EMPNO,ENAME,HIREDATE FROM EMP WHERE HIREDATE=TO_DATE('82/01/23');
--�� �÷��� �ڷ����� ��¥���� ��� �񱳰��� ���ڰ��̸� �ڵ����� ��¥������ ��ȯ�Ͽ� �� - �ڵ� ����ȯ
SELECT EMPNO,ENAME,HIREDATE FROM EMP WHERE HIREDATE='82/01/23';

--��¥���� [RR/MM/DD] ���� ��� [YYYY-MM-DD] �������� ǥ�� ����
SELECT EMPNO,ENAME,HIREDATE FROM EMP WHERE HIREDATE='1982-01-23';
--��¥ ���Ͽ� ���� ���� ���ڰ��� ����� ��� ���� �߻�
SELECT EMPNO,ENAME,HIREDATE FROM EMP WHERE HIREDATE='01-23-1982';--���� �߻�
--TO_DATE �Լ��� ���Ϲ��ڸ� �̿��Ͽ� ���ϴ� ���� �������� ���ڰ� ��ȯ ���� - TO_DATE(���ڰ�,���Ϲ���)
SELECT EMPNO,ENAME,HIREDATE FROM EMP WHERE HIREDATE=TO_DATE('01-23-1982','MM-DD-YYYY');

--EMP ���̺��� �����ȣ�� [7844]�� ����� �����ȣ,����̸�,�Ի���,�Ի��Ϸκ��� 2000�� 1�� 1�ϱ��� �ٹ��� ���ڸ� ����Ͽ� �˻�
SELECT EMPNO,ENAME,HIREDATE,'2000-01-01'-HIREDATE FROM EMP WHERE EMPNO=7844;--���� �߻� : ���ڰ��� ��¥�� ���� �Ұ���
--TO_DATE �Լ��� ����Ͽ� ���ڰ��� ��¥������ ��ȯ�ϸ� ���� ����
SELECT EMPNO,ENAME,HIREDATE,TO_DATE('2000-01-01')-HIREDATE FROM EMP WHERE EMPNO=7844;

--TO_CHAR({���ڰ�|��¥��},���Ϲ���) : ���ڰ� �Ǵ� ��¥���� ���޹޾� ���ϴ� ������ ���ڰ����� ��ȯ�Ͽ� ��ȯ�ϴ� �Լ�

--��¥���Ϲ��� : YYYY(��),RR(��),MM(��),DD(��),HH24(�ð�),HH12(�ð�),AM(����),PM(����),MI(��),SS(��)
SELECT SYSDATE FROM DUAL;
SELECT TO_CHAR(SYSDATE,'YYYY-MM-DD') FROM DUAL;
SELECT TO_CHAR(SYSDATE,'YYYY-MM-DD HH24:MI:SS') FROM DUAL;

--EMP ���̺��� 1981�⵵�� �Ի��� ����� �����ȣ,����̸�,�Ի��� �˻�
--������ ��¥����(NLS_DATE_FORMAT)�� [RR/MM/DD]�� ��쿡�� �˻� ����
SELECT EMPNO,ENAME,HIREDATE FROM EMP WHERE HIREDATE LIKE '81%';
--TO_CHAR �Լ��� �̿��Ͽ� ��¥���� ���ϴ� ������ ���ڰ����� ��ȯ�Ͽ� ��
SELECT EMPNO,ENAME,HIREDATE FROM EMP WHERE TO_CHAR(HIREDATE,'YYYY')='1981';

--�������Ϲ��� : 9(���� �Ǵ� ����),0(����),L(ȭ���ȣ),$(�޷�) - ���Ϲ��ڰ� ���ڶ� ��� #���� ǥ��
SELECT 100000000,TO_CHAR(100000000,'9,999,999,990') FROM DUAL;
SELECT 1000000000,TO_CHAR(1000000000,'9,999,999,990') FROM DUAL;
SELECT 10000000000,TO_CHAR(10000000000,'9,999,999,990') FROM DUAL;

--EMP ���̺��� �����ȣ�� [7844]�� ����� �����ȣ,����̸�,�޿� �˻�
SELECT EMPNO,ENAME,SAL FROM EMP WHERE EMPNO=7844;
SELECT EMPNO,ENAME,TO_CHAR(SAL,'999,990') SAL FROM EMP WHERE EMPNO=7844;
SELECT EMPNO,ENAME,TO_CHAR(SAL,'L99,990') SAL FROM EMP WHERE EMPNO=7844;
SELECT EMPNO,ENAME,TO_CHAR(SAL,'$99,990.00') SAL FROM EMP WHERE EMPNO=7844;

--�Ϲ��Լ� : ���ް��� Ư�� ������ ��쿡�� ó���Ǿ� ������� ��ȯ�ϴ� �Լ�

--NVL(�÷���,���氪) : �÷����� NULL�� ��� ���氪���� ��ȯ�Ͽ� ��ȯ�ϴ� �Լ�
--���氪�� �÷��� �ڷ����� ������ �ڷ����� ������ �������� ������ ���� �߻�

--EMP ���̺��� ��� ����� �����ȣ,����̸�,����(�޿�*12) �˻�
SELECT EMPNO,ENAME,SAL*12 ANNUAL FROM EMP;

--EMP ���̺��� ��� ����� �����ȣ,����̸�,����((�޿�+������)*12) �˻�
--�������� NULL�� ��� ��� ������ �Ұ����ϹǷ� NULL �˻� 
SELECT EMPNO,ENAME,(SAL+COMM)*12 ANNUAL FROM EMP;-- �˻� ����
--NVL �Լ��� ����Ͽ� �������� NULL�� ��� 0���� ��ȯ�Ͽ� ���� ó��
SELECT EMPNO,ENAME,(SAL+NVL(COMM,0))*12 ANNUAL FROM EMP;

--NVL2(�÷���,���氪1,���氪2) : �÷����� NULL�� �ƴ� ��� ���氪1�� ��ȯ�ϰ� NULL�� ��� ���氪2���� ��ȯ�Ͽ� ��ȯ�ϴ� �Լ�
SELECT EMPNO,ENAME,(SAL+NVL2(COMM,COMM,0))*12 ANNUAL FROM EMP;
SELECT EMPNO,ENAME,NVL2(COMM,SAL+COMM,SAL)*12 ANNUAL FROM EMP;

--DECODE(�÷���,�񱳰�1,���氪1,�񱳰�2,���氪2,...[,�⺻���氪]) : �÷����� �񱳰��� ���ʴ�� ���Ͽ� ���� ��� 
--���氪���� ��ȯ�Ͽ� ��ȯ�ϴ� �Լ�
-- >> �÷����� ��� �񱳰��� �ٸ� ��� �⺻ ���氪���� ��ȯ�Ͽ� ��ȯ - �⺻ ���氪�� ������ ��� NULL ��ȯ

--EMP ���̺��� ��� ����� �����ȣ,����̸�,����,�޿�,������ �Ǳ޿� �˻�
--������ �Ǳ޿� : �������� �޿��� ����Ͽ� ������ ���ҵ� �޿�
SELECT DISTINCT JOB FROM EMP;
--ANALYST : �޿�*1.1, CLERK : �޿�*1.2, MANAGER : �޿�*1.3, PRESIDENT : �޿�*1.4, SALESMAN : �޿�*1.5
SELECT EMPNO,ENAME,JOB,SAL,DECODE(JOB,'ANALYST',SAL*1.1,'CLERK',SAL*1.2,'MANAGER',SAL*1.3
    ,'PRESIDENT',SAL*1.4,'SALESMAN',SAL*1.5,SAL) "������ �Ǳ޿�" FROM EMP;
    
--EMP ���̺��� ��� ����� �����ȣ,����̸�,����,�޿� �˻�
SELECT EMPNO,ENAME,JOB,SAL FROM EMP;

--EMP ���̺��� ��� ����� �����ȣ,����̸�,������ �޿��� �����Ͽ� �˻��ϸ� �ش� ������ �ƴ� ��� NULL �˻�
SELECT EMPNO,ENAME,DECODE(JOB,'ANALYST',SAL) "ANALYST",DECODE(JOB,'CLERK',SAL) "CLERK"
    ,DECODE(JOB,'MANAGER',SAL) "MANAGER",DECODE(JOB,'PRESIDENT',SAL) "PRESIDENT",DECODE(JOB,'SALESMAN',SAL) "SALESMAN" FROM EMP;
    
--�׷��Լ� : ���� ���� �� ���޹޾� ó���Ͽ� ������� ��ȯ�ϴ� �Լ�

--COUNT(�÷���) : �÷����� ������ ��ȯ�ϴ� �Լ� - �˻����� ���� ��ȯ
SELECT COUNT(EMPNO) FROM EMP;

--�׷��Լ��� �ٸ� �˻����� ���� ��� �Ұ��� - �˻������ �˻����� ������ ���� �ٸ��Ƿ� ���� �߻�
SELECT EMPNO,COUNT(EMPNO) FROM EMP;--���� �߻�

--�׷��Լ��� NULL�� ������ �ν����� �ʾ� ��ó��
SELECT COUNT(EMPNO),COUNT(COMM) FROM EMP;

--COUNT �Լ��� �÷��� ��� [*]�� ����Ͽ� ��� �÷����� ���̺� ����� ���� ���� ��ȯ
SELECT COUNT(*) FROM EMP;

--MAX(�÷���) : �÷��� �� �ִ밪�� ��ȯ�ϴ� �Լ�
SELECT MAX(SAL) FROM EMP;
SELECT MAX(ENAME) FROM EMP;
SELECT MAX(HIREDATE) FROM EMP;

--MIN(�÷���) : �÷��� �� �ּҰ��� ��ȯ�ϴ� �Լ�
SELECT MIN(SAL) FROM EMP;
SELECT MIN(ENAME) FROM EMP;
SELECT MIN(HIREDATE) FROM EMP;

--SUM(�÷���) : ������ �÷��� ���� ���޹޾� �հ踦 ����Ͽ� ��ȯ�ϴ� �Լ�
SELECT SUM(SAL) FROM EMP;

--AVG(�÷���) : ������ �÷��� ���� ���޹޾� ����� ����Ͽ� ��ȯ�ϴ� �Լ�
SELECT AVG(SAL) FROM EMP;
SELECT ROUND(AVG(SAL),2) FROM EMP;

--EMP ���̺��� ��� ����� ��� �������� ����Ͽ� �˻�
--�������� NULL�� �ƴ� ����鿡 ���� ��� �޿� �˻� - �˻�����
SELECT AVG(COMM) FROM EMP;

--NVL �Լ��� ����Ͽ� �������� NULL�� ��� 0���� ��ȯ�Ͽ� ��� �������� ����Ͽ� �˻�
SELECT CEIL(AVG(NVL(COMM,0))) "��� ������" FROM EMP;

--EMP ���̺� ����� ��� ����� ���� �ο��� �˻�
SELECT COUNT(*) FROM EMP;

--EMP ���̺� ����� �μ��� ��� �ο��� �˻�
SELECT DISTINCT DEPTNO FROM EMP;
SELECT COUNT(*) FROM EMP WHERE DEPTNO=10;
SELECT COUNT(*) FROM EMP WHERE DEPTNO=20;
SELECT COUNT(*) FROM EMP WHERE DEPTNO=30;

--GROUP BY : �׷��Լ��� ����� ��� �÷������� �׷��� �����Ͽ� �˻��ϴ� ���
-- >> �÷����� ���� ��� ���� �׷����� ó��
--����)SELECT �׷��Լ�[,�˻����,...] FROM ���̺��,���̺��,... [WHERE ���ǽ�]
--    GROUP BY {�÷���|�����|�Լ�},... [ORDER BY {�÷���|�����|��Ī|÷��} {ASC|DESC},...]

--EMP ���̺� ����� �μ��� ��� �ο��� �˻�
SELECT COUNT(*) FROM EMP GROUP BY DEPTNO;

--GROUP BY �������� ���� �׷� ǥ������ �׷��Լ��� ���� �˻�������� ��� ����
SELECT DEPTNO,COUNT(*) FROM EMP GROUP BY DEPTNO ORDER BY DEPTNO;
--�˻������ ��Ī�� GROUP BY ������ �׷� ǥ�������� ����� ��� ���� �߻�
SELECT DEPTNO DNO,COUNT(*) FROM EMP GROUP BY DNO;--���� �߻�

--EMP ���̺��� ��� ����� ������ ��� �޿� �˻�
SELECT JOB,CEIL(AVG(SAL)) AVG_SAL FROM EMP GROUP BY JOB;

--EMP ���̺��� ������ [PRESIDENT]�� ����� ������ ��� ����� ������ ��� �޿� �˻�
SELECT JOB,CEIL(AVG(SAL)) AVG_SAL FROM EMP WHERE JOB<>'PRESIDENT' GROUP BY JOB;

--EMP ���̺��� ������ [PRESIDENT]�� ����� ������ ��� ����� ������ ��� �޿��� ��� �޿��� �������� �����Ͽ� �˻�
SELECT JOB,CEIL(AVG(SAL)) AVG_SAL FROM EMP WHERE JOB<>'PRESIDENT' GROUP BY JOB ORDER BY AVG_SAL DESC;

--HAVING : GROUP BY �������� �׷�ȭ�� �˻� ����� �׷������� �����Ͽ� �˻��ϴ� ���
--����)SELECT �׷��Լ�[,�˻����,...] FROM ���̺��,���̺��,... [WHERE ���ǽ�]
--    GROUP BY {�÷���|�����|�Լ�},... HAVING �׷����ǽ� [ORDER BY {�÷���|�����|��Ī|÷��} {ASC|DESC},...]

--EMP ���̺��� ��� ����� �μ��� �޿� �հ� �� �޿� �հ谡 9000�̻��� �μ� �˻�
SELECT DEPTNO,SUM(SAL) FROM EMP GROUP BY DEPTNO HAVING SUM(SAL)>=9000;

--EMP ���̺��� ������ [PRESIDENT]�� ����� ������ ��� ����� ������ ��� �޿� �˻�
SELECT JOB,CEIL(AVG(SAL)) AVG_SAL FROM EMP WHERE JOB<>'PRESIDENT' GROUP BY JOB;
SELECT JOB,CEIL(AVG(SAL)) AVG_SAL FROM EMP GROUP BY JOB HAVING JOB<>'PRESIDENT'; 
