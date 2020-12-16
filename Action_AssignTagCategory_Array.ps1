<#
Action escrita em PowerShell para configurar array de TAGss na VM. A tag é criada se ela não existir.
A categoria também é criada se não existir.
Variaveis de entrada:
vmName - string
category - string Array
tagName -string Array
vcuser - string
vcpassword - string
vcenter - string

Observação: O script foi aproveitado e ajustado a partir desse KB: https://kb.vmware.com/s/article/2149731
#>

function Handler($context, $inputs) {
    $inputsString = $inputs | ConvertTo-Json -Compress
    Write-Host "Inputs were $inputsString"
    
#VARIAVEIS

    $vcenter = $inputs.vcenter
    $vcuser = $inputs.vcuser
    $vcpassword = $inputs.vcpassword 
    $vmName = $inputs.vmName
    $categoryName = $inputs.category
    $tagName = $inputs.tagName

# DEBUG
    Write-Host "vCenter: " $vcenter
#    Write-Host "Categoria: " $categoryName[0]
#    Write-Host "Tag: " $tagName[0]
    Write-Host "Variavel vmName: " $vmName


#CONNECT POWERCLI TO VCENTER
    Set-PowerCLIConfiguration -InvalidCertificateAction Ignore -Confirm:$false
    Connect-VIServer -Server $vcenter -User $vcuser -Password $vcpassword

#POWERCLI SCRIPT

Write-Host "Quantidade de Tags: " $tagName.Length

For ($i=0; $i -lt $tagName.Length; $i++){
        Write-Host "Categoria: " $categoryName[$i]
        Write-Host "Tag: " $tagName[$i]


    try{
        $categoryObject = Get-TagCategory -Name $categoryName[$i] -ErrorAction Stop
       } 
       
    catch {
        Write-Host "Erro ao encontar a categoria. Criando nova categoria..."
        New-TagCategory -Name $categoryName[$i] -Description 'Categoria criada pelo vRO'
        $categoryObject = Get-TagCategory -Name $categoryName[$i]
       }

    try{
        $tagObject = Get-Tag -Name $tagName[$i] -ErrorAction Stop
       } 
    
    catch {
        Write-Host "Erro ao encontar a Tag. Criando nova tag..."
        $categoryObject = Get-TagCategory -Name $categoryName[$i]
        New-Tag -Name $tagName[$i] -Category $categoryObject -Description 'Tag criada pelo vRO'
       }

    try{
        $tagObject = Get-Tag -Name $tagName[$i] -ErrorAction Stop
        Get-VM -Name $vmName | New-TagAssignment -Tag $tagObject
       } 
    
    catch {
        Write-Host "Erro ao configurar a Tag!"

       }



}

}
    $output=@{status = 'done'}

    return $output