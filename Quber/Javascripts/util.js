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

function openPickupLocationPage() {
    var div = document.getElementsByClassName("cta")[0];
    simulate(div, "click");
}

function gotoFareQuotePage() {
    var btn = document.getElementsByClassName("fare-quote");
    if(btn == null || btn.length == 0)
        return 0;
    btn = btn[0];
    simulate(btn, 'click');
    return true;
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
    tagName = tagName.toUpperCase();
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

function closeConfirmationPage() {
    var div = document.getElementsByClassName("confirm-view");
    if(div == null || div.length == 0)
        return false;
    var header = searchChildForTag(div[0], 'HEADER');
    if(header == null)
        return false;
    var btn = searchChildForTag(header, 'A');
    if(btn == null)
        return false;
    simulate(btn, 'click');
    return true;
}

function showingConfirmationPage() {
    var div = document.getElementsByClassName("confirm-view");
    if(div == null || div.length == 0)
        return false;
    var header = searchChildForTag(div[0], 'HEADER');
    if(header == null)
        return false;
    var txt = header.textContent.trim();
    return txt.indexOf('Confirmation')!=-1;
}

function openDropoffLocationPage() {
    var div = document.getElementsByClassName("pickup");
    if(div == null || div.length == 0)
        return false;
    var btn = searchChildForTag(div[0], 'A');
    if(!hasClass(btn, 'btn'))
        return false;
    if(!hasClass(btn, 'plus'))
        return false;
    simulate(btn, 'click');
    return true;
}

function showingDropOffLocation() {
    var div = document.getElementsByTagName("header");
    if(div == null || div.length == 0) {
        return false;
    }
    for(var i=0; i<div.length; i++) {
        var txt = div[i].textContent.trim();
        if (txt.toUpperCase().indexOf('DROPOFF LOCATION')!=-1) return true;
    }
        return false;
}

function showingFareQuote() {
    var div = document.getElementsByClassName("search-view");
    if(div == null || div.length == 0)
        return false;
    if(!hasClass(div[0], 'page'))
        return false;
    if(!hasClass(div[0], 'page-white'))
        return false;
    var header = searchChildForTag(div[0], 'HEADER');
    if(header == null)
        return false;
    var txt = header.textContent.trim();
    return txt.indexOf('Fare Quote')!=-1;
}

function closeDropOffLocation() {
    var div = document.getElementsByClassName("search-view");
    if(div == null || div.length == 0)
        return false;
    if(!hasClass(div[0], 'page'))
        return false;
    if(!hasClass(div[0], 'page-white'))
        return false;
    if(!hasClass(div[0], 'show-list'))
        return false;
    var header = searchChildForTag(div[0], 'HEADER');
    if(header == null)
        return false;
    var btn = searchChildForTag(header, 'A');
    if(btn == null)
        return false;
    simulate(btn, 'click');
    return true;
}

function closeFareQuote() {
    var div = document.getElementsByClassName("search-view");
    if(div == null || div.length == 0)
        return 0;
    if(!hasClass(div[0], 'page'))
        return 1;
    if(!hasClass(div[0], 'page-white'))
        return 2;
    var header = searchChildForTag(div[0], 'HEADER');
    if(header == null)
        return 3;
    var btn = searchChildForTag(header, 'A');
    if(btn == null)
        return 4;
    simulate(btn, 'click');
    return true;
}

function fillSearchField(addr) {
    var field = document.getElementsByName('search');
    if(field == null || field.length == 0)
        return 0;
    field = field[0];
    field.focus();
    field.value = addr;
    $(field).trigger(jQuery.Event('keydown', {which: 13}));
    $(field).trigger(jQuery.Event('keyup', {which: 13}));
    $(field).trigger(jQuery.Event('keypress', {which: 13}));
    return true;
}

function selectSearchResult() {
    var div = document.getElementsByClassName('search-results');
    if (div == null || div.length == 0)
        return 1;
    div = div[0];
    var ul = searchChildForTag(div, "UL");
    if(ul == null)
        return 2;
    var lis = searchChildForTags(ul, "LI");
    if(lis == null || lis.length == 0)
        return 3;
    simulate(lis[0], 'click');
    return true;
}

function triggerKeyboardEvent(el, keyCode)
{
    var eventObj = document.createEventObject ?
    document.createEventObject() : document.createEvent("Events");
    
    if(eventObj.initEvent){
        eventObj.initEvent("keydown", true, true);
    }
    
    eventObj.keyCode = keyCode;
    eventObj.which = keyCode;
    
    el.dispatchEvent ? el.dispatchEvent(eventObj) : el.fireEvent("onkeydown", eventObj);
}

function getPriceRange() {
    var div = document.getElementsByClassName('quote');
    if (div == null || div.length == 0)
        return 0;
    div = div[0];
    var ul = searchChildForTag(div, "SPAN");
    if(ul == null)
        return 1;
    return ul.textContent.trim();
}
