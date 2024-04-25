var filter = "None";
var opt = "None";
function jsonParse(text) {
    let json;
    try {
        json = JSON.parse(text);
    } catch (e) {
        return false;
    }
    return json;
}


function get_filtered_by_type(){
    var ajax = new XMLHttpRequest();

    ajax.onreadystatechange = function(){
        if(this.readyState === 4 && this.status === 200){
            let table = document.getElementsByTagName("table")[0];
            let oldTableBody = document.getElementsByTagName("tbody")[0];
            let newTableBody = document.createElement('tbody');
            let json = jsonParse(this.responseText);
            for(let i = 0; i < json.length; i++){
                let document1 = json[i];
                let row = newTableBody.insertRow();
                Object.keys(document1).forEach(function (k){
                    let text;
                    let cell = row.insertCell();
                    text = document1[k];
                    cell.appendChild(document.createTextNode(text));
                })
            }
            table.appendChild(newTableBody);
            oldTableBody.parentNode.removeChild(oldTableBody);
        }
    }

    ajax.open('POST', 'getAllFilesByType.php', true);
    let type = document.getElementsByTagName("select")[0].value;
    let json = JSON.stringify({'type': type});
    ajax.send(json);

    setPrevious("Type", type);

}


function get_filtered_by_format(){
    var ajax = new XMLHttpRequest();
    ajax.onreadystatechange = function(){
        if(this.readyState === 4 && this.status === 200){
            let table = document.getElementsByTagName("table")[0];
            let oldTableBody = document.getElementsByTagName("tbody")[0];
            let newTableBody = document.createElement('tbody');
            let json = jsonParse(this.responseText);
            for(let i = 0; i < json.length; i++){
                let document1 = json[i];
                let row = newTableBody.insertRow();
                Object.keys(document1).forEach(function (k){
                    let text;
                    let cell = row.insertCell();
                    text = document1[k];
                    cell.appendChild(document.createTextNode(text));
                })
            }
            table.appendChild(newTableBody);
            oldTableBody.parentNode.removeChild(oldTableBody);
        }
    }

    ajax.open('POST', 'getAllFilesByFormat.php', true);
    let format = document.getElementsByTagName("select")[1].value;
    let json = JSON.stringify({'format': format});
    ajax.send(json);

    setPrevious("Format", format);

}

function setPrevious(filt, option){
    document.getElementById("previous-filter").innerHTML = "Previously used: " + filter + " filter: " + opt;
    filter=filt;
    opt = option;

}