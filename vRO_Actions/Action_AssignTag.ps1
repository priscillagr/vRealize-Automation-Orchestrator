<#
Action escrita em PowerShell para criar Tags e configurar nas VMs.
Variaveis de entrada:
vmName - string
category - string
tagName -string
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
    Write-Host "Atributo: " $categoryName
    Write-Host "Tag: " $tagName
    Write-Host "Variavel vmName: " $vmName


#CONNECT POWERCLI TO VCENTER
    Set-PowerCLIConfiguration -InvalidCertificateAction Ignore -Confirm:$false
    Connect-VIServer -Server $vcenter -User $vcuser -Password $vcpassword

#POWERCLI SCRIPT
    try{
        $tagObject = Get-Tag -Name $tagName -ErrorAction Stop
        Get-VM -Name $vmName | New-TagAssignment -Tag $tagObject
       } catch {
             Write-Host "Erro ao encontar a Tag. Criando nova tag..."
             $categoryObject = Get-TagCategory -Name $categoryName
             New-Tag -Name $tagName -Category $categoryObject -Description 'Criado pelo vRO'
             Write-Host "Nova tag criada. Adicionando na VM..."
               } try {
                    $tagObject = Get-Tag -Name $tagName
                    Get-VM -Name $vmName | New-TagAssignment -Tag $tagObject
                     } catch {
             Write-Host "Erro. Verifique se a categoria existe no vCenter."
           }

    $output=@{status = 'done'}

    return $output
}