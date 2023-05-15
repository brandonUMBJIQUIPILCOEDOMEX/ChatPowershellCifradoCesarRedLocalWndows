<#
To Do:
    * Graceful Exit of server while keeping console active
    * Better handling of message traffic
    * Message to client if at max connections    
#>

#Function to halt server and disconnect clients
[cmdletbinding()]
Param (
    [parameter()]
    [string]$EnableLogging # (Join-Path $pwd ChatLog.log)
)
If ($PSBoundParameters['EnableLogging']) {
    #Make global so it can be seen in event Action blocks
    $Global:EnableLogging = $EnableLogging
}
#Save previous prompt
$Global:old_Prompt = Get-Content Function:Prompt
#No Prompt
Function Global:Prompt { [char]8 }
Clear-Host
##Create Globally synchronized hash tables and queue to share across runspaces
#Used for initial connections
$Global:sharedData = [HashTable]::Synchronized(@{})
#Used for managing client connections
$Global:ClientConnections = [hashtable]::Synchronized(@{})
#Used for managing the queue of messages in an orderly fashion
$Global:MessageQueue = [System.Collections.Queue]::Synchronized((New-Object System.collections.queue))
#Used to manage incoming client messages
$Global:ClientHash = [HashTable]::Synchronized(@{})
#Removal Queue
$Global:RemoveQueue = [System.Collections.Queue]::Synchronized((New-Object System.collections.queue))
#Listener
$Global:Listener = [HashTable]::Synchronized(@{})

#Set up timer
$Timer = New-Object Timers.Timer
$timer.Enabled = $true
$Timer.Interval = 1000 
 
#Timer event to track client connections and remove disconnected clients
$NewConnectionTimer = Register-ObjectEvent -SourceIdentifier MonitorClientConnection -InputObject $Timer -EventName Elapsed -Action { 
    While ($RemoveQueue.count -ne 0) {    
        $user = $RemoveQueue.Dequeue()
        ##Close down the runspace
        $ClientConnections.$user.PowerShell.EndInvoke($ClientConnections.$user.Job)
        $ClientConnections.$user.PowerShell.Runspace.Close()
        $ClientConnections.$user.PowerShell.Dispose()          
        $ClientConnections.Remove($User)                          
        $Messagequeue.Enqueue("~D{0}" -f $user)   
    }   
}




  
   
  
 




#Timer event to track for new incoming connections and to kick off seperate jobs to track messages 
$NewConnectionTimer = Register-ObjectEvent -SourceIdentifier NewConnectionTimer -InputObject $Timer -EventName Elapsed -Action {
    If ($ClientHash.count -lt $SharedData.count) {
        $sharedData.GetEnumerator() | ForEach {
            If (-Not ($ClientHash.Contains($_.Name))) {
                #Spin off new job and add to ClientHash
                $ClientHash[$_.Name] = $_.Value               
                $User = $_.Name
                $Messagequeue.Enqueue(("~C{0}" -f $User))
                
                #Kick off a job to watch for messages from clients
                $newRunspace = [RunSpaceFactory]::CreateRunspace()
                $newRunspace.Open()
                $newRunspace.SessionStateProxy.setVariable("shareddata", $shareddata)
                $newRunspace.SessionStateProxy.setVariable("ClientHash", $ClientHash)
                $newRunspace.SessionStateProxy.setVariable("User", $user)
                $newRunspace.SessionStateProxy.setVariable("MessageQueue", $MessageQueue)               
                $newRunspace.SessionStateProxy.setVariable("RemoveQueue", $RemoveQueue)
                $newPowerShell = [PowerShell]::Create()
                $newPowerShell.Runspace = $newRunspace   
                $sb = {
                    #Code to kick off client connection monitor and look for incoming messages.
                    $client = $ClientHash.$user
                    $serverstream = $Client.GetStream()
                    #While client is connected to server, check for incoming traffic
                    While ($True) {                                              
                        [byte[]]$inStream = New-Object byte[] 200KB
                        $buffSize = $client.ReceiveBufferSize
                        $return = $serverstream.Read($inStream, 0, $buffSize)  
                        If ($return -gt 0) {
                            $Messagequeue.Enqueue([System.Text.Encoding]::ASCII.GetString($inStream[0..($return - 1)]))
                        }
                        Else {
                            $shareddata.Remove($User)
                            $clienthash.Remove($User)                   
                            $RemoveQueue.Enqueue($User)
                            Break
                        }
                    }
                }
                $job = "" | Select Job, PowerShell
                $job.PowerShell = $newPowerShell
                $Job.job = $newPowerShell.AddScript($sb).BeginInvoke()
                $ClientConnections.$User = $job                                             
            }
        }
    }
}

#Timer event to track for new incoming messages and broadcast message to all connected clients
$IncomingMessageTimer = Register-ObjectEvent -SourceIdentifier IncomingMessageTimer -InputObject $Timer -EventName Elapsed -Action {
    While ($MessageQueue.Count -ne 0) {
        $Message = $MessageQueue.dequeue() 
        Switch ($Message) {
            { $_.Startswith("~M") } {
                #Message
                $data = ($_).SubString(2)
                # imprime usuario y mensaaje
                Write-Host "data : $data"
                $split = $data -split ("{0}" -f "~~")
                Write-Host "split : $split"

                If ($split[1].startswith("@")) {
                    If ($split[1] -Match "(?<name>@\w+)(?<Message>.*)") {
                        $directMessage = $matches.name.Trim("@")
                        $tempmessage = $matches.Message.Trim(" ")
                        $message = ("~B{0}~~{1}" -f $split[0], $tempmessage)
                        

                    }
                }
                Else {
                    # 13/05/2023 12:49:17 a. m. >> brandon: lspe gsqs iwxer 

                    # desifra ceszar
                    $msgEncrip = $split[1]
                    $msgDecrip = ""
                    
                    Write-Host " despues del else : $msg"

                    
                    # cifrado cezsar inicio


                    #Write-Host "Cifrado Cessar Powershell"
 
 
                    # $EType = read-host "Digita 'e' para Encriptar o Digita 'd' para Desencriptar"
                    # 
                   
    
 
 
 
 
                    # numero de dezplzamiento
                    # [int]$key = read-host "Cree la clave de cambio de cifrado César, ingrese un número del 1 al 26"
                    # [int]$key = 4
 
                    [int]$key = $global:dezplazaCeszar
 
 
                    # mensaje a encriptar
 
                    # $msg = read-host "Ingrese el mensaje"
                    $msg = $msgEncrip

                  
 
                    #Write-Host "-------------------------------------------------" 
 
 
   
                    #Decrypt
                   
 
                        #Write-Host "Encrypted Message: " $msg -foregroundcolor "red"
 
                        $String = [char[]]$msg
 
                        #Hide
 
                        $acum = ""
                        foreach ($letter in $String) {
                            #Hide (the foreeach cmd)
                            $nbr = [int[]][char]$letter
                            #Write-Host $nbr -foregroundcolor "red"
                            $acum = $nbr + $acum
 
                        }
                        #Write-Host "Encrypted Text Letter ASCII Values" -foregroundcolor "red" $acum
 
 
       
 
                        $String = [char[]]$msg
                        $acum3 = ""
                        foreach ($letter in $String) {
                            $nbr = [int[]][char]$letter
    
                            If ($nbr -ge 0 -and $nbr -le 64) {
                                #ASCII Codes
                                [string]$Snbr = $nbr
                                [int]$Nnbr = $Snbr  
                                [int]$Enbr = $Nnbr 
                                #Write-Host $Enbr -foregroundcolor "green"#Hide
                                $acum3 = $acum3 + $Enbr.ToString() + " "
                                [string]$ELetter = [char]$Enbr
                            }
   
                            If ($nbr -ge 65 -and $nbr -le 90) {
                                #Alphabet UpperCase
                                [string]$Snbr = $nbr
                                [int]$Nnbr = $Snbr 
                                [int]$nkey = $key
                                [int]$Enbr = $Nnbr - $nkey 
                                If ($Enbr -gt 90) { $Enbr = $Enbr - 26 }
                                If ($Enbr -lt 65) { $Enbr = $Enbr + 26 }
                                #Write-Host $Enbr -foregroundcolor "green" #Hide
                                $acum3 = $acum3 + $Enbr.ToString() + " "
                                [string]$ELetter = [char]$Enbr
                                #Write-Host "Lowercase " + $ELetter        
                            }  
    
                            If ($nbr -ge 91 -and $nbr -le 96) {
                                #ASCII Codes
                                [string]$Snbr = $nbr
                                [int]$Nnbr = $Snbr  
                                [int]$Enbr = $Nnbr 
                                #Write-Host $Enbr -foregroundcolor "green"
                                $acum3 = $acum3 + $Enbr.ToString() + " "
                                [string]$ELetter = [char]$Enbr
                            }
           
                            If ($nbr -ge 97 -and $nbr -le 122) {
                                #Alphabet LowerCase
                                [string]$Snbr = $nbr
                                [int]$Nnbr = $Snbr 
                                [int]$nkey = $key
                                [int]$Enbr = $Nnbr - $nkey 
                                If ($Enbr -gt 122) { $Enbr = $Enbr - 26 }
                                If ($Enbr -lt 97) { $Enbr = $Enbr + 26 }
                                #Write-Host $Enbr -foregroundcolor "green" #Hide
                                $acum3 = $acum3 + $Enbr.ToString() + " "
                                [string]$ELetter = [char]$Enbr       
                            }    
      
                            If ($nbr -ge 123 -and $nbr -le 127) {
                                #ASCII Codes
                                [string]$Snbr = $nbr
                                [int]$Nnbr = $Snbr  
                                [int]$Enbr = $Nnbr 
                                #Write-Host $Enbr -foregroundcolor "green" #Hide
                                $acum3 = $acum3 + $Enbr.ToString() + " "
                                [string]$ELetter = [char]$Enbr
                            }    
 
                            $EMsg = $EMsg + $ELetter    
                        } 
                        # Write-Host "PlainText Letter ASCII Values"  -foregroundcolor "green" $acum3 #Hide
                        # Write-Host "PlainText: " $EMsg -foregroundcolor "green"
                        # texto encriptado
 
 
                        #Clear-variable EMsg
                        Write-Host "-------------------------------------------------"
    
                       
                        Write-Host " original: $EMsg"
                        $split[1] = $EMsg

                        Clear-variable EMsg

                    
    

                    # cifrado ceszar fin




                   # $Message = ("~M{0}~~{1}" -f $split[0], $split[1])

                    Write-Host ("{0} >> {1}: {2}" -f (Get-Date).ToString(), $split[0], $split[1])
                    Write-Host "Entro aqui 2"
                    If ($EnableLogging) {
                        $split[1] = $EMsg
                        Out-File -Inputobject ("{0} >> {1}: {2}" -f (Get-Date).ToString(), $split[0], $split[1]) -FilePath $EnableLogging -Append
                    }
                }
            }
            { $_.Startswith("~D") } {
                #Disconnect
                Write-Host ("{0} >> {1} has disconnected from the server" -f (Get-Date).ToString(), $_.SubString(2))
                If ($EnableLogging) {
                    Out-File -Inputobject ("{0} >> {1} has disconnected from the server" -f (Get-Date).ToString(), $_.SubString(2)) -FilePath $EnableLogging -Append
                }                
            }
            { $_.StartsWith("~C") } {
                #Connect
                Write-Host ("{0} >> {1} has connected to the server" -f (Get-Date).ToString(), $_.SubString(2))
                If ($EnableLogging) {
                    Out-File -Inputobject ("{0} >> {1} has connected to the server" -f (Get-Date).ToString(), $_.SubString(2)) -FilePath $EnableLogging -Append
                }                              
            }
            { $_.StartsWith("~S") } {
                #Server Shutdown
                Write-Host ("{0} >> Server has shutdown." -f (Get-Date).ToString())
                If ($EnableLogging) {
                    Out-File -Inputobject ("{0} >> Server has shutdown." -f (Get-Date).ToString()) -FilePath $EnableLogging -Append
                }                              
            }            
            Default {
                Write-Host ("{0} >> {1}" -f (Get-Date).ToString(), $_)
                Write-Host "Entro aqui 1"
                If ($EnableLogging) {
                    Out-File -Inputobject ("{0} >> {1}" -f (Get-Date).ToString(), $_) -FilePath $EnableLogging -Append
                }                  
            }
        }        
        #Broadcast message
        If ($directMessage) {
            $Broadcast = $Clienthash[$directMessage]
            $broadcastStream = $broadcast.GetStream()
            $string = $Message
            $broadcastbyte = ([text.encoding]::ASCII).GetBytes($string)
            Write-Host "Entro aqui 5"
            $broadcastStream.Write($broadcastbyte, 0, $broadcastbyte.Length)
            $broadcastStream.Flush()         
            Remove-Variable directMessage -ErrorAction SilentlyContinue
        }
        Else {
            $Clienthash.GetEnumerator() | ForEach {
                $Broadcast = $Clienthash[$_.Name]
                $broadcastStream = $broadcast.GetStream()
                $string = $Message
                $broadcastbyte = ([text.encoding]::ASCII).GetBytes($string)
                Write-Host "Entro aqui 6"
                Write-Host "String: $string"


                $broadcastStream.Write($broadcastbyte, 0, $broadcastbyte.Length)
                $broadcastStream.Flush()            
            }
        }
    }
}

$Timer.Start()

#Initial runspace creation to set up server listener 
$Global:newRunspace = [RunSpaceFactory]::CreateRunspace()
$newRunspace.Open()
$newRunspace.SessionStateProxy.setVariable("sharedData", $sharedData)
$newRunspace.SessionStateProxy.setVariable("Listener", $Listener)
$newRunspace.SessionStateProxy.setVariable("EnableLogging", $EnableLogging)
$Global:newPowerShell = [PowerShell]::Create()
$newPowerShell.Runspace = $newRunspace
Write-Host "-------------------------------------------------" 
Write-Host "Cifrado Cessar Powershell"
Write-Host "-------------------------------------------------" 

[int]$global:dezplazaCeszar = read-host "Cree la clave de cambio de cifrado Ceszar, ingrese un número del 1 al 26"
$sb = {
    
    $Listener['listener'] = [System.Net.Sockets.TcpListener]15600
    $Listener['listener'].Start()
    [console]::WriteLine("{0} >> Server Started on port 15600" -f (Get-Date).ToString())
    If ($EnableLogging) {
    
        Write-Verbose ('Logging to file')
        Out-File -Inputobject ("{0} >> Server Started on port 15600" -f (Get-Date).ToString()) -FilePath $EnableLogging
    } 
    while ($true) {
        [byte[]]$byte = New-Object byte[] 5KB
        $client = $Listener['listener'].AcceptTcpClient()
        If ($client -ne $Null) {
            $stream = $client.GetStream()
            Do {
                #Write-Host 'Processing Data'
                Write-Verbose ("Bytes Left: {0}" -f $Client.Available)
                $Return = $stream.Read($byte, 0, $byte.Length)
                $String += [text.Encoding]::Ascii.GetString($byte[0..($Return - 1)])
           
            } While ($stream.DataAvailable)
            If ($SharedData.Count -lt 30) { 
                $SharedData[$String] = $client           
                #Send list of online users to client
                $users = ("~Z{0}" -f ($shareddata.Keys -join "~~"))
                $broadcastStream = $client.GetStream()
                $broadcastbyte = ([text.encoding]::ASCII).GetBytes($users)
                $broadcastStream.Write($broadcastbyte, 0, $broadcastbyte.Length)
                Write-Host "Entro aqui 7"
                Write-Host "$broadcastbyte"
                $broadcastStream.Flush()             
                $String = $Null
            }
            Else {
                #Too many clients, refuse connection
            }
        }
        Else {
            #Connection to server closed
            Break
        }
    }#End While
}
$Global:handle = $newPowerShell.AddScript($sb).BeginInvoke()
