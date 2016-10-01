@echo off

REM This modlet adds a registry entry to a specified location

call mod_flag_parsing %*
call mod_flag_check /type regdir /flag path
call mod_flag_check /type string /flag name
call mod_flag_check /type enum /flag type /acceptedValues "REG_SZ,REGMULTI_SZ,REG_EXPAND_SZ,REG_DWORD,REG_QWORD,REG_BINARY,REG_NONE" /defaultValue REG_SZ
call mod_flag_check /type string /flag value

call mod_tee Loading Key
reg add "%flag_path%" /f /v "%flag_name%" /t %flag_type% /d %flag_value%
if ERRORLEVEL 1(
	call mod_error /error %errorlevel% /pause false
)

reg query "%flag_path%" /v "%flag_name%" 2>nul | find "%flag_value%" > nul
if ERRORLEVEL 1 (
	call mod_error /error %errorlevel% /lookup false /description Adding Reg Key
) else (
	call mod_tee Key Loaded
)
exit /b