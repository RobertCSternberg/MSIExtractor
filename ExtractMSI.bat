@echo off
setlocal enabledelayedexpansion

:input_msi
set /p "msi_file_path=Enter the path to the MSI file: "
if not exist "!msi_file_path!" (
    echo The specified MSI file does not exist. Please try again.
    goto input_msi
) else (
    for %%I in ("!msi_file_path!") do (
        if /i not "%%~xI"==".msi" (
            echo The specified file is not an MSI file. Please try again.
            goto input_msi
        )
    )
)

:input_output
set /p "output_directory=Enter the path to the output directory: "
if not exist "!output_directory!" (
    mkdir "!output_directory!" 2> nul
    if errorlevel 1 (
        echo Failed to create the output directory. Please try again.
        goto input_output
    )
)

msiexec /a "!msi_file_path!" /qb TARGETDIR="!output_directory!"
if errorlevel 1 (
    echo An error occurred during the extraction. Please check the input and try again.
) else (
    echo Extraction complete. Files have been extracted to "!output_directory!"
)
pause
