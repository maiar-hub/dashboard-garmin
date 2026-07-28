@echo off
setlocal enabledelayedexpansion
echo.
echo ========================================
echo   Publicando Dashboard no GitHub Pages
echo ========================================
echo.

cd /d "C:\Users\raulm\Claude\Projects\Treinador"

echo [INFO] Limpando locks do git...
for %%f in (.git\*.lock) do del /f "%%f" 2>nul

echo [INFO] Atualizando timestamp...
python atualizar_timestamp.py

echo [INFO] Sincronizando index.html...
xcopy /y dashboard_anual_2026.html index.html* >nul

git config user.email "rosanemeloadv@gmail.com" >nul 2>&1
git config user.name "Raul" >nul 2>&1

git add dashboard_anual_2026.html index.html
git diff --cached --quiet
set DIFF_RESULT=!errorlevel!

if !DIFF_RESULT! == 0 (
    echo [INFO] Nenhuma alteracao pendente.
) else (
    git commit -m "Dashboard atualizado - %date:~6,4%-%date:~3,2%-%date:~0,2%"
    if !errorlevel! neq 0 (
        echo [ERRO] Falha no commit.
        pause
        exit /b 1
    )
    echo [OK] Commit realizado.
)

echo.
echo [INFO] Enviando para o GitHub...
git push origin main
if !errorlevel! == 0 (
    echo.
    echo [OK] Dashboard publicado!
    echo Link: https://maiar-hub.github.io/dashboard-garmin/
) else (
    echo.
    echo [ERRO] Falha no push.
)

echo.
pause
