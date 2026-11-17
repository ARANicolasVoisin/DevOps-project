<#
Description : Ce script permet de récuupérer le mot de passe laps administrateur
Usage : Permet de rentrer plusieurs poste et de récupérer le mot de passe admin local
Auteur : 
Version : 1.0
Révision : 

#>

#########################################
# Mise en place de la boite de dialogue #
#########################################

# Chargement des bibliothèques nécessaires pour créer des interfaces graphiques avec PowerShell
Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

# Création de la fenètre qui va accueillir les boutons OK et annuler ainsi que le menu
$form = New-Object System.Windows.Forms.Form
$form.Text = 'Mot de passe Administrateur'
$form.Size = New-Object System.Drawing.Size(350,200)
$form.StartPosition = 'CenterScreen'
# Changement de couleur de la fenêtre
$form.BackColor = [System.Drawing.Color]::White

# Création du bouton OK
$BoutonOk = New-Object System.Windows.Forms.Button
$BoutonOk.Location = New-Object System.Drawing.Point(60,120)
$BoutonOk.Size = New-Object System.Drawing.Size(75,23)
$BoutonOk.Text = 'OK'
$BoutonOk.DialogResult = [System.Windows.Forms.DialogResult]::OK
$form.AcceptButton = $BoutonOk
$form.Controls.Add($BoutonOk)
# Changement de couleur du bouton OK
$BoutonOk.BackColor = [System.Drawing.Color]::LightGreen
$BoutonOk.ForeColor = [System.Drawing.Color]::Black

# Création du bouton Annuler
$BoutonAnnuler = New-Object System.Windows.Forms.Button
$BoutonAnnuler.Location = New-Object System.Drawing.Point(200,120)
$BoutonAnnuler.Size = New-Object System.Drawing.Size(75,23)
$BoutonAnnuler.Text = 'Annuler'
$BoutonAnnuler.DialogResult = [System.Windows.Forms.DialogResult]::Cancel
$form.CancelButton = $BoutonAnnuler
$form.Controls.Add($BoutonAnnuler)
# Changement de couleur du bouton Annuler
$BoutonAnnuler.BackColor = [System.Drawing.Color]::LightCoral
$BoutonAnnuler.ForeColor = [System.Drawing.Color]::Black

# Création du label qui permet d'afficher un texte d'instruction
$label = New-Object System.Windows.Forms.Label
$label.Location = New-Object System.Drawing.Point(10,20)
$label.Size = New-Object System.Drawing.Size(350,20)
$label.Text = 'Veuillez rentrer un poste pour avoir son mot de passe admin :'
$form.Controls.Add($label)
# Changement de couleur du label
$label.BackColor = [System.Drawing.Color]::White
$label.ForeColor = [System.Drawing.Color]::Black

# Création de la zone de texte
$textBox = New-Object System.Windows.Forms.TextBox
$textBox.Location = New-Object System.Drawing.Point(10,40)
$textBox.Size = New-Object System.Drawing.Size(310,80)
# Permet de sélectionner plusieurs postes
$textBox.Multiline = $true
# Permet d'appuyer sur la touche entré pour aller à la ligne
$textBox.AcceptsReturn = $true
# Ajoute une barre sur le côté pour scroller
$textBox.ScrollBars = 'Vertical'
$form.Controls.Add($textBox)


# Affichage du formulaire : Topmost => définit le formulaire comme étant toujours au-dessus des autres fenêtres.
#                           SowDialog => Affiche le formulaire en mode dialogue
$form.Controls.Add($textBox)
$form.Topmost = $true


# Affichage du formulaire   
$result = $form.ShowDialog()

# Vérifie si le bouton OK a été sélectionné.
if ($result -eq [System.Windows.Forms.DialogResult]::OK) {
    $computerNames = $textBox.Lines
    # Etablit une liste qui va se remplir avec les noms des postes remplis
    $passwords = @()
    foreach ($computerName in $computerNames) {
        if ($computerName -ne "") {
            $password = Get-AdmPwdPassword -ComputerName $computerName | Select-Object -Property ComputerName, Password
            $passwords += $password
        }
    }
if ($passwords.Count -gt 0) {
        # Création d'une nouvelle fenêtre pour afficher les mots de passe
        $resultForm = New-Object System.Windows.Forms.Form
        $resultForm.Text = 'Résultats des mots de passe'
        $resultForm.Size = New-Object System.Drawing.Size(400,300)
        $resultForm.StartPosition = 'CenterScreen'
        
        # Création de la zone de texte pour afficher les mots de passe
        $resultTextBox = New-Object System.Windows.Forms.TextBox
        $resultTextBox.Location = New-Object System.Drawing.Point(10,10)
        $resultTextBox.Size = New-Object System.Drawing.Size(360,240)
        $resultTextBox.Multiline = $true
        $resultTextBox.ScrollBars = 'Vertical'
        $resultTextBox.ReadOnly = $false
        $resultTextBox.Text = ($passwords | Out-String)
        
        $resultForm.Controls.Add($resultTextBox)
        $resultForm.ShowDialog()
    } else {
        [System.Windows.Forms.MessageBox]::Show("Aucun mot de passe trouvé pour les postes spécifiés.", "Résultat", [System.Windows.Forms.MessageBoxButtons]::OK, [System.Windows.Forms.MessageBoxIcon]::Information)
    }
}

# Vérifie si le bouton Annuller a été sélectionné.
$result -eq [System.Windows.Forms.DialogResult]::Annuler