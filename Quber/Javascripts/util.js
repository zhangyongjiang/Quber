function qtest() {
    alert("hi qtest");
}

function listVehicles() {
    try {
        var div = document.getElementsByClassName("vehicle-selector")[0];
        var ul = searchChildForTag(div, "UL");
    } catch (e) {
        alert(e);
    }
}

function searchChildForTag(node, tagName) {
    for(var i=0; i<node.childNodes.length; i++) {
        var child = node.childNodes[i];
        if(child.nodeName == tagName) {
            return child;
        }
    }
}