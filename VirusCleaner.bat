@echo off
color f3
title VirusCleaner    by zhanchen
set pathError=false

:Start
echo.
echo  ****************************************************************
echo  * �ýű����Խ������ص��ļ��ָ���ʾ,�����αװ�������ļ���U�̲���
echo  * (�ýű��������������ļ��У����U�������ļ�����������ĳ�ļ����£�
echo  * ��������ļ���·��)
echo  *
echo  * ע1���ýű����ڵ�ǰĿ¼����һ��temp.dat�ļ�������������ɾ��
echo  * ע2�����֡��Ҳ����ļ�������������
echo  * ע3���ýű��Ὣȥ�������ļ������ؼ�ϵͳ����
echo  * ע4���ýű���ɾ��autorun.inf�ļ�
echo  *
echo  * ���ߣ�zhanchen                                      2016.07.07
echo  ****************************************************************
echo.

if %pathError%==true (
  echo ����·��%disk%�����ڣ�����������
  set disk=
  echo.
)
echo ������U���̷����ļ���·��(��C:��C:\folder)��
set /p disk=ֱ�Ӱ��س�Ϊ��ǰ·����
echo.

if "%disk%"=="" set disk=%~dp0

if not exist %disk% (
  cls
  set pathError=true
  goto Start
)

for %%i in (%disk%\*.lnk %disk%\*.exe) do (
  echo %%~nxi>>temp.dat
)
if not exist temp.dat (
  goto L1
)

for /f "delims=" %%j in ('dir /ah/b "%disk%"') do (
  attrib -s -h -a -r %disk%\%%~nxj>nul
)

for /f "delims=/" %%i in (temp.dat) do (
  for /f "delims=" %%j in ('dir /b "%disk%"') do (
    if %%~nxj==%%~ni del %disk%\%%i /s/q/f
  )
)

:L1

if exist %disk%\autorun.inf del autorun.inf /s/q/f >nul

if exist %disk%\���Ʋ����ļ��б�.txt del %disk%\���Ʋ����ļ��б�.txt /f/s/q>nul

for %%i in (%disk%\*.lnk %disk%\*.exe %disk%\*.vbs %disk%\*.cmd %disk%\*.bat) do (
  if %%~nxi neq %~nx0 echo %%~nxi>>%disk%\���Ʋ����ļ��б�.txt
)

if exist %disk%\���Ʋ����ļ��б�.txt (
  echo.
  echo �����ļ��޷��ж��Ƿ�Ϊ����
  echo ���ļ����ѱ�д��%disk%�¡����Ʋ����ļ��б�.txt����
  echo �������жϲ��������ļ�ɾ��
)

if not exist temp.dat (if not exist ���Ʋ����ļ��б�.txt echo δ���ֲ���)

:End
if exist temp.dat del temp.dat /f/q >nul
echo.
echo �������н�������������˳�...
pause>nul