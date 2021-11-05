$score=parseInt(document.querySelector(".assistant_score").textContent,10);
$cssValue=$score/15*7;
document.querySelector(".progress_bar").style.width = $cssValue.toString()+"vw";