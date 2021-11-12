$resourceGroupsToDelete = [System.Collections.ArrayList]::new();
[bool] $doNotDelete = $false

[System.Collections.ArrayList]$rgList = Get-AzResourceGroup -Tag @{'coral'='e2e'};

foreach ($resourceGroup in $rgList)
{
    $doNotDelete = $false;
    $name = $resourceGroup.ResourceGroupName;
    Write-Host "Examining $name for lock tag.";


    [System.Collections.ArrayList]$tags=$resourceGroup.Tags
    foreach($tag in $tags)
    {
        if ($tag.Name -eq 'lock'){
            $doNotDelete = $true;
            Write-Host "Found Lock tag, ignoring resource group $resourceGroup.ResourceGroupName";
        }
    }

    if($doNotDelete -eq $false)
    {
       $resourceGroupsToDelete.Add($resourceGroup.ResourceGroupName);
    }
}

foreach($resourceGroupName in $resourceGroupsToDelete)
{
    Write-Host "Deleting $resourceGroupName";
    #Remove-AzResourceGroup -Force -Name $resourceGroupName
}