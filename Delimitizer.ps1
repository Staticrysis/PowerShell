clear
function GetColumnNames {param($Str)
    ($str.Split([environment]::NewLine,[System.StringSplitOptions]::RemoveEmptyEntries))
}

function GetRuler{param($str)
#
#$str = "1	24
#25	31
#32	51
#52	52
#53	59
#60	66
#67	74
#75	104
#105	106
#107	107
#108	124
#125	139
#140	154
#155	231
#232	234
#235	264
#265	294
#295	314
#315	316
#317	327
#328	347
#"
#/



    [System.Int32[]]$RulerValues = $Str.Split((","," ","`r","`n","`t"),[System.StringSplitOptions]::RemoveEmptyEntries)
    #Converts 1d array too 2d array
    $RulerSets = [System.Collections.Generic.List[System.Int32[]]]::new()
    for ($i = 0; $i -lt $RulerValues.Length; $i++){if($i % 2 -eq 0){$RulerSets.Add(($RulerValues[$i],$RulerValues[$i+1]))}}
    #for ($i = 0; $i -lt $RulerValues.Length; $i++){if($i % 2 -eq 0){$RulerSets[[System.Math]::Floor($i/2)][0]=$RulerValues[$i]}else{$RulerSets[[System.Math]::Floor($i/2)][1]=$RulerValues[$i]}}
    $RulerSets
}
function CreateDataTable {
    param(
        [System.Windows.Forms.DataGridView]$DT,
        [System.Collections.Generic.List[System.Int32[]]]$RulerSets,
        $Content,
        [System.String[]]$ColumnNames,
        [System.Int32]$ExtractionType=2
    )

    #$DT = [System.Windows.Forms.DataGridView]::new()
    #Create Data Table Columns
    for ($i = 0; $i -lt $RulerSets.Count; $i++)
    {
        if($ColumnNames -eq $null -or [System.String]::IsNullOrWhiteSpace($ColumnNames[$i]))
        {$DT.Columns.Add("Split $i","Split $i") | Out-Null}
        else
        {$DT.Columns.Add($ColumnNames[$i],$ColumnNames[$i]) | Out-Null}
    }
    
    #Fixed Additive = 1 
    #Fixed End-to-End
    for ($r = 0; $r -lt $Content.Length; $r++)
    { 
        $Col = for($c = 0; $c -lt $RulerSets.Count-1; $c++)
        { 
            $T = if($ExtractionType -eq 1){($Rulersets[$c][0],$Rulersets[$c][1])}
             elseif($ExtractionType -eq 2){($Rulersets[$c][0],($Rulersets[$c][1]-$Rulersets[$c][0]))}


            if($Content[$r].Length -lt ($T[0]+$T[1]) -or [System.String]::IsNullOrWhiteSpace($Content[$r])) {""} else {$Content[$r].Substring($T[0]-1,$T[1])}
        }
    
        if($col -ne $null) {$DT.rows.Add($Col) | Out-Null}
    }
    

    $DT 
}

$FD = [System.Windows.Forms.OpenFileDialog]::new()
#$FD.ShowDialog()
#$Content = Get-Content $FD.FileName | Where {[System.String]::IsNullOrWhiteSpace($_) -ne $true}

#$ColumnNames = GetColumnNames   "
#25	31
#32	51
#52	52
#53	59
#60	66
#67	74
#75	104
#105	106
#107	107
#108	124
#125	139
#140	154
#155	231
#232	234
#235	264
#265	294
#295	314
#315	316
#317	327
#328	347
#"



$Form1 = [System.Windows.Forms.Form]::new()
$splitContainer1 = [System.Windows.Forms.SplitContainer]::new()
$DataGridView1 = [System.Windows.Forms.DataGridView]::new() # CreateDataTable -RulerSets $RulerSets -Content $Content 
$splitContainer2 = [System.Windows.Forms.SplitContainer]::new()
$button1 = [System.Windows.Forms.Button]::new()
$splitContainer3 = [System.Windows.Forms.SplitContainer]::new()
$textBox1 = [System.Windows.Forms.TextBox]::new()
$textBox2 = [System.Windows.Forms.TextBox]::new()


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
$splitContainer1.SplitterDistance = 266;
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
# splitContainer2.Panel1
# 
$splitContainer2.Panel1.Controls.Add($button1);
# 
# splitContainer2.Panel2
# 
$splitContainer2.Panel2.Controls.Add($splitContainer3);
$splitContainer2.Size = [System.Drawing.Size]::new(800, 180);
$splitContainer2.SplitterDistance = 100;
$splitContainer2.TabIndex = 0;
# 
# button1
# 
$button1.Dock = [System.Windows.Forms.DockStyle]::Fill;
$button1.Location = [System.Drawing.Point]::new(0, 0);
$button1.Name = "button1";
$button1.Size = [System.Drawing.Size]::new(100, 180);
$button1.TabIndex = 0;
$button1.Text = "Enter";
$button1.UseVisualStyleBackColor = $true;
$button1.Add_Click({    
    $DT = [System.Windows.Forms.DataGridView]::new()

    $RulerSets   = GetRuler -str $textBox2.Text
    $ColumnNames = GetColumnNames -Str $textBox1.Text
    
    do
    {
        $FD.ShowDialog()
    }
    while ($FD -match ".zip")

    $Content = Get-Content $FD.FileName | Where {[System.String]::IsNullOrWhiteSpace($_) -ne $true}
    #$TestStr = "1,$(($Content | Measure-Object -Maximum -Property Length).Maximum)"

    $textBox2.Text = for ($i = 0; $i -lt $RulerSets.Count; $i++)
                     { 
                         "`r`n$($RulerSets[$i][0]),$($RulerSets[$i][1])"
                         
                     }
    #TODO Content set to a sample size
    $dataGridView1 = (CreateDataTable -RulerSets $RulerSets -Content $Content -ColumnNames $ColumnNames -DT $DT -ExtractionType 1)
    #$dataGridView1.Rows.Cells.Value

    $dataGridView1.BorderStyle = [System.Windows.Forms.BorderStyle]::None;
    $dataGridView1.ColumnHeadersHeightSizeMode = [System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode]::AutoSize;
    $dataGridView1.Dock = [System.Windows.Forms.DockStyle]::Fill;
    $dataGridView1.Location = [System.Drawing.Point]::new(0, 0);
    $dataGridView1.Name = "dataGridView1";
    $dataGridView1.Size = [System.Drawing.Size]::new(800, 266);
    $dataGridView1.TabIndex = 0;
   

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
$splitContainer3.Size = [System.Drawing.Size]::new(696, 180);
$splitContainer3.SplitterDistance = 320;
# 
# textBox1
# 
$textBox1.Dock = [System.Windows.Forms.DockStyle]::Fill;
$textBox1.Location = [System.Drawing.Point]::new(0, 0);
$textBox1.Multiline = $true;
$textBox1.Name = "textBox1";
$textBox1.Size = [System.Drawing.Size]::new(341, 180);
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
$textBox2.Size = [System.Drawing.Size]::new(341, 180);
$textBox2.TabIndex = 1;
$textBox2.WordWrap = $false
$textBox2.ScrollBars = [System.Windows.Forms.ScrollBars]::Both
$textBox2.Text =  $TestStr
# 
# Form1
# 
#$AutoScaleDimensions = [System.Drawing.SizeF]::new(6F, 13F);
$form1.AutoScaleMode = [System.Windows.Forms.AutoScaleMode]::Font;
$form1.ClientSize = [System.Drawing.Size]::new(800, 450);
$form1.Controls.Add($splitContainer1);
$form1.Name = "Form1";
$form1.Text = "Form1";
[System.windows.forms.application]::run($form1)









