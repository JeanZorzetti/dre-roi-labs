# Dockerfile para DRE ROI Labs
# Aplicação estática servida com Nginx

FROM nginx:alpine

# Instalar dependências básicas
RUN apk add --no-cache \
    curl \
    jq

# Copiar arquivos da aplicação
COPY . /usr/share/nginx/html/

# Configuração customizada do Nginx
COPY nginx.conf /etc/nginx/nginx.conf

# Expor porta
EXPOSE 80

# Health check
HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 \
    CMD curl -f http://localhost/health || exit 1

# Comando de inicialização
CMD ["nginx", "-g", "daemon off;"]