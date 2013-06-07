function rpson(img) {
  img.style.oldWidth = img.clientWidth;
  img.style.width = "200px";
}

function rpsoff(img) {
  img.style.width = img.style.oldWidth;
}
