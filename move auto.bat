NHN Move Auto(8:30)


@echo off

chcp 65001 > nul

setlocal enabledelayedexpansion

:: 오늘 날짜를 YYYY-MM-DD 형식으로 설정
for /f "tokens=2 delims==" %%i in ('wmic os get localdatetime /value') do set datetime=%%i
set "today=%datetime:~0,4%-%datetime:~4,2%-%datetime:~6,2%"

:: 소스 및 타겟 디렉토리 설정
set "SOURCE_DIRS="
for %%i in (
    "D:\Backups\Daily_coopvm - coopvm"
    "D:\Backups\Daily_coopvm-log\coopvm"
    "D:\Backups\Daily_egov-coop-DB\egov-coop-DB"
    "D:\Backups\Daily_egov-DB\egov-DB"
    "D:\Backups\Daily_LOG-NFS\LOG-NFS"
    "D:\Backups\Daily_rep-db\rep-db"
    "D:\Backups\Daily_rep-search\rep-search"
    "D:\Backups\Daily_workstation\workstation"
    "D:\Backups\Monthly_NFS_Volume\NFS"
    "D:\Backups\NHN-VEEAM_niaictadmin\Job_KIV-DB"
) do (
    if defined SOURCE_DIRS (
        set "SOURCE_DIRS=!SOURCE_DIRS!;%%~i"
    ) else (
        set "SOURCE_DIRS=%%~i"
    )
)

set "TARGET_DIRS="
for %%i in (
    "X:\nhn-Backups-LongTerm\Daily_coopvm - coopvm"
    "X:\nhn-Backups-LongTerm\Daily_coopvm-log"
    "X:\nhn-Backups-LongTerm\Daily_egov-coop-DB - egov-coop-DB"
    "X:\nhn-Backups-LongTerm\Daily_egov-DB - egov-DB"
    "X:\nhn-Backups-LongTerm\Daily_LOG-NFS - LOG-NFS"
    "X:\nhn-Backups-LongTerm\Daily_rep-db - rep-db"
    "X:\nhn-Backups-LongTerm\Daily_rep-search\rep-search"
    "X:\nhn-Backups-LongTerm\Daily_workstation\workstation"
    "X:\nhn-Backups-LongTerm\Monthly_NFS_Volume\NFS"
    "X:\nhn-Backups-LongTerm\NHNBPMASTER1_Administrator\Job_KIV-DB"
) do (
    if defined TARGET_DIRS (
        set "TARGET_DIRS=!TARGET_DIRS!;%%~i"
    ) else (
        set "TARGET_DIRS=%%~i"
    )
)

set idx=0

:: 소스 디렉토리 배열로 저장
for %%S in ("%SOURCE_DIRS:;=" "%") do (
    set "SOURCE_DIRS_ARR[!idx!]=%%~S"
    set /a idx+=1
)

set idx=0

:: 타겟 디렉토리 배열로 저장
for %%T in ("%TARGET_DIRS:;=" "%") do (
    set "TARGET_DIRS_ARR[!idx!]=%%~T"
    set /a idx+=1
)

:: 디렉토리 개수 가져오기
set /a numDirs=idx-1

:: 대응되는 디렉토리에 오늘 날짜가 포함된 파일만 복사
for /L %%i in (0,1,%numDirs%) do (
    set "SOURCE_DIR=!SOURCE_DIRS_ARR[%%i]!"
    set "TARGET_DIR=!TARGET_DIRS_ARR[%%i]!"

    for %%f in ("!SOURCE_DIR!\*%today%*") do (
        copy "%%~f" "!TARGET_DIR!"
    )
)




endlocal
