$psISE.Options.FontName = "Hack"

. 'C:\tools\poshgit\dahlbyk-posh-git-fadc4dd\profile.example.ps1'

#docker-machine env --shell=powershell dmlocal | iex
$Env:DOCKER_TLS_VERIFY = "1"
$Env:DOCKER_HOST = "tcp://192.168.137.28:2376"
$Env:DOCKER_CERT_PATH = "C:\Users\kevin\.docker\machine\machines\dmlocal"
$Env:DOCKER_MACHINE_NAME = "dmlocal"

# Enable ANSI
Add-Type -MemberDefinition @"
[DllImport("kernel32.dll", SetLastError=true)]
public static extern bool SetConsoleMode(IntPtr hConsoleHandle, int mode);
[DllImport("kernel32.dll", SetLastError=true)]
public static extern IntPtr GetStdHandle(int handle);
[DllImport("kernel32.dll", SetLastError=true)]
public static extern bool GetConsoleMode(IntPtr handle, out int mode);
"@ -namespace win32 -name nativemethods

$h = [win32.nativemethods]::getstdhandle(-11) #  stdout
$m = 0
$success = [win32.nativemethods]::getconsolemode($h, [ref]$m)
$m = $m -bor 4 # undocumented flag to enable ansi/vt100
$success = [win32.nativemethods]::setconsolemode($h, $m)

cd C:\Users\Kevin\Source\Repos
& ssh-add C:\Users\kevin\.ssh\bitbucket_rsa

function ssh { Start-Process ssh $args }
function vim { Start-Process vim $args }
