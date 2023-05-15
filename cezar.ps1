Write-Host "Cifrado Cessar Powershell"

$EType = read-host "Digita 'e' para Encriptar o Digita 'd' para Desencriptar"
[int]$key = read-host "Cree la clave de cambio de cifrado César, ingrese un número del 1 al 26"
$msg = read-host "Ingrese el mensaje"
Write-Host "-------------------------------------------------" 

#Encryption
if ($EType -eq "e")
{

Write-Host "PlainText Message: " $msg -foregroundcolor "green" #Hide

$String=[char[]]$msg


Write-Host "PlainText Letter ASCII Values" -foregroundcolor "green" #Hide


foreach ($letter in $String) #Hide (the foreeach cmd)
{
    $nbr = [int[]][char]$letter
    Write-Host $nbr -foregroundcolor "green"
}


Write-Host "Encrypted Text Letter ASCII Values"  -foregroundcolor "red" #Hide

$String=[char[]]$msg
foreach ($letter in $String)
{
    $nbr = [int[]][char]$letter
     
    If ($nbr -ge 0 -and $nbr -le 64) #ASCII Codes
       {
       [string]$Snbr = $nbr
       [int]$Nnbr = $Snbr  
       [int]$Enbr = $Nnbr 
       Write-Host $Enbr -foregroundcolor "red" #Hide
       [string]$ELetter = [char]$Enbr
       }
   
    If ($nbr -ge 65 -and $nbr -le 90) #Alphabet UpperCase
       {
       [string]$Snbr = $nbr
       [int]$Nnbr = $Snbr 
       [int]$nkey = $key
       [int]$Enbr = $Nnbr + $nkey 
       If ($Enbr -gt 90) {$Enbr = $Enbr - 26}
       If ($Enbr -lt 65) {$Enbr = $Enbr + 26}
       Write-Host $Enbr -foregroundcolor "red" #Hide
       [string]$ELetter = [char]$Enbr
       #Write-Host "Lowercase " + $ELetter        
       } 
   
    If ($nbr -ge 91 -and $nbr -le 96) #ASCII Codes
       {
       [string]$Snbr = $nbr
       [int]$Nnbr = $Snbr  
       [int]$Enbr = $Nnbr 
       Write-Host $Enbr -foregroundcolor "red"
       [string]$ELetter = [char]$Enbr
       }
   
    If ($nbr -ge 97 -and $nbr -le 122) #Alphabet Lowercase
       {
       [string]$Snbr = $nbr
       [int]$Nnbr = $Snbr 
       [int]$nkey = $key
       [int]$Enbr = $Nnbr + $nkey 
       If($Enbr -gt 122) {$Enbr = $Enbr - 26}
       If  ($Enbr -lt 97) {$Enbr = $Enbr + 26}
       Write-Host $Enbr -foregroundcolor "red" #Hide
       [string]$ELetter = [char]$Enbr
       #Write-Host "Lowercase " + $ELetter        
       }
        
     If ($nbr -ge 123 -and $nbr -le 127) #ASCII Codes
        {
        [string]$Snbr = $nbr
        [int]$Nnbr = $Snbr  
        [int]$Enbr = $Nnbr 
        Write-Host $Enbr -foregroundcolor "red" #Hide
        [string]$ELetter = [char]$Enbr
        }    

$EMsg = $EMsg + $ELetter 
    
} 
Write-Host "Encrypted Text: " $EMsg -foregroundcolor "red"
Clear-variable EMsg
Write-Host "-------------------------------------------------" 
}
  
#Decrypt
if ($EType -eq "d")
{

Write-Host "Encrypted Message: " $msg -foregroundcolor "red"

$String=[char[]]$msg

Write-Host "Encrypted Text Letter ASCII Values" -foregroundcolor "red" #Hide

foreach ($letter in $String) #Hide (the foreeach cmd)
{
    $nbr = [int[]][char]$letter
    Write-Host $nbr -foregroundcolor "red"
}

Write-Host "PlainText Letter ASCII Values"  -foregroundcolor "green" #Hide

$String=[char[]]$msg
foreach ($letter in $String)
{
    $nbr = [int[]][char]$letter
   
    If ($nbr -ge 0 -and $nbr -le 64) #ASCII Codes
       {
       [string]$Snbr = $nbr
       [int]$Nnbr = $Snbr  
       [int]$Enbr = $Nnbr 
       Write-Host $Enbr -foregroundcolor "green"#Hide
       [string]$ELetter = [char]$Enbr
       }
  
    If ($nbr -ge 65 -and $nbr -le 90) #Alphabet UpperCase
       {
       [string]$Snbr = $nbr
       [int]$Nnbr = $Snbr 
       [int]$nkey = $key
       [int]$Enbr = $Nnbr - $nkey 
       If ($Enbr -gt 90) {$Enbr = $Enbr - 26}
       If ($Enbr -lt 65) {$Enbr = $Enbr + 26}
       Write-Host $Enbr -foregroundcolor "green" #Hide
       [string]$ELetter = [char]$Enbr
       #Write-Host "Lowercase " + $ELetter        
       }  
   
    If ($nbr -ge 91 -and $nbr -le 96) #ASCII Codes
       {
       [string]$Snbr = $nbr
       [int]$Nnbr = $Snbr  
       [int]$Enbr = $Nnbr 
       Write-Host $Enbr -foregroundcolor "green"
       [string]$ELetter = [char]$Enbr
       }
          
    If ($nbr -ge 97 -and $nbr -le 122) #Alphabet LowerCase
       {
       [string]$Snbr = $nbr
       [int]$Nnbr = $Snbr 
       [int]$nkey = $key
       [int]$Enbr = $Nnbr - $nkey 
       If($Enbr -gt 122) {$Enbr = $Enbr - 26}
       If  ($Enbr -lt 97) {$Enbr = $Enbr + 26}
       Write-Host $Enbr -foregroundcolor "green" #Hide
       [string]$ELetter = [char]$Enbr       
       }    
     
    If ($nbr -ge 123 -and $nbr -le 127) #ASCII Codes
       {
       [string]$Snbr = $nbr
       [int]$Nnbr = $Snbr  
       [int]$Enbr = $Nnbr 
       Write-Host $Enbr -foregroundcolor "green" #Hide
       [string]$ELetter = [char]$Enbr
       }    

$EMsg = $EMsg + $ELetter    
} 
Write-Host "PlainText: " $EMsg -foregroundcolor "green"
Clear-variable EMsg
Write-Host "-------------------------------------------------"
}