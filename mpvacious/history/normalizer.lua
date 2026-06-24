local h = require('helpers')

local this = {}

function this.normalize(text, config)
    if h.is_empty(text) then
        return ''
    end
    text = h.unescape_special_characters(text)
    text = h.remove_html_tags(text)
    text = h.trim(text)
    if config and config.nuke_spaces == true and h.contains_non_latin_letters(text) then
        text = h.remove_all_spaces(text)
    end
    return text
end

function this.run_tests()
    h.assert_equals(this.normalize('  これは　ペンです。  ', { nuke_spaces = false }), 'これは ペンです。')
    h.assert_equals(this.normalize('これは ペン です。', { nuke_spaces = true }), 'これはペンです。')
    h.assert_equals(this.normalize('&lt;b&gt;語&lt;/b&gt;', { nuke_spaces = false }), '語')
    h.assert_equals(this.normalize('<b>語</b>', { nuke_spaces = false }), '語')
end

return this
