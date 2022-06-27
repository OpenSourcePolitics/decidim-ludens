import ConfettiGenerator from "confetti-js";

document.addEventListener('DOMContentLoaded', event => {
    if(document.querySelector("#level-up").value== "unreached"){
        createCanvasOverlay("grey-holder");
        let grey_holder = document.querySelector("#grey-holder");
        var ctx=grey_holder.getContext('2d');
        ctx.fillStyle = "grey";
        ctx.globalAlpha = 0.3;
        ctx.fillRect(0, 0, grey_holder.width, grey_holder.height);
        ctx.globalAlpha = 1;
        createCanvasOverlay("confetti-holder");
        var confettiSettings = {
            "target": "confetti-holder",
            "max": "1000",
            "size": "1",
            "animate": true,
            "props": ["circle", "square", "triangle", "line"],
            "colors": [[165, 104, 246], [230, 61, 135], [0, 199, 228], [253, 214, 126]],
            "clock": "25",
            "rotate": true,
            "width": "1848",
            "height": "980",
            "start_from_edge": true,
            "respawn": true
        }
        var confetti = new ConfettiGenerator(confettiSettings);
        confetti.render();
        createCanvasOverlay("level-holder");
        let myCanvas = document.querySelector("#level-holder");
        var context=myCanvas.getContext('2d');
        context.fillStyle = "#eee";
        roundRect(context,myCanvas.width/3,myCanvas.height/3, myCanvas.width/3, myCanvas.height/3, 4, true, false);
        context.font = "600 1.5vw Source Sans Pro";
        context.fillStyle = "black";
        let message1 = "Congratulations, you are now";
        context.fillText(message1, myCanvas.width/2-context.measureText(message1).width/2, myCanvas.height*4.9/12);
        let heightMessage1 = context.measureText(message1).actualBoundingBoxAscent + context.measureText(message1).actualBoundingBoxDescent;
        context.font = "600 2vw Source Sans Pro";
        switch(document.querySelector(".assistant_level").textContent){
            case ' Level 1 ':
                context.fillStyle = "#97FAE8";
                break;
            case ' Level 2 ':
                context.fillStyle = "#9A4C00";
                break;
            case ' Level 3 ':
                context.fillStyle = "#737373";
                break;
            case ' Level 4 ':
                context.fillStyle = "#BF9B30";
                break;
            case ' Level 5 ':
                context.fillStyle = "#0092A8";
                break;
        }
        let message2 = document.querySelector(".assistant_level").textContent;
        context.fillText(message2, myCanvas.width/2-context.measureText(message2).width/2, myCanvas.height*7/12 + heightMessage1*1.5);
        context.fillStyle = "#303030";
        context.font = "100 1.7vw Source Sans Pro";
        let message3 = "×";
        let heightMessage3 = context.measureText(message3).actualBoundingBoxAscent + context.measureText(message3).actualBoundingBoxDescent;
        context.fillText(message3, myCanvas.width*2/3-context.measureText(message3).width-15, myCanvas.height/3+heightMessage3+15);
        var image = document.querySelector(".avatar");
        context.drawImage(image,myCanvas.width*11/24,myCanvas.height*10.5/24, myCanvas.width/12,myCanvas.width/12);
        document.querySelector("#level-holder").addEventListener("click", event => {
            document.querySelector("#level-holder").parentElement.remove();
            document.querySelector("#confetti-holder").parentElement.remove();
            document.querySelector("#grey-holder").parentElement.remove();
        })
        document.querySelector("#level-holder").addEventListener("mousemove", event => {
            var xlow = myCanvas.width*2/3-context.measureText(message3).width-20;
            var xhigh = myCanvas.width*2/3;
            var yhigh = myCanvas.height/3+heightMessage3+20
            var ylow = myCanvas.height/3;
            if(event.pageX>xlow && event.pageX<xhigh && event.pageY>ylow && event.pageY<yhigh){
                context.fillStyle = "#eee";
                roundRect(context,xlow,ylow, xhigh-xlow, yhigh-ylow, 4, true, false);
                context.fillStyle = "#4488DD";
                context.font = "100 1.7vw Source Sans Pro";
                context.fillText(message3, myCanvas.width*2/3-context.measureText(message3).width-15, myCanvas.height/3+heightMessage3+15);
            } else {
                context.fillStyle = "#eee";
                roundRect(context,xlow,ylow, xhigh-xlow, yhigh-ylow, 4, true, false);
                context.fillStyle = "#303030";
                context.font = "100 1.7vw Source Sans Pro";
                context.fillText(message3, myCanvas.width*2/3-context.measureText(message3).width-15, myCanvas.height/3+heightMessage3+15);
            }
        })
        document.addEventListener('keydown', function(event){
            if(event.key === "Escape"){
                document.querySelector("#level-holder").parentElement.remove();
                document.querySelector("#confetti-holder").parentElement.remove();
                document.querySelector("#grey-holder").parentElement.remove();
            }
        });
    }
});


function createCanvasOverlay(id) {
    var canvasContainer = document.createElement('div');
    document.body.appendChild(canvasContainer);
    canvasContainer.style.position = "absolute";
    canvasContainer.style.left = "0px";
    canvasContainer.style.top = "0px";
    canvasContainer.style.width = "100%";
    canvasContainer.style.height = "100%";
    canvasContainer.style.zIndex = "100";
    var superContainer = document.body;

    var myCanvas = document.createElement('canvas');
    myCanvas.style.width = superContainer.scrollWidth + "px";
    myCanvas.style.height = superContainer.scrollHeight + "px";
    // You must set this otherwise the canvas will be streethed to fit the container
    myCanvas.width = superContainer.scrollWidth;
    myCanvas.height = superContainer.scrollHeight;
    myCanvas.style.overflow = 'visible';
    myCanvas.style.position = 'absolute';
    myCanvas.id=id

    canvasContainer.appendChild(myCanvas);
}

/**
 * Draws a rounded rectangle using the current state of the canvas.
 * If you omit the last three params, it will draw a rectangle
 * outline with a 5 pixel border radius
 * @param {CanvasRenderingContext2D} ctx
 * @param {Number} x The top left x coordinate
 * @param {Number} y The top left y coordinate
 * @param {Number} width The width of the rectangle
 * @param {Number} height The height of the rectangle
 * @param {Number} [radius = 5] The corner radius; It can also be an object
 *                 to specify different radii for corners
 * @param {Number} [radius.tl = 0] Top left
 * @param {Number} [radius.tr = 0] Top right
 * @param {Number} [radius.br = 0] Bottom right
 * @param {Number} [radius.bl = 0] Bottom left
 * @param {Boolean} [fill = false] Whether to fill the rectangle.
 * @param {Boolean} [stroke = true] Whether to stroke the rectangle.
 */
function roundRect(ctx, x, y, width, height, radius, fill, stroke) {
    if (typeof stroke === 'undefined') {
        stroke = true;
    }
    if (typeof radius === 'undefined') {
        radius = 5;
    }
    if (typeof radius === 'number') {
        radius = {tl: radius, tr: radius, br: radius, bl: radius};
    } else {
        var defaultRadius = {tl: 0, tr: 0, br: 0, bl: 0};
        for (var side in defaultRadius) {
            radius[side] = radius[side] || defaultRadius[side];
        }
    }
    ctx.beginPath();
    ctx.moveTo(x + radius.tl, y);
    ctx.lineTo(x + width - radius.tr, y);
    ctx.quadraticCurveTo(x + width, y, x + width, y + radius.tr);
    ctx.lineTo(x + width, y + height - radius.br);
    ctx.quadraticCurveTo(x + width, y + height, x + width - radius.br, y + height);
    ctx.lineTo(x + radius.bl, y + height);
    ctx.quadraticCurveTo(x, y + height, x, y + height - radius.bl);
    ctx.lineTo(x, y + radius.tl);
    ctx.quadraticCurveTo(x, y, x + radius.tl, y);
    ctx.closePath();
    if (fill) {
        ctx.fill();
    }
    if (stroke) {
        ctx.stroke();
    }

}