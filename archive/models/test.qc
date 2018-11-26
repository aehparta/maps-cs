// Output .MDL
$modelname "P:\csim\HL_maps\models\test.mdl"

// Directory of .SMD
$cd "\csim\HL_maps\models\"

// bodygroups: use relative path from $cd
$bodygroup body
{
studio "./reference"
}

// sequences: all sequences are in $cd
$sequence seq-name "sequence" loop fps 30 ACT_IDLE 1
