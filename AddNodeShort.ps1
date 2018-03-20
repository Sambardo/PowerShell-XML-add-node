$pathToConfig = "$PSScriptRoot\DistributedCacheService.exe.config" #put your path here

#force the config into an XML
$xml = [xml](get-content $pathToConfig)

#build new node by hand and force it to be an XML object
[xml]$newNode = @"
<appSettings>
    <add key="backgroundGC" value="true"/>
</appSettings>
"@

#add new node AFTER the configsections node
$xml.configuration.InsertAfter($xml.ImportNode($newNode.appSettings, $true), $xml.configuration.configsections) | out-null

#save file
$xml.Save($pathToConfig)