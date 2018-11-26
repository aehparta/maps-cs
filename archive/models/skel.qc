// Output .MDL
$modelname "P:\csim\HL_maps\models\skel.mdl"

// Directory of .SMD
$cd "\csim\HL_maps\models\"

// Directory of .BMP
$cdtexture "\csim\HL_maps\models\"
$cliptotextures

// Write textures into a ???T.mdl
//$externaltextures

$scale 1.0

// bodygroups: use relative path from $cd
$bodygroup body
{
studio "./reference"
}

// sequences: all sequences are in $cd
$sequence seq-name "sequence" loop fps 30 ACT_IDLE 1
