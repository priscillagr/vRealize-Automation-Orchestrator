/*
Action escrita em PowerShell para criar Tags e configurar nas VMs.

*/

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

#CONNECT POWERCLI TO VCENTER
    Set-PowerCLIConfiguration -InvalidCertificateAction Ignore -Confirm:$false
    Connect-VIServer -Server $vcenter -User $vcuser -Password $vcpassword

#POWERCLI SCRIPT

    try{
        $tagObject = Get-Tag -Name $tagName[0] -ErrorAction Stop
        Get-VM -Name $vmName | New-TagAssignment -Tag $tagObject
         } catch {
             Write-Host "Erro ao encontar a Tag. Criando nova tag..."
             $categoryObject = Get-TagCategory -Name $categoryName[0]
             New-Tag -Name $tagName[0] -Category $categoryObject -Description 'Criado pelo vRO'
             Write-Host "Nova tag criada. Adicionando na VM..."

         } try {
             $tagObject = Get-Tag -Name $tagName[0]
              Get-VM -Name $vmName | New-TagAssignment -Tag $tagObject
             } catch {
             Write-Host "Erro. Verifique se a categoria existe no vCenter."
    }


# DEBUG

    Write-Host "vCenter: " $vcenter
    Write-Host "Atributo: " $categoryName[1]
    Write-Host "Tag: " $tagName[1]
    Write-Host "Variavel vmName: " $vmName



    ##$result = 
    ##Write-Host $result.ScriptOutput
    $output=@{status = 'done'}

    return $output
}