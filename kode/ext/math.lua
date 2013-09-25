function math.round(num)
    return math.floor(num + 0.5)
end

function math.random2(...)
    math.randomseed(tonumber(tostring(os.time()):reverse():sub(1,6)))
    return math.random(...)
end