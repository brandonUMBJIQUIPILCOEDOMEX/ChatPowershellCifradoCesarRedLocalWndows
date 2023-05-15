function cezzar($action, [int]$dezplaza, $mensg) {

  
   #Write-Host "Cifrado Cessar Powershell"


   # $EType = read-host "Digita 'e' para Encriptar o Digita 'd' para Desencriptar"
   # $EType = "e"
   $EType = $action




   # numero de dezplzamiento
   # [int]$key = read-host "Cree la clave de cambio de cifrado César, ingrese un número del 1 al 26"
   # [int]$key = 4

   [int]$key = $dezplaza


   # mensaje a encriptar

   # $msg = read-host "Ingrese el mensaje"
   $msg = $mensg

   Write-Host "-------------------------------------------------" 






   #Encryption
   if ($EType -eq "e") {

      Write-Host "PlainText Message: " $msg -foregroundcolor "green" #Hide

      $String = [char[]]$msg


     
      
      $acum=""

      foreach ($letter in $String) { #Hide (the foreeach cmd)
         $nbr = [int[]][char]$letter
         #Write-Host $nbr -foregroundcolor "green"
         $acum=$nbr+$acum

      }
      #Write-Host $acum -foregroundcolor "green"

      Write-Host "PlainText Letter ASCII Values" -foregroundcolor "green" $acum #Hide


      

      $String = [char[]]$msg
      $acum2=""
      foreach ($letter in $String) {
         

         $nbr = [int[]][char]$letter
     
         If ($nbr -ge 0 -and $nbr -le 64) { #ASCII Codes
            [string]$Snbr = $nbr
            [int]$Nnbr = $Snbr  
            [int]$Enbr = $Nnbr 
            #Write-Host $Enbr -foregroundcolor "red" #Hide
            $acum2=$acum2+$Enbr.ToString()+" "
            [string]$ELetter = [char]$Enbr
         }
   
         If ($nbr -ge 65 -and $nbr -le 90) { #Alphabet UpperCase
            [string]$Snbr = $nbr
            [int]$Nnbr = $Snbr 
            [int]$nkey = $key
            [int]$Enbr = $Nnbr + $nkey 
            If ($Enbr -gt 90) { $Enbr = $Enbr - 26 }
            If ($Enbr -lt 65) { $Enbr = $Enbr + 26 }
            #Write-Host $Enbr -foregroundcolor "red" #Hide
            $acum2=$acum2+$Enbr.ToString()+" "
            [string]$ELetter = [char]$Enbr
            #Write-Host "Lowercase " + $ELetter        
         } 
   
         If ($nbr -ge 91 -and $nbr -le 96) { #ASCII Codes
            [string]$Snbr = $nbr
            [int]$Nnbr = $Snbr  
            [int]$Enbr = $Nnbr 
            #Write-Host $Enbr -foregroundcolor "red"
            $acum2=$acum2+$Enbr.ToString()+" "
            [string]$ELetter = [char]$Enbr
         }
   
         If ($nbr -ge 97 -and $nbr -le 122) { #Alphabet Lowercase
            [string]$Snbr = $nbr
            [int]$Nnbr = $Snbr 
            [int]$nkey = $key
            [int]$Enbr = $Nnbr + $nkey 
            If ($Enbr -gt 122) { $Enbr = $Enbr - 26 }
            If ($Enbr -lt 97) { $Enbr = $Enbr + 26 }
            #Write-Host $Enbr -foregroundcolor "red" #Hide
            $acum2=$acum2+$Enbr.ToString()+" "
            [string]$ELetter = [char]$Enbr
            #Write-Host "Lowercase " + $ELetter        
         }
        
         If ($nbr -ge 123 -and $nbr -le 127) { #ASCII Codes
            [string]$Snbr = $nbr
            [int]$Nnbr = $Snbr  
            [int]$Enbr = $Nnbr 
            #Write-Host $Enbr -foregroundcolor "red" #Hide
            $acum2=$acum2+$Enbr.ToString()+" "
            [string]$ELetter = [char]$Enbr
         }    

         $EMsg = $EMsg + $ELetter 
        
    
      } 
      Write-Host "Encrypted Text Letter ASCII Values"  -foregroundcolor "red" $acum2 #Hide
     # Write-Host $acum2 -foregroundcolor "red"
      Write-Host "Encrypted Text: " $EMsg -foregroundcolor "red" 
      #Clear-variable EMsg
      Write-Host "-------------------------------------------------" 

      return $EMsg
      Write-Host "$EMsg"

   }
  
   #Decrypt
   if ($EType -eq "d") {

      Write-Host "Encrypted Message: " $msg -foregroundcolor "red"

      $String = [char[]]$msg

       #Hide

      $acum=""
      foreach ($letter in $String) { #Hide (the foreeach cmd)
         $nbr = [int[]][char]$letter
         #Write-Host $nbr -foregroundcolor "red"
         $acum=$nbr+$acum

      }
      Write-Host "Encrypted Text Letter ASCII Values" -foregroundcolor "red" $acum


      

      $String = [char[]]$msg
      $acum3=""
      foreach ($letter in $String) {
         $nbr = [int[]][char]$letter
   
         If ($nbr -ge 0 -and $nbr -le 64) { #ASCII Codes
            [string]$Snbr = $nbr
            [int]$Nnbr = $Snbr  
            [int]$Enbr = $Nnbr 
            #Write-Host $Enbr -foregroundcolor "green"#Hide
            $acum3=$acum3+$Enbr.ToString()+" "
            [string]$ELetter = [char]$Enbr
         }
  
         If ($nbr -ge 65 -and $nbr -le 90) { #Alphabet UpperCase
            [string]$Snbr = $nbr
            [int]$Nnbr = $Snbr 
            [int]$nkey = $key
            [int]$Enbr = $Nnbr - $nkey 
            If ($Enbr -gt 90) { $Enbr = $Enbr - 26 }
            If ($Enbr -lt 65) { $Enbr = $Enbr + 26 }
            #Write-Host $Enbr -foregroundcolor "green" #Hide
            $acum3=$acum3+$Enbr.ToString()+" "
            [string]$ELetter = [char]$Enbr
            #Write-Host "Lowercase " + $ELetter        
         }  
   
         If ($nbr -ge 91 -and $nbr -le 96) { #ASCII Codes
            [string]$Snbr = $nbr
            [int]$Nnbr = $Snbr  
            [int]$Enbr = $Nnbr 
            #Write-Host $Enbr -foregroundcolor "green"
            $acum3=$acum3+$Enbr.ToString()+" "
            [string]$ELetter = [char]$Enbr
         }
          
         If ($nbr -ge 97 -and $nbr -le 122) { #Alphabet LowerCase
            [string]$Snbr = $nbr
            [int]$Nnbr = $Snbr 
            [int]$nkey = $key
            [int]$Enbr = $Nnbr - $nkey 
            If ($Enbr -gt 122) { $Enbr = $Enbr - 26 }
            If ($Enbr -lt 97) { $Enbr = $Enbr + 26 }
            #Write-Host $Enbr -foregroundcolor "green" #Hide
            $acum3=$acum3+$Enbr.ToString()+" "
            [string]$ELetter = [char]$Enbr       
         }    
     
         If ($nbr -ge 123 -and $nbr -le 127) { #ASCII Codes
            [string]$Snbr = $nbr
            [int]$Nnbr = $Snbr  
            [int]$Enbr = $Nnbr 
            #Write-Host $Enbr -foregroundcolor "green" #Hide
            $acum3=$acum3+$Enbr.ToString()+" "
            [string]$ELetter = [char]$Enbr
         }    

         $EMsg = $EMsg + $ELetter    
      } 
      Write-Host "PlainText Letter ASCII Values"  -foregroundcolor "green" $acum3 #Hide
      Write-Host "PlainText: " $EMsg -foregroundcolor "green"
      # texto encriptado


      #Clear-variable EMsg
      Write-Host "-------------------------------------------------"
   
      return $EMsg
      Write-Host "$EMsg"
   }
   
 

}



$msgE = cezzar "e" "4" "Hola a todos"
$msgD = cezzar "d" "4" $msgE

Write-Host  "$msgE -"
Write-Host  "$msgD -"


