  class Helper {
    static index = 0;
  } 
  
  function changeBackgroundImage() {
    const backgroundImages = [
      "url(1.png)",
      "url(2.png)",
      "url(3.png)",
      "url(4.png)",
      "url(5.png)"
    ];
  
    document.body.style.backgroundImage = backgroundImages[Helper.index];
    document.body.style.backgroundRepeat = "no-repeat";
    document.body.style.backgroundPositionX = "center";
    document.body.style.backgroundPositionY = "300px";
    document.body.style.backgroundSize = "300px 300px";

    Helper.index = (Helper.index + 1) % 5;
  }
  
  function generateHexaColor() {
    const elements = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "A", "B", "C", "D", "E", "F"];
    let result = "#";
  
    for (let i = 0; i < 6; i++) {
      let index = Math.round(Math.random() * 100) % 16;
      let element = elements[index];
      result = result.concat(element);
    }
    return result;
  }
  
  function changeLinksColor() {
    const links = document.querySelectorAll("a");
    for (let link of links) {
      let color = generateHexaColor();

      link.style.color = color;
      link.style.textDecoration = "none"; 
      link.style.fontWeight = "bold"; 
      link.style.fontStyle = "italic";
      link.style.fontFamily = "Comic Sans MS";
    }
  }

  function deleteLinks() {
    const links = document.querySelectorAll("a");
    for (let link of links) {
      link.remove();
    }
  }