$pathToConfig = "$PSScriptRoot\DistributedCacheService.exe.config" #put your path here
 
#force the config into an XML
$xml = [xml](get-content $pathToConfig)
 
#find the node to insert after
$foundNode = $xml.configuration.configsections
 
#build new node by hand and force it to be an XML object
$newNode = [xml]@"
<appSettings>
    <add key="backgroundGC" value="true"/>
</appSettings>
"@
 
#add new node AFTER the configsections node
$newNode = $xml.ImportNode($newNode.appSettings,$true) 
$xml.configuration.InsertAfter($newNode,$foundNode) |out-null
 
#save file
$xml.Save("$pathToConfig.CHANGED.XML")