@echo off
mode con cols=80 lines=60
chcp 949 1> NUL 2> NUL
set "PATH=%~dp0\bin;%PATH%"
setlocal enabledelayedexpansion enableextensions

cd %~dp0
pushd %~dp0
title RidiPaper4 JailBreak Heplper # 리디페이퍼4 탈옥 도우미 v1.3

echo.
echo =========================================
echo RidiPaper4 JailBreak Helper v1.3 230605
echo =========================================
echo RP400JB_Helper sky_ranch @ 230605 v1.3
echo.
echo 본 배치파일은 V1.08 펌웨어 기준으로 제작되었습니다.
echo 1.08 이후 펌웨어의 경우 아래링크를 방문하여 
echo 변동사항 여부를 확인하시길 바랍니다.
echo.
echo *게시글링크
echo https://cafe.naver.com/ebook/673447
echo.
echo *다운로드링크
echo https://github.com/sky-ranch/RP400JB_Helper
echo.
echo *도움을 주신분
echo 본 배치파일은 Limerainee 님의 Ridipaer Pro Kitchien r13.2 
echo 		https://github.com/limerainne/PaperProKitchen
echo 그리고 perillamint 님의 RP4JailbreakKit v1 을 기반으로 만들어졌습니다.
echo 		https://github.com/perillamint/RP4JailbreakKit
echo.
echo 폴더가 복잡하거나 "한글명" 폴더가 경로에 있는경우 실행이 안되는경우가 있습니다.
echo 바탕화면에 압축을 풀고 실행하시길 바랍니다.
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

echo  ★perillamint님의 스크립트★
echo -----------------------------------------
echo 트랜스 권리는 인권입니다.
echo -----------------------------------------
echo 이 스크립트를 실행함으로서
echo.
echo 기기의 품질 보증은 무효화되며, 스크립트 작성자는 스크립트 사용으로 인한
echo 벽돌된 장치, 죽은 메모리, 잘못된 보안 설정에 따른 기기 손상 및 열핵 전쟁
echo 등에 책임이 없음에 동의합니다.

set AREYOUSURE=N
SET /P AREYOUSURE=동의합니까? [Y/[N]]: 
echo.
IF /I "!AREYOUSURE!" EQU "Y" GOTO 0_stage_shortcut
echo.
echo.
echo 동의하지 않으셨습니다. 창을 종료합니다.
pause
exit

:0_stage_shortcut
echo.
echo 직전단계 바로가기 기능을 시작합니다
echo.
echo 첫 시작이신분들은 0 혹은 엔터 키를 누르면 처음으로 이동합니다. 
echo.
echo ============= 바로가기 목록 ============= 
echo		0. 처음 시작 = 리디페이퍼 초기화
echo		1. Google ADB 드라이버 설치
echo		2. 장치 관리자 열어 두기
echo		3. 기기 전원 끄기
echo		4. Fastboot 모드로 기기 시작
echo		5. 루트 이미지로 부팅
echo		   - 순정이미지 복구도 5에서 합니다.
echo		6. ADB 작업 (IP 입력)
echo	7. ADB Shell 스크립트 장치설정 (슈퍼유저권한)
echo.
echo =============== 추가 환경 =============== 
echo.
echo		8. ADB 환경 (초.중급자용)
echo.
echo	아무것도 입력하지 않으면 처음부터 시작합니다
echo.
SET /P SHORTCUT=원하는 바로가기의 숫자를 입력하세요 [0-8]: 
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
echo ======== 0. 리디페이퍼 초기화 ========
echo.
echo 루팅 작업 실행전 리디페이퍼 초기화를 진행해야 합니다.
echo 필요한 자료는 미리 백업해놓으시길 바랍니다.
echo.
echo ★★ 초기화후 Wi-Fi 연결 만 진행합니다. ★★
echo ★★ 작업하는 PC와 리페4는 같은 Wifi (동일네트워크)에 있어야합니다.★★
echo ★★ 아이폰 테더링 환경에서 안됩니다.갤럭시 테더링(핫스팟) 사용하세요.★★
echo.
echo - WiFi 설정이후 ADB 가 닫히므로 초기화후 Wi-Fi 연결 실행 까지만 하고 
echo - 리디페이퍼를 종료합니다.
echo - 리디로그인 하지마세요, 로그인창이 뜨면 전원을 종료하세요
echo.
echo 리디페이퍼 4 초기화 후 Wi-Fi 연결 그리고 전원 종료 까지 하셨나요?
echo 다음 단계로 가려면 엔터 키를 누르세요.
echo.
pause

:1_install_driver
echo.
echo ==== 1. Google ADB 드라이버 설치 ====
echo.
set DRIVER_PATH=drivers\GoogleUSBDriver
if %USE_DPINST% EQU 1 (
  REM install driver using DPINST tool
  echo DPInst 도구를 이용해 드라이버를 설치합니다. 아무키나 누르면 시작합니다.
  echo ^- 관리자 권한 승인 창에서 권한 사용을 허락하고
  echo ^- 나타날 DPInst 도구 창의 설명을 따라 진행해주세요.
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
    echo 드라이버를 설치합니다. 아무키나 누르면 시작합니다.
    echo ^- 관리자 권한 승인 창^(^"INF Default Install^"^)에서 권한 사용을 허락한 뒤
    echo ^- 잠시 후 나타날 설치 완료 메시지를 확인하세요.
    echo.
    pause
    REM powershell -command "start-process cmd -argumentlist '/c','pnputil','-i','-a','%cd%\%DRIVER_PATH%\android_winusb.inf','&','pause' -verb runas -wait"
    infdefaultinstall "%cd%\%DRIVER_PATH%\android_winusb.inf"
  ) else (
    echo 다음 윈도 탐색기 창에서 드라이버를 직접 설치해 주세요.
    echo android_winusb.inf 파일에서 오른쪽 클릭 ^> 설치
    echo.
    start /wait explorer %cd%\%DRIVER_PATH%
    
    echo 설치를 마치셨다면 계속 진행해주세요.
    echo.
    pause
  )
)
REM NOTE 괄호짝 잘 맞출 것...

echo.
echo 혹시 드라이버 설치를 다시 시도해야 하나요?
echo 그렇다면 Y를 입력하고 엔터 키를, 다음 단계로 가려면 엔터 키를 누르세요.

set AREYOUSURE=N
SET /P AREYOUSURE=다시 설치할까요? [Y/[N]]: 
echo.
IF /I "!AREYOUSURE!" EQU "Y" GOTO 1_install_driver

echo.


:2_start_devmgmt
echo.
echo ==== 2. 장치 관리자 열어두기 ====
echo.
echo Google ADB Driver 가 설치 되었지만 추후 수동으로 드라이버 설정을 해야합니다.
echo 장치 관리자 창은 닫지 마시고 절차가 끝날 때까지 그대로 두시길 바랍니다.
echo.
echo * 창을 닫으셨더라도 다시 띄울 수 있습니다:
echo ^- 루트 도구에 들어 있는 "_open_devmgmt.cmd" 실행
echo ^- 시작 버튼 오른쪽 클릭 ^> "장치 관리자" 선택
echo ^- [시작] ^> [실행] 창에 "devmgmt.msc" 입력 후 [확인] 버튼 클릭
start devmgmt.msc
echo.
echo 엔터를 눌러 다음단계로 진행하시길 바랍니다.
echo.
pause

echo.


:3_shutdown_device
echo.
echo ==== 3. 기기 전원 끄기 ====
echo.
echo 리디페이퍼 4와 PC를 연결할 준비를 합니다. 원활한 인식을 위해 다음을 권장합니다:
echo ^- 권장하는 USB 케이블: 리디 번들, 휴대폰 제조사 정품, ...
echo ^- PC에 직접 연결 (USB 허브 대신), 데스크탑이면 뒷면 포트
echo ^- C to C 보다는 C to A를 권장합니다. (간혹 TB4 to C에서 에러 발생)
echo.
echo 기기가 켜진 상태에서 전원 버튼을 꾹 눌러 기기 종료 메뉴를 띄우고 [확인]을 눌러 기기 전원을 끄세요.
echo USB케이블은 아직 연결하지 않습니다.
echo.
pause

echo.


:4_reboot_into_fastboot
echo ==== 4. Fastboot 모드로 기기 시작 ====
echo.
echo 리디페이퍼4의 전원이 완전히 꺼진 것을 확인합니다.
echo ^- 전면 물리 버튼 중 Up 버튼과 기기 상단 전원 버튼을 동시에 7초간 누른후 손을 뗍니다.
echo ^- 손을 뗀 즉시 USB 케이블로 리디페이퍼 4와 PC를 연결합니다. 
echo ^- 그리고 이 USB 케이블은 작업 끝까지 빼지 않습니다.
echo.
echo 정상적으로 Fastboot 모드로 연결되었다면
echo 화면에는 RIDI PAPER 4 로고 혹은 전원Off 화면 만 보일 것입니다.
echo.
echo 리디홈으로 부팅이 되었다면 Fastboot 모드로 부팅된 것이 아니므로
echo ^- 위 작업을 반복하여 Fastboot 모드로 연결합니다.
echo.
echo 장치관리자 창을 엽니다
echo ^- 장치관리자 창에서 기타장치 "Exynos3830 LK Bootloader" 를 확인합니다.
echo ^- 우클릭 
echo ^- 드라이버 업데이트
echo ^- 내 컴퓨터에서 드라이버 찾아보기
echo ^- 컴퓨터의 사용가능한 드라이버 목록에서 직접 선택
echo ^- ADB Interface - SAMSUNG Android ADB Interface
echo 	**사용하는 OS 에 따라 Android ADB 혹은 Google Anroid ADB interface로 뜰 수 있습니다
echo 	**[Android ADB interface]가 들어간 드라이버를 골라주세요
echo 드라이버 업데이트 경고
echo ^- "예"를 눌러 진행
echo.
echo 다시 장치관리자를 열어
echo ADB Interface (Android Interface) - [SAMSUNG or Google 등] Android ADB Interface 로 인식되었는지 확인합니다.
echo.
echo 인식이 되었으면 엔터키를 눌러 다음단계로 이동합니다.
pause

echo.

:5_boot_with_image
echo ==== 5. 루트 이미지로 부팅 ====
echo.
echo 리디페이퍼4가 [SAMSUNG or Google 등] Android ADB Interface 로 인식되었나요? 그렇지 않다면,
echo ^- USB 케이블을 바꿔보거나,
echo ^- PC의 다른 USB 포트를 사용해 보세요.

:5_1_fastboot_devices
echo.
echo -- Fastboot 프로그램이 인식한 기기 목록 --
echo ^> fastboot devices
fastboot devices
echo.

echo 위 목록에 기기(숫자와 문자조합으로 뜹니다)가 있나요? 
echo 계속하려면 Y를 입력하고 엔터 키를, 목록을 새로고치시려면 엔터 키를 누르세요.

set AREYOUSURE=N
SET /P AREYOUSURE=계속 진행할까요? [Y/[N]]: 
echo.
IF /I "!AREYOUSURE!" NEQ "Y" GOTO 5_1_fastboot_devices

:5_2_choose_image
echo -- 사용가능한 Boot 이미지 --
echo 1. 루트(magisk) Boot 이미지
echo 2. 순정 Boot 이미지 
echo [미지원] 3. 루트 후 언루트 
echo.

set RECV_IMAGE=0
echo 현재 Perillamint 님의 Magsik 루트 이미지 및 순정이미지만 지원합니다.
echo 루팅은 1을 순정복구를 원하시는분은 2를 입력하세요.
SET /P RECV_IMAGE=사용할 이미지 번호를 입력하고 엔터 키를 누르세요 [1-2]: 
echo.
IF /I "%RECV_IMAGE%" GEQ "5" GOTO 5_2_choose_image
IF /I "%RECV_IMAGE%" LEQ "0" GOTO 5_2_choose_image

set RECV_IMAGE_PATH=RP4JailbreakKit
if /I "%RECV_IMAGE%" == "1" (
set RECV_IMAGE_PATH=%RECV_IMAGE_PATH%/magisk-cust.img
) else if /I "%RECV_IMAGE%" == "2" (
set RECV_IMAGE_PATH=%RECV_IMAGE_PATH%/RP400_org_boot.img
) else if /I "%RECV_IMAGE%" == "3" (
set RECV_IMAGE_PATH=%RECV_IMAGE_PATH%/no3temp.img
) else if /I "%RECV_IMAGE%" == "4" (
set RECV_IMAGE_PATH=%RECV_IMAGE_PATH%/no4temp.img
)

echo 현재는 1번 Magisk-cust 와 2번 순정 boot 이미지만 지원합니다.
echo 선택한 이미지가 맞나요? 맞다면 Y를 입력하고 엔터 키를, 아니라면 엔터 키를 눌러 다시 선택하세요.
echo ^# !RECV_IMAGE!번 이미지
echo ^> !RECV_IMAGE_PATH!
echo.

set AREYOUSURE=N
SET /P AREYOUSURE=계속 진행할까요? [Y/[N]]: 
echo.
IF /I "!AREYOUSURE!" NEQ "Y" GOTO 5_2_choose_image

:5_3_fastboot_boot_with_chosen_image

echo.
echo 기기에 Boot 이미지를 플래싱 합니다.
echo	- 순정 복구를 선택한경우 Fastboot 플래싱 후 부팅 되면 다시 초기화 바랍니다.
echo.
echo Sending, Writing 후 재부팅이 진행됩니다. 혹시 3분이 지나도 재부팅이 되지않는경우
echo 기기와 usb 케이블을 분리하고 전원 버튼을 약 10초간 눌러 강제 재부팅 후
echo 물리 버튼 중 Up 버튼과 기기 상단 전원 버튼을 동시에 7초간 눌러 flashboot 모드에 다시 진입한후
echo PC에 연결하여 Fastboot 명령을 내립니다.
echo.
echo ^> fastboot flash boot %RECV_IMAGE_PATH%
fastboot flash boot %RECV_IMAGE_PATH%
echo ^> flashboot reboot
fastboot reboot
echo.

echo 'Sending" 'Writing', 'Rebooting', 'Finished' 메시지가 차례로 떴나요?
echo 그렇지 않아서 다시 시도하려면 Y를 입력하고 엔터 키를, 다음으로 넘어가려면 엔터 키를 누르세요.
set AREYOUSURE=N
SET /P AREYOUSURE=Fastboot 명령을 다시 내릴까요? [Y/[N]]: 
echo.
IF /I "!AREYOUSURE!" EQU "Y" GOTO 5_3_fastboot_boot_with_chosen_image


:6_wait_for_the_job
echo.
echo ==== 6. ADB 작업 ====
echo.
echo USB 케이블 제거하지마세요! PC에 연결된채로 진행합니다.
echo	단 재부팅 직후 USB 데이터 전송모드창이 뜬다면 USB 케이블을 제거하고 재부팅합니다.
echo.
echo  QnA 및 오류는 https://cafe.naver.com/ebook/673447 (링크를 Ctrl누르고 클릭)를 참고하시길 바랍니다.
echo.
echo 지금까지 앞의 작업들을 잘 따라하셨다면
echo ^- 현재 리디페이퍼 4는 초기화 후 상태로 부팅되어있을겁니다. (자동 재부팅 2분정도 소요)
echo ^- 다음으로 를 눌러 Wifi연결창 (Wi-Fi를 연결해주세요) 로 넘어갑니다,
echo ^- 내 Wifi가 이미 연결되어 있을텐데 나의 Wifi 신호세기 옆 i (ⓛ) 를 누릅니다
echo ^- 마지막 줄의 IP 주소 (192.168.X.XX / 172.X.X.X / 10.X.X.X 와 같은 숫자)를 확인합니다.
echo.
echo 이제 리디페이퍼4의 IP 주소를 입력합니다.
echo IP 주소에는 192.168.0.4 처럼 숫자와 . 만 입력해주시길 바랍니다
echo.
echo 본인 리디페이퍼4의 IP 주소를 입력해주세요.
SET /P RP400IP=IP 주소  [예시 : 192.168.0.5]를 입력해주세요. : 
echo.
echo 리디페이퍼 4 IP인 %RP400IP% 로 연결을 시작합니다.
echo.
echo 만일 잘못 입력하였다면 IP주소입력단계로 다시 돌아와서 입력하면 됩니다.
echo.

set ADB_ADD_PATH=RP4JailbreakKit

adb connect %RP400IP%:5555
adb push %ADB_ADD_PATH%\magisk-snap.tar /sdcard/magisk-snap.tar
adb push %ADB_ADD_PATH%\rp4-boot-magisk-261.img /sdcard/boot.img
adb push %ADB_ADD_PATH%\setup.sh /sdcard/setup.sh
adb uninstall com.topjohnwu.magisk
adb install %ADB_ADD_PATH%\magisk.apk
adb install %ADB_ADD_PATH%\net.micode.fileexplorer_1.apk
adb install %ADB_ADD_PATH%\SimpleFileManagerPro_6.15.3.apk

echo.
echo Success 메시지가 차례로 떴나요?
echo Success 메시지가 잘 떴다면 엔터키를 눌러 다음으로 넘어갑니다.
echo.
echo Success 메시지가 없거나 
echo 대상 컴퓨터에서 연결을 거부하였으므로 연결하지 못했습니다. 혹은
echo no device found 등의 에러가 뜨는경우 IP주소를 잘못입력했거나 ADB가 막힌상황으로 보입니다.
echo. 
echo  이 창을 그대로 두고 즉시 리디페이퍼4를 재부팅합니다.
echo  리디페이퍼4 Wifi 연결을 확인 후 Y입력후 엔터 키를  눌러 IP주소 입력단계를 반복합니다.
echo.
echo IP주소를 다시 입력하려면 Y를 입력하고 엔터 키를 누르세요.
echo 다음단계로 넘어가려면 N 혹은 아무것도 입력하지 않고 엔터 키를 누르세요
set AREYOUSURE=N
SET /P AREYOUSURE=IP 주소입력창으로 돌아갈까요? [Y/[N]]: 
echo.
IF /I "!AREYOUSURE!" EQU "Y" GOTO 6_wait_for_the_job
echo.
echo 장치설정을 시작 하기 앞서 주의사항입니다.
echo ^- 기기화면을 잘 보시고 장치에서 슈퍼유저 권한을 허용해 주세요
echo ^- 슈퍼유저 요청 창이 뜨면 ""우측""의 일괄허용을 누르셔야합니다.
echo ^- 슈퍼유저 권한 허용을 못 누르셨다면 기기초기화 후 처음부터 진행하시길 바랍니다.
echo ^- 슈퍼유저 권한 창이 뜨지 않은경우도. 초기화후 처음부터 진행하시길 바랍니다
echo		Cf.) 아이폰-테더링, KT공유기(일부)에서 슈퍼유저 권한 창이 뜨지 않는 것으로 보고됨
echo.
echo Y를 입력후 엔터 키를 누르면 장치설정이 시작됩니다.
echo 장치설정이 시자되면 리디페이퍼 4 화면을 잘 봐주시고 슈퍼유저 권한을 허용해주세요
set AREYOUSURE=N
SET /P AREYOUSURE=장치설정을 시작할까요? [Y/[N]]: 
echo.
IF /I "!AREYOUSURE!" EQU "Y" GOTO 7_adb_shell_root
echo.

:7_adb_shell_root
adb shell su -c "'sh /sdcard/setup.sh'"
echo 탈옥이 완료되었습니다. 좋은 하루 되세요. :)
echo.

:finish
echo.
echo Adb no device found 등의 문구가 보인다면 작업과정에 에러가 있었던 것으로 생각되어집니다.
echo 위와같은경우 배치파일을 재실행하여 에러가 있던 단계부터 재실행 하시길 바랍니다.
echo.
echo. [완료되었습니다. 기기를 껐다 켜 주세요.] 문구가 보인다면 작업이 정상적으로 종료된 것입니다.
echo.
echo 이제 모든작업이 종료되었습니다. 
echo ^- 기기 재부팅 후 RIDI 로그인을 진행하시면 됩니다.
echo ^- 홈버튼을 누르면 e-ink 런처로 이동합니다.
echo ^- 파일매니저 를 통하여 apk 설치가 가능합니다.
echo ^- 범용기로 사용하실 분은 퀵버튼을 뒤로가기로 할당하여 쓰는걸 추천드립니다.
echo ^- 퀵버튼 설정(퀵버튼 2초 누르세요)은 리디페이퍼4 홈에서만 가능합니다
echo ^- 추가 내용이나 버그 제보는 카페 게시글 혹은 Github을 이용해주세요
echo.
echo 이제 창을 닫으셔도 좋습니다.
echo. 
echo RP400JB_Helper 230604_skyranch
echo.
pause
exit

:8_adb_env
cd %dp0\bin
echo.
echo 초 중급자를 위한 ADB 환경입니다
echo ^-  adb devices, adb connect 192.168.0.4:5555 와 같은 명령어를 바로 입력할 수 있습니다.
echo ^-  adb, fastboot 의 환경설정이 되어있으므로 바로 명령어를 입력하시면 됩니다.
echo.

cmd /K