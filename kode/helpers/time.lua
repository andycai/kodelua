kode.time = {}

function kode.time.minutes(number)
  return number * 60
end

function kode.time.hours(number)
  return number * kode.time.minutes(60)
end

function kode.time.days(number)
  return number * kode.time.hours(24)
end