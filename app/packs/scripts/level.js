import ConfettiGenerator from "confetti-js";

document.addEventListener('DOMContentLoaded', event => {
    if(document.querySelector("#level-up").value== "reached"){
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
        context.fillStyle = "lightgrey";
        roundRect(context,myCanvas.width*2/5,myCanvas.height/3, myCanvas.width/5, myCanvas.height/3, 10, true, false);
        context.font = "bold 1.2vw Arial";
        context.fillStyle = "white";
        let message1 = "Congratulations, you are now";
        context.fillText(message1, myCanvas.width/2-context.measureText(message1).width/2, myCanvas.height*7/12);
        let heightMessage1 = context.measureText(message1).actualBoundingBoxAscent + context.measureText(message1).actualBoundingBoxDescent;
        context.font = "bold 1.4vw Arial";
        context.fillStyle = "white";
        let message2 = "Level 3";
        context.fillText(message2, myCanvas.width/2-context.measureText(message2).width/2, myCanvas.height*7/12 + heightMessage1*1.5);
        var image = document.querySelector(".avatar");
        context.drawImage(image,myCanvas.width*11/24,myCanvas.height*9/24, myCanvas.width/12,myCanvas.width/12);
        document.querySelector("#level-holder").addEventListener("click", event => {
            document.querySelector("#level-holder").parentElement.remove();
            document.querySelector("#confetti-holder").parentElement.remove();
        })
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