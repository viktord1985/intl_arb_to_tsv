# 📝 intl_arb_to_tsv

A lightweight Dart CLI tool to convert Flutter `.arb` translation files into a TSV (tab-separated values) format, useful for translators, spreadsheets, or sharing. Automatically copies the result to your system clipboard.

---

## ✨ Example Output

Given this `intl_en.arb`:

```json
{
  "@@locale": "en",
  "Generate": "Generate",
  "MyImages": "My Images",
  "Favorite": "Favorite",
  "Profile": "Profile",
  "GenerateTattoo": "Generate Tattoo"
}
```

The tool generates:

```json
Keys	en
Generate	Generate
MyImages	My Images
```
