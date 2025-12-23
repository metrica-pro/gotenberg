# Gotenberg с поддержкой PDF/A и ГОСТ

Кастомный образ Gotenberg с расширенной функциональностью для работы с документами по ГОСТ Р 7.0.97-2016.

## Возможности

- ✅ **Gotenberg 8** - базовая функциональность конвертации документов
- ✅ **Ghostscript** - конвертация в PDF/A-1b, PDF/A-2b, PDF/A-3b
- ✅ **LibreOffice** - конвертация DOCX, XLSX, ODT, ODP в PDF
- ✅ **Chromium** - конвертация HTML/Markdown в PDF
- ✅ **Русские шрифты** - PT Sans, PT Serif, Liberation для ГОСТ

## Используемые компоненты

- **Gotenberg**: 8.x
- **Ghostscript**: 9.x
- **LibreOffice**: встроен в gotenberg:8
- **Шрифты**: PT Sans, PT Serif, Liberation, DejaVu

## Docker образ

```bash
docker pull ghcr.io/metrica-pro/gotenberg:latest
```

## Использование

### Запуск локально

```bash
docker run --rm -p 3000:3000 ghcr.io/metrica-pro/gotenberg:latest
```

### HTML → PDF

```bash
curl --request POST \
  --url http://localhost:3000/forms/chromium/convert/html \
  --header 'Content-Type: multipart/form-data' \
  --form files=@index.html \
  -o result.pdf
```

### DOCX → PDF

```bash
curl --request POST \
  --url http://localhost:3000/forms/libreoffice/convert \
  --header 'Content-Type: multipart/form-data' \
  --form files=@document.docx \
  -o result.pdf
```

### PDF → PDF/A (ГОСТ)

```bash
curl --request POST \
  --url http://localhost:3000/forms/pdfengines/convert \
  --header 'Content-Type: multipart/form-data' \
  --form files=@input.pdf \
  --form pdfa=PDF/A-2b \
  -o result-pdfa.pdf
```

## Развертывание в Kubernetes

См. репозиторий [metrica-pro/cluster](https://github.com/metrica-pro/cluster) для манифестов Kubernetes.

## Ссылки

- [Gotenberg Documentation](https://gotenberg.dev)
- [Ghostscript](https://www.ghostscript.com/)
- [ГОСТ Р 7.0.97-2016](https://docs.cntd.ru/document/1200135629)

## Лицензия

Основано на [gotenberg/gotenberg](https://github.com/gotenberg/gotenberg) (MIT License)
