: << 'CMDBLOCK'
@echo off
REM Hook launcher that runs under both cmd (Windows) and bash (Unix).
REM cmd runs this block; bash skips it as a heredoc after ':'.
REM Technique from obra/superpowers hooks/run-hook.cmd (MIT).
REM KEEP THIS FILE ASCII-ONLY: cmd mis-splits LF-only lines that contain
REM multibyte characters (tests/test-session-start.sh checks this).
REM Hook scripts have no extension: a .sh name makes Claude Code on
REM Windows prepend bash and bypass this launcher.

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

REM No bash: exit quietly (rules are not injected, the session still starts)
if not defined BASH_EXE exit /b 0

"%BASH_EXE%" "%HOOK_DIR%%~1" %2 %3 %4 %5 %6 %7 %8 %9
exit /b %ERRORLEVEL%
CMDBLOCK

# Unix: run the named script from this directory
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
