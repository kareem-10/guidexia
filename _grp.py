import os, collections
groups=collections.defaultdict(int)
with open(r'D:\ca.txt',encoding='utf-8') as f:
  for l in f:
    rel=l.split(':',1)[0]; parts=rel.split('/')
    key='features/'+parts[1] if parts[0]=='features' and len(parts)>1 else parts[0]
    groups[key]+=1
for k,v in sorted(groups.items(), key=lambda x:-x[1]): print(v,k)
