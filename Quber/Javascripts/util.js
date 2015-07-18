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

function changeVehicle(index) {
        var div = document.getElementsByClassName("vehicle-selector")[0];
        var ul = searchChildForTag(div, "UL");
        var lis = searchChildForTags(ul, "LI");
        simulate(lis[index], 'click');
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

function simulate(element, eventName)
{
    var options = extend(defaultOptions, arguments[2] || {});
    var oEvent, eventType = null;
    
    for (var name in eventMatchers)
    {
        if (eventMatchers[name].test(eventName)) { eventType = name; break; }
    }
    
    if (!eventType)
        throw new SyntaxError('Only HTMLEvents and MouseEvents interfaces are supported');
    
    if (document.createEvent)
    {
        oEvent = document.createEvent(eventType);
        if (eventType == 'HTMLEvents')
        {
            oEvent.initEvent(eventName, options.bubbles, options.cancelable);
        }
        else
        {
            oEvent.initMouseEvent(eventName, options.bubbles, options.cancelable, document.defaultView,
                                  options.button, options.pointerX, options.pointerY, options.pointerX, options.pointerY,
                                  options.ctrlKey, options.altKey, options.shiftKey, options.metaKey, options.button, element);
        }
        element.dispatchEvent(oEvent);
    }
    else
    {
        options.clientX = options.pointerX;
        options.clientY = options.pointerY;
        var evt = document.createEventObject();
        oEvent = extend(evt, options);
        element.fireEvent('on' + eventName, oEvent);
    }
    return element;
}

function extend(destination, source) {
    for (var property in source)
        destination[property] = source[property];
    return destination;
}

var eventMatchers = {
    'HTMLEvents': /^(?:load|unload|abort|error|select|change|submit|reset|focus|blur|resize|scroll)$/,
    'MouseEvents': /^(?:click|dblclick|mouse(?:down|up|over|move|out))$/
}
var defaultOptions = {
pointerX: 0,
pointerY: 0,
button: 0,
ctrlKey: false,
altKey: false,
shiftKey: false,
metaKey: false,
bubbles: true,
cancelable: true
}
