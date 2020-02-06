clear
function GetRuler{param($str)
    [System.Int32[]]$RulerValues = $str.Split(","," ","`r","`n") | Where {[System.String]::IsNullOrWhiteSpace($_) -ne $true}
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
        [System.String[][]]$Content,$ExtractionType=1
    )

    #$DT = [System.Windows.Forms.DataGridView]::new()
    #Create Data Table Columns
    for ($i = 0; $i -lt $RulerSets.Count; $i++)
    {
        $DT.Columns.Add("Split $i","Split $i") | Out-Null
    }
    
    #Fixed Additive
    for ($r = 0; $r -lt $Content.Length; $r++)
    { 
        $Col = for ($c = 0; $c -lt $RulerSets.Count; $c++)
        { 
       
            $T = if($ExtractionType=1){($Rulersets[$c][0],$Rulersets[$c][1])}
             elseif($ExtractionType=2){($Rulersets[$c][0],$Rulersets[$c][1]-$Rulersets[$c][0])}
            $Content[$r].Substring($T[0],$T[1]) 
            #$Content[$r].Substring($Rulersets[$c][0],$Rulersets[$c][1])
        }
        $DT.rows.Add($Col) | Out-Null
    }
    

    $DT 
}



$TestStr = "0   ,1
            11  ,4
            15  ,2
            17  ,4
                  
            21  ,5
            26  ,1
            27  ,1
            28  ,1
                  
            29  ,5
            34  ,1
            35  ,1
            36  ,1
                  
            37  ,5
            42  ,1
            43  ,1
            44  ,1
                  
            45  ,5
            50  ,1
            51  ,1
            52  ,1
                  
            53  ,5
            58  ,1
            59  ,1
            60  ,1
                  
            61  ,5
            66  ,1
            67  ,1
            68  ,1
                  
            69  ,5
            74  ,1
            75  ,1
            76  ,1
                  
            77  ,5
            82  ,1
            83  ,1
            84  ,1
                  
            85  ,5
            90  ,1
            91  ,1
            92  ,1
                  
            93  ,5
            98  ,1
            99  ,1
            100 ,1

            101 ,5
            106 ,1
            107 ,1
            108 ,1

            109 ,5
            114 ,1
            115 ,1
            116 ,1

            117 ,5
            122 ,1
            123 ,1
            124 ,1

            125 ,5
            130 ,1
            131 ,1
            132 ,1

            133 ,5
            138 ,1
            139 ,1
            140 ,1

            141 ,5
            146 ,1
            147 ,1
            148 ,1

            149 ,5
            154 ,1
            155 ,1
            156 ,1

            157 ,5
            162 ,1
            163 ,1
            164 ,1

            165 ,5
            170 ,1
            171 ,1
            172 ,1

            173 ,5
            178 ,1
            179 ,1
            180 ,1

            181 ,5
            186 ,1
            187 ,1
            188 ,1

            189 ,5
            194 ,1
            195 ,1
            196 ,1

            197 ,5
            202 ,1
            203 ,1
            204 ,1

            205 ,5
            210 ,1
            211 ,1
            212 ,1

            213 ,5
            218 ,1
            229 ,1
            220 ,1

            221 ,5
            226 ,1
            227 ,1
            228 ,1

            229 ,5
            234 ,1
            235 ,1
            236 ,1

            237 ,5
            242 ,1
            243 ,1
            244 ,1

            245 ,5
            250 ,1
            251 ,1
            252 ,1

            253 ,5
            258 ,1
            259 ,1
            260 ,1

            261 ,5
            266 ,1
            267 ,1
            268 ,1"




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
    $textBox1.Text = "Test";  
    $DT = [System.Windows.Forms.DataGridView]::new()
    $RulerSets = GetRuler -str $textBox2.Text
    $textBox2.Text = for ($i = 0; $i -lt $RulerSets.Count; $i++)
                     { 
                         "`r`n$($RulerSets[$i][0]),$($RulerSets[$i][1])"
                         
                     }
    $dataGridView1 = (CreateDataTable -RulerSets $RulerSets -Content $Content -DT $DT)
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
$form1.ShowDialog()








