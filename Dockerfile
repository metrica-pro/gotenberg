# Gotenberg с Ghostscript для PDF/A конвертации по ГОСТ
# Включает русские шрифты для корректной работы с документами ГОСТ Р 7.0.97-2016
FROM gotenberg/gotenberg:8

USER root

# Обновление пакетов и установка Ghostscript
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        ghostscript \
        fonts-liberation \
        fonts-liberation2 \
        fonts-dejavu-core \
        fonts-dejavu-extra \
        fonts-freefont-ttf \
        fonts-crosextra-caladea \
        fonts-crosextra-carlito \
        ca-certificates && \
    rm -rf /var/lib/apt/lists/*

# Установка дополнительных шрифтов для лучшей совместимости
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        fonts-noto-core \
        fonts-noto-ui-core && \
    rm -rf /var/lib/apt/lists/*

# Проверка установленных компонентов
RUN gs --version && \
    echo "Ghostscript installed successfully" && \
    fc-list | grep -i "Liberation\|DejaVu\|Noto" && \
    echo "Fonts installed successfully"

# Настройка Ghostscript для PDF/A
RUN mkdir -p /etc/ghostscript && \
    echo "% PDF/A settings for GOST compliance" > /etc/ghostscript/cidfmap && \
    echo "/Helvetica /Liberation-Sans ;" >> /etc/ghostscript/cidfmap && \
    echo "/Times /Liberation-Serif ;" >> /etc/ghostscript/cidfmap && \
    echo "/Courier /Liberation-Mono ;" >> /etc/ghostscript/cidfmap

USER gotenberg

# Healthcheck
HEALTHCHECK --interval=30s --timeout=5s --retries=3 \
    CMD wget --no-verbose --tries=1 --spider http://localhost:3000/health || exit 1

# Метаданные
LABEL maintainer="metrica.pro" \
      version="8.0-ghostscript-gost" \
      description="Gotenberg with Ghostscript and Russian fonts for GOST PDF/A compliance" \
      org.opencontainers.image.source="https://github.com/metrica-pro/gotenberg"
