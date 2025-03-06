0902

@echo off

chcp 65001  nul

setlocal enabledelayedexpansion

 텔레그램 설정
set BOT_TOKEN=
set CHAT_ID=

 오늘 날짜를 YYYY-MM-DD 형식으로 설정
for f tokens=2 delims== %%i in ('wmic os get localdatetime value') do set datetime=%%i
set today=%datetime~0,4%-%datetime~4,2%-%datetime~6,2%

   
 소스 디렉토리 설정
set idx=0
for %%i in (
    DBackupsDaily_LOG-NFSLOG-NFS
    DBackupsDaily_rep-dbrep-db
    DBackupsDaily_rep-searchrep-search
    DBackupsDaily_workstationworkstation
    DBackupsMonthly_NFS_VolumeNFS
    DBackupsNHN-VEEAM_niaictadminJob_KIV-DB
) do (
    set SOURCE_DIRS_ARR[!idx!]=%%~i
    set DIR_NAMES_ARR[!idx!]=%%~ni
    set a idx+=1
)

 소스 디렉토리 개수 가져오기
set a numDirs=idx-1
if %numDirs% LSS 0 set numDirs=0

 텔레그램 메시지
set message=!message_!



 오늘 날짜가 포함된 파일이 있는지 체크
for L %%i in (0,1,%numDirs%) do (
    call set SOURCE_DIR=%%SOURCE_DIRS_ARR[%%i]%%
    call set DIR_NAME=%%DIR_NAMES_ARR[%%i]%%
    set file_found=false

    for %%f in (!SOURCE_DIR!%today%) do (
        set file_found=true
    )

    if !file_found!==true (
        set message=!message!!DIR_NAME!(%today%) success%%0A
    ) else (
        set message=!message!!DIR_NAME!(%today%) fail%%0A
    )
)

echo !message!  test.txt


 텔레그램 전송
curl -s -X POST httpsapi.telegram.orgbot%BOT_TOKEN%sendMessage -d chat_id=%CHAT_ID% -d text=%message% -d parse_mode=Markdown

endlocal
