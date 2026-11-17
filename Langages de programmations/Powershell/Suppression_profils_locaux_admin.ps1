<#
Description : Ce script permet de supprimer les profils locaux
Usage : Ce script permet de supprimer les autres adm-* connecté sur le poste
Auteur : 
Version : 1.0
Révision : 
#>

# Fonction qui permet une remontée dans un fichier de log 
function Add-ToLogFile($texteAAjouter) {

    $dateAction = Get-Date -Format "yyyyMMdd HH:mm:ss"
    Add-Content -Value $dateAction" -- "$texteAAjouter -Path "C:\Scripts\log_suppression_profils_locaux.txt"

}

do {
# Récupération des profils utilisateurs sur le poste 
$profils_locaux = Get-CimInstance -ClassName Win32_UserProfile | Where-Object { $_.LocalPath -match "adm-" -and $_.Special -eq $false -and $_.Loaded -eq $false } | Select-Object -Property LocalPath 

# Export de ces profils dans un fichier csv
$fichier_csv = $profils_locaux | Export-Csv -Path "C:\Scripts\profils_locaux_$((Get-Date).ToString('dd-MM-yyyy')).csv" -Encoding UTF8

# Importation du fichier csv pour une utilisation ultérieure
$profils_importes = Import-Csv -Path "C:\Scripts\profils_locaux_$((Get-Date).ToString('dd-MM-yyyy')).csv" -Encoding UTF8

# Extraction des noms d'utilisateurs
$profils_importes = $profils_importes | ForEach-Object {
    $_.LocalPath = ($_.LocalPath -split '\\')[-1]
    $_
}

# Mise en place de la boite de dialogue avec menu déroulant
# Chargement des bibliothèques nécessaires pour créer des interfaces graphiques avec PowerShell
Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

# Création de la fenètre qui va accueillir les boutons OK et annuler ainsi que le menu déroulant
$form = New-Object System.Windows.Forms.Form
$form.Text = 'Selectionnez un profil à supprimer'
$form.Size = New-Object System.Drawing.Size(400,200)
$form.StartPosition = 'CenterScreen'

# Création du bouton OK
$BoutonOk = New-Object System.Windows.Forms.Button
$BoutonOk.Location = New-Object System.Drawing.Point(75,120)
$BoutonOk.Size = New-Object System.Drawing.Size(75,23)
$BoutonOk.Text = 'OK'
$BoutonOk.DialogResult = [System.Windows.Forms.DialogResult]::OK
$form.AcceptButton = $BoutonOk
$form.Controls.Add($BoutonOk)

# Création du bouton Annuler
$BoutonAnnuler = New-Object System.Windows.Forms.Button
$BoutonAnnuler.Location = New-Object System.Drawing.Point(150,120)
$BoutonAnnuler.Size = New-Object System.Drawing.Size(75,23)
$BoutonAnnuler.Text = 'Annuler'
$BoutonAnnuler.DialogResult = [System.Windows.Forms.DialogResult]::Cancel
$form.CancelButton = $BoutonAnnuler
$form.Controls.Add($BoutonAnnuler)

# Création du label qui permet d'afficher un texte d'instruction
$label = New-Object System.Windows.Forms.Label
$label.Location = New-Object System.Drawing.Point(10,20)
$label.Size = New-Object System.Drawing.Size(280,20)
$label.Text = 'Merci de selectionner un profil à supprimer:'
$form.Controls.Add($label)

# Création du menu déroulant
$listBox = New-Object System.Windows.Forms.ListBox
$listBox.Location = New-Object System.Drawing.Point(10,40)
$listBox.Size = New-Object System.Drawing.Size(260,20)
$listBox.Height = 80

# Mise en place d'une boucle foreach pour ajouter les noms des profils utilisateurs à ajouter dans la liste déroulante
# Attention à bien mettre le [string] 
foreach ($profils in $profils_importes) {
$profil = [string]$profils.Localpath
[void] $listBox.Items.Add("$profil")
}

# Affichage du formulaire : Topmost => définit le formulaire comme étant toujours au-dessus des autres fenêtres.
#                           SowDialog => Affiche le formulaire en mode dialogue
$form.Controls.Add($listBox)
$form.Topmost = $true


    # Affichage du formulaire   
    $result = $form.ShowDialog()

    # Vérifie si le bouton OK a été selectionné.
    # SelectedItem : Récupère l'élément sélectionné dans la liste.
    if ($result -eq [System.Windows.Forms.DialogResult]::OK)
    {
    $profil_utilisateur_selectionne = $listBox.SelectedItem
    Get-CimInstance -ClassName Win32_UserProfile | Where-Object { $_.LocalPath -match "$profil_utilisateur_selectionne" -and $_.Special -eq $false -and $_.Loaded -eq $false } | Remove-CimInstance -ErrorAction Stop
    Add-ToLogFile ("L'utilisateur $profil_utilisateur_selectionne a bien été supprimé")
    }
}
# Vérifie si le bouton Annuler a été sélectionné.
until ($result -eq [System.Windows.Forms.DialogResult]::Cancel){
exit
}