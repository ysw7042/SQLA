--�����Լ� ����
--����1.������̺��� �Ի����� 12���� ����� ���,�����,�Ի��� �˻��Ͻÿ�.
SELECT EMPNO,ENAME,HIREDATE FROM EMP WHERE HIREDATE LIKE '%/12/%';
SELECT EMPNO,ENAME,HIREDATE FROM EMP WHERE HIREDATE LIKE '__/12/__';
SELECT EMPNO,ENAME,HIREDATE FROM EMP WHERE TO_CHAR(HIREDATE,'MM')='12';

--����2.������ ���� ����� �˻��� �� �ִ� SQL ������ �ۼ��Ͻÿ�.
SELECT EMPNO,ENAME,LPAD(SAL,10,'*') "�޿�" FROM EMP;

--����3.������ ���� ����� �˻��� �� �ִ� SQL ������ �ۼ��Ͻÿ�.
SELECT EMPNO,ENAME,TO_CHAR(HIREDATE,'YYYY-MM-DD') "�Ի���" FROM EMP;

--�׷��Լ� ����
--����1.������̺��� �μ��� �ο����� 6�� �̻��� �μ��ڵ� �˻�?
SELECT DEPTNO,COUNT(*) FROM EMP GROUP BY DEPTNO HAVING COUNT(*)>=6; 

--����2.������̺�κ��� �μ���ȣ, ������ �޿��հ踦 ����ϰ��� �Ѵ�. ������ ���� ����� ����Ҽ� �ִ� SQL���� �ۼ�?
SELECT DEPTNO,SUM(DECODE(JOB,'CLERK',SAL)) "CLERK",SUM(DECODE(JOB,'MANAGER',SAL)) "MANAGER"
    ,SUM(DECODE(JOB,'PRESIDENT',SAL)) "PRESIDENT",SUM(DECODE(JOB,'ANALYST',SAL)) "ANALYST"
    ,SUM(DECODE(JOB,'SALESMAN',SAL)) "SALESMAN" FROM EMP GROUP BY DEPTNO ORDER BY DEPTNO;
    
--����3.������̺�κ��� �⵵��, ���� �޿��հ踦 ����� �� �ִ� SQL���� �ۼ�?    
SELECT TO_CHAR(HIREDATE,'YYYY') "��",TO_CHAR(HIREDATE,'MM') "��",SUM(SAL) FROM EMP
    GROUP BY TO_CHAR(HIREDATE,'YYYY'),TO_CHAR(HIREDATE,'MM') ORDER BY "��","��";
    
--����4.������̺��� �μ��� comm(Ŀ�̼�)�� �������� ���� ������ �հ� ������ ������ ���� ���ϴ� SQL�� �ۼ��Ͻÿ�.    
SELECT DEPTNO,SUM(SAL*12) "����" FROM EMP GROUP BY DEPTNO ORDER BY DEPTNO;
SELECT DEPTNO,SUM((SAL+NVL(COMM,0))*12) "����" FROM EMP GROUP BY DEPTNO ORDER BY DEPTNO;

--����5.������̺��� SALESMAN�� ������ JOB�� �޿��հ�?
SELECT JOB,SUM(SAL) FROM EMP WHERE JOB<>'SALESMAN' GROUP BY JOB;
SELECT JOB,SUM(SAL) FROM EMP GROUP BY JOB HAVING JOB<>'SALESMAN';

--�м��Լ� : ������ �Լ�(�׷��Լ�,�����Լ�,�����Լ� ��)�� ���� ��ȯ�� ������� �����޾� ó���Ͽ� ��ȯ�ϴ� �Լ�
--����)SELECT �������Լ� OVER([PARTITION BY �÷���][ORDER BY �÷���][WINDOWING]),�˻����,... FROM ���̺�� [WHERE ���ǽ�]

--EMP ���̺��� ��� ��� �� ���� ���� �޿��� �޴� ����� �����ȣ,����̸�,�޿� �˻�
--�׷��Լ��� ����� ��� �ٸ� �˻������ ���� ����ϸ� ���� �߻�
SELECT EMPNO,ENAME,MAX(SAL) FROM EMP;--����

--SELECT ����� ������ ����Ͽ� ���� ���� �޿��� �޴� ����� �����ȣ,����̸�,�޿� �˻� ����
SELECT MAX(SAL) FROM EMP;--�˻����:5000
SELECT EMPNO,ENAME,SAL FROM EMP WHERE SAL=5000;

--�׷��Լ��� �м��Լ��� ���� ����� ��� �ٸ� �˻���� ��� ����
SELECT EMPNO,ENAME,SAL,MAX(SAL) OVER() FROM EMP;

--EMP ���̺��� ��� ����� �μ��� ��� �޿� �˻�
SELECT DEPTNO,CEIL(AVG(SAL)) "�μ��� ��� �޿�" FROM EMP GROUP BY DEPTNO;

--EMP ���̺��� ��� ����� �����ȣ,����̸�,�޿�,�μ���ȣ,�μ��� ��� �޿� �˻�
--�м��Լ��� ����� ��� GROUP BY ������ ����ϸ� ���� �߻�
SELECT EMPNO,ENAME,SAL,DEPTNO,CEIL(AVG(SAL) OVER()) "�μ��� ��� �޿�" FROM EMP GROUP BY DEPTNO;--����

--GROUP BY ���� ��� �м��Լ������� PARTITION BY ��� ����
SELECT EMPNO,ENAME,SAL,DEPTNO,CEIL(AVG(SAL) OVER(PARTITION BY DEPTNO)) "�μ��� ��� �޿�" FROM EMP;

--EMP ���̺��� ��� ����� �����ȣ,����̸�,�޿�,�޿��հ踦 �޿��� �������� �����Ͽ� �˻�
SELECT EMPNO,ENAME,SAL,SUM(SAL) OVER() "�޿��հ�" FROM EMP ORDER BY SAL DESC;

--EMP ���̺��� ��� ����� �����ȣ,����̸�,�޿�,���������� ������ �޿��հ踦 �޿��� �������� �����Ͽ� �˻�
--�м��Լ��� ORDER BY ����� �̿��ϸ� �����ϸ鼭 ������ �Լ��� ����� �˻��� ���� ������� ó���Ͽ� ��ȯ
--���İ��� ���� ��� ������ �Լ��� ���� ó�� ����� ��ȯ
SELECT EMPNO,ENAME,SAL,SUM(SAL) OVER(ORDER BY SAL DESC) "������ ���� �޿��հ�" FROM EMP;

--���İ��� ���� ��� �ٸ� ���İ��� �����ϸ� ������ �Լ��� ���� ó�� ����� ��ȯ ����
SELECT EMPNO,ENAME,SAL,SUM(SAL) OVER(ORDER BY SAL DESC,EMPNO) "������ ���� �޿��հ�" FROM EMP;

--�м��Լ��� WINDOWS ����� �̿��ϸ� ���İ��� ������ ��췹�� ���� ó�� ����� ��ȯ ����
--ROWS UNBOUNDED PRECEDING : �˻����� �������� ������ �����ϴ� ��� ����� �˻�������� ����
SELECT EMPNO,ENAME,SAL,SUM(SAL) OVER(ORDER BY SAL DESC ROWS UNBOUNDED PRECEDING) "������ ���� �޿��հ�" FROM EMP;