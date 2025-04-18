
                            @echo off
                            echo === Dang cap nhat ung dung... ===

                            setlocal
                            set TEMP_DIR=temp_git

                            echo Xoa thu muc tam neu co san...
                            if exist "%TEMP_DIR%" (
                                rmdir /s /q "%TEMP_DIR%"
                            )

                            echo Clone repository...
                            git clone https://github.com/VayneMai021296/ShopeeScanner-Release.git "%TEMP_DIR%"
                            if errorlevel 1 (
                                echo Loi khi clone repository!
                                goto END
                            )

                            :: Đợi 2 giây cho chắc
                            timeout /t 2 >nul

                            echo Dang sao chep file va thu muc...
                            :: Copy toàn bộ nội dung từ TEMP_DIR sang thư mục hiện tại, trừ các file bị loại trừ
                            for /f "delims=" %%f in ('dir "%TEMP_DIR%" /b') do (
                                set "item=%%f"
                                call :copyItemIfNotExcluded "%%f"
                            )

                            :: Xoa thu muc tam sau khi hoan tat
                            echo Dang xoa thu muc tam...
                            rmdir /s /q "%TEMP_DIR%"

                            echo === Cap nhat hoan tat ===
                            echo Dang goi file start_scanner.bat...

                            :: Goi file start_scanner.bat
                            start "" "%~dp0start_scanner.bat"

                            goto END

                            ::--------------------------------------
                            :copyItemIfNotExcluded
                            set "name=%~nx1"

                            if /i "%name%"==".gitignore" goto :eof
                            if /i "%name%"=="README.md" goto :eof
                            if /i "%name%"=="LICENSE" goto :eof

                            :: Copy thu muc hoac file
                            if exist "%TEMP_DIR%\%name%\*" (
                                REM Neu la thu muc
                                xcopy /E /I /Y "%TEMP_DIR%\%name%" "%~dp0%name%" >nul
                            ) else (
                                REM Neu la file
                                xcopy /Y "%TEMP_DIR%\%name%" "%~dp0" >nul
                            )

                            goto :eof

                            :END
                            endlocal
                            exit
                            