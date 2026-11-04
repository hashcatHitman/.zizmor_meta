# Cheat Sheet

List repos by number of lint findings:

```bash
rg '(\[[^\[\]]*\]:)' rust-lang/ --count-matches --color=always | sort -t':' -k2 -n
```

List unresolved lint kinds by count:

```bash
rg '(\[[^\[\]]*\]:)' rust-lang/ --color=always -oIN | sort | uniq -c | sort -n
```

List unique lint findings in `./ziz_aud.txt`:

```bash
rg '(\[[^\[\]]*\]:)' -o ./ziz_aud.txt | sort | uniq
```
