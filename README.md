# Cheat Sheet

List repos by number of lint findings:

```bash
rg '(\[[^\[\]]*\]:)' rust-lang/ --count-matches --color=always| sort -t':' -k2 -n
```

List unique lint findings in `./ziz_aud.txt`:

```bash
rg '(\[[^\[\]]*\]:)' -o ./ziz_aud.txt | sort | uniq
```
