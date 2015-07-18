function qtest() {
    alert("hi qtest");
//    alert(JSON.stringify({lat: 10 , lon: 12}));
    return "hi test";
}

function listVehicles() {
    try {
        var div = document.getElementsByClassName("vehicle-selector")[0];
        var ul = searchChildForTag(div, "UL");
        var lis = searchChildForTags(ul, "LI");
        var vehicles = new Array();
        for(var i=0; i<lis.length; i++) {
            var v = {
                name:lis[i].textContent.trim(),
                available: !hasClass(lis[i], 'unavailable')
            };
            vehicles.push(v);
        }
        return JSON.stringify(vehicles);
    } catch (e) {
        alert(e);
    }
}

function getPickupTime() {
    var div = document.getElementsByClassName("tracer")[0];
    var timeNode = searchChildForTag(div.parentNode, 'STRONG');
    return timeNode.textContent.trim();
}

function gotoPickupLocation() {
    var div = document.getElementsByClassName("cta")[0];
    simulate(div, "click");
}

function gotoFareQuotePage() {
    var div = document.getElementsByClassName("paypal")[0];
    var btn = deepSearchChildForTag(div.parentNode, 'A');
    simulate(btn, 'click');
    return btn.textContent;
}

function cancelPickupLocation() {
    var list = document.getElementsByClassName("confirm-view");
    if(list.length == 0)
        return 0;
    var div = list[0];
    var link = deepSearchChildForTag(div, "A");
    if(link == null)
        return 0;
    simulate(link, "click");
    return 1;
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

function deepSearchChildForTag(node, tagName) {
    var tags = searchChildForTags(node, tagName);
    if (tags.length>0)
        return tags[0];
    for(var i=0; i<node.childNodes.length; i++) {
        var child = deepSearchChildForTag(node.childNodes[i], tagName);
        if(child != null)
            return child;
    }
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

function hasDialog() {
    var div = document.getElementsByClassName("dialog-overview");
    if(div == null || div.length == 0)
        return false;
    else
        return true;
}

function closeDialog() {
    var div = document.getElementsByClassName("message-view");
    if(div == null || div.length == 0)
        return false;
    if(!hasClass(div[0], 'dialog-overlay')) {
        return false;
    }
    var link = deepSearchChildForTag(div[0], 'A');
    if (link != null) {
        simulate(link, 'click');
        return true;
    }
    return false;
}

function hasClass(element, cls) {
    return (' ' + element.className + ' ').indexOf(' ' + cls + ' ') > -1;
}

function log(str) {
    window.location = "log:" + str;
}