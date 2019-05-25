$ = window.$;

function getTextRect(node) {
    let range = node.ownerDocument.createRange();
    range.selectNode(node);
    clientRect = range.getBoundingClientRect();
    range.detach();
    return {
        left: clientRect.left,
        top: clientRect.top,
        width: clientRect.width,
        height: clientRect.height,
    }
}

function splitTextNode(textNode, doc){
    var parentNode = textNode.parentNode;
    var textDiv = doc.createElement('span');
    var split = textNode.nodeValue.split('');
    characters = [];
    for (var i = 0, len = split.length; i < len; ++i) {
        var newTextNode = doc.createTextNode(split[i]);
        var span = doc.createElement('span');
        span.appendChild(newTextNode);
        textDiv.appendChild(span);
        characters.push(span);
    }
    textNode.parentNode.replaceChild(textDiv, textNode);
    return characters;
}


function isValid(rect) {
    return (rect.width > 0.0 && rect.height > 0.0);
}

class Block {
    
    constructor(qElem, rect) {
        this.qElem = qElem;
        this.rect = rect;
    }

    toggleBorder() {
        this.qElem.toggleClass('webbreaker-border');
    }
    
    toDict() {
        return {
            rect: this.rect
        }
    }
}

class Bar {

    constructor() {
        function createBar(){
        var barElem = document.createElement('scrollbar');
        barElem.setAttribute('id', 'kasumi-bar', '');
        barElem.setAttribute('maxpos', 100, '');
        barElem.setAttribute('curpos', 50, '');
        barElem.setAttribute('width', window.innerWidth, '');
        var barBox = document.createElement('hbox');
        barBox.setAttribute('width', '1000', '');
        barBox.appendChild(barElem);
        barBox.style.zIndex = '5';
        document.getElementById('appcontent').insertBefore(barBox, document.getElementById('statusbar-display'));
        bar = new Bar(barElem);
    };  

    }
}

class Stage {
    
    constructor(rect, doc) {
        this.rect = rect;
        this.blocks = [];
        this.doc = doc;
    }
    
    build(rootNode) {
        rootNode.contents().each((i, node) => {
            if (node.nodeType === node.TEXT_NODE) {
                let rect = getTextRect(node);
                if (isValid(rect)) {
                    splitTextNode(node, this.doc).forEach(character => {
                        if (character.firstChild.nodeValue == '\n') {
                            return;
                        }
                        let qChar = $(character);
                        let rect = {
                            left: qChar.offset().left,
                            top: qChar.offset().top,
                            right: qChar.offset().left + qChar.width(),
                            bottom: qChar.offset().top + qChar.height()
                        }
                        let block = new Block(qChar, rect);
                        block.toggleBorder();
                        this.blocks.push(block);
                    });
                }
            } else {
                this.build($(node));
            }
        });
    }

    toDict() {
        return {
            rect: this.rect,
            blocks: this.blocks.map(block => block.toDict()),
        };
    }
    
}

let windowRect = {
    left: (window.screenLeft || window.screenX),
    top: (window.screenTop || window.screenY),
    right: (window.screenLeft || window.screenX) + (window.innerWidth || document.documentElement.clientWidth),
    bottom: (window.screenTop || window.screenY) + (window.innerHeight || document.documentElement.clientHeight),
}

let stage = new Stage(windowRect, document);
stage.build($('body'));

let res = JSON.stringify({
    error: false,
    stage: stage.toDict()
});

res;
