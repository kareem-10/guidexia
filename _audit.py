import os, re
base = r'D:\flutter_projects\learn_flutter\tourist_app\lib'
color_re = re.compile(r'Colors\.|Color\(0x|Color\.from|const Color\(')
style_re = re.compile(r'TextStyle\(|TextStyles\.')
c = s = 0
ca = []
sa = []
for root, _, files in os.walk(base):
    for f in files:
        if not f.endswith('.dart'):
            continue
        path = os.path.join(root, f)
        rel = os.path.relpath(path, base).replace('\\', '/')
        with open(path, encoding='utf-8', errors='ignore') as fh:
            for i, l in enumerate(fh, 1):
                if color_re.search(l):
                    c += 1
                    ca.append(rel + ':' + str(i) + ':' + l.rstrip()[:200])
                if style_re.search(l):
                    s += 1
                    sa.append(rel + ':' + str(i) + ':' + l.rstrip()[:200])
print('COLOR', c, 'STYLE', s)
open(r'D:\ca.txt', 'w', encoding='utf-8').write('\n'.join(ca))
open(r'D:\sa.txt', 'w', encoding='utf-8').write('\n'.join(sa))
