local mp = require('mp')

local function test()
    local root = assert(os.getenv("MPVACIOUS_ROOT"))
    package.path = root .. "/?.lua;" .. package.path
    assert(type(require('history.client').new) == "function")
    assert(type(require('history.controller').new) == "function")
    local checker = require('anki.new_note_checker')

    assert(checker.classify_claim({ status = "claimed", record = { id = "rec-1" } }) == "claimed")
    assert(checker.classify_claim({ status = "already_claimed" }) == "handled")
    assert(checker.classify_claim({ status = "unmatched" }) == "fallback")
    assert(checker.classify_claim(nil, "server unavailable") == "retry")
    assert(checker.classify_claim({ status = "unexpected" }) == "retry")
end

local success, error = pcall(test)
if success then
    mp.msg.info("TESTS PASSED")
else
    mp.msg.error("TESTS FAILED: " .. tostring(error))
end
mp.commandv("quit", success and 0 or 1)
