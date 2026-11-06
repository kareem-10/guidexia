import os,re
base=r'D:\flutter_projects\learn_flutter\tourist_app\lib\features'
targets=[]
for feat in ['stays','guides','place_details']:
  for r,_,fs in os.walk(os.path.join(base,feat)):
    for f in fs:
      if f.endswith('.dart'): targets.append(os.path.join(r,f))
for p in targets:
  s=open(p,encoding='utf-8').read(); o=s
  s=s.replace("Colors.grey.shade200","Theme.of(context).colorScheme.surfaceContainerHighest")
  s=s.replace("Colors.grey.shade500","Theme.of(context).colorScheme.onSurfaceVariant")
  s=s.replace("Colors.grey.shade600","Theme.of(context).colorScheme.onSurfaceVariant")
  s=s.replace("Colors.grey.shade400","Theme.of(context).colorScheme.onSurfaceVariant.withValues(alpha:0.6)")
  s=s.replace("Colors.grey.shade700","Theme.of(context).colorScheme.onSurfaceVariant")
  s=s.replace("Colors.blueGrey","Theme.of(context).colorScheme.onSurfaceVariant")
  s=s.replace("const Color(0xFFE9EFF0)","Theme.of(context).colorScheme.surfaceContainerHighest")
  s=s.replace("const Color(0xFFE6E9EC)","Theme.of(context).colorScheme.outlineVariant")
  s=s.replace("const Color(0xFFE5E9EC)","Theme.of(context).colorScheme.outlineVariant")
  s=s.replace("const Color(0xFFE0E6E8)","Theme.of(context).colorScheme.outlineVariant")
  s=s.replace("const Color(0xFF59636B)","Theme.of(context).colorScheme.onSurfaceVariant")
  s=s.replace("const Color(0xFF242B31)","Theme.of(context).colorScheme.onSurface")
  s=s.replace("const Color(0xFF252D33)","Theme.of(context).colorScheme.onSurface")
  s=s.replace("Colors.black87","Theme.of(context).colorScheme.onSurface")
  s=s.replace("Colors.black54","Theme.of(context).colorScheme.onSurfaceVariant")
  s=s.replace("Colors.black.withValues","Theme.of(context).colorScheme.shadow.withValues")
  if s!=o: open(p,'w',encoding='utf-8').write(s); print('mod',os.path.relpath(p,base))
print('ok')
