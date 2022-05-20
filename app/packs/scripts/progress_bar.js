$score=parseInt(document.querySelector(".assistant_score").textContent,10);
$paliersScore=document.querySelector(".paliers").value;
$paliersScore=$paliersScore.substr(1,$paliersScore.length-2).split(',');
$progressSize=window.getComputedStyle(document.querySelector(".progress")).getPropertyValue("width");
$progressSize=Math.round($progressSize.substring(0,$progressSize.length-2)/ [document.documentElement.clientWidth]*100);
if($score<$paliersScore[0]){
    $cssValue=$score/$paliersScore[0]*$progressSize;
}
else if($score<$paliersScore[1]){
    $cssValue=($score-$paliersScore[0])/($paliersScore[1]-$paliersScore[0])*$progressSize;
}
else if($score<$paliersScore[2]){
    $cssValue=($score-$paliersScore[1])/($paliersScore[2]-$paliersScore[1])*$progressSize;
}
else if($score<$paliersScore[3]){
    $cssValue=($score-$paliersScore[2])/($paliersScore[3]-$paliersScore[2])*$progressSize;
}
else if($score<$paliersScore[4]){
    $cssValue=($score-$paliersScore[3])/($paliersScore[4]-$paliersScore[3])*$progressSize;
}
else{
    $cssValue=$progressSize;
}
document.querySelector(".progress_bar").style.width = $cssValue.toString()+"vw";