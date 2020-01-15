@echo off

:: Copyright (c) Erlimar Silva Campos. All rights reserved.
:: Licensed under the MIT License. More license information in LICENSE.

set PYTHON=python
set PIP=pip
set OUTPUT=.\venv

:: Check PYTHON installation
where %PYTHON% 2>nul >nul
IF ERRORLEVEL 1 (
    echo Python not installed!
    exit /b 1
)

:: Check PIP installation
where %PIP% 2>nul >nul
IF ERRORLEVEL 1 (
    echo Pip not installed!
    exit /b 1
)

:: Check PYTHON version
%PYTHON% -c "import sys; exit(0 if sys.version_info.major == 3 else 1)" 2>nul >nul
IF ERRORLEVEL 1 (
    echo Python version is not supported. Expected version 3.
    %PYTHON% --version
    exit /b 1
)

:: Check VIRTUALENV installation
%PYTHON% -m virtualenv --version 2>nul >nul
IF ERRORLEVEL 1 (
    echo Virtualenv not installed.
    echo Run:
    echo ^ ^ C:^\^> %PIP% install --user virtualenv
    exit /b 1
)

:: Initializes VENV
IF NOT EXIST %OUTPUT%\Scripts\activate.bat (
    %PYTHON% -m virtualenv --python=%PYTHON% %OUTPUT%
    IF ERRORLEVEL 1 (
        echo Virtualenv command failed.
	exit /b %ERRORLEVEL%
    )
)

IF NOT EXIST %OUTPUT%\Scripts\activate.bat (
    echo VENV initialization failed.
    exit /b 1
)

echo To start, exec: %OUTPUT%\Scripts\activate.bat

