: << 'CMDBLOCK'
@echo off
REM Windows(cmd)와 Unix(bash) 양쪽에서 실행되는 hook 실행기.
REM cmd는 이 블록을 실행하고, bash는 ':' 이후 heredoc으로 건너뛴다.
REM 기법 출처: obra/superpowers hooks/run-hook.cmd (MIT)
REM hook 스크립트는 확장자 없이 둔다. 이름에 .sh가 있으면 Windows의
REM Claude Code가 앞에 bash를 붙여 이 실행기를 우회하기 때문이다.

if "%~1"=="" (
    echo run-hook.cmd: missing script name >&2
    exit /b 1
)

setlocal
set "HOOK_DIR=%~dp0"
set "BASH_EXE="

if exist "C:\Program Files\Git\bin\bash.exe" set "BASH_EXE=C:\Program Files\Git\bin\bash.exe"
if not defined BASH_EXE if exist "C:\Program Files (x86)\Git\bin\bash.exe" set "BASH_EXE=C:\Program Files (x86)\Git\bin\bash.exe"
if not defined BASH_EXE if defined LOCALAPPDATA if exist "%LOCALAPPDATA%\Programs\Git\bin\bash.exe" set "BASH_EXE=%LOCALAPPDATA%\Programs\Git\bin\bash.exe"

REM bash가 없으면 조용히 끝낸다 (규칙 주입만 빠지고 세션은 정상 시작)
if not defined BASH_EXE exit /b 0

"%BASH_EXE%" "%HOOK_DIR%%~1" %2 %3 %4 %5 %6 %7 %8 %9
exit /b %ERRORLEVEL%
CMDBLOCK

# Unix: 이름 붙은 스크립트를 같은 폴더에서 실행
case "$0" in
  */*|*\\*) SCRIPT_DIR="${0%[/\\]*}" ;;
  *) SCRIPT_DIR="." ;;
esac
SCRIPT_NAME="$1"
shift

if [ -n "${BASH:-}" ]; then
  shell="$BASH"
elif command -v bash >/dev/null 2>&1; then
  shell="bash"
else
  exit 0
fi

exec "$shell" "${SCRIPT_DIR}/${SCRIPT_NAME}" "$@"
