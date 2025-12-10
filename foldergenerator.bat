@echo off
setlocal EnableDelayedExpansion

REM --- Konfigurasi Inisial Bulan Indonesia ---
REM Mapping Index (1-12) ke Nama Bulan (Jan, Feb, dst)
SET MonthName[1]=Jan
SET MonthName[2]=Feb
SET MonthName[3]=Mar
SET MonthName[4]=Apr
SET MonthName[5]=Mei
SET MonthName[6]=Jun
SET MonthName[7]=Jul
SET MonthName[8]=Agu
SET MonthName[9]=Sep
SET MonthName[10]=Okt
SET MonthName[11]=Nov
SET MonthName[12]=Des

REM --- Meminta Input Rentang Tahun dan Bulan ---
SET /P StartYear="Masukkan tahun mulai (contoh: 2021): "
SET /P EndYear="Masukkan tahun akhir (contoh: 2023): "
SET /P StartMonth="Masukkan bulan mulai (angka 1-12, contoh: 1): "
SET /P EndMonth="Masukkan bulan akhir (angka 1-12, contoh: 12): "

REM --- Validasi Input Dasar (Opsional) ---
IF NOT DEFINED StartYear GOTO :EndScript
IF NOT DEFINED EndYear GOTO :EndScript
IF NOT DEFINED StartMonth GOTO :EndScript
IF NOT DEFINED EndMonth GOTO :EndScript

REM --- Proses Pembuatan Folder ---
ECHO Mulai membuat folder...

REM Loop untuk Tahun
FOR /L %%Y IN (%StartYear%, 1, %EndYear%) DO (
    ECHO --- Tahun %%Y ---

    REM Loop untuk Bulan dalam rentang yang diminta
    FOR /L %%M IN (%StartMonth%, 1, %EndMonth%) DO (
        REM Format angka bulan menjadi 2 digit (01, 02, dst)
        SET "MonthNum=0%%M"
        SET "MonthNum=!MonthNum:~-2!"

        REM Mengambil nama bulan dari array
        SET "MonthID=!MonthName[%%M]!"

        REM Menggabungkan menjadi format akhir: YYYY_MM-ID
        SET "FolderName=%%Y_!MonthNum!-!MonthID!"

        REM Membuat folder
        IF NOT EXIST "!FolderName!" (
            MKDIR "!FolderName!"
            ECHO Dibuat: !FolderName!
        ) ELSE (
            ECHO Folder sudah ada: !FolderName!
        )
    )
)

:EndScript
ECHO Proses selesai.
PAUSE

