<?php
include 'database.php';
connection();
global $con;
@header('Content-Type:application/json; charset=UTF-8');
@header('Content-Type: application/x-www-form-urlencoded');
@header('Access-Control-Allow-Origin: *');
@header('Access-Control-Allow-Methods: POST');
@header('Access-Control-Allow-Headers: Access-Control-Allow-Headers,Content-Type,Access-Control-Allow-Methods, Authorization, X-Requested-With');
$data = json_decode(file_get_contents("php://input"),true);

 date_default_timezone_set("Asia/Kolkata");
// $u_name = $_POST['u_name'] ?? NULL;
$u_image = $_FILES['image'] ?? NULL;
$u_id = $_POST['pid'] ?? NULL;
// $u_id=$userid;





$imgname=$u_image['name'];
$imgtmpname=$u_image['tmp_name'];


if(!empty($u_image)|| !empty($u_id))
{

        if($imgname!='no_image.png')
        {
            $imgtitle=$u_id.'_'.time().$imgname;
            $img_location="patient_image/".$imgtitle;
            $return_img_locatioon=$imgtitle;
            $query="SELECT p_image FROM hospital_user WHERE p_id='{$u_id}'";
            $result1=mysqli_query($con,$query);
            if($result1)
	  {
                $getrecord = mysqli_num_rows($result1);
                if($getrecord > 0){
                    $imagedata=mysqli_fetch_assoc($result1);
                	$oldimage=$imagedata['image'];
		if($oldimage !='no_image.png')
		{
			unlink('patient_image/'.$oldimage);
			$profileinfo="UPDATE hospital_user SET p_image='".$imgtitle."' WHERE p_id='{$u_id}'";
			$result= mysqli_query($con,$profileinfo);
			if($result)
			{
		
				move_uploaded_file($imgtmpname,$img_location);
				echo json_encode(array('msg'=>'Image Saved','status'=>"true",'imgtitle'=>$imgtitle));
			}
			else
			{
				echo json_encode(array('msg'=>'Image Not saved','status'=>"false"));
			}
			
		}
		else{
		    	$profileinfo="UPDATE nbus_signin SET image='".$imgtitle."' WHERE userid=".$u_id;
			$result= mysqli_query($con,$profileinfo);
			if($result)
			{
		
				move_uploaded_file($imgtmpname,$img_location);
				echo json_encode(array('msg'=>'Image Saved','status'=>"true",'imgtitle'=>$imgtitle));
			}
			else
			{
				echo json_encode(array('msg'=>'Image Not saved','status'=>"false"));
			}
		    
		}
                }
	      else{
		echo json_encode(array('msg'=>'No record found','status'=>"false"));

	      }
                
	}
	else{
		echo json_encode(array('msg'=>'Error in query','status'=>"false"));

	}

           
	}
        
	else
	{
		echo json_encode(array('msg'=>'Error in Image','status'=>"false"));
	}
}
else
{
	echo json_encode(array('msg'=>'Sorry, Please Try Again...','status'=>"false"));
}
?>