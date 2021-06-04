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

--