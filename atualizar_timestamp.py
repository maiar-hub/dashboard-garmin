import re
from datetime import datetime

MESES = {1:'Jan',2:'Fev',3:'Mar',4:'Abr',5:'Mai',6:'Jun',
         7:'Jul',8:'Ago',9:'Set',10:'Out',11:'Nov',12:'Dez'}

def atualizar(path='dashboard_anual_2026.html'):
    with open(path, 'r', encoding='utf-8') as f:
        content = f.read()

    now = datetime.now()
    nova = f"{now.day:02d} {MESES[now.month]} {now.year} · {now.strftime('%H:%M')} · v2"

    # substitui qualquer timestamp anterior no formato "DD Mmm YYYY · HH:MM · v2"
    content, n = re.subn(
        r'\d{1,2} \w{3} \d{4} · [\d:]{5} · v2',
        nova,
        content
    )
    # fallback: se ainda não tinha hora (formato antigo sem hora)
    if n == 0:
        content, n = re.subn(
            r'\d{1,2} \w{3} \d{4} · v2',
            nova,
            content
        )

    with open(path, 'w', encoding='utf-8') as f:
        f.write(content)

    print(f"[OK] Timestamp: {nova} ({n} substituicao(es))")

atualizar()
