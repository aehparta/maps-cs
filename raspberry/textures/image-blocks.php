<?php

if (!isset($_SERVER['argv'][2]) || !is_file($_SERVER['argv'][1])) {
    echo "usage: <script> <image> <out-prefix>\n";
    exit(1);
}

$img = new Imagick($_SERVER['argv'][1]);
if (!$img) {
    echo "cannot load image\n";
    exit(1);
}

$outfile_prefix = $_SERVER['argv'][2];
$ext            = pathinfo($_SERVER['argv'][1], PATHINFO_EXTENSION);

$w_div = 5;
$h_div = 3;
$w     = $img->getImageWidth();
$h     = $img->getImageHeight();
$wb    = $w / $w_div;
$hb    = $h / $h_div;
$wf    = 512;
$hf    = 512;

echo "original w: $w, h: $h\n";
echo "blocks in original w: $wb, h: $hb\n";
echo "final blocks w: $wf, h: $hf\n";

for ($y = 0; $y < $h; $y += $hb) {
    echo ' * y: ' . ($y / $hb) . "\n";
    for ($x = 0; $x < $w; $x += $wb) {
        $bi = clone $img;
        $bi->cropImage($wb, $hb, $x, $y);
        $bi->resizeImage($wf, $hf, imagick::FILTER_SINC, 1.0);

        $outfile = $outfile_prefix . '-' . ($y / $hb) . '-' . ($x / $wb) . '.' . $ext;
        echo '   - x: ' . ($x / $wb) . ' -> ' . $outfile . "\n";

        $bi->writeImage($outfile);
    }
}
