def santa_time e, h
  h = h.split /\+|\n/
  h.map { |h|
    n, g = h.split('*').map(&:to_i)
    g ||= 0
    n ||= 0
    return -1 if (g > 0 && e < 2) ||(n > 0 && e < 3)
    next 0 if e == 0
    v = [1]*n + [0]*g
    o = v.permutation
    f = o.map do |j|
      j = j.map { |x| x==1 ? [3,5] : [2,4] }
      c = [0] * e
      j.each do |q|
        w, y = q
        r = c.map.with_index do |x,i|
          a = 0
          c[i..e].each { |r| r <= x ? a+=1 : break }
          a
        end
        l = c.map.with_index do |x,i|
          a = 0
          c[0..i].reverse.each { |r| r <= x ? a+=1 : break }
          a
        end
        a = r.each.with_index.inject([]) { |acc,(x,i)|
              acc<<i if x >= w
              acc
            }
        d = a.min { |a,b| c[a] <=> c[b] }
        b = d - (l[d] - 1)
        z = c[d] + y
        (b..(b+w-1)).each { |x| c[x] = z }
      end
      c.max
    end
    f.min
  }.sum
end
