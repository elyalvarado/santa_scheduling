->e,h{
h.split(/\+|\n/).map{|h|
n,g=h.split('*').map(&:to_i)+[0,0]
return-1if(g>0&&e<2)||(n>0&&e<3)
([[3,5]]*n+[[2,4]]*g).permutation.map{|j|
c=[0]*e
j.map{|q|
w,y=q
i=j=0
r=c.map{|x|
a=b=0
c[i..e].map{|r|r<=x ?a+=1:break}
(t=i+=1).times{c[t-=1]<=x ?b+=1:break}
[a,b]
}
a=r.inject([]){|k,x|
k<<j if x[0]>=w
j+=1
k
}
d=a.min{|a,b|c[a]<=>c[b]}
b=d-r[d][1]+1
z=c[d]+y
(b..(b+w-1)).map{|x|c[x]=z}
}
c.max
}.min||0
}.sum
}
