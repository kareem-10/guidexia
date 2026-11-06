import os,re
base=r'D:\flutter_projects\learn_flutter\tourist_app\lib\features'
feats=['explore','saved','stays','guides','place_details']
pats=[('COLOR',re.compile(r"Colors\.(?!transparent\b)[A-Za-z_]+|Color\(0x|AppColors\.")),
      ('STYLE',re.compile(r"TextStyle\(|TextStyles\."))]
for feat in feats:
  for r,_,fs in os.walk(os.path.join(base,feat)):
    for f in fs:
      if not f.endswith('.dart'): continue
      p=os.path.join(r,f); s=open(p,encoding='utf-8').read()
      c=sum(1 for _,pat in pats for _ in pat.finditer(s))
      if c: print(c, os.path.relpath(p,base))
