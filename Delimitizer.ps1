
clear
function GetColumnNames {param($Str)
    ($str.Split([environment]::NewLine,[System.StringSplitOptions]::RemoveEmptyEntries))
}


function GetRuler{param($str)
    $RulerArray = [System.Collections.Generic.List[Tuple[int,int,string]]]::new()
    $Str.Split([Environment]::NewLine,[System.StringSplitOptions]::RemoveEmptyEntries) | foreach {[regex]::Match($_,"(\d+[\t\s,]+)(\d+[\t,\s]+)(.+[^,])",[System.Text.RegularExpressions.RegexOptions]::Multiline)} `
    | foreach {$RulerArray.Add([System.Tuple[int,int,string]]::new($_.Captures.Groups[1].Value,$_.Captures.Groups[2].Value,$_.Captures.Groups[3].Value))}
    $RulerArray 
}




function CreateDataTable {
    param(
        [System.Windows.Forms.DataGridView]$DT,
        [System.Collections.Generic.List[Tuple[int,int,string]]]$RulerSets,
        $Content,
        [System.Int32]$ExtractionType=0,
        [System.Int32]$Shift1 = 0,
        [System.Int32]$Shift2 = 0
    )
    Write-Host $Shift1
    Write-Host $Shift2



    #$DT = [System.Windows.Forms.DataGridView]::new()
    #Create Data Table Columns
    for ($i = 0; $i -lt $RulerSets.Count; $i++)
    {
        if($RulerSets -eq $null -or [System.String]::IsNullOrWhiteSpace($RulerSets[$i].Item3))
        {$DT.Columns.Add("Split $i","Split $i") | Out-Null}
        else
        {$DT.Columns.Add($RulerSets[$i].Item3,$RulerSets[$i].Item3) | Out-Null}
    }
    
    #Fixed Additive = 1 
    #Fixed End-to-End
    for ($r = 0; $r -lt $Content.Length; $r++)
    { 
        $Col = for($c = 0; $c -lt $RulerSets.Count-1; $c++)
        { 
            $T = if($ExtractionType -eq 0){(($Rulersets[$c].Item1+$Shift1), ($Rulersets[$c].Item2+$Shift2))}
             elseif($ExtractionType -eq 1){(($Rulersets[$c].Item1+$Shift1),(($Rulersets[$c].Item2+$Shift2)-($Rulersets[$c].Item1+$Shift1)))}

        
            if($Content[$r].Length -lt ($T[0]+$T[1]) `
            -or $T[1] -le 0 `
            -or [System.String]::IsNullOrWhiteSpace($T[0]) `
            -or [System.String]::IsNullOrWhiteSpace($T[1])) 
            {""} else {$Content[$r].Substring($T[0],$T[1])}
        }
    
        if($col -ne $null) {$DT.rows.Add($Col) | Out-Null}
    }
    

    $DT 
}

$FD = [System.Windows.Forms.OpenFileDialog]::new()
#$FD.ShowDialog()
#$Content = Get-Content $FD.FileName | Where {[System.String]::IsNullOrWhiteSpace($_) -ne $true}




$Form1 = [System.Windows.Forms.Form]::new()
$splitContainer1 = [System.Windows.Forms.SplitContainer]::new()
$DataGridView1 = [System.Windows.Forms.DataGridView]::new() # CreateDataTable -RulerSets $RulerSets -Content $Content 
$splitContainer2 = [System.Windows.Forms.SplitContainer]::new()
$button1 = [System.Windows.Forms.Button]::new()
$splitContainer3 = [System.Windows.Forms.SplitContainer]::new()
$textBox1 = [System.Windows.Forms.RichTextBox]::new()
$textBox2 = [System.Windows.Forms.RichTextBox]::new()
$splitContainer4 = [System.Windows.Forms.SplitContainer]::new()
$comboBox1 = [System.Windows.Forms.ComboBox]::new()
$FlowLayoutPanel1 = [System.Windows.Forms.FlowLayoutPanel]::new()
$CB_RulerShift1 = [System.Windows.Forms.ComboBox]::new()
$CB_RulerShift2 = [System.Windows.Forms.ComboBox]::new()




# 
# splitContainer1
#
$splitContainer1.Dock = [System.Windows.Forms.DockStyle]::Fill
$splitContainer1.Location = [System.Drawing.Point]::new(0, 0);
$splitContainer1.Name = "splitContainer1";
$splitContainer1.Orientation = [System.Windows.Forms.Orientation]::Horizontal;
# 
# splitContainer1.Panel1
# 
$splitContainer1.Panel1.Controls.Add($dataGridView1);
# 
# splitContainer1.Panel2
#   
$splitContainer1.Panel2.Controls.Add($splitContainer2);
$splitContainer1.Size = [System.Drawing.Size]::new(800, 450);
$splitContainer1.SplitterDistance = 285;
$splitContainer1.TabIndex = 0;
# 
# dataGridView1
# 
$dataGridView1.BorderStyle = [System.Windows.Forms.BorderStyle]::None;
$dataGridView1.ColumnHeadersHeightSizeMode = [System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode]::AutoSize;
$dataGridView1.Dock = [System.Windows.Forms.DockStyle]::Fill;
$dataGridView1.Location = [System.Drawing.Point]::new(0, 0);
$dataGridView1.Name = "dataGridView1";
$dataGridView1.Size = [System.Drawing.Size]::new(800, 266);
$dataGridView1.TabIndex = 0;
# 
# splitContainer2
# 
$splitContainer2.Dock = [System.Windows.Forms.DockStyle]::Fill;
$splitContainer2.Location = [System.Drawing.Point]::new(0, 0);
$splitContainer2.Name = "splitContainer2";
# 
# splitContainer2.Panel2
# 
$splitContainer2.Panel2.Controls.Add($splitContainer3);
$splitContainer2.Size = [System.Drawing.Size]::new(800, 180);
$splitContainer2.SplitterDistance = 128;
$splitContainer2.TabIndex = 0;
# 
# button1
# 
$button1.Dock = [System.Windows.Forms.DockStyle]::Fill;
$button1.Location = [System.Drawing.Point]::new(0, 0);
$button1.Name = "button1";
$button1.Size = [System.Drawing.Size]::new(100, 180);
$button1.TabIndex = 0;
$button1.Text = "Run";
$button1.UseVisualStyleBackColor = $true;
$button1.Add_Click({  
    clear  
    $DT = [System.Windows.Forms.DataGridView]::new()

    $RulerSets   = GetRuler -str $textBox1.Text
    
    
    do
    {
        $FD.ShowDialog()
    }
    while ($FD -match ".zip")

    $Content = Get-Content $FD.FileName | Where {[System.String]::IsNullOrWhiteSpace($_) -ne $true}
    #$TestStr = "1,$(($Content | Measure-Object -Maximum -Property Length).Maximum)"

    $textBox1.Text = for ($i = 0; $i -lt $RulerSets.Count; $i++)
                     { 
                         "`r`n$($RulerSets[$i].Item1),$($RulerSets[$i].Item2),$($RulerSets[$i].Item3)"
                         
                     }
    $textBox2.Text = $Content | Out-String

    
    
    $dataGridView1 = (CreateDataTable -RulerSets $RulerSets -Content $Content -DT $DT -ExtractionType $comboBox1.SelectedIndex -Shift1 $CB_RulerShift1.SelectedItem -Shift2 $CB_RulerShift2.SelectedItem)
    $dataGridView1.BorderStyle = [System.Windows.Forms.BorderStyle]::None;
    $dataGridView1.ColumnHeadersHeightSizeMode = [System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode]::AutoSize;
    $dataGridView1.Dock = [System.Windows.Forms.DockStyle]::Fill;
    $dataGridView1.Location = [System.Drawing.Point]::new(0, 0);
    $dataGridView1.Name = "dataGridView1";
    $dataGridView1.Size = [System.Drawing.Size]::new(800, 266);

   

    $splitContainer1.Panel1.Controls.Clear()
    $splitContainer1.Panel1.Controls.Add($dataGridView1)
    $splitContainer1.Panel1.Refresh();

    #$DataGridView1.Refresh()
    })
# 
# splitContainer3
# 
$splitContainer3.Dock = [System.Windows.Forms.DockStyle]::Fill;
$splitContainer3.Location = [System.Drawing.Point]::new(0, 0);
$splitContainer3.Name = "splitContainer3";
# 
# splitContainer3.Panel1
# 
$splitContainer3.Panel1.Controls.Add($textBox1);
# 
# splitContainer3.Panel2
# 
$splitContainer3.Panel2.Controls.Add($textBox2);
$splitContainer3.Size = [System.Drawing.Size]::new(671, 171);
$splitContainer3.SplitterDistance = 120;
# 
# textBox1
# 
$textBox1.Dock = [System.Windows.Forms.DockStyle]::Fill;
$textBox1.Location = [System.Drawing.Point]::new(0, 0);
$textBox1.Multiline = $true;
$textBox1.Name = "textBox1";
$textBox1.Size = [System.Drawing.Size]::new(120, 180);
$textBox1.WordWrap = $false
$textBox1.ScrollBars = [System.Windows.Forms.ScrollBars]::Both
$textBox1.TabIndex = 0;
# 
# textBox2
# 
$textBox2.Dock = [System.Windows.Forms.DockStyle]::Fill;
$textBox2.Location = [System.Drawing.Point]::new(0, 0);
$textBox2.Multiline = $true;
$textBox2.Name = "textBox2";
$textBox2.Size = [System.Drawing.Size]::new(572, 180);
$textBox2.TabIndex = 1;
$textBox2.WordWrap = $false
$textBox2.ScrollBars = [System.Windows.Forms.ScrollBars]::Both
# 
# splitContainer4
# 


$splitContainer4.Dock =[system.Windows.Forms.DockStyle]::Fill;
$splitContainer4.Location = [System.Drawing.Point]::new(0, 0);
$splitContainer4.Name = "splitContainer4";
$splitContainer4.Orientation = [system.Windows.Forms.Orientation]::Horizontal;
# 
# splitContainer4.Panel1
# 

# 
# splitContainer4.Panel2
# 
$splitContainer4.Panel2.Controls.Add($button1);
$splitContainer4.Size = [System.Drawing.Size]::new(100, 180);
$splitContainer4.SplitterDistance = 90;
$splitContainer4.TabIndex = 0;
$splitContainer4.SplitterWidth = 1;
$splitContainer4.Panel2.Anchor 
# 
# comboBox1
#
$comboBox1.Dock = [system.Windows.Forms.DockStyle]::Fill;
$comboBox1.FormattingEnabled = $true;
$comboBox1.Location = [System.Drawing.Point]::new(0, 0);
$comboBox1.Name = "comboBox1";
$comboBox1.Size = [System.Drawing.Size]::new(100, 21);
$comboBox1.TabIndex = 0;
$comboBox1.Items.Add("Fixed Additive")
$comboBox1.Items.Add("Fixed End-to-End")
$comboBox1.SelectedIndex = 0


-5..5 | ? {$CB_RulerShift1.Items.Add($_)}
$CB_RulerShift1.SelectedIndex = [Math]::Floor($CB_RulerShift1.Items.Count/2)

-5..5 | ? {$CB_RulerShift2.Items.Add($_)}
$CB_RulerShift2.SelectedIndex = [Math]::Floor($CB_RulerShift2.Items.Count/2)



$splitContainer2.Panel1.Controls.Add($splitContainer4)

$FlowLayoutPanel1.FlowDirection = [System.Windows.Forms.FlowDirection]::TopDown
$FlowLayoutPanel1.Dock  =[System.Windows.Forms.DockStyle]::Fill
#$FlowLayoutPanel1.Anchor  =[System.Windows.Forms.AnchorStyles]::left


$FlowLayoutPanel1.Controls.Add($comboBox1)
$FlowLayoutPanel1.Controls.Add($CB_RulerShift1)
$FlowLayoutPanel1.Controls.Add($CB_RulerShift2)
$splitContainer4.Panel1.Controls.Add($FlowLayoutPanel1);
# 
# Form1
# 
#$AutoScaleDimensions = [System.Drawing.SizeF]::new(6F, 13F);
$form1.AutoScaleMode = [System.Windows.Forms.AutoScaleMode]::Font;
$form1.ClientSize = [System.Drawing.Size]::new(800, 476);
$form1.Controls.Add($splitContainer1);
$form1.Name = "Form1";
$form1.Text = "Form1";
[System.windows.forms.application]::run($form1)


