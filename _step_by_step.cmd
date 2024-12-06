@echo off
mode con cols=80 lines=60
chcp 949 1> NUL 2> NUL
set "PATH=%~dp0\bin;%PATH%"
setlocal enabledelayedexpansion enableextensions

cd %~dp0
pushd %~dp0
title RidiPaper4 JailBreak Heplper # ����������4 Ż�� ����� v1.4

echo.
echo =========================================
echo RidiPaper4 JailBreak Helper v1.40 241206
echo =========================================
echo RP400JB_Helper sky_ranch @ 230618 v1.4
echo.
echo �� ��ġ������ V1.09 �߿��� �������� ���۵Ǿ����ϴ�.
echo 1.09 ���� �߿����� ��� �Ʒ���ũ�� �湮�Ͽ� 
echo �������� ���θ� Ȯ���Ͻñ� �ٶ��ϴ�.
echo.
echo *�Խñ۸�ũ
echo https://cafe.naver.com/ebook/673447
echo.
echo *�ٿ�ε帵ũ
echo https://github.com/sky-ranch/RP400JB_Helper
echo.
echo *������ �ֽź�
echo �� ��ġ������ Limerainee ���� Ridipaer Pro Kitchien r13.2 
echo 		https://github.com/limerainne/PaperProKitchen
echo �׸��� perillamint ���� RP4JailbreakKit v1 �� ������� ����������ϴ�.
echo 		https://github.com/perillamint/RP4JailbreakKit
echo.
echo ������ �����ϰų� "�ѱ۸�" ������ ��ο� �ִ°�� ������ �ȵǴ°�찡 �ֽ��ϴ�.
echo ����ȭ�鿡 ������ Ǯ�� �����Ͻñ� �ٶ��ϴ�.
echo =========================================
echo.
pause

:detect_os_arch
REM https://github.com/limerainne/PaperProKitchen
REM default value
set ASK_WIN7_DRVTWK=0
set USE_DPINST=1
set OS=64BIT
set DRV_W8A_UTIL_EXIST=1

REM https://helloacm.com/windows-batch-script-to-detect-windows-version/
for /f "tokens=2 delims=[]" %%i in ('ver') do set VERSION=%%i
for /f "tokens=2-3 delims=. " %%i in ("%VERSION%") do set VERSION=%%i.%%j
if "%VERSION%" == "6.0" ( 
  REM echo Windows Vista
  set USE_DPINST=1
  set ASK_WIN7_DRVTWK=1
)
if "%VERSION%" == "6.1" ( 
  REM echo Windows 7
  set USE_DPINST=1
  set ASK_WIN7_DRVTWK=1
)
if "%VERSION%" == "6.2" ( 
  REM echo Windows 8
  set USE_DPINST=1
)
if "%VERSION%" == "6.3" ( 
  REM echo Windows 8.1
  set USE_DPINST=1
)
if "%VERSION%" == "10.0" ( 
  REM echo Windows 10
  set USE_DPINST=0
)

REM https://stackoverflow.com/questions/12322308/batch-file-to-check-64bit-or-32bit-os
REM http://www.robvanderwoude.com/condexec.php
reg Query "HKLM\Hardware\Description\System\CentralProcessor\0" | find /i "x86" > NUL && set OS=32BIT || set OS=64BIT
REM echo %OS%

REM check if powershell, (pnputil), infdefaultinstall exist
where powershell > NUL
IF %ERRORLEVEL% NEQ 0 set DRV_W8A_UTIL_EXIST=0
REM where pnputil > NUL
REM IF %ERRORLEVEL% NEQ 0 set DRV_W8A_UTIL_EXIST=0
where infdefaultinstall > NUL
IF %ERRORLEVEL% NEQ 0 set DRV_W8A_UTIL_EXIST=0
echo.

echo  ��perillamint���� ��ũ��Ʈ��
echo -----------------------------------------
echo Ʈ���� �Ǹ��� �α��Դϴ�.
echo -----------------------------------------
echo �� ��ũ��Ʈ�� ���������μ�
echo.
echo ����� ǰ�� ������ ��ȿȭ�Ǹ�, ��ũ��Ʈ �ۼ��ڴ� ��ũ��Ʈ ������� ����
echo ������ ��ġ, ���� �޸�, �߸��� ���� ������ ���� ��� �ջ� �� ���� ����
echo � å���� ������ �����մϴ�.

set AREYOUSURE=N
SET /P AREYOUSURE=�����մϱ�? [Y/[N]]: 
echo.
IF /I "!AREYOUSURE!" EQU "Y" GOTO 0_stage_shortcut
echo.
echo.
echo �������� �����̽��ϴ�. â�� �����մϴ�.
pause
exit

:0_stage_shortcut
echo.
echo �����ܰ� �ٷΰ��� ����� �����մϴ�
echo.
echo ù �����̽źе��� 0 Ȥ�� ���� Ű�� ������ ó������ �̵��մϴ�. 
echo.
echo ============= �ٷΰ��� ��� ============= 
echo		0. ó�� ���� = ���������� �ʱ�ȭ
echo		1. Google ADB ����̹� ��ġ
echo		2. ��ġ ������ ���� �α�
echo		3. ��� ���� ����
echo		4. Fastboot ���� ��� ����
echo		5. ��Ʈ �̹����� ����
echo		   - �����̹��� ������ 5���� �մϴ�.
echo		   - Fastboot ������ �����ϼ���
echo		6. ADB �۾� (IP �Է�)
echo	7. ADB Shell ��ũ��Ʈ ��ġ���� (������������)
echo.
echo =============== �߰� ȯ�� =============== 
echo.
echo		8. ADB ȯ�� (��.�߱��ڿ�)
echo.
echo	�ƹ��͵� �Է����� ������ ó������ �����մϴ�
echo.
SET /P SHORTCUT=���ϴ� �ٷΰ����� ���ڸ� �Է��ϼ��� [0-8]: 
IF "%SHORTCUT%"=="0" GOTO 0_Reset_Agree
IF "%SHORTCUT%"=="1" GOTO 1_install_driver
IF "%SHORTCUT%"=="2" GOTO 2_start_devmgmt
IF "%SHORTCUT%"=="3" GOTO 3_shutdown_device
IF "%SHORTCUT%"=="4" GOTO 4_reboot_into_fastboot
IF "%SHORTCUT%"=="5" GOTO 5_boot_with_image
IF "%SHORTCUT%"=="6" GOTO 6_wait_for_the_job
IF "%SHORTCUT%"=="7" GOTO 7_adb_shell_root
IF "%SHORTCUT%"=="8" GOTO 8_adb_env

:0_Reset_Agree
echo.
echo ======== 0. ���������� �ʱ�ȭ ========
echo.
echo ���� �۾� ������ ���������� �ʱ�ȭ�� �����ؾ� �մϴ�.
echo �ʿ��� �ڷ�� �̸� ����س����ñ� �ٶ��ϴ�.
echo.
echo �ڡ� �ʱ�ȭ�� Wi-Fi ���� �� �����մϴ�. �ڡ�
echo �ڡ� �۾��ϴ� PC�� ����4�� ���� Wifi (���ϳ�Ʈ��ũ)�� �־���մϴ�.�ڡ�
echo �ڡ� ������ �״��� ȯ�濡�� �ȵ˴ϴ�.������ �״���(�ֽ���) ����ϼ���.�ڡ�
echo.
echo - WiFi �������� ADB �� �����Ƿ� �ʱ�ȭ�� Wi-Fi ���� ���� ������ �ϰ� 
echo - ���������۸� �����մϴ�.
echo - ����α��� ����������, �α���â�� �߸� ������ �����ϼ���
echo.
echo ���������� 4 �ʱ�ȭ �� Wi-Fi ���� �׸��� ���� ���� ���� �ϼ̳���?
echo ���� �ܰ�� ������ ���� Ű�� ��������.
echo.
pause

:1_install_driver
echo.
echo ==== 1. Google ADB ����̹� ��ġ ====
echo.
set DRIVER_PATH=drivers\GoogleUSBDriver
if %USE_DPINST% EQU 1 (
  REM install driver using DPINST tool
  echo DPInst ������ �̿��� ����̹��� ��ġ�մϴ�. �ƹ�Ű�� ������ �����մϴ�.
  echo ^- ������ ���� ���� â���� ���� ����� ����ϰ�
  echo ^- ��Ÿ�� DPInst ���� â�� ������ ���� �������ּ���.
  pause
  if %OS% == 32BIT (
    start /wait %DRIVER_PATH%\DPINST_x86.exe
  ) else if %OS% == 64BIT (
    start /wait %DRIVER_PATH%\DPINST_x64.exe
  )
) else (
  REM install driver using pnputil + powershell to elevate
  REM https://stackoverflow.com/questions/22496847/installing-a-driver-inf-file-from-command-line
  REM 'pnputil -i -a <PATH_TO_DRIVER_INF>
  REM => it seems not reliable...

  REM install driver using 'infdefaultinstall' same as right click -> install
  REM 'infdefaultinstall' <path/to/inf>
  
  if %DRV_W8A_UTIL_EXIST% == 1 (
    echo ����̹��� ��ġ�մϴ�. �ƹ�Ű�� ������ �����մϴ�.
    echo ^- ������ ���� ���� â^(^"INF Default Install^"^)���� ���� ����� ����� ��
    echo ^- ��� �� ��Ÿ�� ��ġ �Ϸ� �޽����� Ȯ���ϼ���.
    echo.
    pause
    REM powershell -command "start-process cmd -argumentlist '/c','pnputil','-i','-a','%cd%\%DRIVER_PATH%\android_winusb.inf','&','pause' -verb runas -wait"
    infdefaultinstall "%cd%\%DRIVER_PATH%\android_winusb.inf"
  ) else (
    echo ���� ���� Ž���� â���� ����̹��� ���� ��ġ�� �ּ���.
    echo android_winusb.inf ���Ͽ��� ������ Ŭ�� ^> ��ġ
    echo.
    start /wait explorer %cd%\%DRIVER_PATH%
    
    echo ��ġ�� ��ġ�̴ٸ� ��� �������ּ���.
    echo.
    pause
  )
)
REM NOTE ��ȣ¦ �� ���� ��...

echo.
echo ---------------------------------------------------------
echo �ڵ� ����̹� ��ġ���н� RP400JB_Helper\drivers\GoogleUSBDriver
echo  �����ȿ� android_winusb.inf �� ��Ŭ���Ͽ� "��ġ" �� ������
echo  ����̹��� ��ġ�˴ϴ�
echo  *��11������ ��Ŭ��-�����⸦ ������ ��ġ�� �ֽ��ϴ�.
echo ---------------------------------------------------------
echo.
echo.
echo Ȥ�� ����̹� ��ġ�� �ٽ� �õ��ؾ� �ϳ���?
echo �׷��ٸ� Y�� �Է��ϰ� ���� Ű��, ���� �ܰ�� ������ ���� Ű�� ��������.
echo.

set AREYOUSURE=N
SET /P AREYOUSURE=�ٽ� ��ġ�ұ��? [Y/[N]]: 
echo.
IF /I "!AREYOUSURE!" EQU "Y" GOTO 1_install_driver

echo.


:2_start_devmgmt
echo.
echo ==== 2. ��ġ ������ ����α� ====
echo.
echo Google ADB Driver �� ��ġ �Ǿ����� ���� �������� ����̹� ������ �ؾ��մϴ�.
echo ��ġ ������ â�� ���� ���ð� ������ ���� ������ �״�� �νñ� �ٶ��ϴ�.
echo.
echo * â�� �����̴��� �ٽ� ��� �� �ֽ��ϴ�:
echo ^- ��Ʈ ������ ��� �ִ� "_open_devmgmt.cmd" ����
echo ^- ���� ��ư ������ Ŭ�� ^> "��ġ ������" ����
echo ^- [����] ^> [����] â�� "devmgmt.msc" �Է� �� [Ȯ��] ��ư Ŭ��
start devmgmt.msc
echo.
echo ���͸� ���� �����ܰ�� �����Ͻñ� �ٶ��ϴ�.
echo.
pause

echo.


:3_shutdown_device
echo.
echo ==== 3. ��� ���� ���� ====
echo.
echo ���������� 4�� PC�� ������ �غ� �մϴ�. ��Ȱ�� �ν��� ���� ������ �����մϴ�:
echo ^- �����ϴ� USB ���̺�: ���� ����, �޴��� ������ ��ǰ, ...
echo ^- PC�� ���� ���� (USB ��� ���), ����ũž�̸� �޸� ��Ʈ
echo ^- C to C ���ٴ� C to A�� �����մϴ�. (��Ȥ TB4 to C���� ���� �߻�)
echo.
echo ��Ⱑ ���� ���¿��� ���� ��ư�� �� ���� ��� ���� �޴��� ���� [Ȯ��]�� ���� ��� ������ ������.
echo USB���̺��� ���� �������� �ʽ��ϴ�.
echo.
pause

echo.


:4_reboot_into_fastboot
echo ==== 4. Fastboot ���� ��� ���� ====
echo.
echo ����������4�� ������ ������ ���� ���� Ȯ���մϴ�.
echo ^- ���� ���� ��ư �� Up ��ư�� ��� ��� ���� ��ư�� ���ÿ� 7�ʰ� ������ ���� ���ϴ�.
echo ^- 7������ �����ٺ��� ȭ��Ʈ LED �����̴� �ӵ��� �̹��ϰ� �޶����µ� �̶��� fastboot ����Դϴ�.
echo ^- LED�����̴� �ӵ��� �޶����� ���� ����, ���� �� ��� USB ���̺�� ���������� 4�� PC�� �����մϴ�. 
echo ^- �׸��� �� USB ���̺��� �۾� ������ ���� �ʽ��ϴ�.
echo.
echo ���������� Fastboot ���� ����Ǿ��ٸ�
echo ȭ�鿡�� RIDI PAPER 4 �ΰ� Ȥ�� ����Off ȭ�� �� ���� ���Դϴ�.
echo.
echo ����Ȩ���� ������ �Ǿ��ٸ� Fastboot ���� ���õ� ���� �ƴϹǷ�
echo ^- �� �۾��� �ݺ��Ͽ� Fastboot ���� �����մϴ�.
echo.
echo ��ġ������ â�� ���ϴ�
echo ^- ��ġ������ â���� ��Ÿ��ġ "Exynos3830 LK Bootloader" �� Ȯ���մϴ�.
echo ^- ��Ŭ�� 
echo ^- ����̹� ������Ʈ
echo ^- �� ��ǻ�Ϳ��� ����̹� ã�ƺ���
echo ^- ��ǻ���� ��밡���� ����̹� ��Ͽ��� ���� ����
echo ^- ADB Interface - SAMSUNG Android ADB Interface
echo 	**����ϴ� OS �� ���� Android ADB Ȥ�� Google Anroid ADB interface�� �� �� �ֽ��ϴ�
echo 	**[Android ADB interface]�� �� ����̹��� ����ּ���
echo ����̹� ������Ʈ ��� :  "��"�� ���� ����
echo.
echo �ٽ� ��ġ�����ڸ� ����
echo ADB Interface (Android Interface) - [SAMSUNG or Google ��] Android ADB Interface �� �νĵǾ����� Ȯ���մϴ�.
echo.
echo �ν��� �Ǿ����� ����Ű�� ���� �����ܰ�� �̵��մϴ�.
pause

echo.

:5_boot_with_image
echo ==== 5. ��Ʈ �̹����� ���� ====
echo.
echo ����������4�� [SAMSUNG or Google ��] Android ADB Interface �� �νĵǾ�����? �׷��� �ʴٸ�,
echo ^- USB ���̺��� �ٲ㺸�ų�,
echo ^- PC�� �ٸ� USB ��Ʈ�� ����� ������.

:5_1_fastboot_devices
echo.
echo -- Fastboot ���α׷��� �ν��� ��� ��� --
echo ^> fastboot devices
fastboot devices
echo.

echo �� ��Ͽ� ���(���ڿ� ������������ ��ϴ�)�� �ֳ���? 
echo ����Ϸ��� Y�� �Է��ϰ� ���� Ű��, ����� ���ΰ�ġ�÷��� ���� Ű�� ��������.

set AREYOUSURE=N
SET /P AREYOUSURE=��� �����ұ��? [Y/[N]]: 
echo.
IF /I "!AREYOUSURE!" NEQ "Y" GOTO 5_1_fastboot_devices

:5_2_choose_image
echo -- ��밡���� Boot �̹��� --
echo 1. ��Ʈ(magisk) Boot �̹���
echo 2. ���� Boot �̹��� 
echo [������] 3. ��Ʈ �� ���Ʈ 
echo.

set RECV_IMAGE=0
echo ���� Perillamint ���� Magsik ��Ʈ �̹��� �� �����̹����� �����մϴ�.
echo ������ 1�� ���������� ���Ͻôº��� 2�� �Է��ϼ���.
SET /P RECV_IMAGE=����� �̹��� ��ȣ�� �Է��ϰ� ���� Ű�� �������� [1-2]: 
echo.
IF /I "%RECV_IMAGE%" GEQ "5" GOTO 5_2_choose_image
IF /I "%RECV_IMAGE%" LEQ "0" GOTO 5_2_choose_image

set RECV_IMAGE_PATH=RP4JailbreakKit
if /I "%RECV_IMAGE%" == "1" (
set RECV_IMAGE_PATH=%RECV_IMAGE_PATH%/magisk-cust.img
) else if /I "%RECV_IMAGE%" == "2" (
set RECV_IMAGE_PATH=%RECV_IMAGE_PATH%/rp4-109-stock.img
) else if /I "%RECV_IMAGE%" == "3" (
set RECV_IMAGE_PATH=%RECV_IMAGE_PATH%/no3temp.img
) else if /I "%RECV_IMAGE%" == "4" (
set RECV_IMAGE_PATH=%RECV_IMAGE_PATH%/no4temp.img
)

echo ����� 1�� Magisk-cust �� 2�� ���� boot �̹����� �����մϴ�.
echo ������ �̹����� �³���? �´ٸ� Y�� �Է��ϰ� ���� Ű��, �ƴ϶�� ���� Ű�� ���� �ٽ� �����ϼ���.
echo ^# !RECV_IMAGE!�� �̹���
echo ^> !RECV_IMAGE_PATH!
echo.

set AREYOUSURE=N
SET /P AREYOUSURE=��� �����ұ��? [Y/[N]]: 
echo.
IF /I "!AREYOUSURE!" NEQ "Y" GOTO 5_2_choose_image

:5_3_fastboot_boot_with_chosen_image

echo.
echo ��⿡ Ŀ���� magisk �̹����� �÷��� �մϴ�.
echo.
echo Sending, Writing �� ������� ����˴ϴ�. Ȥ�� 3���� ������ ������� �����ʴ°��
echo ���� usb ���̺��� �и��ϰ� ���� ��ư�� �� 10�ʰ� ���� ���� ����� ��
echo ���� ��ư �� Up ��ư�� ��� ��� ���� ��ư�� ���ÿ� 7�ʰ� ���� flashboot ��忡 �ٽ� ��������
echo PC�� �����Ͽ� Fastboot ����� �����ϴ�.
echo.
echo ^> fastboot flash boot %RECV_IMAGE_PATH%
fastboot flash boot %RECV_IMAGE_PATH%
echo ^> flashboot reboot
fastboot reboot
echo.

echo 'Sending" 'Writing', 'Rebooting', 'Finished' �޽����� ���ʷ� ������?
echo �׷��� �ʾƼ� �ٽ� �õ��Ϸ��� Y�� �Է��ϰ� ���� Ű��, �������� �Ѿ���� ���� Ű�� ��������.
set AREYOUSURE=N
SET /P AREYOUSURE=Fastboot ����� �ٽ� �������? [Y/[N]]: 
echo.
IF /I "!AREYOUSURE!" EQU "Y" GOTO 5_3_fastboot_boot_with_chosen_image


:6_wait_for_the_job
echo.
echo ==== 6. ADB �۾� ====
echo.
echo USB ���̺� ��������������! PC�� �����ä�� �����մϴ�.
echo   �� ������ ���۸�尡 �ߴ°�� ���̺��� �����ϰ�
echo   ���̺� ������ä�� ��� ������մϴ�.
echo.
echo ���ݱ��� ���� �۾����� �� �����ϼ̴ٸ�
echo ^- ���� ���������� 4�� �ʱ�ȭ �� ���·� ���õǾ������̴ϴ�. (�ڵ� ����� 2������ �ҿ�)
echo ^- �������� �� ���� Wifi����â (Wi-Fi�� �������ּ���) �� �Ѿ�ϴ�,
echo ^- �� Wifi�� �̹� ����Ǿ� �����ٵ� ���� Wifi ��ȣ���� �� i (��) �� �����ϴ�
echo ^- ������ ���� IP �ּ� (192.168.X.XX / 172.X.X.X / 10.X.X.X �� ���� ����)�� Ȯ���մϴ�.
echo.
echo ���� ����������4�� IP �ּҸ� �Է��մϴ�.
echo IP �ּҿ��� 192.168.0.4 ó�� ���ڿ� . �� �Է����ֽñ� �ٶ��ϴ�
echo.
echo ���� ����������4�� IP �ּҸ� �Է����ּ���.
SET /P RP400IP=IP �ּ�  [���� : 192.168.0.5]�� �Է����ּ���. : 
echo.
echo ���������� 4 IP�� %RP400IP% �� ������ �����մϴ�.
echo.

set ADB_ADD_PATH=RP4JailbreakKit

adb connect %RP400IP%:5555
adb push %ADB_ADD_PATH%\magisk-snap.tar /sdcard/magisk-snap.tar
adb push %ADB_ADD_PATH%\rp4-109-boot-magisk-280.img /sdcard/boot.img
adb push %ADB_ADD_PATH%\setup.sh /sdcard/setup.sh
adb uninstall com.topjohnwu.magisk
adb install %ADB_ADD_PATH%\apk\magisk.apk
adb install %ADB_ADD_PATH%\apk\net.micode.fileexplorer_1.apk
adb install %ADB_ADD_PATH%\SimpleFileManagerPro_6.15.3.apk

echo.
echo Success �޽����� ���ʷ� ������?
echo Success �޽����� �� ���ٸ� ����Ű�� ���� �������� �Ѿ�ϴ�.
echo.
echo Success �޽����� ���ų� 
echo ��� ��ǻ�Ϳ��� ������ �ź��Ͽ����Ƿ� �������� ���߽��ϴ�. Ȥ��
echo no device found ���� ������ �ߴ°�� IP�ּҸ� �߸��Է��߰ų�
echo fastboot�� ���������� �̷������ ���������� ���Դϴ�.
echo.
echo �����ܰ�� �Ѿ���� ����Ű��
echo IP�ּҸ� �ٽ� �Է��Ϸ��� Y�� �Է��ϰ� ���� Ű�� ��������.
set AREYOUSURE=N
SET /P AREYOUSURE=IP �ּ��Է�â���� ���ư����? [Y/[N]]: 
echo.
IF /I "!AREYOUSURE!" EQU "Y" GOTO 6_wait_for_the_job
echo.
echo ��ġ������ ���� �ϱ� �ռ� ���ǻ����Դϴ�.
echo ^- ���ȭ���� �� ���ð� ��ġ���� �������� ������ ����� �ּ���
echo ^- �������� ��û â�� �߸� ""����""�� �ϰ������ �����ž��մϴ�.
echo ^- �������� ���� ����� �� �����̴ٸ� ����ʱ�ȭ �� ó������ �����Ͻñ� �ٶ��ϴ�.
echo ^- �������� ���� â�� ���� ������쵵. �ʱ�ȭ�� ó������ �����Ͻñ� �ٶ��ϴ�
echo		Cf.) ������-�״���, KT������(�Ϻ�)���� �������� ���� â�� ���� �ʴ� ������ �����
echo.
echo Y�� �Է��� ���� Ű�� ������ ��ġ������ ���۵˴ϴ�.
echo ��ġ������ ���ڵǸ� ���������� 4 ȭ���� �� ���ֽð� �������� ������ ������ּ���
set AREYOUSURE=N
SET /P AREYOUSURE=��ġ������ �����ұ��? [Y/[N]]: 
echo.
IF /I "!AREYOUSURE!" EQU "Y" GOTO 7_adb_shell_root
echo.

:7_adb_shell_root
adb shell su -c "'sh /sdcard/setup.sh'"
echo.
echo Ż���� �Ϸ�Ǿ����ϴ�. ���� �Ϸ� �Ǽ���. :)
echo.
echo �� no devices / adb error ���� ���� �߻��� ADB ������ ����� �̷������ �������̸�
echo.
echo Permission Denied ���� �߻��� �������������� ������� ���Ѱ� �Դϴ�.
echo - permission denied ������ �ٷΰ��� 7�� ���� �ٽ� �����ϼ���
echo - �׷��� �ȵȴٸ� ����4 ������� 6�� ���� �ٽ� �����ϼ���
echo.

:finish
echo.
echo Adb no device found ���� ������ ���δٸ� �۾������� ������ �־��� ������ �����Ǿ����ϴ�.
echo ���Ͱ������ ��ġ������ ������Ͽ� ������ �ִ� �ܰ���� ����� �Ͻñ� �ٶ��ϴ�.
echo.
echo. "�Ϸ�Ǿ����ϴ�. ��⸦ ���� �� �ּ���." ������ ���δٸ� �۾��� ���������� ����� ���Դϴ�.
echo.
echo ���� ����۾��� ����Ǿ����ϴ�. 
echo ^- ��� ����� �� RIDI �α����� �����Ͻø� �˴ϴ�.
echo ^- Ȩ��ư�� ������ e-ink ��ó�� �̵��մϴ�.
echo ^- ���ϸŴ��� �� ���Ͽ� apk ��ġ�� �����մϴ�.
echo ^- ������ ����Ͻ� ���� ����ư�� �ڷΰ���� �Ҵ��Ͽ� ���°� ��õ�帳�ϴ�.
echo ^- ����ư ����(����ư 2�� ��������)�� ����������4 Ȩ������ �����մϴ�
echo ^- �߰� �����̳� ���� ������ ī�� �Խñ� Ȥ�� Github�� �̿����ּ���
echo.
echo =========================================
echo 1.4 ������ Perillamint�� magisk�̹����� ������� ���װ� �Ƚ��Ǿ��ֽ��ϴ�.
echo v1.0.8 Ȥ�� 24.12.06 ���� �������� ������� ���װ� ������ �Ʒ� ��ũ�� 
echo ����( https://cafe.naver.com/ebook/673447 )�� �����Ͻñ� �ٶ��ϴ�.
echo =========================================
echo.
echo ���� â�� �����ŵ� �����ϴ�.
echo. 
echo RP400JB_Helper 241206_skyranch
echo.
pause
exit

:8_adb_env
echo.
echo �� �߱��ڸ� ���� ADB ȯ���Դϴ�
echo ^-  adb devices, adb connect 192.168.0.4:5555 �� ���� ��ɾ �ٷ� �Է��� �� �ֽ��ϴ�.
echo ^-  adb shell su -c "'sh /sdcard/setup.sh'" �̳� adb install "������\��apk��ũ.apk" �� ���� ��ɾ �Է��� �� �ֽ��ϴ�.
echo ^-  RP400JB_Helper ������ A.apk�� �־���´ٸ� adb install A.apk�� ��ġ�����մϴ�.
echo ^-  adb, fastboot �� ȯ�漳���� �Ǿ������Ƿ� �ٷ� ��ɾ �Է��Ͻø� �˴ϴ�.
echo.

cmd /K
