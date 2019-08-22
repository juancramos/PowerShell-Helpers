$filePathToTask = "{SOME_SYSTEM_PATH}/strings.xml"
$xml = New-Object XML
$xml.Load($filePathToTask)
$element = $xml.SelectSingleNode("descendant::string[@name='{SOME_SERVER_NAME_KEY}']")
$element.InnerText = "{https://someserver.com}"
$element = $xml.SelectSingleNode("descendant::string[@name='{SOME_KEY_API_KEY}']")
$element.InnerText = "{XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX}"
$xml.Save($filePathToTask)