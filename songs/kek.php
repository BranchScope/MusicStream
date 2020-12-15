<?php
 
$fileList = glob('*.mp3');
shuffle($fileList);

foreach($fileList as $filename){
   $kek = " file '" . $filename . "'"; 
   exec('echo "' . $kek . '" >> list.txt');
}
