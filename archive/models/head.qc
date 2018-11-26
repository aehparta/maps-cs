$modelname "P:\csim\HL_maps\models\head.mdl"
$cd "\csim\HL_maps\models\"
$cdtexture "\csim\HL_maps\models\"
$cliptotextures

$scale 1.0

// 0 attachments

// 0 bone controllers

// 2 hit boxes
$hbox 0 "Bip02 Spine2" -2.250000 -0.700000 0.000000  0.000000 1.990000 6.900062
$hbox 0 "Bip02 Head" -8.500000 -6.410000 -5.260000  6.940000 6.690000 12.470000

$bodygroup body
{
studio "./reference"
}

// 1 sequences
$sequence idle "idle" loop fps 30 ACT_IDLE 1 
