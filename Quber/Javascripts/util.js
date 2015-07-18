function qtest() {
    alert("hi qtest");
}

function listVehicles() {
    try {
        var div = document.getElementsByClassName("vehicle-selector")[0];
        var ul = searchChildForTag(div, "UL");
        var lis = searchChildForTags(ul, "LI");
        var all = '';
        for(var i=0; i<lis.length; i++) {
            if(i>0)
                all += ",";
            all += lis[i].textContent.trim();
        }
        return all;
    } catch (e) {
        alert(e);
    }
}

function searchChildForTag(node, tagName) {
    var tags = searchChildForTags(node, tagName);
    if (tags.length>0)
        return tags[0];
}

function searchChildForTags(node, tagName) {
    var array = [];
    for(var i=0; i<node.childNodes.length; i++) {
        var child = node.childNodes[i];
        if(child.nodeName == tagName) {
            array.push(child);
        }
    }
    return array;
}
