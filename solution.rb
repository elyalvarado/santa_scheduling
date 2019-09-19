->e,h{
  h.split(/\+|\n/).map { |h|
    n, g = h.split('*').map(&:to_i)
    g ||= 0
    n ||= 0
    return -1 if (g > 0 && e < 2) ||(n > 0 && e < 3)
    next 0 if e == 0
    ([[3,5]]*n + [[2,4]]*g).permutation.map { |j|
      c = [0] * e
      j.each { |q|
        w, y = q
        i=j=0
        r = c.map { |x|
          a = b = 0
          c[i..e].each { |r| r <= x ? a+=1 : break }
          c[0..i].reverse.each { |r| r <= x ? b+=1 : break }
          i+=1
          [a,b]
        }
        a = r.inject([]) { |acc,x|
              acc<<j if x[0] >= w
              j+=1
              acc
            }
        d = a.min { |a,b| c[a] <=> c[b] }
        b = d - (r[d][1] - 1)
        z = c[d] + y
        (b..(b+w-1)).each { |x| c[x] = z }
      }
      c.max
    }.min
  }.sum
}
