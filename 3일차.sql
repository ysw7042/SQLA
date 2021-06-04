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

--EMP ���̺��� ��� ����� �����ȣ,����̸�,�޿�,�˻���� ���� ����� �޿��� �˻���� ���� ����� �޿��� �հ踦 �޿��� �������� �����Ͽ� �˻�
SELECT EMPNO,ENAME,SAL,SUM(SAL) OVER(ORDER BY SAL ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING) "�κ��հ�" FROM EMP;

--EMP ���̺��� ��� ����� �����ȣ,����̸�,�޿�,�˻������ �޿����� 100 �۰ų� 200 ū ����� �μ������� �޿��� �������� �����Ͽ� �˻�
SELECT EMPNO,ENAME,SAL,COUNT(*) OVER(ORDER BY SAL RANGE BETWEEN 100 PRECEDING AND 200 FOLLOWING)-1 "�ο���" FROM EMP;

--�����Լ� : RANK, DENSE_RANK, ROW_NUMBER - �ݵ�� �м��Լ��� ���� ���

--EMP ���̺��� ��� ����� �����ȣ,����̸�,�޿��� �޿��� �������� �����Ͽ� �˻�
SELECT EMPNO,ENAME,SAL FROM EMP ORDER BY SAL DESC;

--EMP ���̺��� ��� ����� �����ȣ,����̸�,�޿�,�޿������� �޿��� �������� �����Ͽ� �˻�
--RANK �Լ� : ���İ��� ���� ��� ���� ������ �˻��Ǹ� ���� ������ �ǳʶٰ� �˻��ϴ� �Լ�
SELECT EMPNO,ENAME,SAL,RANK() OVER(ORDER BY SAL DESC) "�޿�����" FROM EMP;

--DENSE_RANK �Լ� : ���İ��� ���� ��� ���� ������ �˻��Ǹ� ���� ������ �ǳʶ��� �ʰ� �˻��ϴ� �Լ�
SELECT EMPNO,ENAME,SAL,DENSE_RANK() OVER(ORDER BY SAL DESC) "�޿�����" FROM EMP;

--ROW_NUMBER �Լ� : ���İ��� ���� ��쿡�� �ٸ� ������ �˻��ϴ� �Լ�
SELECT EMPNO,ENAME,SAL,ROW_NUMBER() OVER(ORDER BY SAL DESC) "�޿�����" FROM EMP;

--�����Լ� : FIRST_VALUE, LAST_VALUE, LAG, LEAD - �ݵ�� �м��Լ��� ���� ���

--EMP ���̺��� ��� ����� �����ȣ,����̸�,�޿�,�޿��� ���� ���� �޴� ����� ����̸�,�޿��� ���� ���� �޴� ����̸��� 
--�޿��� �������� �����Ͽ� �˻�
--FIRST_VALUE �Լ� : ù��° �˻����� �÷����� ��ȯ�ϴ� �Լ�
--LAST_VALUE �Լ� : ������ �˻����� �÷����� ��ȯ�ϴ� �Լ�
SELECT EMPNO,ENAME,SAL,FIRST_VALUE(ENAME) OVER(ORDER BY SAL DESC),LAST_VALUE(ENAME)
    OVER(ORDER BY SAL DESC ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING) FROM EMP;
    
--EMP ���̺��� ��� ����� �����ȣ,����̸�,�޿�,�˻���� ���� ����� �޿�,�˻���� ���� ����� �޿��� �޿��� �������� �����Ͽ� �˻�
--LAG �Լ� : �˻����� ���� ���� �÷����� ��ȯ�ϴ� �Լ�
--����)LAG(�÷���,��������ġ,�⺻��) : ���� ��ġ�� ���� �÷����� ��ȯ�ϵ� ���� ��ġ�� ���� ������ �⺻�� ��ȯ
--LEAD �Լ� : �˻����� ���� ���� �÷����� ��ȯ�ϴ� �Լ�
--����)LAED(�÷���,��������ġ,�⺻��) : ���� ��ġ�� ���� �÷����� ��ȯ�ϵ� ���� ��ġ�� ���� ������ �⺻�� ��ȯ
SELECT EMPNO,ENAME,SAL,LAG(SAL,1,0) OVER(ORDER BY SAL DESC),LEAD(SAL,1,0) OVER(ORDER BY SAL DESC) FROM EMP;   

--JOIN : �� ���̻��� ���̺��� ���ϴ� �÷����� �˻��ϱ� ���� ���

--EMP ���̺��� ��� ����� �����ȣ,����̸�,�޿�,�μ���ȣ �˻�
SELECT EMPNO,ENAME,SAL,DEPTNO FROM EMP;

--DEPT ���̺��� ��� �μ��� �μ���ȣ,�μ��̸�,��ġ �˻�
SELECT DEPTNO,DNAME,LOC FROM DEPT;

--EMP ���̺�� DEPT ���̺��� ��� ����� �����ȣ,����̸�,�޿�,�μ��̸�,�μ���ġ �˻�
--�� ���̻��� ���̺��� �÷����� �˻��ϱ� ���ؼ��� �ݵ�� ���������� ����Ͽ� �˻�
--īŸ�þ� ���δ�Ʈ(CATASIAN PRODUCT) : �� ���̻��� ���̺��� ������ �� ���������� ������� ���� ��� �߻� - ��������
SELECT EMPNO,ENAME,SAL,DNAME,LOC FROM EMP,DEPT;

--��������(EQUI JOIN) : �������ǿ� = �����ڸ� ����Ͽ� ����� ���� �ุ �˻�
--���������� WHERE ������ ���ǽ����� ǥ���Ͽ� ���
--EMP ���̺�� DEPT ���̺��� �������� : EMP ���̺��� �μ���ȣ(DEPTNO)�� DEPT ���̺��� �μ���ȣ(DEPTNO)�� ���� �ุ �˻�
--���� ���̺� ������ �̸��� �÷��� ������ ��� ���̺���� ����Ͽ� �÷��� ��Ȯ�� ���� - ���̺��.�÷���
SELECT EMPNO,ENAME,SAL,DNAME,LOC FROM EMP,DEPT WHERE EMP.DEPTNO=DEPT.DEPTNO;

--EMP ���̺�� DEPT ���̺��� ��� ����� �����ȣ,����̸�,�޿�,�μ���ȣ,�μ��̸�,�μ���ġ �˻�
SELECT EMPNO,ENAME,SAL,EMP.DEPTNO,DNAME,LOC FROM EMP,DEPT WHERE EMP.DEPTNO=DEPT.DEPTNO;
SELECT EMPNO,ENAME,SAL,DEPT.DEPTNO,DNAME,LOC FROM EMP,DEPT WHERE EMP.DEPTNO=DEPT.DEPTNO;

--���� ���̺� ������ �̸��� �÷����� ���� �˻��� ��� ù��° �÷��� ������ ������ �÷����� �ڵ����� ����Ǿ� �˻�
SELECT EMPNO,ENAME,SAL,EMP.DEPTNO,DEPT.DEPTNO,DNAME,LOC FROM EMP,DEPT WHERE EMP.DEPTNO=DEPT.DEPTNO;

--���� ���̺� ������ �̸��� �÷����� ���� �˻��� ��� �÷��� ��Ī�� �����Ͽ� �˻�
SELECT EMPNO,ENAME,SAL,EMP.DEPTNO EMP_DEPTNO,DEPT.DEPTNO DEPT_DEPTNO,DNAME,LOC FROM EMP,DEPT WHERE EMP.DEPTNO=DEPT.DEPTNO;

--���̺� ��Ī(TABLE ALIAS) : ���̺� ���ο� �̸��� �Ͻ������� �ο��ϴ� ��� 
--����)SELECT �˻����,... FROM ���̺�� ��Ī,...
-- >> ���̺� ��Ī�� ������ ��� ��Ī ��� ���̺���� ����ϸ� ���� �߻�
--���̺���� �����ϰ� ǥ���ϱ� ���� ����ϰų� ���� ���̺��� ���� ���� ���̺�� ǥ���ϱ� ���� ���
SELECT EMPNO,ENAME,SAL,E.DEPTNO EMP_DEPTNO,D.DEPTNO DEPT_DEPTNO,DNAME,LOC FROM EMP E,DEPT D WHERE E.DEPTNO=D.DEPTNO;

--�񵿵� ����(NON-EQUI JOIN) : �������ǿ� = �����ڸ� ������ �����ڸ� ����Ͽ� ����� ���� �ุ �˻�

--EMP ���̺��� ��� ����� �����ȣ,����̸�,�޿� �˻�
SELECT EMPNO,ENAME,SAL FROM EMP;

--SALGRADE  ���̺��� ��� �޿������ ���,�ּұ޿�,�ִ�޿� �˻�
SELECT GRADE,LOSAL,HISAL FROM SALGRADE;

--EMP ���̺�� SALGRADE ���̺��� ��� ����� �����ȣ,����̸�,�޿�,�޿���� �˻�
--�������� : ����� �޿��� �ּұ޿����� �ִ�޿� ������ ���Ե� ��쿡 �޿���� �˻�
SELECT EMPNO,ENAME,SAL,GRADE FROM EMP,SALGRADE WHERE SAL BETWEEN LOSAL AND HISAL;

--�ܺ�����(OUTER JOIN) : ���������� ���� �ุ �˻��ϴ� ���� �ƴ϶� �������ǿ� ������ �൵ �˻�
--���������� ���̺� (+)�� ����Ͽ� �������ǿ� ������ ���� �÷����� NULL�� �˻��ǵ��� ����

--EMP ���̺��� ��� ����� �μ���ȣ�� �ߺ����� �ʴ� ������ ������ �˻�
SELECT DISTINCT DEPTNO FROM EMP;--�˻���� : 10, 20, 30

--DEPT ���̺��� ��� �μ��� �μ���ȣ �˻�
SELECT DEPTNO FROM DEPT;--�˻���� : 10, 20, 30, 40

--EMP ���̺�� DEPT ���̺��� ��� ����� �����ȣ,����̸�,�޿�,�μ��̸�,�μ���ġ �˻�
--��������(��������) : EMP ���̺��� �μ���ȣ�� DEPT ���̺��� �μ���ȣ�� ���� �ุ ���յǾ� �˻�
--40�� �μ��� �ٹ��ϴ� ����� �����Ƿ� 40�� �μ��� ���� �μ��̸��� �μ���ġ �̰˻�
SELECT EMPNO,ENAME,SAL,DNAME,LOC FROM EMP,DEPT WHERE EMP.DEPTNO=DEPT.DEPTNO;

--EMP ���̺�� DEPT ���̺��� ��� ����� �����ȣ,����̸�,�޿�,�μ��̸�,�μ���ġ �˻�
--��������(�ܺ�����) : EMP ���̺��� �μ���ȣ�� DEPT ���̺��� �μ���ȣ�� ���� ���� ���յǾ� �˻��ϰ� ����� �ٹ����� �ʴ� �μ��� �˻�
--����� ���� �μ��� �˻��ؾ� �Ǵ� ��� EMP ���̺��� �������ǿ� (+)�� �ٿ� EMP ���̺��� �÷��� ��� NULL�� �˻��ǵ��� ����
SELECT EMPNO,ENAME,SAL,DNAME,LOC FROM EMP,DEPT WHERE EMP.DEPTNO(+)=DEPT.DEPTNO;

--��������(SELF JOIN) : �ϳ��� ���̺� �ٸ� ���� ���� ��Ī�� �����Ͽ� �����ϴ� ���

--EMP ���̺��� ��� ����� �����ȣ,����̸�,�Ŵ�����ȣ(�Ŵ����� �����ȣ) �˻�
SELECT EMPNO,ENAME,MGR FROM EMP;

--EMP ���̺��� ��� ����� �����ȣ,����̸�,�Ŵ�����ȣ(�Ŵ����� �����ȣ),�Ŵ��� �̸�(�Ŵ����� ����̸�) �˻�
--�������� : EMP ���̺�(WORKER)�� �Ŵ�����ȣ�� EMP ���̺�(MANAGER)�� �����ȣ�� ���Ͽ� ���� �ุ �����Ͽ� �˻� - ��������
--�Ŵ�����ȣ�� NULL�� ��� �̰˻�
SELECT WORKER.EMPNO,WORKER.ENAME WORKER_ENAME,WORKER.MGR,MANAGER.ENAME MANAGER_ENAME
    FROM EMP WORKER,EMP MANAGER WHERE WORKER.MGR=MANAGER.EMPNO;
    
--�Ŵ�����ȣ�� NULL�� ����� �˻��ϰ��� �� ��� �ܺ����� �̿�
SELECT WORKER.EMPNO,WORKER.ENAME WORKER_ENAME,WORKER.MGR,MANAGER.ENAME MANAGER_ENAME
    FROM EMP WORKER,EMP MANAGER WHERE WORKER.MGR=MANAGER.EMPNO(+);

--EMP ���̺�� DEPT ���̺��� SALES �μ��� �ٹ��ϴ� ����� �����ȣ,����̸�,�޿�,�μ��̸�,�μ���ġ �˻�
SELECT EMPNO,ENAME,SAL,DNAME,LOC FROM EMP,DEPT WHERE EMP.DEPTNO=DEPT.DEPTNO AND DNAME='SALES';

--1999 JOIN : 1999�⿡ ä�õ� ǥ�� SQL(SQL3)�� �߰��� JOIN ����

--CROSS JOIN : ���� ���̺��� ��� ���� ���������ϱ� ���� ���� - ���������� ������� �ʰ� ����
--����)SELECT �˻����,... FROM ���̺��1 CROSS JOIN ���̺��2
SELECT EMPNO,ENAME,SAL,DNAME,LOC FROM EMP CROSS JOIN DEPT;

--NATURAL JOIN : ���� ���̺� ���� �̸��� �÷��� �ϳ��� �ִ� ��� ���� �̸��� �÷����� ���Ͽ� ���� - ���������� ������� �ʰ� ����
--����)SELECT �˻����,... FROM ���̺��1 NATURAL JOIN ���̺��2
--EMP ���̺��� DEPTNO �÷����� DEPT ���̺��� DEPTNO �÷����� ���Ͽ� ����
SELECT EMPNO,ENAME,SAL,DNAME,LOC FROM EMP NATURAL JOIN DEPT;

--NATURAL JOIN������ ���� �̸��� �÷��� ���̺���� ������� �ʾƵ� ��� ����
SELECT EMPNO,ENAME,SAL,DEPTNO,DNAME,LOC FROM EMP NATURAL JOIN DEPT;

--���� ���̺� ���� �̸��� �÷��� ���� �� �ִ� ��� JOIN~USING ������ �̿��Ͽ� ���� �̸��� �÷����� ���Ͽ� ���� - ���������� ������� �ʰ� ����
--����)SELECT �˻����,... FROM ���̺��1 JOIN ���̺��2 USING(�÷���)
--USING �������� ��õ� �÷����� ���̺���� ������� �ʾƵ� ��� ����
SELECT EMPNO,ENAME,SAL,DEPTNO,DNAME,LOC FROM EMP JOIN DEPT USING(DEPTNO);

--INNER JOIN : ���������� ����Ͽ� ���������� �´� �ุ �����Ͽ� �˻��ϴ� ����
--����)SELECT �˻����,... FROM ���̺��1 [INNER] JOIN ���̺��2 ON ��������
--���� ���̺� ���� �̸��� �÷��� ������ ��� ���̺���� �ݵ�� ����Ͽ� �˻�
SELECT EMPNO,ENAME,SAL,DNAME,LOC FROM EMP INNER JOIN DEPT ON EMP.DEPTNO=DEPT.DEPTNO;
SELECT EMPNO,ENAME,SAL,DNAME,LOC FROM EMP JOIN DEPT ON EMP.DEPTNO=DEPT.DEPTNO;

--EMP ���̺�� SALGRADE ���̺��� ��� ����� �����ȣ,����̸�,�޿�,�޿���� �˻�
--�������� : ����� �޿��� �ּұ޿����� �ִ�޿� ������ ���Ե� ��쿡 �޿���� �˻�
SELECT EMPNO,ENAME,SAL,GRADE FROM EMP JOIN SALGRADE ON SAL BETWEEN LOSAL AND HISAL;

--EMP ���̺�� DEPT ���̺��� SALES �μ��� �ٹ��ϴ� ����� �����ȣ,����̸�,�޿�,�μ��̸�,�μ���ġ �˻�
SELECT EMPNO,ENAME,SAL,DNAME,LOC FROM EMP JOIN DEPT ON EMP.DEPTNO=DEPT.DEPTNO WHERE DNAME='SALES';

--OUTER JOIN : ���������� ����Ͽ� ���������� �´� ��� ���������� ���� �ʾ� ������ �൵ �����Ͽ� �˻��ϴ� ����
--����)SELECT �˻����,... FROM ���̺��1 {LEFT|RIGHT|FULL} [OUTER] JOIN ���̺��2 ON ��������
--LEFT OUTER JOIN : ���� ���⿡ ����� ���̺��� ��� ���� �˻��ϵ� �����ʹ����� ����� ���̺��� ���������� ���� ��� �����Ͽ� �˻��ϰ�
--�������ǿ� ���� ���� ���� ��� NULL�� �����Ͽ� �˻�
--RIGHT OUTER JOIN : ������ ���⿡ ����� ���̺��� ��� ���� �˻��ϵ� ���� ������ ����� ���̺��� ���������� ���� ��� �����Ͽ� �˻��ϰ�
--�������ǿ� ���� ���� ���� ��� NULL�� �����Ͽ� �˻�
--FULL OUTER JOIN : ���� ���⿡ ����� ���̺��� ��� ���� �˻��ϵ� ���������� ���� ���� �����Ͽ� �˻��ϰ� ���������� ���� ���� ���� ��� 
--NULL�� �����Ͽ� �˻�
SELECT EMPNO,ENAME,SAL,DNAME,LOC FROM EMP LEFT JOIN DEPT ON EMP.DEPTNO=DEPT.DEPTNO;
SELECT EMPNO,ENAME,SAL,DNAME,LOC FROM EMP RIGHT JOIN DEPT ON EMP.DEPTNO=DEPT.DEPTNO;
SELECT EMPNO,ENAME,SAL,DNAME,LOC FROM EMP FULL JOIN DEPT ON EMP.DEPTNO=DEPT.DEPTNO;

--EMP ���̺��� ��� ����� �����ȣ,����̸�,�Ŵ�����ȣ(�Ŵ����� �����ȣ),�Ŵ��� �̸�(�Ŵ����� ����̸�) �˻� - ��������
--�������� : EMP ���̺�(WORKER)�� �Ŵ�����ȣ�� EMP ���̺�(MANAGER)�� �����ȣ�� ���Ͽ� ���� �ุ �����Ͽ� �˻� - INNER JOIN
SELECT WORKER.EMPNO,WORKER.ENAME WORKER_ENAME,WORKER.MGR,MANAGER.ENAME MANAGER_ENAME 
    FROM EMP WORKER JOIN EMP MANAGER ON WORKER.MGR=MANAGER.EMPNO;--KING ��� ����
    
--OUTER JOIN�� ����Ͽ� ��� ��� �˻�    
SELECT WORKER.EMPNO,WORKER.ENAME WORKER_ENAME,WORKER.MGR,MANAGER.ENAME MANAGER_ENAME 
    FROM EMP WORKER LEFT JOIN EMP MANAGER ON WORKER.MGR=MANAGER.EMPNO;