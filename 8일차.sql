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

--KIM �������� DBMS ���� ����
-- >> KIM �������� CREATE SESSION �ý��� ������ ��� ���� �ź�

--�����ڰ� KIM �������� CREATE SESSION �ý��� ���� �ο� - ������ ���� ����
--GRANT CREATE SESSION TO KIM;

--CREATE SESSION �ý��� ���� �ο� �� KIM �������� DBMS ���� ���� - SQLPLUS : ���� ����
--SQL> CONN KIM/1234
--SQL> SHOW USER




























































