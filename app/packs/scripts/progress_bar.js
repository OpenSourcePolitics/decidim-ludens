$score=parseInt(document.querySelector(".assistant_score").textContent,10);
if($score<6){
    $cssValue=$score/6*7;
}
else if($score<16){
    $cssValue=($score-6)/10*7;
}
else if($score<28){
    $cssValue=($score-16)/12*7;
}
else if($score<40){
    $cssValue=($score-28)/12*7;
}
else if($score<50){
    $cssValue=($score-40)/10*7;
}
else{
    $cssValue=7;
}

document.querySelector(".progress_bar").style.width = $cssValue.toString()+"vw";