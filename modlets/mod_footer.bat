call mod_newline
if %errorct% geq 1 (
	call mod_tee Complete With Errors /color 0C
) else (
	call mod_tee Complete /color 0A
)
timeout /nobreak 3 > nul
if "[%debug%]"=="[true]" pause
exit %errorct%