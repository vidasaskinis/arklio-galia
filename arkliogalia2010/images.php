
      <?php

          $images = array(
      	0 => 'title.gif',
      	1 => 'title2.gif',
  
          );
   
          $image = $images[ rand(0,(count($images)-1)) ];
 
          $output = "<img src=\"/priekiniai/".$image."\" alt=\"\" border=\"0\" />";
  
          print($output);
  
      ?>

