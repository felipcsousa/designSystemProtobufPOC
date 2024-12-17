#!/usr/bin/env bash
set -e
set -o pipefail

PROTO_FILE=proto/progress_indicator.proto
ANDROID_DIR=android
IOS_DIR=ios
KOTLIN_PLUGIN=protoc-gen-kotlin.jar
LOG_FILE="generation.log"

log() {
    echo "[$(date +'%Y-%m-%d %H:%M:%S')] $*" | tee -a "$LOG_FILE"
}

handle_error() {
    log "❌ Erro durante a geração dos DTOs"
    exit 1
}
trap handle_error ERR

log "🧹 Limpando diretórios de saída anteriores"
rm -rf "$ANDROID_DIR" "$IOS_DIR"
mkdir -p "$ANDROID_DIR" "$IOS_DIR"

log "🔍 Verificando gerador Kotlin"
if [ ! -f "$KOTLIN_PLUGIN" ]; then
    log "❌ Plugin Kotlin não encontrado. Baixe em: https://github.com/protocolbuffers/protobuf-kotlin"
    exit 1
fi

log "🤖 Gerando DTO para Android (Kotlin)"
protoc -I proto --plugin=protoc-gen-kotlin="$KOTLIN_PLUGIN" \
       --kotlin_out="$ANDROID_DIR" "$PROTO_FILE"

log "🍏 Gerando DTO para iOS (Swift)"
protoc -I proto --swift_out="$IOS_DIR" "$PROTO_FILE"

log "🚀 DTOs gerados com sucesso!"