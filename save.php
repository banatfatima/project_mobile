<?php 
include('connection.php');
$jsonData= file_get_contents('php://input');
$data= json_decode($jsonData,true);

if($data!==null){
    $cid=addslashes(strip_tags($data['cid']));
    $name=addslashes(strip_tags($data['name']));
    $key=addslashes(strip_tags($data['key']));
    
if($key !="baria" or trim($name)=="")
die("access denied");

$sql="insert into categories values ('$cid','$name')";
mysqli_query($con,$sql) or
die("cant add record");

echo "Record Added";

mysqli_close($con);

}else{
    http_response_code(400);
    echo "Invalid JSON data";
}
?>