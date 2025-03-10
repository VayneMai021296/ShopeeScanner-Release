@echo off
echo Dang cap nhat ung dung...

REM Clone repository
git clone https://github.com/VayneMai021296/ShopeeScanner-Release.git "temp_git"

REM Sao chep file (loai tru .gitignore, README.md, LICENSE)
for %%f in ("temp_git\*") do (
    if not "%%~nxf"==".gitignore" if not "%%~nxf"=="README.md" if not "%%~nxf"=="LICENSE" (
        xcopy /y "%%f" "%~dp0"
    )
)

REM Xoa thu muc git
rmdir /s /q "temp_git"

REM Khoi dong lai ung dung
start "" "%~dp0Scanner"

echo Cap nhat hoan tat.