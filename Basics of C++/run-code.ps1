param(
    [Parameter(Mandatory=$true)]
    [string]$File
)

$File = (Resolve-Path $File).Path

$extension = [System.IO.Path]::GetExtension($File).ToLower()
$directory = Split-Path $File
$fileName = [System.IO.Path]::GetFileNameWithoutExtension($File)

$input = Join-Path $directory "input.txt"
$output = Join-Path $directory "output.txt"

Write-Host ""
Write-Host "========================================"
Write-Host "File: $File"
Write-Host "Language: $extension"
Write-Host "========================================"

switch ($extension) {

    ".cpp" {
        $exe = Join-Path $directory "$fileName.exe"

        Write-Host "Compiling C++..."

        g++ -std=c++17 $File -o $exe

        if ($LASTEXITCODE -ne 0) {
            Write-Host "Compilation failed." -ForegroundColor Red
            exit $LASTEXITCODE
        }

        Get-Content $input | & $exe | Out-File $output -Encoding utf8
    }

    ".cc" {
        $exe = Join-Path $directory "$fileName.exe"

        g++ -std=c++17 $File -o $exe

        if ($LASTEXITCODE -ne 0) {
            exit $LASTEXITCODE
        }

        Get-Content $input | & $exe | Out-File $output -Encoding utf8
    }

    ".c" {
        $exe = Join-Path $directory "$fileName.exe"

        Write-Host "Compiling C..."

        gcc $File -o $exe

        if ($LASTEXITCODE -ne 0) {
            exit $LASTEXITCODE
        }

        Get-Content $input | & $exe | Out-File $output -Encoding utf8
    }

    ".java" {
        Write-Host "Compiling Java..."

        javac $File

        if ($LASTEXITCODE -ne 0) {
            exit $LASTEXITCODE
        }

        Get-Content $input |
            java -cp $directory $fileName |
            Out-File $output -Encoding utf8
    }

    ".py" {
        Write-Host "Running Python..."

        Get-Content $input |
            python $File |
            Out-File $output -Encoding utf8
    }

    ".js" {
        Write-Host "Running JavaScript..."

        Get-Content $input |
            node $File |
            Out-File $output -Encoding utf8
    }

    ".ts" {
        Write-Host "Running TypeScript..."

        Get-Content $input |
            npx tsx $File |
            Out-File $output -Encoding utf8
    }

    ".go" {
        Write-Host "Running Go..."

        Get-Content $input |
            go run $File |
            Out-File $output -Encoding utf8
    }

    ".rs" {
        $exe = Join-Path $directory "$fileName.exe"

        Write-Host "Compiling Rust..."

        rustc $File -o $exe

        if ($LASTEXITCODE -ne 0) {
            exit $LASTEXITCODE
        }

        Get-Content $input |
            & $exe |
            Out-File $output -Encoding utf8
    }

    ".php" {
        Write-Host "Running PHP..."

        Get-Content $input |
            php $File |
            Out-File $output -Encoding utf8
    }

    ".rb" {
        Write-Host "Running Ruby..."

        Get-Content $input |
            ruby $File |
            Out-File $output -Encoding utf8
    }

    default {
        Write-Host ""
        Write-Host "Unsupported language: $extension" -ForegroundColor Red
        exit 1
    }
}

Write-Host ""
Write-Host "========================================"
Write-Host "DONE"
Write-Host "Output: $output"
Write-Host "========================================"