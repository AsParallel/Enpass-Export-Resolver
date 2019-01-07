param(
    [Parameter(position=0)]
    [string]$path,
    [Parameter(position=1)]
    [ValidateSet("login","note","license")]
    [string]$cmd
)

ipmo ./convert-password-util.ps1

$data = cat $path | ConvertFrom-Json;
switch ($cmd) {
        "note" { return getNote $data }
        "license" {return getLicense $data}
        "login" { return getLogin $data }
}
