
var syms = {
    ">"  :  "&gt;",
    "<"  :  "&lt;",
    "\"" :  "&quot;",
    "&"  :  "&amp;",
};
var list = [
    ">", "<", "\"", "&",
];

function formHTMLmap(text)
/** HTML is in [[]], example:
 *    hello! 
 *    [[<a href="www.google.com">link</a>]] 
 *    buy!
 */
{
    var brackets = 0;
    var res = []; // is res[i] html or not
    for (var i = 0; i < text.length; i++)
        res = res.concat([false]);
    for (var i = 1; i < text.length; i++) {
        if (text[i] == '[' && text[i - 1] == '[')
            brackets++;
        else if (text[i] == ']' && text[i - 1] == ']')
            brackets--;            
        if (brackets > 0)
            res[i] = true;
    }
    return res;
}

function correct(text) {
    var HTML = formHTMLmap(text);
    for (var i = text.length - 1; i > -1; i--) { // inverted, because else i am going forward and changing 'text', so 'HTML' doesnt correspond to the current 'text'
        if (list.indexOf(text[i]) != -1) {
            if (!HTML[i]) {
                text = text.substr(0, i)
                     + syms[text[i]]
                     + text.substr(i + 1, text.length);
            }
        }
    }
    return text;
}

function removeBrackets(text) {
    text = text.replace(/\[\[/g, "");
    text = text.replace(/\]\]/g, "");
    return text;
}

function correctForm() {
     var text = document.getElementById('user_message').value;
     text = correct(text);
     text = removeBrackets(text);
     document.getElementById('user_message').value = text;
}
